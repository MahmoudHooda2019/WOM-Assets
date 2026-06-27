package peak.resource.asset.display
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Rectangle;
   
   public class Scale9AssetPainter implements ScalableAssetPainter
   {
      
      protected var _innerRectangle:Rectangle;
      
      public function Scale9AssetPainter(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super();
         _innerRectangle = new Rectangle(param1,param2,param3,param4);
      }
      
      public function get innerRectangle() : Rectangle
      {
         return _innerRectangle;
      }
      
      public function paint(param1:Graphics, param2:BitmapData, param3:int, param4:int) : Rectangle
      {
         var _loc10_:int = 0;
         var _loc9_:Number = NaN;
         var _loc7_:int = 0;
         var _loc5_:Rectangle = calculateScale9Grid(param2.width,param2.height,param3,param4);
         var _loc8_:Array = [_loc5_.left,_loc5_.right,param2.width];
         var _loc11_:Array = [_loc5_.top,_loc5_.bottom,param2.height];
         param1.clear();
         var _loc6_:Number = 0;
         _loc10_ = 0;
         while(_loc10_ < 3)
         {
            _loc9_ = 0;
            _loc7_ = 0;
            while(_loc7_ < 3)
            {
               param1.beginBitmapFill(param2);
               param1.drawRect(_loc6_,_loc9_,_loc8_[_loc10_] - _loc6_,_loc11_[_loc7_] - _loc9_);
               param1.endFill();
               _loc9_ = Number(_loc11_[_loc7_]);
               _loc7_++;
            }
            _loc6_ = Number(_loc8_[_loc10_]);
            _loc10_++;
         }
         return _loc5_;
      }
      
      protected function calculateScale9Grid(param1:int, param2:int, param3:int, param4:int) : Rectangle
      {
         return _innerRectangle;
      }
      
      public function clone() : ScalableAssetPainter
      {
         return new Scale9AssetPainter(_innerRectangle.x,_innerRectangle.y,_innerRectangle.width,_innerRectangle.height);
      }
   }
}

