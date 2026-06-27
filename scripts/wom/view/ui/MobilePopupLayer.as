package wom.view.ui
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   
   public class MobilePopupLayer extends Sprite
   {
      
      public static const MIN_SCREEN_WIDTH:int = 760;
      
      public static const MIN_SCREEN_HEIGHT:int = 620;
      
      public static const MARGIN:int = 5;
      
      public static const TWEENMAX_DURATION:Number = 0.3;
      
      private var _visibleWidth:int;
      
      private var _visibleHeight:int;
      
      private var _lastAddedWindow:DisplayObject;
      
      public function MobilePopupLayer()
      {
         super();
         _visibleWidth = 760;
         _visibleHeight = 620;
         createMembers();
         build();
         positionMembers();
      }
      
      private function createMembers() : void
      {
      }
      
      public function positionMembers() : void
      {
      }
      
      private function build() : void
      {
      }
      
      public function addPopUpWindow(param1:DisplayObject) : void
      {
         _lastAddedWindow = param1;
         addChild(param1);
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
      
      public function get lastAddedWindowPosition() : Point
      {
         if(_lastAddedWindow != null)
         {
            return new Point(_lastAddedWindow.x,_lastAddedWindow.y);
         }
         return null;
      }
      
      public function resizeLayer(param1:int, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         _visibleWidth = param1;
         _visibleHeight = param2;
         _loc6_ = 0;
         while(_loc6_ < numChildren)
         {
            _loc3_ = getChildAt(_loc6_);
            _loc5_ = int("windowWidth" in _loc3_ ? _loc3_["windowWidth"] : _loc3_.width);
            _loc4_ = int("windowHeight" in _loc3_ ? _loc3_["windowHeight"] : _loc3_.height);
            _loc3_.x = int((_visibleWidth - _loc5_) / 2);
            _loc3_.y = int((_visibleHeight - _loc4_) / 2);
            _loc6_++;
         }
      }
   }
}

