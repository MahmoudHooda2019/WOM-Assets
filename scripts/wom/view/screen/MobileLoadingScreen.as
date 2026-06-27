package wom.view.screen
{
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileLoadingScreen extends MobileBaseScreen
   {
      
      public static const MIN_SCREEN_WIDTH:int = 760;
      
      public static const MIN_SCREEN_HEIGHT:int = 620;
      
      private static const RADIUS:int = 450;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _visibleWidth:int;
      
      private var _visibleHeight:int;
      
      private var manuelAuth:Boolean;
      
      public function MobileLoadingScreen(param1:Boolean = false)
      {
         super();
         this.manuelAuth = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      protected function initLayout() : void
      {
      }
      
      private function onTweenRepeat() : void
      {
      }
      
      private function drawLayout() : void
      {
      }
      
      public function resizeScreen() : void
      {
         drawLayout();
      }
      
      public function get visibleWidth() : int
      {
         return _visibleWidth < 760 ? 760 : _visibleWidth;
      }
      
      public function get visibleHeight() : int
      {
         return _visibleHeight < 620 ? 620 : _visibleHeight;
      }
      
      public function set visibleWidth(param1:int) : void
      {
         _visibleWidth = param1;
      }
      
      public function set visibleHeight(param1:int) : void
      {
         _visibleHeight = param1;
      }
   }
}

