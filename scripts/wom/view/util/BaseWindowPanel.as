package wom.view.util
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import peak.display.View;
   import wom.model.resource.WomAssetRepository;
   
   public class BaseWindowPanel extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      protected var _visibleWidth:int;
      
      protected var _visibleHeight:int;
      
      protected var bg:DisplayObject;
      
      public function BaseWindowPanel(param1:int, param2:int)
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
         return "TabBackground";
      }
      
      protected function drawBackground() : void
      {
         bg = assetRepository.getDisplayObject(backgroundAssetId);
         bg.width = _visibleWidth;
         bg.height = _visibleHeight;
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

