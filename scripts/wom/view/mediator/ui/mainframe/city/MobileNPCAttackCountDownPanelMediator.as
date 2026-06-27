package wom.view.mediator.ui.mainframe.city
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.defense.NPCAttackStatus;
   import wom.model.message.request.StartNPCAttackRequest;
   import wom.view.ui.mainframe.city.MobileNPCAttackCountDownPanel;
   
   public class MobileNPCAttackCountDownPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileNPCAttackCountDownPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileNPCAttackCountDownPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("npcAttackStatusUpdated",onNPCAttackStatusUpdated);
         addContextListener("gameModeChange",onGameModeChanged);
         eventMap.mapStarlingListener(view.engageButton,"touch",onEngageButton,TouchEvent);
      }
      
      private function onGameModeChanged(param1:GameModeChangedEvent) : void
      {
         checkNPCAttackStatus();
      }
      
      private function onNPCAttackStatusUpdated(param1:ModelUpdateEvent) : void
      {
         checkNPCAttackStatus();
      }
      
      private function checkNPCAttackStatus() : void
      {
         if(userInfo.canReceiveNPCAttacks)
         {
            if(userInfo.npcAttackStatus == NPCAttackStatus.DELAY && userInfo.gameMode == GameModeType.NORMAL)
            {
               addContextListener("tick",onTick,GameTickEvent);
               view.visible = true;
            }
            else
            {
               view.visible = false;
               removeContextListener("tick",onTick,GameTickEvent);
            }
         }
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         var _loc2_:Number = userInfo.remainingDurationToNextNPCAttack + userInfo.npcDurationSaveTime - new Date().getTime();
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
            removeContextListener("tick",onTick,GameTickEvent);
            return;
         }
         view.updateRemainingDuration(_loc2_);
      }
      
      public function onEngageButton(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.engageButton,"ended");
         if(_loc2_)
         {
            userInfo.npcAttackStatus = NPCAttackStatus.INIT_ATTACK;
            dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
            dispatch(new OutgoingMessageEvent("outgoingMessage",new StartNPCAttackRequest()));
         }
      }
   }
}

