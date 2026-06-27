package peak.cuckoo.game.attribute.view
{
   import flash.events.Event;
   import peak.cuckoo.game.GameSprite;
   import peak.resource.asset.core.BitmapAssetReference;
   
   public class LoadingAssetView extends AssetView
   {
      
      public var source:BitmapAssetReference;
      
      public function LoadingAssetView(param1:int, param2:BitmapAssetReference, param3:String)
      {
         super(param1,param3,false);
         this.source = param2;
      }
      
      override public function init() : void
      {
         initialized = true;
         if(source)
         {
            source.addEventListener("change",onSourceChange);
         }
         update();
      }
      
      protected function onSourceChange(param1:Event) : void
      {
         update();
      }
      
      override public function destroy() : void
      {
         if(source)
         {
            source.removeEventListener("change",onSourceChange);
         }
         super.destroy();
      }
      
      protected function update() : void
      {
         if(source && source.complete)
         {
            source.removeEventListener("change",onSourceChange);
            assetLoaded.dispatch();
            owner.root.layers[layerId].add(owner as GameSprite);
         }
      }
   }
}

