package wom.view.mediator.ui.mainframe.combat.catapult
{
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.AttackInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultMenuTab;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultMenuView;
   
   public class MobileCatapultMenuTabMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCatapultMenuTab;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      public function MobileCatapultMenuTabMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         addContextListener("attackInfoUpdated",onAttackInfoUpdated);
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         if(view.hitTest(view.globalToLocal(new Point(param1.stageX,param1.stageY))) == null)
         {
            checkMouseUp();
         }
      }
      
      private function checkMouseUp() : void
      {
         if(view.activeCatapultMenuOptions && view.activeCatapultMenuOptions.visible)
         {
            view.activeCatapultMenuOptions.visible = false;
         }
         for each(var _loc1_ in view.catapultViews)
         {
            if(_loc1_.button.isSelected)
            {
               _loc1_.button.isSelected = false;
            }
         }
      }
      
      private function onAttackInfoUpdated(param1:ModelUpdateEvent) : void
      {
         if(attackInfo.deployPassed)
         {
            view.clearCatapults();
         }
      }
   }
}

