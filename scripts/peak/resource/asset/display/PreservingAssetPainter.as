package peak.resource.asset.display
{
   import flash.geom.Rectangle;
   
   public class PreservingAssetPainter extends CuttingAssetPainter implements ScalableAssetPainter
   {
      
      protected var _preserveUp:int;
      
      protected var _preserveDown:int;
      
      protected var _preserveLeft:int;
      
      protected var _preserveRight:int;
      
      public function PreservingAssetPainter(param1:Number, param2:Number, param3:Number, param4:Number, param5:int = 1, param6:int = 1, param7:int = 1, param8:int = 1)
      {
         super(param1,param2,param3,param4);
         _preserveUp = param5;
         _preserveDown = param6;
         _preserveLeft = param7;
         _preserveRight = param8;
      }
      
      override protected function calculateScale9Grid(param1:int, param2:int, param3:int, param4:int) : Rectangle
      {
         var _loc5_:Rectangle = super.calculateScale9Grid(param1,param2,param3,param4);
         if(preservesWidth(param3,param1))
         {
            _loc5_.x = _preserveLeft;
            _loc5_.width = param1 - (_preserveLeft + _preserveRight);
         }
         if(preservesHeight(param4,param2))
         {
            _loc5_.y = _preserveUp;
            _loc5_.height = param2 - (_preserveUp + _preserveDown);
         }
         return _loc5_;
      }
      
      protected function preservesWidth(param1:int, param2:int) : Boolean
      {
         return param1 < param2 - _innerRectangle.width;
      }
      
      protected function preservesHeight(param1:int, param2:int) : Boolean
      {
         return param1 < param2 - innerRectangle.height;
      }
      
      override public function clone() : ScalableAssetPainter
      {
         return new PreservingAssetPainter(_innerRectangle.x,_innerRectangle.y,_innerRectangle.width,_innerRectangle.height,_preserveUp,_preserveDown,_preserveLeft,_preserveRight);
      }
   }
}

