package wom.view.mediator.screen.windows.hiringquarters
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.logging.log;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.Environment;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.CancelActiveHiringEvent;
   import wom.controller.event.ui.CancelQueuedHiringEvent;
   import wom.controller.event.ui.MobileHiringQuarterHireEvent;
   import wom.controller.event.ui.MobileHiringQuarterMercenaryInfoEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfoUtil;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.screen.popups.resource.MobileResourceCapacityExceedsPopup;
   import wom.view.screen.popups.unit.MobileNotEnoughResourcePopUp;
   import wom.view.screen.windows.hiringquarters.*;
   
   public class MobileHiringQuartersMercenaryViewMediator extends StarlingMediator
   {
      
      public static var TOUCH_DOWN:Boolean = false;
      
      [Inject]
      public var view:MobileHiringQuartersMercenaryView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      private var pressDownCount:int;
      
      private var mouseDownForHiringMercenary:Boolean = false;
      
      private var mouseDownForQueuedMercenary:Boolean = false;
      
      private var lastEventHandledTime:Number;
      
      public function MobileHiringQuartersMercenaryViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         pressDownCount = 0;
         view.unitTypeDIO = domainInfo.getUnit(view.unitTypeId);
         view.isCentralHiring = BuildingInfoUtil.getBuildingByBuildingInstanceId(city.buildings,view.buildingInstanceId).buildingTypeId == 21;
         onUnitTypesUpdated(null);
         injector.injectInto(view);
         addContextListener("unitTypesUpdated",onUnitTypesUpdated);
         eventMap.mapStarlingListener(view.mercButton,"triggered",onMercButtonClick,starling.events.Event);
         if(view.viewType == 2)
         {
            eventMap.mapStarlingListener(view.mercButton,"touch",onMercButtonTouch,TouchEvent);
            eventMap.mapStarlingListener(view.infoButton,"triggered",onClickInfoButton,starling.events.Event);
         }
         else if(view.viewType == 0)
         {
            addContextListener("askForOverflowInfoUpdated",askForOverflowUpdated,ModelUpdateEvent);
            eventMap.mapStarlingListener(view.subButton,"triggered",onCancelInProgressMercenary,starling.events.Event);
         }
         else if(view.viewType == 1)
         {
            addContextListener("askForOverflowInfoUpdated",askForOverflowUpdated,ModelUpdateEvent);
            eventMap.mapStarlingListener(view.subButton,"triggered",onCancelQueuedMercenary,starling.events.Event);
            eventMap.mapStarlingListener(view.mercButton,"touch",onCancelQueuedMercenaryTouch,TouchEvent);
            eventMap.mapStarlingListener(view.subButton,"touch",onCancelQueuedMercenaryTouch,TouchEvent);
         }
      }
      
      private function onNativeUp(param1:MouseEvent) : void
      {
         MobileHiringQuartersMercenaryViewMediator.TOUCH_DOWN = false;
         resetTouchDown();
         log(WomLoggerContexts.GAME,"________________  ON NATIVE UP RESET ALL __________________");
         Environment.stage.removeEventListener("mouseUp",onNativeUp);
      }
      
      private function onMercButtonTouch(param1:TouchEvent) : void
      {
         var _loc3_:Touch = param1.getTouch(view.mercButton,"began");
         if(_loc3_ && !TOUCH_DOWN)
         {
            addViewListener("enterFrame",onEnterFrame,starling.events.Event);
            pressDownCount = 0;
            mouseDownForHiringMercenary = true;
            MobileHiringQuartersMercenaryViewMediator.TOUCH_DOWN = true;
            Environment.stage.addEventListener("mouseUp",onNativeUp,false,0,true);
            log(WomLoggerContexts.GAME,"FINGER_TEST>> MercDOWN  - id:" + view.unitTypeId);
            lastEventHandledTime = getTimer() + 250;
            view.isMercButtonDown = true;
            view.drawLayout();
            return;
         }
         var _loc2_:Touch = param1.getTouch(view.mercButton,"ended");
         if(_loc2_)
         {
            log(WomLoggerContexts.GAME,"FINGER_TEST>> MercUP  - id:" + view.unitTypeId);
            resetTouchDown();
         }
      }
      
      private function onCancelQueuedMercenaryTouch(param1:TouchEvent) : void
      {
         var _loc3_:Touch = param1.getTouch(view.subButton,"began");
         var _loc2_:Touch = param1.getTouch(view.mercButton,"began");
         if((_loc3_ || _loc2_) && !TOUCH_DOWN)
         {
            addViewListener("enterFrame",onEnterFrame,starling.events.Event);
            pressDownCount = 0;
            mouseDownForQueuedMercenary = true;
            MobileHiringQuartersMercenaryViewMediator.TOUCH_DOWN = true;
            Environment.stage.addEventListener("mouseUp",onNativeUp,false,0,true);
            log(WomLoggerContexts.GAME,"FINGER_TEST>> CancelDOWN - id:" + view.unitTypeId);
            lastEventHandledTime = getTimer() + 250;
            if(_loc2_)
            {
               view.isMercButtonDown = true;
               view.drawLayout();
            }
            return;
         }
         var _loc5_:Touch = param1.getTouch(view.subButton,"ended");
         var _loc4_:Touch = param1.getTouch(view.mercButton,"ended");
         if(_loc5_ || _loc4_)
         {
            log(WomLoggerContexts.GAME,"FINGER_TEST>> CancelUP  - id:" + view.unitTypeId);
            resetTouchDown();
         }
      }
      
      private function resetTouchDown() : void
      {
         removeViewListener("enterFrame",onEnterFrame,starling.events.Event);
         mouseDownForHiringMercenary = false;
         mouseDownForQueuedMercenary = false;
         MobileHiringQuartersMercenaryViewMediator.TOUCH_DOWN = false;
         var _loc1_:Boolean = view.isMercButtonDown;
         view.isMercButtonDown = false;
         if(_loc1_)
         {
            view.drawLayout();
         }
      }
      
      private function onClickInfoButton(param1:starling.events.Event) : void
      {
         if(userInfo.mandatoryTutorialCompleted)
         {
            eventDispatcher.dispatchEvent(new MobileHiringQuarterMercenaryInfoEvent("info",view.unitTypeId));
         }
      }
      
      private function beforeHireMercenary() : void
      {
         var _loc1_:UnitTypeDIO = null;
         var _loc3_:int = 0;
         var _loc2_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc6_:HiringQueueInfo = null;
         var _loc8_:int = 0;
         var _loc5_:HiringSlotView = null;
         var _loc4_:UnitTypeInfo = view.unitTypeInfo;
         if(_loc4_.recruited)
         {
            _loc1_ = view.unitTypeDIO;
            _loc3_ = _loc4_.currentLevel - 1;
            _loc2_ = _loc1_.hiringCostsPerLevel[_loc3_][0].resourceAmount;
            if(_loc2_ > city.resourceAmounts[ResourceType.IRON.id])
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughResourcePopUp(_loc1_.id,ResourceType.IRON)));
               return;
            }
            if(view.isCentralHiring)
            {
               hireMercenary();
               view.showHireAnimation();
               return;
            }
            _loc7_ = false;
            _loc6_ = (city.hiringInfoDictionary[view.buildingInstanceId] as HiringInfo).hiringQueue;
            _loc8_ = 0;
            while(_loc8_ < _loc6_.hiringSlots.length)
            {
               _loc5_ = _loc6_.hiringSlots[_loc8_];
               if(_loc5_.numberOfUnits == 0 || _loc5_.numberOfUnits < 20 && _loc5_.unitId == _loc1_.id)
               {
                  _loc7_ = true;
                  break;
               }
               _loc8_++;
            }
            if(_loc8_ < _loc6_.maxNumberOfHiringSlots)
            {
               _loc7_ = true;
            }
            if(_loc7_)
            {
               hireMercenary();
               view.showHireAnimation();
            }
         }
      }
      
      private function onMercButtonClick(param1:starling.events.Event) : void
      {
         if(view.viewType == 2)
         {
            beforeHireMercenary();
         }
         else if(view.viewType == 1)
         {
            cancelQueuedMercenary();
         }
         else if(view.viewType == 0)
         {
            onCancelInProgressMercenary(param1);
         }
      }
      
      private function hireMercenary() : void
      {
         var _loc1_:Vector.<UnitTypeAmountDTO> = new Vector.<UnitTypeAmountDTO>();
         _loc1_.push(new UnitTypeAmountDTO(view.unitTypeDIO.id,1));
         dispatch(new MobileHiringQuarterHireEvent("hireUnit",view.buildingInstanceId,_loc1_));
      }
      
      private function cancelQueuedMercenary() : void
      {
         var _loc1_:flash.events.Event = null;
         var _loc2_:int = (city.unitTypes[view.unitTypeId] as UnitTypeInfo).currentLevel - 1;
         var _loc3_:ResourceAmountDTO = view.unitTypeDIO.hiringCostsPerLevel[_loc2_][0];
         if(view.dontAskForOverflow)
         {
            dispatch(new CancelQueuedHiringEvent("cancelUnit",view.buildingInstanceId,view.unitTypeId,view.slotIndex,1,false));
         }
         else if(city.hiringSessionResourceAmounts[_loc3_.resourceType] + _loc3_.resourceAmount > city.totalResourceCapacity >> 2)
         {
            resetTouchDown();
            _loc1_ = new CancelQueuedHiringEvent("cancelUnit",view.buildingInstanceId,view.unitTypeId,view.slotIndex,1,false);
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileResourceCapacityExceedsPopup("cancel",_loc1_,"closeSecondaryPopUpWindow")));
         }
         else
         {
            dispatch(new CancelQueuedHiringEvent("cancelUnit",view.buildingInstanceId,view.unitTypeId,view.slotIndex,1,true));
         }
      }
      
      private function onCancelQueuedMercenary(param1:starling.events.Event) : void
      {
         cancelQueuedMercenary();
      }
      
      private function onCancelInProgressMercenary(param1:starling.events.Event) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:flash.events.Event = null;
         for each(var _loc6_ in city.hiringInfoDictionary)
         {
            if(_loc6_.hiringBuildingInstanceId == view.buildingInstanceId)
            {
               if(_loc6_.isHiringPaused)
               {
                  _loc5_ = _loc6_.lastHiredUnitId;
               }
               else
               {
                  if(!_loc6_.activeHiring)
                  {
                     return;
                  }
                  _loc5_ = _loc6_.activeHiring.unitTypeId;
               }
               _loc4_ = (city.unitTypes[_loc5_] as UnitTypeInfo).currentLevel;
               for each(var _loc3_ in domainInfo.getUnit(_loc5_).hiringCostsPerLevel[_loc4_ - 1])
               {
                  if(view.dontAskForOverflow)
                  {
                     dispatch(new CancelActiveHiringEvent("cancelActiveUnit",view.buildingInstanceId,view.unitTypeId,false));
                  }
                  else if(_loc3_.resourceAmount + city.hiringSessionResourceAmounts[_loc3_.resourceType] > city.totalResourceCapacity >> 2)
                  {
                     resetTouchDown();
                     _loc2_ = new CancelActiveHiringEvent("cancelActiveUnit",view.buildingInstanceId,view.unitTypeId,false);
                     dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileResourceCapacityExceedsPopup("cancel",_loc2_,"closeSecondaryPopUpWindow")));
                  }
                  else
                  {
                     dispatch(new CancelActiveHiringEvent("cancelActiveUnit",view.buildingInstanceId,view.unitTypeId,true));
                  }
               }
            }
         }
      }
      
      private function onUnitTypesUpdated(param1:ModelUpdateEvent) : void
      {
         view.unitTypeInfo = city.unitTypes[view.unitTypeDIO.id];
      }
      
      private function onEnterFrame(param1:starling.events.Event) : void
      {
         if(mouseDownForHiringMercenary)
         {
            log(WomLoggerContexts.GAME,">>>>> HiringQuartersMercenaryViewMediator: Mouse Down To Hire <<<<<");
            if(getTimer() > lastEventHandledTime + (pressDownCount > 5 ? 10 : 50))
            {
               log(WomLoggerContexts.GAME,">>>>> HiringQuartersMercenaryViewMediator: Hired! <<<<<");
               pressDownCount = pressDownCount + 1;
               lastEventHandledTime = getTimer();
               hireMercenary();
            }
            if(!MobileHiringQuartersMercenaryViewMediator.TOUCH_DOWN || view.mercButton && view.mercButton.touchState == "up")
            {
               resetTouchDown();
               log(WomLoggerContexts.GAME,"FINGER_TEST >>> RESET DOWN MERC:" + MobileHiringQuartersMercenaryViewMediator.TOUCH_DOWN + " - UP STATE: " + view.mercButton.touchState);
            }
         }
         else if(mouseDownForQueuedMercenary)
         {
            log(WomLoggerContexts.GAME,">>>>> HiringQuartersMercenaryViewMediator: Mouse Down To Cancel Hiring <<<<<");
            if(getTimer() > lastEventHandledTime + (pressDownCount > 5 ? 10 : 50))
            {
               log(WomLoggerContexts.GAME,">>>>> HiringQuartersMercenaryViewMediator: Hire Cancelled! <<<<<");
               pressDownCount = pressDownCount + 1;
               lastEventHandledTime = getTimer();
               cancelQueuedMercenary();
            }
            if(!MobileHiringQuartersMercenaryViewMediator.TOUCH_DOWN || view.subButton && view.subButton.touchState == "up" && (view.mercButton && view.mercButton.touchState == "up"))
            {
               resetTouchDown();
               log(WomLoggerContexts.GAME,"FINGER_TEST >>> RESET DOWN SUB:" + MobileHiringQuartersMercenaryViewMediator.TOUCH_DOWN + " - UP STATE: " + view.mercButton.touchState);
            }
         }
      }
      
      private function askForOverflowUpdated(param1:ModelUpdateEvent) : void
      {
         view.dontAskForOverflow = true;
      }
   }
}

