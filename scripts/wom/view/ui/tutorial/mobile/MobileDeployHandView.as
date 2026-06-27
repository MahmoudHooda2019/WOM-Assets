package wom.view.ui.tutorial.mobile
{
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileDeployHandView extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _hand:DisplayObject;
      
      public function MobileDeployHandView()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         _hand = assetRepository.getDisplayObject("DeployHand");
         _hand.touchable = false;
         addChild(_hand);
      }
      
      public function get hand() : DisplayObject
      {
         return _hand;
      }
   }
}

