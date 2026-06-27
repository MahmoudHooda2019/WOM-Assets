package wom.view.mediator.screen.windows.tavern
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.view.screen.windows.tavern.MobileTavernGiftView;
   
   public class MobileTavernGiftViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileTavernGiftView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileTavernGiftViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.tavernItemAsset,"change",onAssetChanged,Event);
         rotateAndHide();
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function rotateAndHide() : void
      {
         view.startGiftAnimation();
      }
   }
}

