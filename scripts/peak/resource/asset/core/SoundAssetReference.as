package peak.resource.asset.core
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class SoundAssetReference extends EventDispatcher
   {
      
      protected var _soundAsset:SoundAsset;
      
      public function SoundAssetReference(param1:SoundAsset)
      {
         super();
         resolve(param1);
      }
      
      public function get soundAsset() : SoundAsset
      {
         return _soundAsset;
      }
      
      public function resolve(param1:SoundAsset) : void
      {
         if(resolved)
         {
            throw new Error("SoundAssetReference alrady resolved");
         }
         _soundAsset = param1;
         dispatchEvent(new Event("change"));
      }
      
      internal function get resolved() : Boolean
      {
         return soundAsset != null;
      }
      
      public function get available() : Boolean
      {
         return soundAsset != null && soundAsset.available;
      }
      
      public function get complete() : Boolean
      {
         return soundAsset != null && soundAsset.complete;
      }
   }
}

