package wom.view.mediator.ui.common
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.view.ui.common.MobileLightAnimationView;
   
   public class MobileLightAnimationViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileLightAnimationView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileLightAnimationViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.animationAsset1,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.animationAsset2,"change",onAssetChanged,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
   }
}

