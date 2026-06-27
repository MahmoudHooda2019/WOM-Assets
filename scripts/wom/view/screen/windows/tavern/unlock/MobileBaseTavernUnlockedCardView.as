package wom.view.screen.windows.tavern.unlock
{
   import peak.display.View;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileBaseTavernUnlockedCardView extends Sprite implements View
   {
      
      public static const BASE_WIDTH:int = 90;
      
      public static const BASE_HEIGHT:int = 83;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var viewWidth:int;
      
      protected var viewHeight:int;
      
      private var _background:DisplayObject;
      
      public function MobileBaseTavernUnlockedCardView(param1:int = 90, param2:int = 83)
      {
         super();
         this.viewWidth = param1;
         this.viewHeight = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         resetBackgroundWithAsset(assetRepository.getDisplayObject("MercSlotBackground"));
         drawLayout();
      }
      
      public function drawLayout() : void
      {
      }
      
      public function get background() : DisplayObject
      {
         return _background;
      }
      
      public function set background(param1:DisplayObject) : void
      {
         _background = param1;
      }
      
      protected function resetBackgroundWithAsset(param1:DisplayObject) : void
      {
         removeChild(_background);
         _background = param1;
         _background.width = viewWidth;
         _background.height = viewHeight;
         addChild(_background);
      }
   }
}

