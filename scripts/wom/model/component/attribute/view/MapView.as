package wom.model.component.attribute.view
{
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.resource.asset.core.BitmapAssetReference;
   import wom.model.component.attribute.data.MapTileData;
   
   public class MapView extends AssetView
   {
      
      public var tileData:MapTileData;
      
      public function MapView(param1:int, param2:BitmapAssetReference, param3:String, param4:MapTileData)
      {
         super(param1,param3);
         this.tileData = param4;
      }
   }
}

