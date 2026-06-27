package wom.view.mediator.ui
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.display.ViewportResizeEvent;
   import wom.view.ui.MobileLoadingLayer;
   
   public class MobileLoadingLayerMediator extends StarlingMediator
   {
      
      private static const ROTATE_SPEED_IN_ANGLE:Number = 5;
      
      [Inject]
      public var view:MobileLoadingLayer;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileLoadingLayerMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         resizeScreen(contextView.stage.stageWidth,contextView.stage.stageHeight);
         addContextListener("resize",onScreenResize,ViewportResizeEvent);
      }
      
      private function onScreenResize(param1:ViewportResizeEvent) : void
      {
         resizeScreen(contextView.stage.stageWidth,contextView.stage.stageHeight);
      }
      
      private function resizeScreen(param1:int, param2:int) : void
      {
         view.visibleWidth = param1;
         view.visibleHeight = param2;
         view.resizeScreen();
      }
   }
}

