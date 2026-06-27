package wom.model.component.attribute.view
{
   import peak.cuckoo.game.attribute.view.BaseView;
   import wom.model.component.attribute.data.MapTileData;
   import wom.model.component.operations.MapAssetOpearator;
   
   public class MapFlagNameView extends BaseView
   {
      
      public var data:MapTileData;
      
      public var mapName:String;
      
      public function MapFlagNameView(param1:MapTileData, param2:String)
      {
         super(3);
         this.data = param1;
         this.mapName = param2;
      }
      
      override public function init() : void
      {
         super.init();
         bitmapData = MapAssetOpearator.getMapNameField(data,mapName);
      }
   }
}

