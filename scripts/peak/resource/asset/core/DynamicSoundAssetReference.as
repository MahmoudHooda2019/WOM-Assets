package peak.resource.asset.core
{
   public class DynamicSoundAssetReference extends SoundAssetReference implements DynamicAssetReference
   {
      
      protected var _assetId:String;
      
      public function DynamicSoundAssetReference(param1:String)
      {
         super(null);
         _assetId = param1;
      }
      
      public function get assetId() : String
      {
         return _assetId;
      }
   }
}

