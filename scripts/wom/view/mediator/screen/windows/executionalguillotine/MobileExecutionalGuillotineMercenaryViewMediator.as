package wom.view.mediator.screen.windows.executionalguillotine
{
   import flash.utils.getTimer;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ExecuteWatchPostUnitEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.ExecutionalGuillotineSelectMercenaryEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.request.BuyUnitRequest;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.executionalguillotine.MobileExecutionalGuillotineMercenaryView;
   
   public class MobileExecutionalGuillotineMercenaryViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileExecutionalGuillotineMercenaryView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      private var friendWatchPostId:int;
      
      private var pressDownCount:int;
      
      private var mouseDownForExecuteMercenary:Boolean = false;
      
      private var mouseDownForCancelMercenary:Boolean = false;
      
      private var lastEventHandledTime:Number;
      
      public function MobileExecutionalGuillotineMercenaryViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         onUnitTypesUpdated(null);
         injector.injectInto(view);
         friendWatchPostId = findFriendWatchPostId();
         updateCount();
         addContextListener("unitsInWatchPostUpdated",unitsUpdated);
         addContextListener("unitsInBarracksUpdated",unitsUpdated);
         addContextListener("unitTypesUpdated",unitsUpdated);
         addViewListener("enterFrame",onEnterFrame,Event);
         if(view.viewType == 1)
         {
            eventMap.mapStarlingListener(view.mercButton,"touch",onMercButtonTouch,TouchEvent);
            eventMap.mapStarlingListener(view.mercButton,"triggered",selectMercenaryToExecute,Event);
            eventMap.mapStarlingListener(view.subButton,"touch",onSubButtonTouch,TouchEvent);
            eventMap.mapStarlingListener(view.subButton,"triggered",deselectMercenaryToExecute,Event);
         }
         else if(view.viewType == 2)
         {
            addContextListener("unitTypesUpdated",onUnitTypesUpdated);
            eventMap.mapStarlingListener(view.hireButton,"triggered",onHireButtonClicked,Event);
         }
         else if(view.viewType == 4)
         {
            addContextListener("unitTypesUpdated",onUnitTypesUpdated);
            eventMap.mapStarlingListener(view.subButton,"triggered",onExecuteButtonClicked,Event);
         }
      }
      
      public function onMercButtonTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.mercButton,"began");
         if(_loc2_)
         {
            pressDownCount = 0;
            mouseDownForExecuteMercenary = true;
            lastEventHandledTime = getTimer() + 250;
            view.isMercButtonDown = true;
         }
         var _loc3_:Touch = param1.getTouch(view.mercButton,"ended");
         if(_loc3_)
         {
            mouseDownForExecuteMercenary = false;
            view.isMercButtonDown = false;
         }
         view.drawLayout();
      }
      
      public function onSubButtonTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.subButton,"began");
         if(_loc2_)
         {
            pressDownCount = 0;
            mouseDownForCancelMercenary = true;
            lastEventHandledTime = getTimer() + 250;
         }
         var _loc3_:Touch = param1.getTouch(view.subButton,"ended");
         if(_loc3_)
         {
            mouseDownForCancelMercenary = false;
         }
      }
      
      private function onExecuteButtonClicked(param1:Event) : void
      {
         dispatch(new ExecuteWatchPostUnitEvent("executeWatchPostUnit",view.unitTypeDIO.id));
      }
      
      private function unitsUpdated(param1:ModelUpdateEvent) : void
      {
         updateCount();
      }
      
      private function onUnitTypesUpdated(param1:ModelUpdateEvent) : void
      {
         view.unitTypeInfo = city.unitTypes[view.unitTypeDIO.id];
      }
      
      private function onHireButtonClicked(param1:Event) : void
      {
         var _loc7_:int = 0;
         var _loc9_:BuildingTypeDIO = null;
         var _loc10_:int = 0;
         var _loc4_:UnitTypeDIO = null;
         var _loc8_:UnitTypeInfo = null;
         var _loc2_:int = 0;
         var _loc5_:int = view.unitTypeDIO.barracksGoldPricesPerLevel[(city.unitTypes[view.unitTypeDIO.id] as UnitTypeInfo).currentLevel - 1];
         if(_loc5_ > userInfo.numberOfGolds)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold",MonetizationType.NOT_ENOUGH_GOLD)));
         }
         else
         {
            _loc7_ = 0;
            _loc9_ = domainInfo.getBuilding(19);
            for each(var _loc6_ in city.buildings)
            {
               if(_loc6_.buildingTypeId == 19)
               {
                  _loc7_ += _loc9_.buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][_loc6_.level - 1];
               }
            }
            _loc10_ = 0;
            for each(var _loc3_ in city.units)
            {
               if(_loc3_.status == UnitStatusType.IN_BARRACKS)
               {
                  _loc4_ = domainInfo.getUnit(_loc3_.typeId);
                  _loc8_ = city.unitTypes[_loc3_.typeId];
                  _loc10_ += _loc4_.spacesPerLevel[_loc8_.currentLevel - 1];
               }
            }
            _loc7_ *= userInfo.barracksSpaceModifier;
            _loc2_ = _loc7_ - _loc10_;
            if(_loc2_ < view.unitTypeDIO.spacesPerLevel[view.unitTypeInfo.currentLevel - 1])
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(78)));
            }
            else
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyUnitRequest(view.unitTypeDIO.id)));
            }
         }
      }
      
      private function selectMercenaryToExecute() : void
      {
         if(view.selectedCount < view.mercenaryCount && view.viewType == 1)
         {
            view.selectedCount++;
            eventDispatcher.dispatchEvent(new ExecutionalGuillotineSelectMercenaryEvent("executionalGuillotineSelectMercenaryEvent"));
         }
      }
      
      private function deselectMercenaryToExecute() : void
      {
         if(view.selectedCount > 0 && view.mercenaryCount > 0 && view.viewType == 1)
         {
            view.selectedCount--;
            eventDispatcher.dispatchEvent(new ExecutionalGuillotineSelectMercenaryEvent("executionalGuillotineSelectMercenaryEvent"));
         }
      }
      
      private function updateCount() : void
      {
         var _loc2_:int = 0;
         var _loc3_:UnitStatusType = view.viewType == 3 ? UnitStatusType.IN_ALLIANCE_BARRACKS : UnitStatusType.IN_BARRACKS;
         for each(var _loc1_ in city.units)
         {
            if(_loc1_.typeId == view.unitTypeDIO.id && (view.viewType == 4 && _loc1_.buildingId == friendWatchPostId || view.viewType != 4 && _loc1_.status == _loc3_))
            {
               _loc2_++;
            }
         }
         view.updateMercenaryCount(_loc2_);
      }
      
      private function findFriendWatchPostId() : int
      {
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.buildingTypeId == 38)
            {
               return _loc1_.instanceId;
            }
         }
         return -1;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(mouseDownForExecuteMercenary)
         {
            if(getTimer() > lastEventHandledTime + (pressDownCount > 5 ? 10 : 50))
            {
               pressDownCount = pressDownCount + 1;
               lastEventHandledTime = getTimer();
               selectMercenaryToExecute();
            }
         }
         if(mouseDownForCancelMercenary)
         {
            if(getTimer() > lastEventHandledTime + (pressDownCount > 5 ? 10 : 50))
            {
               pressDownCount = pressDownCount + 1;
               lastEventHandledTime = getTimer();
               deselectMercenaryToExecute();
            }
         }
      }
   }
}

