package wom.view.mediator.screen.windows.tavern
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Circ;
   import com.greensock.easing.Linear;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import peak.logging.log;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.TavernItemDIO;
   import wom.model.game.UserInfo;
   import wom.model.game.gold.GoldCostConstants;
   import wom.model.game.tavern.TavernInfo;
   import wom.model.message.request.tavern.TavernSpinRequest;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.tavern.MobileTavernWindow;
   
   public class MobileTavernWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileTavernWindow;
      
      [Inject]
      public var tavernInfo:TavernInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var goldCostConstants:GoldCostConstants;
      
      internal var closeWindowTimer:Timer;
      
      internal var tavernSpecificBeastUnlocked:Boolean;
      
      public function MobileTavernWindowMediator()
      {
         super();
      }
      
      private static function toRad(param1:Number) : Number
      {
         return param1 / 180 * 3.141592653589793;
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         closeWindowTimer = new Timer(10000,1);
         closeWindowTimer.addEventListener("timer",closeWindowTimerListener);
         tavernSpecificBeastUnlocked = checkTavernSpecificBeastUnlocked();
         addContextListener("tick",onTick,GameTickEvent);
         updateSpinButton();
      }
      
      private function closeWindowTimerListener(param1:TimerEvent) : void
      {
         closeWindow();
      }
      
      private function checkByGold() : Boolean
      {
         return tavernInfo.tillNextSpin > 0 && getTimer() < tavernInfo.tillNextSpin;
      }
      
      private function updateSpinButton() : void
      {
         view.updateSpinButton(checkByGold(),goldCostConstants.tavernSpinCost);
         eventMap.unmapStarlingListener(view.spinButton,"triggered",onSpinButtonClicked,Event);
         eventMap.mapStarlingListener(view.spinButton,"triggered",onSpinButtonClicked,Event);
      }
      
      private function onSpinButtonClicked() : void
      {
         if(checkByGold() && userInfo.numberOfGolds < goldCostConstants.tavernSpinCost)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
            return;
         }
         view.spinButton.visible = false;
         tavernInfo.spinInfo.spin();
         dispatch(new OutgoingMessageEvent("outgoingMessage",new TavernSpinRequest()));
         var _loc1_:Number = 360 + tavernInfo.spinInfo.lastSpinVisualOrder * 22.5;
         TweenMax.to(view.wheelView,_loc1_ / 180,{
            "rotation":toRad(_loc1_),
            "ease":Circ.easeIn,
            "onComplete":infiniteSpin
         });
         log(WomLoggerContexts.GAME,"Tween 1");
      }
      
      private function infiniteSpin() : void
      {
         TweenMax.to(view.wheelView,1,{
            "rotation":3.141592653589793 * 2,
            "ease":Linear.easeNone,
            "onComplete":checkSpinResult
         });
         log(WomLoggerContexts.GAME,"Tween 2");
      }
      
      private function checkSpinResult() : void
      {
         var _loc2_:TavernItemDIO = null;
         var _loc1_:Number = NaN;
         tavernInfo.spinInfo.turn();
         if(tavernInfo.spinInfo.isMinTurnSatisfied() && tavernInfo.spinInfo.resultTavernItemDIO != null)
         {
            checkWindowClosable();
            _loc2_ = tavernInfo.spinInfo.resultTavernItemDIO;
            _loc1_ = 360 + (16 - _loc2_.visualOrder) * 22.5;
            TweenMax.to(view.wheelView,_loc1_ / 90,{
               "rotation":toRad(_loc1_),
               "ease":Circ.easeOut,
               "repeat":0,
               "onComplete":stopSpin
            });
            log(WomLoggerContexts.GAME,"Tween 3");
         }
         else if(tavernInfo.spinInfo.spinCancelled)
         {
            TweenMax.to(view.wheelView,4,{
               "rotation":3.141592653589793 * 2,
               "ease":Circ.easeOut,
               "repeat":0,
               "onComplete":stopSpin
            });
            log(WomLoggerContexts.GAME,"Tween 4");
            tavernInfo.spinInfo.spinCancelled = false;
         }
         else
         {
            infiniteSpin();
         }
      }
      
      private function stopSpin() : void
      {
         if(tavernInfo.spinInfo.resultTavernItemDIO != null)
         {
            view.updateGiftView(tavernInfo.spinInfo.resultTavernItemDIO);
            dispatch(new ModelUpdateEvent("tavernCardUnlocked"));
         }
         tavernInfo.spinInfo.stop();
         updateSpinButton();
      }
      
      private function checkWindowClosable() : void
      {
         if(!tavernSpecificBeastUnlocked && checkTavernSpecificBeastUnlocked())
         {
            closeWindowTimer.start();
         }
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         var _loc2_:Boolean = false;
         if(view.spinButton && view.spinButton.visible)
         {
            _loc2_ = checkByGold();
            if(_loc2_ && view.spinButton.color == "Blue" || !_loc2_ && view.spinButton.color == "Green")
            {
               updateSpinButton();
            }
         }
      }
      
      private function checkTavernSpecificBeastUnlocked() : Boolean
      {
         var _loc1_:BeastTypeDIO = domainInfo.getBeast(33);
         if(_loc1_ != null)
         {
            return _loc1_.unlocked;
         }
         return false;
      }
   }
}

