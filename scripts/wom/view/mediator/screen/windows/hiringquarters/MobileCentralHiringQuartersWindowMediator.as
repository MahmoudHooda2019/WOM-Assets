package wom.view.mediator.screen.windows.hiringquarters
{
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.model.FinishNowHiringEvent;
   import wom.controller.event.model.NotEnoughResourceEvent;
   import wom.controller.event.ui.MobileHiringQuarterMercenaryInfoEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringPauseReasonType;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.job.UnitHireJob;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.GetHiringStatusRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.hiringquarters.MobileCentralHiringQuartersWindow;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileCentralHiringQuartersWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileCentralHiringQuartersWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileCentralHiringQuartersWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         view.selectMercenaryPanel.fillUnits(domainInfo.getUnits());
         city.hiringSessionResourceAmounts = city.resourceAmounts;
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetHiringStatusRequest(view.buildingInstanceId)));
         onUnitTypesUpdated(null);
         onResourcesUpdated(null);
         onHiringInfoUpdated(null);
         addContextListener("unitTypesUpdated",onUnitTypesUpdated,ModelUpdateEvent);
         addContextListener("hiringInfoUpdated",onHiringInfoUpdated,ModelUpdateEvent);
         addContextListener("resourcesUpdated",onResourcesUpdated,ModelUpdateEvent);
         addContextListener("resourceCapacityUpdated",onResourcesUpdated,ModelUpdateEvent);
         addContextListener("resourceTypeKnown",onNotEnoughIron,NotEnoughResourceEvent);
         addContextListener("info",onShowMercenaryInfo,MobileHiringQuarterMercenaryInfoEvent);
         addContextListener("askForOverflowInfoUpdated",askForOverflowUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.speedupButton,"triggered",onSpeedUpButtonClicked,Event);
         eventMap.mapStarlingListener(view.topOffIronButton,"triggered",onTopOffButtonClicked,Event);
         eventMap.mapStarlingListener(view.finishNowButton,"triggered",onFinishNowButtonClicked,Event);
         eventMap.mapStarlingListener(view.selectMercenaryPanel.infoButton,"triggered",onHideMercenaryInfo,Event);
         addContextListener("tick",onTick,GameTickEvent);
      }
      
      private function onHideMercenaryInfo(param1:Event) : void
      {
         view.selectMercenaryPanel.hideMercenaryInfoPanel();
         view.hiringQuartersSpriteVisible = true;
      }
      
      private function onShowMercenaryInfo(param1:MobileHiringQuarterMercenaryInfoEvent) : void
      {
         var _loc4_:int = param1.unitId;
         var _loc2_:UnitTypeDIO = domainInfo.getUnit(_loc4_);
         var _loc3_:UnitTypeInfo = city.unitTypes[_loc4_];
         view.selectMercenaryPanel.loadMercenaryData(_loc2_,_loc3_);
         view.hiringQuartersSpriteVisible = false;
      }
      
      private function onResourcesUpdated(param1:ModelUpdateEvent) : void
      {
         view.ironProgressBar.maximum = city.totalResourceCapacity / 4;
         view.ironProgressBar.value = city.resourceAmounts[ResourceType.IRON.id];
      }
      
      private function onUnitTypesUpdated(param1:ModelUpdateEvent) : void
      {
         view.selectMercenaryPanel.updateUnits(city.unitTypes);
      }
      
      private function onHiringInfoUpdated(param1:ModelUpdateEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:UnitHireJob = null;
         calculateCapacity();
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         for each(var _loc7_ in city.hiringInfoDictionary)
         {
            _loc3_ = 0;
            _loc5_ = _loc7_.activeHiring;
            if(_loc5_ && !_loc7_.isHiringPaused)
            {
               _loc3_ = _loc5_.unitTypeId;
               _loc6_ += domainInfo.getUnit(_loc3_).spacesPerLevel[(city.unitTypes[_loc5_.unitTypeId] as UnitTypeInfo).currentLevel - 1];
               view.setMercenaryInProgress(_loc2_,_loc3_,_loc7_.hiringBuildingInstanceId);
            }
            else if(_loc7_.isHiringPaused)
            {
               if(_loc7_.lastHiredUnitId)
               {
                  _loc3_ = _loc7_.lastHiredUnitId;
                  _loc6_ += domainInfo.getUnit(_loc3_).spacesPerLevel[(city.unitTypes[_loc7_.lastHiredUnitId] as UnitTypeInfo).currentLevel - 1];
                  view.setMercenaryInProgress(_loc2_,_loc3_,_loc7_.hiringBuildingInstanceId);
               }
               else if(_loc7_.pauseReason == HiringPauseReasonType.HIRING_BUILDING_BEING_UPGRADED)
               {
                  view.updateNonBuiltHiringQuarterSlot(_loc2_,true);
               }
            }
            else
            {
               view.setMercenaryInProgress(_loc2_,_loc5_ == null ? 0 : _loc5_.unitTypeId,_loc7_.hiringBuildingInstanceId);
            }
            if(_loc2_ == 0)
            {
               view.fillQueuedMercenaries(_loc7_.hiringQueue);
               for each(var _loc4_ in _loc7_.hiringQueue.hiringSlots)
               {
                  _loc6_ += domainInfo.getUnit(_loc4_.unitId).spacesPerLevel[(city.unitTypes[_loc4_.unitId] as UnitTypeInfo).currentLevel - 1] * _loc4_.numberOfUnits;
               }
            }
            _loc2_++;
         }
         while(_loc2_ < 5)
         {
            view.updateNonBuiltHiringQuarterSlot(_loc2_);
            _loc2_++;
         }
         view.queuedHousing = _loc6_;
         view.isFirstUpdate = false;
         onTick(null);
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:UnitHireJob = null;
         var _loc2_:int = 0;
         for each(var _loc5_ in city.hiringInfoDictionary)
         {
            _loc4_ = _loc5_.activeHiring;
            if(_loc4_ && !_loc5_.isHiringPaused)
            {
               _loc3_ = _loc4_.jobCreationTime + _loc4_.remainingDuration - new Date().getTime();
               view.resetMercenaryInProgressRemainingTime(_loc2_,LocalizedDateTimeUtil.getUserFriendlyTime(_loc3_));
            }
            else if(_loc5_.isHiringPaused)
            {
               if(_loc5_.pauseReason == HiringPauseReasonType.HIRING_BUILDING_BEING_UPGRADED)
               {
                  view.resetMercenaryInProgressStatus(_loc2_);
                  view.setMercenaryInProgressAlpha(_loc2_,1);
               }
               else
               {
                  var _temp_5:* = view;
                  var _temp_4:* = _loc2_;
                  var _loc8_:String = "ui.windows.centralhiring.waiting" + _loc5_.pauseReason.id;
                  _temp_5.resetMercenaryInProgressStatus(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc8_));
                  view.setMercenaryInProgressAlpha(_loc2_,0.5);
               }
            }
            else
            {
               view.resetMercenaryInProgressStatus(_loc2_);
               view.setMercenaryInProgressAlpha(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      private function onFinishNowButtonClicked(param1:Event) : void
      {
         dispatch(new FinishNowHiringEvent("calculateFinishNowPrice",view.buildingInstanceId,true));
      }
      
      private function onTopOffButtonClicked(param1:Event) : void
      {
         view.addWindowEnumeration(new WindowEnumeration(11,{"buildingInstanceId":view.buildingInstanceId}));
         view.addWindowEnumeration(new WindowEnumeration(18,{"tab":1}));
         closeWindow();
      }
      
      private function onSpeedUpButtonClicked(param1:Event) : void
      {
         view.addWindowEnumeration(new WindowEnumeration(11,{"buildingInstanceId":view.buildingInstanceId}));
         view.addWindowEnumeration(new WindowEnumeration(18,{"tab":2}));
         closeWindow();
      }
      
      private function calculateCapacity() : void
      {
         var _loc4_:int = 0;
         var _loc5_:BuildingTypeDIO = domainInfo.getBuilding(19);
         for each(var _loc3_ in city.buildings)
         {
            if(_loc3_.buildingTypeId == 19)
            {
               _loc4_ += _loc5_.buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][_loc3_.level - 1];
            }
         }
         _loc4_ *= userInfo.barracksSpaceModifier;
         view.capacityOfBarracks = _loc4_;
         var _loc1_:int = 0;
         for each(var _loc2_ in city.units)
         {
            if(_loc2_.status == UnitStatusType.IN_BARRACKS)
            {
               _loc1_ += domainInfo.getUnit(_loc2_.typeId).spacesPerLevel[(city.unitTypes[_loc2_.typeId] as UnitTypeInfo).currentLevel - 1];
            }
         }
         view.housingOfUnitsInBarracks = _loc1_;
      }
      
      private function onNotEnoughIron(param1:NotEnoughResourceEvent) : void
      {
         if(param1.resourceType != ResourceType.IRON)
         {
            return;
         }
         view.addWindowEnumeration(new WindowEnumeration(11,{"buildingInstanceId":view.buildingInstanceId}));
         view.addWindowEnumeration(new WindowEnumeration(18,{
            "tab":1,
            "page":1,
            "windowEnumeration":view.windowEnumerations
         }));
         closeWindow();
      }
      
      private function askForOverflowUpdated(param1:ModelUpdateEvent) : void
      {
         view.dontAskForOverflow = true;
      }
   }
}

