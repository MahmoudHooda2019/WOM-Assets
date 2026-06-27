package wom.view.mediator.ui.mainframe
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.display.ViewportResizeEvent;
   import wom.view.ui.mainframe.MobileUILayer;
   
   public class MobileUILayerMediator extends StarlingMediator
   {
      
      [Inject]
      public var uiLayer:MobileUILayer;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileUILayerMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(uiLayer);
         uiLayer.visibleWidth = contextView.stage.stageWidth;
         uiLayer.visibleHeight = contextView.stage.stageHeight;
         resizeLayer(contextView.stage.stageWidth,contextView.stage.stageHeight);
         addContextListener("resize",onScreenResize,ViewportResizeEvent);
      }
      
      private function onScreenResize(param1:ViewportResizeEvent) : void
      {
         resizeLayer(param1.viewport.width,param1.viewport.height);
      }
      
      protected function resizeLayer(param1:int, param2:int) : void
      {
         uiLayer.visibleWidth = param1;
         uiLayer.visibleHeight = param2;
         uiLayer.drawLayout();
      }
   }
}

