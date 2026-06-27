package wom.view.ui
{
   import starling.display.Quad;
   import starling.display.Sprite;
   
   public class MobileModalLayer extends Sprite
   {
      
      public static const DEFAULT_ALPHA:Number = 0.8;
      
      public static const MIN_SCREEN_WIDTH:int = 760;
      
      public static const MIN_SCREEN_HEIGHT:int = 620;
      
      public static const MARGIN:int = 5;
      
      private var _visibleWidth:int;
      
      private var _visibleHeight:int;
      
      private var quad:Quad;
      
      public function MobileModalLayer()
      {
         super();
         _visibleWidth = 760;
         _visibleHeight = 620;
         this.alpha = 0.8;
         init();
      }
      
      private function init() : void
      {
         updateQuad();
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
      
      public function resizeLayer(param1:int, param2:int) : void
      {
         visibleWidth = param1;
         visibleHeight = param2;
         updateQuad();
      }
      
      private function updateQuad() : void
      {
         if(!quad)
         {
            quad = new Quad(_visibleWidth,_visibleHeight,0);
            quad.alpha = 0.8;
            addChild(quad);
         }
         quad.width = _visibleWidth;
         quad.height = _visibleHeight;
      }
   }
}

