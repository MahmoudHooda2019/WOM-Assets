package peak.resource.asset.core
{
   import flash.events.Event;
   import flash.geom.Point;
   import peak.resource.asset.display.Scale9AssetPainter;
   
   public class SingleSourceBitmapAsset extends BitmapAsset
   {
      
      private var _sourceAssetReference:BitmapAssetReference;
      
      public function SingleSourceBitmapAsset(param1:String, param2:Scale9AssetPainter = null, param3:Vector.<Point> = null)
      {
         super(null,param2,param3);
         this._sourceAssetReference = new DynamicBitmapAssetReference(param1);
         addDependency(sourceAssetReference);
      }
      
      protected function get sourceAssetReference() : BitmapAssetReference
      {
         return _sourceAssetReference;
      }
      
      override public function update() : void
      {
         if(_sourceAssetReference.available)
         {
            draw();
            dispatchEvent(new Event("change"));
         }
      }
      
      protected function draw() : void
      {
      }
   }
}

