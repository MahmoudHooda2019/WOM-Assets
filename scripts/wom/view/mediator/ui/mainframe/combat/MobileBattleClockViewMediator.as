package wom.view.mediator.ui.mainframe.combat
{
   import flash.utils.getTimer;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.GameTickEvent;
   import wom.model.game.AttackInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.attack.GameModeType;
   import wom.view.ui.mainframe.combat.MobileBattleClockView;
   
   public class MobileBattleClockViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBattleClockView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      public function MobileBattleClockViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("tick",onTick,GameTickEvent);
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         var _loc2_:Number = NaN;
         if(userInfo.gameMode == GameModeType.ATTACK || userInfo.gameMode == GameModeType.TUSK_HORN)
         {
            view.visible = userInfo.mandatoryTutorialCompleted;
            if(view.visible)
            {
               _loc2_ = (attackInfo.deployPassed ? attackInfo.attackEndTime : attackInfo.attackStartTime + 300000) - getTimer();
               if(_loc2_ > 0)
               {
                  view.updateInformation(attackInfo.deployPassed,_loc2_);
               }
            }
         }
      }
   }
}

