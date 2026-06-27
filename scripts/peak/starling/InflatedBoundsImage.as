package peak.starling
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class InflatedBoundsImage extends Image
   {
      
      private var _paddingLeft:Number = 0;
      
      private var _paddingRight:Number = 0;
      
      private var _paddingTop:Number = 0;
      
      private var _paddingBottom:Number = 0;
      
      public function InflatedBoundsImage(param1:Texture)
      {
         super(param1);
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(param2 && (!visible || !touchable))
         {
            return null;
         }
         var _loc3_:Rectangle = getBounds(this);
         _loc3_.x -= _paddingLeft;
         _loc3_.width += _paddingLeft;
         _loc3_.width += _paddingRight;
         _loc3_.y -= _paddingTop;
         _loc3_.height += _paddingTop;
         _loc3_.height += _paddingBottom;
         if(_loc3_.containsPoint(param1))
         {
            return this;
         }
         return null;
      }
      
      public function setPaddings(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
      {
         _paddingLeft = param1;
         _paddingRight = param2;
         _paddingTop = param3;
         _paddingBottom = param4;
      }
   }
}

