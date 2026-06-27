package peak.resource.asset.core
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class BitmapAssetReference extends EventDispatcher
   {
      
      protected var _bitmapAsset:BitmapAsset;
      
      public function BitmapAssetReference(param1:BitmapAsset)
      {
         super();
         resolve(param1);
      }
      
      public function get bitmapAsset() : BitmapAsset
      {
         return _bitmapAsset;
      }
      
      public function resolve(param1:BitmapAsset) : void
      {
         if(resolved)
         {
            throw new Error("BitmapAssetReference alrady resolved");
         }
         _bitmapAsset = param1;
         if(param1 != null)
         {
            param1.addEventListener("change",onAssetChange);
         }
         dispatchEvent(new Event("change"));
      }
      
      internal function get resolved() : Boolean
      {
         return bitmapAsset != null;
      }
      
      public function get available() : Boolean
      {
         return bitmapAsset != null && bitmapAsset.available;
      }
      
      public function get complete() : Boolean
      {
         return bitmapAsset != null && bitmapAsset.complete;
      }
      
      protected function onAssetChange(param1:Event) : void
      {
         dispatchEvent(param1);
      }
   }
}

