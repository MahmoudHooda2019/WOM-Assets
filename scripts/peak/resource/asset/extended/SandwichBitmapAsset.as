package peak.resource.asset.extended
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import peak.resource.asset.core.BitmapAsset;
   import peak.util.BitmapUtil;
   
   public class SandwichBitmapAsset extends Scale3BitmapAsset
   {
      
      public function SandwichBitmapAsset(param1:String, param2:String = "Y", param3:int = -1, param4:Vector.<Point> = null)
      {
         super(param1,param3,param2,param4);
      }
      
      override protected function draw() : void
      {
         var _loc3_:BitmapAsset = sourceAssetReference.bitmapAsset;
         _bitmapData = BitmapUtil.mirrorBitmapData(_repeaterOffset < 0 ? _loc3_.bitmapData : BitmapUtil.flipBitmapData(_loc3_.bitmapData,_axis),_axis);
         var _loc2_:int = _axis == "Y" ? _loc3_.bitmapData.width : _loc3_.bitmapData.height;
         var _loc1_:int = int(_repeaterOffset < 0 ? -_repeaterOffset : _repeaterOffset);
         calculateScale9Grid(_loc3_,_loc2_ - _loc1_,_loc1_ << 1);
      }
   }
}

