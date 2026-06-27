package peak.component.mobile
{
   import feathers.controls.Button;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.DisplayObject;
   
   public class MPButton extends Button
   {
      
      private var _padLeft:Number = 0;
      
      private var _padRight:Number = 0;
      
      private var _padTop:Number = 0;
      
      private var _padBottom:Number = 0;
      
      public function MPButton(param1:Boolean = false)
      {
         super();
         this.label = "";
         this.useHandCursor = true;
         this.isFocusEnabled = false;
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(param2 && (!visible || !touchable))
         {
            return null;
         }
         var _loc3_:Rectangle = getBounds(this);
         _loc3_.x -= _padLeft;
         _loc3_.width += _padLeft;
         _loc3_.width += _padRight;
         _loc3_.y -= _padTop;
         _loc3_.height += _padTop;
         _loc3_.height += _padBottom;
         if(_loc3_.containsPoint(param1))
         {
            return this;
         }
         return null;
      }
      
      public function setPaddings(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
      {
         _padLeft = param1;
         _padRight = param2;
         _padTop = param3;
         _padBottom = param4;
      }
      
      public function get touchState() : String
      {
         return _currentState;
      }
   }
}

