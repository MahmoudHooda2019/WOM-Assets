package peak.resource
{
   import flash.display.BitmapData;
   import peak.resource.asset.core.BitmapAsset;
   import peak.resource.asset.core.BitmapAssetReference;
   import peak.resource.asset.core.SoundAsset;
   import peak.resource.asset.core.SoundAssetReference;
   import peak.resource.asset.display.AssetDisplayObject;
   
   public interface AssetRepository
   {
      
      function registerBitmapAsset(param1:String, param2:BitmapAsset) : void;
      
      function getBitmapAssetReference(param1:String) : BitmapAssetReference;
      
      function getDisplayObject(param1:String) : AssetDisplayObject;
      
      function getBitmapData(param1:String, param2:Boolean = false) : BitmapData;
      
      function registerSoundAsset(param1:String, param2:SoundAsset) : void;
      
      function getSoundAssetReference(param1:String) : SoundAssetReference;
      
      function preload(param1:Vector.<String>, param2:int = 0) : void;
      
      function dispose() : void;
   }
}

