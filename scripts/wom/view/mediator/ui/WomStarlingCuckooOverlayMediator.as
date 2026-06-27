package wom.view.mediator.ui
{
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.cuckoo.game.attribute.view.StarlingCuckooOverlay;
   import wom.view.ui.MobileWomCuckooUILayer;
   
   public class WomStarlingCuckooOverlayMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:StarlingCuckooOverlay;
      
      private var _womCuckooUILayer:MobileWomCuckooUILayer;
      
      public function WomStarlingCuckooOverlayMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         trace("__WomStarlingCuckooOverlayMediator");
         super.onRegister();
         view.addChild(_womCuckooUILayer = new MobileWomCuckooUILayer());
      }
      
      override public function onRemove() : void
      {
         trace("__WomStarlingCuckooOverlayMediator.onRemove");
         super.onRemove();
         view.removeChild(_womCuckooUILayer);
      }
   }
}

