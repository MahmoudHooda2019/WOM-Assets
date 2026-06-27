package peak.resource.asset.extended
{
   import flash.geom.Point;
   import peak.resource.asset.core.BitmapAsset;
   import peak.resource.asset.core.SingleSourceBitmapAsset;
   import peak.resource.asset.display.Scale9AssetPainter;
   
   public class Scale3BitmapAsset extends SingleSourceBitmapAsset
   {
      
      protected var _axis:String;
      
      protected var _repeaterOffset:int;
      
      public function Scale3BitmapAsset(param1:String, param2:int, param3:String = "Y", param4:Vector.<Point> = null)
      {
         super(param1,null,param4);
         if(param2 == 0)
         {
            throw new ArgumentError();
         }
         _axis = param3;
         _repeaterOffset = param2;
      }
      
      override public function get scalable() : Boolean
      {
         return true;
      }
      
      override protected function draw() : void
      {
         var _loc3_:BitmapAsset = sourceAssetReference.bitmapAsset;
         _bitmapData = _loc3_.bitmapData;
         var _loc2_:int = _axis == "Y" ? _loc3_.bitmapData.width : _loc3_.bitmapData.height;
         var _loc1_:int = int(_repeaterOffset < 0 ? _loc2_ + _repeaterOffset : _repeaterOffset);
         calculateScale9Grid(_loc3_,_loc1_,1);
      }
      
      protected function calculateScale9Grid(param1:BitmapAsset, param2:int, param3:int) : void
      {
         _scalePainter = param1.scalePainter ? param1.scalePainter.clone() : new Scale9AssetPainter(1,1,1,1);
         if(_axis == "Y")
         {
            _scalePainter.innerRectangle.x = param2;
            _scalePainter.innerRectangle.width = param3;
         }
         else
         {
            _scalePainter.innerRectangle.y = param2;
            _scalePainter.innerRectangle.height = param3;
         }
      }
   }
}

