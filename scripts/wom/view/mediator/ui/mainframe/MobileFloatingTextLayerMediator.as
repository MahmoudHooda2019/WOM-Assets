package wom.view.mediator.ui.mainframe
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.display.ViewportResizeEvent;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.WomScreenType;
   import wom.view.ui.MobileFloatingTextLayer;
   
   public class MobileFloatingTextLayerMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileFloatingTextLayer;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileFloatingTextLayerMediator()
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
         addContextListener("activate",onScreenActivation,ActivateScreenEvent);
         addContextListener("spyStatusChange",onSpyStatusChange,ModelUpdateEvent);
         addContextListener("itemsTabOpened",onItemsTabOpened,CombatEventItemsEvent);
         addContextListener("mobileUINotificationEventShow",onNotificationShow,MobileUINotificationEvent);
      }
      
      private function onNotificationShow(param1:MobileUINotificationEvent) : void
      {
         view.showNotification(param1.message,param1.delay);
      }
      
      private function onScreenResize(param1:ViewportResizeEvent) : void
      {
         view.resizeLayer(param1.viewport.width,param1.viewport.height);
      }
      
      protected function resizeLayer(param1:int, param2:int) : void
      {
         view.visibleWidth = param1;
         view.visibleHeight = param2;
      }
      
      private function onScreenActivation(param1:ActivateScreenEvent) : void
      {
         if(param1.screen == WomScreenType.LOADING)
         {
            view.resetEventItemsShownStatus();
         }
         view.fadeOutSprite.alpha = 0;
      }
      
      private function onSpyStatusChange(param1:ModelUpdateEvent) : void
      {
         if(city && city.spyEnabled)
         {
            view.showSpyInformation();
         }
      }
      
      private function onItemsTabOpened(param1:CombatEventItemsEvent) : void
      {
         view.showEventItemsInformation();
      }
   }
}

