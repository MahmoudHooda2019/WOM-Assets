package wom.view.util
{
   import peak.display.View;
   import starling.display.DisplayObject;
   import starling.display.Quad;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileBaseWindowPanel extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var _visibleWidth:int;
      
      protected var _visibleHeight:int;
      
      protected var bg:DisplayObject;
      
      public function MobileBaseWindowPanel(param1:int, param2:int)
      {
         super();
         _visibleWidth = param1;
         _visibleHeight = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         drawBackground();
      }
      
      public function drawLayout() : void
      {
      }
      
      protected function get backgroundAssetId() : String
      {
         return "MobileDarkBackground";
      }
      
      protected function drawBackground() : void
      {
         if(backgroundAssetId == "TransparentAsset")
         {
            bg = new Quad(_visibleWidth,_visibleHeight,0,0);
            bg.alpha = 0;
         }
         else
         {
            bg = assetRepository.getDisplayObject(backgroundAssetId);
            bg.width = _visibleWidth;
            bg.height = _visibleHeight;
         }
         addChildAt(bg,0);
      }
      
      public function get visibleWidth() : int
      {
         return _visibleWidth;
      }
      
      public function get visibleHeight() : int
      {
         return _visibleHeight;
      }
      
      public function updateBackground(param1:int, param2:int) : void
      {
         bg.width = _visibleWidth = param1;
         bg.height = _visibleHeight = param2;
      }
   }
}

