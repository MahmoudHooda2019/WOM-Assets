package peak.resource.asset.core
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class BitmapAssetNode extends EventDispatcher
   {
      
      private var _assetReference:BitmapAssetReference;
      
      public function BitmapAssetNode(param1:BitmapAssetReference)
      {
         super();
         this._assetReference = param1;
         _assetReference.addEventListener("change",onAssetReferenceChange);
      }
      
      public function get assetReference() : BitmapAssetReference
      {
         return _assetReference;
      }
      
      protected function onAssetReferenceChange(param1:Event) : void
      {
         dispatchEvent(param1);
      }
   }
}

