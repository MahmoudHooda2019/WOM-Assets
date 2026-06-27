package wom.view.mediator.screen.windows.executionalguillotine
{
   import starling.events.Event;
   import wom.controller.event.ExecuteWatchPostUnitEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.ExecutionalGuillotineSelectMercenaryEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.request.ExecuteUnitRequest;
   import wom.model.message.request.KillUnitsInWatchPost;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   import wom.view.screen.windows.executionalguillotine.MobileExecutionalGuillotineMercenaryView;
   import wom.view.screen.windows.executionalguillotine.MobileExecutionalGuillotineWindow;
   
   public class MobileExecutionalGuillotineWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileExecutionalGuillotineWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      private var friendWatchPostInstanceId:int = -1;
      
      public function MobileExecutionalGuillotineWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("executionalGuillotineSelectMercenaryEvent",onMercenarySelect,ExecutionalGuillotineSelectMercenaryEvent);
         eventMap.mapStarlingListener(view.selectAllButton,"triggered",onSelectAllClicked,Event);
         eventMap.mapStarlingListener(view.executeButton,"triggered",onExecuteClicked,Event);
         view.addMercenaries(domainInfo.getUnits());
         calculateCapacity();
         if(view.viewType == 4)
         {
            for each(var _loc1_ in city.buildings)
            {
               if(_loc1_.buildingTypeId == 38)
               {
                  friendWatchPostInstanceId = _loc1_.instanceId;
                  break;
               }
            }
         }
         addContextListener("unitTypesUpdated",onUnitsUpdated);
         addContextListener("unitsInBarracksUpdated",onUnitsUpdated);
         addContextListener("unitsInWatchPostUpdated",onUnitsUpdated);
         addContextListener("executeWatchPostUnit",onExecuteUnitInWatchPost,ExecuteWatchPostUnitEvent);
      }
      
      private function onExecuteUnitInWatchPost(param1:ExecuteWatchPostUnitEvent) : void
      {
         var _loc2_:* = undefined;
         if(friendWatchPostInstanceId != -1)
         {
            _loc2_ = new Vector.<UnitTypeAmountDTO>();
            _loc2_.push(new UnitTypeAmountDTO(param1.unitTypeId,1));
            dispatch(new OutgoingMessageEvent("outgoingMessage",new KillUnitsInWatchPost(friendWatchPostInstanceId,_loc2_)));
         }
      }
      
      private function onUnitsUpdated(param1:ModelUpdateEvent) : void
      {
         calculateCapacity();
      }
      
      private function onMercenarySelect(param1:ExecutionalGuillotineSelectMercenaryEvent) : void
      {
         calculateCapacity();
      }
      
      private function onCancelClicked(param1:Event) : void
      {
         closeWindow();
      }
      
      private function onExecuteClicked(param1:Event) : void
      {
         var _loc2_:Vector.<UnitTypeAmountDTO> = new Vector.<UnitTypeAmountDTO>();
         for each(var _loc3_ in view.mercenaryViews)
         {
            if(_loc3_.selectedCount > 0)
            {
               _loc2_.push(new UnitTypeAmountDTO(_loc3_.unitTypeDIO.id,_loc3_.selectedCount));
            }
         }
         if(_loc2_.length > 0)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new ExecuteUnitRequest(_loc2_)));
            closeWindow();
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(84)));
         }
      }
      
      private function onSelectAllClicked(param1:Event) : void
      {
         for each(var _loc2_ in view.mercenaryViews)
         {
            _loc2_.selectedCount = _loc2_.mercenaryCount;
         }
         calculateCapacity();
      }
      
      private function calculateCapacity() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = view.viewType == 3 ? 43 : (view.viewType == 4 ? 38 : 19);
         var _loc6_:BuildingTypeDIO = domainInfo.getBuilding(_loc1_);
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.buildingTypeId == _loc1_)
            {
               _loc3_ += _loc6_.buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][_loc2_.level - 1];
            }
         }
         var _loc5_:int = 0;
         for each(var _loc4_ in view.mercenaryViews)
         {
            _loc5_ += (_loc4_.mercenaryCount - _loc4_.selectedCount) * _loc4_.unitTypeDIO.spacesPerLevel[(city.unitTypes[_loc4_.unitTypeDIO.id] as UnitTypeInfo).currentLevel - 1];
         }
         _loc3_ *= view.viewType == 2 ? userInfo.barracksSpaceModifier : 1;
         view.capacityStatus = _loc5_ + " / " + _loc3_;
         view.capacityProgress.maximum = _loc3_;
         view.capacityProgress.value = _loc5_;
      }
   }
}

