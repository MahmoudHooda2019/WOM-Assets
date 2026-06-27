package peak.resource.asset.extended
{
   import flash.geom.Point;
   import peak.resource.asset.core.BitmapAsset;
   import peak.resource.asset.core.SingleSourceBitmapAsset;
   import peak.resource.asset.display.Scale9AssetPainter;
   import peak.util.BitmapUtil;
   
   public class ResizedBitmapAsset extends SingleSourceBitmapAsset
   {
      
      protected var _width:int;
      
      protected var _height:int;
      
      public function ResizedBitmapAsset(param1:String, param2:int, param3:int, param4:Scale9AssetPainter = null, param5:Vector.<Point> = null)
      {
         super(param1,param4,param5);
         _width = param2;
         _height = param3;
      }
      
      override protected function draw() : void
      {
         var _loc1_:BitmapAsset = sourceAssetReference.bitmapAsset;
         this._bitmapData = BitmapUtil.resizeBitmapData(_loc1_.bitmapData,_width,_height);
      }
   }
}

