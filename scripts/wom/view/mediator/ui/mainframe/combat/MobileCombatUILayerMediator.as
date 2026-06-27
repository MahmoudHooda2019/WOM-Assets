package wom.view.mediator.ui.mainframe.combat
{
   import flash.desktop.NativeApplication;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.KeepAliveEvent;
   import wom.controller.event.WindowCreationEvent;
   import wom.controller.event.combat.CombatHelpTextEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.ui.VictoryMeterEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.mediator.ui.mainframe.MobileUILayerMediator;
   import wom.view.ui.mainframe.combat.MobileCombatUILayer;
   
   public class MobileCombatUILayerMediator extends MobileUILayerMediator
   {
      
      [Inject]
      public var view:MobileCombatUILayer;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileCombatUILayerMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("getCombatMenuPanelPosition",onCombatMenuPanelPositionRequested,TutorialReferencePositionEvent);
         addContextListener("visibilityChanged",onVictoryMeterVisibilityChanged,VictoryMeterEvent);
         eventMap.mapStarlingListener(view.settingsView,"touch",onSettingsClicked,TouchEvent);
         onGameModeChange(null);
         addContextListener("gameModeChange",onGameModeChange,GameModeChangedEvent);
      }
      
      private function onVictoryMeterVisibilityChanged(param1:VictoryMeterEvent) : void
      {
         view.drawLayout();
      }
      
      private function startKeepAliveTimer() : void
      {
         view.keepAliveTimer.addEventListener("timer",onKeepAlive);
         view.keepAliveTimer.start();
         NativeApplication.nativeApplication.systemIdleMode = "keepAwake";
      }
      
      private function stopKeepAliveTimer() : void
      {
         view.keepAliveTimer.stop();
         NativeApplication.nativeApplication.systemIdleMode = "normal";
      }
      
      private function onGameModeChange(param1:GameModeChangedEvent) : void
      {
         view.keepAliveTimer.removeEventListener("timer",onKeepAlive);
         if(userInfo.gameMode == GameModeType.ATTACK)
         {
            view.attackMode();
            startKeepAliveTimer();
         }
         else if(userInfo.gameMode == GameModeType.TUSK_HORN)
         {
            view.tuskHornMode();
            startKeepAliveTimer();
         }
         else if(userInfo.gameMode == GameModeType.VISIT)
         {
            view.scoutMode();
            stopKeepAliveTimer();
            if(userInfo.mandatoryTutorialCompleted)
            {
               if(view.combatMenuPanel.warMenuButton.isEnabled)
               {
                  dispatch(new CombatHelpTextEvent("tapWarButtonText",true));
               }
               else
               {
                  dispatch(new CombatHelpTextEvent("cityOutOfReachText",true));
               }
            }
         }
      }
      
      private function onKeepAlive(param1:TimerEvent) : void
      {
         dispatch(new KeepAliveEvent("keepAlive"));
      }
      
      override public function onRemove() : void
      {
         stopKeepAliveTimer();
         super.onRemove();
      }
      
      private function onCombatMenuPanelPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         sendPanelPosition(view.combatMenuPanelPosition,param1.objectToBeAligned);
      }
      
      private function sendPanelPosition(param1:Point, param2:int) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param2,param1));
      }
      
      private function onSettingsClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.settingsView,"ended");
         if(_loc2_)
         {
            dispatch(new WindowCreationEvent("createWindow",new WindowEnumeration(203,{})));
         }
      }
   }
}

