package wom.view.mediator.screen.windows.tavern
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.view.screen.windows.tavern.MobileTavernWheelSliceView;
   
   public class MobileTavernWheelSliceViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileTavernWheelSliceView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileTavernWheelSliceViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.tavernItemAsset,"change",onAssetChanged,Event);
      }
      
      private function onAssetChanged() : void
      {
         view.drawLayout();
      }
   }
}

