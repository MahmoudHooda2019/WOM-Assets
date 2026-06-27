package wom.view.mediator.screen.windows.hiringquarters
{
   import flash.geom.Point;
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.model.FinishNowHiringEvent;
   import wom.controller.event.model.NotEnoughResourceEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.ui.MobileHiringQuarterMercenaryInfoEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.job.UnitHireJob;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.GetHiringStatusRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.hiringquarters.MobileHiringQuartersMercenaryView;
   import wom.view.screen.windows.hiringquarters.MobileHiringQuartersWindow;
   
   public class MobileHiringQuartersWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileHiringQuartersWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      private var originalDurationInSeconds:Number;
      
      public function MobileHiringQuartersWindowMediator()
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
         addContextListener("unitTypesUpdated",onUnitTypesUpdated);
         addContextListener("hiringInfoUpdated",onHiringInfoUpdated);
         addContextListener("resourcesUpdated",onResourcesUpdated,ModelUpdateEvent);
         addContextListener("resourceCapacityUpdated",onResourcesUpdated,ModelUpdateEvent);
         addContextListener("resourceTypeKnown",onNotEnoughIron,NotEnoughResourceEvent);
         addContextListener("getHiringMercViewPosition",onHiringMercViewPositionRequested,TutorialReferencePositionEvent);
         addContextListener("info",onShowMercenaryInfo,MobileHiringQuarterMercenaryInfoEvent);
         addContextListener("askForOverflowInfoUpdated",askForOverflowUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.speedupButton,"triggered",onSpeedUpButtonClicked,Event);
         eventMap.mapStarlingListener(view.finishNowButton,"triggered",onFinishNowButtonClicked,Event);
         eventMap.mapStarlingListener(view.topOffIronButton,"triggered",onTopOffButtonClicked,Event);
         eventMap.mapStarlingListener(view.selectMercenaryPanel.infoButton,"triggered",onHideMercenaryInfo,Event);
         addContextListener("tick",onTick,GameTickEvent);
         addContextListener("getMandatoryActionButtonPosition",onMandatoryActionButtonPositionRequested,TutorialReferencePositionEvent);
      }
      
      private function onMandatoryActionButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,view.finishNowButton.localToGlobal(new Point()),param1.additionalInfo,view.finishNowButton));
      }
      
      private function onTopOffButtonClicked(param1:Event) : void
      {
         view.addWindowEnumeration(new WindowEnumeration(8,{"buildingInstanceId":view.buildingInstanceId}));
         view.addWindowEnumeration(new WindowEnumeration(18,{
            "tab":1,
            "page":1
         }));
         closeWindow();
      }
      
      private function onResourcesUpdated(param1:ModelUpdateEvent) : void
      {
         view.ironProgressBar.maximum = city.totalResourceCapacity / 4;
         view.ironProgressBar.value = city.resourceAmounts[ResourceType.IRON.id];
      }
      
      private function onHideMercenaryInfo(param1:Event) : void
      {
         view.selectMercenaryPanel.hideMercenaryInfoPanel();
      }
      
      private function onShowMercenaryInfo(param1:MobileHiringQuarterMercenaryInfoEvent) : void
      {
         var _loc4_:int = param1.unitId;
         var _loc2_:UnitTypeDIO = domainInfo.getUnit(_loc4_);
         var _loc3_:UnitTypeInfo = city.unitTypes[_loc4_];
         view.selectMercenaryPanel.loadMercenaryData(_loc2_,_loc3_);
      }
      
      private function onFinishNowButtonClicked(param1:Event) : void
      {
         dispatch(new FinishNowHiringEvent("calculateFinishNowPrice",view.buildingInstanceId,false));
      }
      
      private function onSpeedUpButtonClicked(param1:Event) : void
      {
         view.addWindowEnumeration(new WindowEnumeration(8,{
            "buildingInstanceId":view.buildingInstanceId,
            "level":view.currentBuildingLevel
         }));
         view.addWindowEnumeration(new WindowEnumeration(18,{"tab":2}));
         closeWindow();
      }
      
      private function onHiringInfoUpdated(param1:ModelUpdateEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:HiringInfo = city.hiringInfoDictionary[view.buildingInstanceId] as HiringInfo;
         var _loc2_:UnitHireJob = _loc3_.activeHiring;
         originalDurationInSeconds = _loc2_ != null ? _loc2_.originalDuration : 0;
         if(_loc2_)
         {
            _loc4_ = _loc2_.unitTypeId;
         }
         else if(_loc3_.isHiringPaused && _loc3_.lastHiredUnitId)
         {
            _loc4_ = _loc3_.lastHiredUnitId;
            var _temp_3:* = view.remainingDurationTF;
            var _loc5_:String = "ui.windows.hiringquarters.waiting";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         }
         view.setMercenaryInProgress(_loc4_);
         view.fillQueuedMercenaries(_loc3_.hiringQueue);
         view.isFirstUpdate = false;
         onTick(null);
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc4_:HiringInfo = city.hiringInfoDictionary[view.buildingInstanceId] as HiringInfo;
         var _loc3_:UnitHireJob = _loc4_.activeHiring;
         if(_loc3_)
         {
            _loc2_ = _loc3_.jobCreationTime + _loc3_.remainingDuration - new Date().getTime();
            view.remainingDurationTF.text = DateTimeUtil.getUserFriendlyTime(_loc2_);
         }
         else if(_loc4_.isHiringPaused && _loc4_.lastHiredUnitId)
         {
            var _temp_3:* = view.remainingDurationTF;
            var _loc5_:String = "ui.windows.hiringquarters.waiting";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         }
         else
         {
            view.remainingDurationTF.text = "";
         }
      }
      
      private function onNotEnoughIron(param1:NotEnoughResourceEvent) : void
      {
         if(param1.resourceType != ResourceType.IRON)
         {
            return;
         }
         view.addWindowEnumeration(new WindowEnumeration(8,{
            "buildingInstanceId":view.buildingInstanceId,
            "level":view.currentBuildingLevel
         }));
         view.addWindowEnumeration(new WindowEnumeration(18,{
            "tab":1,
            "page":1,
            "windowEnumeration":view.windowEnumerations
         }));
         closeWindow();
      }
      
      private function onHiringMercViewPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         var _loc2_:int = 0;
         if("unitTypeId" in param1.additionalInfo)
         {
            _loc2_ = int(param1.additionalInfo["unitTypeId"]);
            for each(var _loc3_ in view.selectMercenaryPanel.mercenaryViews)
            {
               if(_loc3_.unitTypeDIO.id == _loc2_)
               {
                  dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,_loc3_.localToGlobal(new Point(0,0)),param1.additionalInfo,_loc3_));
               }
            }
         }
      }
      
      private function onUnitTypesUpdated(param1:Event) : void
      {
         view.selectMercenaryPanel.updateUnits(city.unitTypes);
      }
      
      private function askForOverflowUpdated(param1:ModelUpdateEvent) : void
      {
         view.dontAskForOverflow = true;
      }
   }
}

