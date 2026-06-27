package peak.resource.asset.extended
{
   import flash.geom.Point;
   import peak.resource.asset.core.BitmapAsset;
   import peak.resource.asset.core.SingleSourceBitmapAsset;
   import peak.resource.asset.display.Scale9AssetPainter;
   import peak.util.BitmapUtil;
   
   public class MirroredBitmapAsset extends SingleSourceBitmapAsset
   {
      
      protected var _axis:String;
      
      public function MirroredBitmapAsset(param1:String, param2:String = "Y", param3:Scale9AssetPainter = null, param4:Vector.<Point> = null)
      {
         super(param1,param3,param4);
         _axis = param2;
      }
      
      override protected function draw() : void
      {
         var _loc1_:BitmapAsset = sourceAssetReference.bitmapAsset;
         this._bitmapData = BitmapUtil.mirrorBitmapData(_loc1_.bitmapData,_axis);
      }
   }
}

