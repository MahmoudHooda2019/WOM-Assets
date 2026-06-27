package wom.view.mediator.ui.mainframe
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.display.ViewportResizeEvent;
   import wom.controller.event.combat.CombatHelpTextEvent;
   import wom.view.ui.MobileCombatHelpTextLayer;
   
   public class MobileCombatHelpTextLayerMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCombatHelpTextLayer;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileCombatHelpTextLayerMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         view.visibleWidth = contextView.stage.stageWidth;
         view.visibleHeight = contextView.stage.stageHeight;
         resizeLayer(contextView.stage.stageWidth,contextView.stage.stageHeight);
         addContextListener("resize",onScreenResize,ViewportResizeEvent);
         addContextListener("tapWarButtonText",onCombatHelpTextEvent,CombatHelpTextEvent);
         addContextListener("cityOutOfReachText",onCombatHelpTextEvent,CombatHelpTextEvent);
         addContextListener("firstUnitDeployText",onCombatHelpTextEvent,CombatHelpTextEvent);
      }
      
      private function onScreenResize(param1:ViewportResizeEvent) : void
      {
         view.resizeLayer(param1.viewport.width,param1.viewport.height);
      }
      
      private function onCombatHelpTextEvent(param1:CombatHelpTextEvent) : void
      {
         view.combatHelpTextUpdate(param1.visible,param1.type);
      }
      
      protected function resizeLayer(param1:int, param2:int) : void
      {
         view.visibleWidth = param1;
         view.visibleHeight = param2;
      }
   }
}

