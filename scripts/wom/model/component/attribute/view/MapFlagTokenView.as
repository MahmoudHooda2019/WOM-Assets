package wom.model.component.attribute.view
{
   import peak.cuckoo.game.attribute.view.BaseView;
   import peak.resource.AssetRepository;
   import wom.model.component.attribute.data.MapTileData;
   import wom.model.component.operations.MapAssetOpearator;
   import wom.model.resource.WomAssetRepository;
   
   public class MapFlagTokenView extends BaseView
   {
      
      public var data:MapTileData;
      
      private var assetRepository:AssetRepository;
      
      public function MapFlagTokenView(param1:MapTileData, param2:WomAssetRepository)
      {
         super(3);
         this.data = param1;
         this.assetRepository = param2;
      }
      
      override public function init() : void
      {
         super.init();
         bitmapData = MapAssetOpearator.getMapToken(data,assetRepository);
      }
   }
}

