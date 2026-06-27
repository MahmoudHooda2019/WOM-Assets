package wom.model.component.entity.gamesprite
{
   import peak.cuckoo.game.GameSprite;
   import wom.model.component.attribute.data.MapTileData;
   import wom.model.component.attribute.viewManager.MapFlagViewManager;
   
   public class MapFlag extends GameSprite
   {
      
      public var data:MapTileData;
      
      public var viewManager:MapFlagViewManager;
      
      public function MapFlag()
      {
         super();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         data = null;
         viewManager = null;
      }
   }
}

