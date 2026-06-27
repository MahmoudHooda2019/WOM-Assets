package peak.resource.asset.core
{
   public class DynamicBitmapAssetReference extends BitmapAssetReference implements DynamicAssetReference
   {
      
      protected var _assetId:String;
      
      public function DynamicBitmapAssetReference(param1:String)
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

