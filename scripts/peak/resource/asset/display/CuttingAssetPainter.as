package peak.resource.asset.display
{
   import flash.geom.Rectangle;
   
   public class CuttingAssetPainter extends Scale9AssetPainter implements ScalableAssetPainter
   {
      
      public function CuttingAssetPainter(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function calculateScale9Grid(param1:int, param2:int, param3:int, param4:int) : Rectangle
      {
         var _loc5_:Rectangle = _innerRectangle.clone();
         var _loc6_:Number = param1 - param3;
         if(_loc6_ > 0)
         {
            _loc5_.x = _innerRectangle.right - _loc6_;
            _loc5_.width = _loc6_;
         }
         var _loc7_:Number = param2 - param4;
         if(_loc7_ > 0)
         {
            _loc5_.y = _innerRectangle.bottom - _loc7_;
            _loc5_.height = _loc7_;
         }
         return _loc5_;
      }
      
      override public function clone() : ScalableAssetPainter
      {
         return new CuttingAssetPainter(_innerRectangle.x,_innerRectangle.y,_innerRectangle.width,_innerRectangle.height);
      }
   }
}

