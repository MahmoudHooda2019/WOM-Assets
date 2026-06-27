package peak.resource
{
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.resource.asset.core.BitmapAsset;
   import peak.resource.asset.core.BitmapAssetReference;
   import peak.resource.asset.core.DynamicAssetReference;
   import peak.resource.asset.core.DynamicBitmapAssetReference;
   import peak.resource.asset.core.DynamicSoundAssetReference;
   import peak.resource.asset.core.SoundAsset;
   import peak.resource.asset.core.SoundAssetReference;
   import peak.resource.asset.display.AssetDisplayObject;
   
   public class DefaultAssetRepository implements AssetRepository
   {
      
      protected const bitmapAssets:Dictionary = new Dictionary();
      
      protected const soundAssets:Dictionary = new Dictionary();
      
      protected const unresolvedDependencies:Dictionary = new Dictionary();
      
      protected var preloadQueue:PreloadingAssetListNode;
      
      public function DefaultAssetRepository()
      {
         super();
      }
      
      public function registerBitmapAsset(param1:String, param2:BitmapAsset) : void
      {
         var _loc3_:* = undefined;
         var _loc5_:int = 0;
         var _loc4_:DynamicBitmapAssetReference = null;
         bitmapAssets[param1] = param2;
         if(param1 in unresolvedDependencies)
         {
            _loc3_ = unresolvedDependencies[param1];
            _loc5_ = _loc3_.length - 1;
            while(_loc5_ >= 0)
            {
               _loc4_ = _loc3_[_loc5_];
               if(_loc4_.assetId == param1)
               {
                  _loc4_.resolve(param2);
                  _loc3_.splice(_loc5_,1);
               }
               _loc5_--;
            }
            if(_loc3_.length == 0)
            {
               delete unresolvedDependencies[param1];
            }
         }
         processDependencies(param2);
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in bitmapAssets)
         {
            if(_loc1_.bitmapData)
            {
               _loc1_.bitmapData.dispose();
            }
         }
      }
      
      public function getDisplayObject(param1:String) : AssetDisplayObject
      {
         return new AssetDisplayObject(getBitmapAssetReference(param1));
      }
      
      public function getBitmapAssetReference(param1:String) : BitmapAssetReference
      {
         if(param1 in bitmapAssets)
         {
            return new BitmapAssetReference(bitmapAssets[param1]);
         }
         var _loc2_:DynamicBitmapAssetReference = new DynamicBitmapAssetReference(param1);
         trackUnresolvedDependency(_loc2_);
         return _loc2_;
      }
      
      public function getSoundAssetReference(param1:String) : SoundAssetReference
      {
         if(param1 in soundAssets)
         {
            return new SoundAssetReference(soundAssets[param1]);
         }
         var _loc2_:DynamicSoundAssetReference = new DynamicSoundAssetReference(param1);
         trackUnresolvedDependency(_loc2_);
         return _loc2_;
      }
      
      protected function processDependencies(param1:BitmapAsset) : void
      {
         for each(var _loc2_ in param1.dependencies)
         {
            if(_loc2_.assetId in bitmapAssets)
            {
               _loc2_.resolve(bitmapAssets[_loc2_.assetId]);
            }
            else
            {
               trackUnresolvedDependency(_loc2_);
            }
         }
      }
      
      protected function trackUnresolvedDependency(param1:DynamicAssetReference) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:String = param1.assetId;
         if(_loc3_ in unresolvedDependencies)
         {
            _loc2_ = unresolvedDependencies[_loc3_];
         }
         else
         {
            _loc2_ = new Vector.<DynamicAssetReference>();
            unresolvedDependencies[_loc3_] = _loc2_;
         }
         _loc2_.push(param1);
      }
      
      public function getBitmapData(param1:String, param2:Boolean = false) : BitmapData
      {
         var _loc3_:BitmapAsset = bitmapAssets[param1];
         if(_loc3_ == null)
         {
            log(LoggerContexts.UNEXPECTED,"asset not available yet",param1);
            return null;
         }
         return _loc3_.bitmapData;
      }
      
      public function registerSoundAsset(param1:String, param2:SoundAsset) : void
      {
         soundAssets[param1] = param2;
      }
      
      public function preload(param1:Vector.<String>, param2:int = 0) : void
      {
         for each(var _loc3_ in param1)
         {
            getBitmapAssetReference(_loc3_);
         }
      }
   }
}

class PreloadingAssetListNode
{
   
   public var assetIds:Vector.<String>;
   
   public var priority:int;
   
   public var next:PreloadingAssetListNode;
   
   public function PreloadingAssetListNode(param1:Vector.<String>, param2:int)
   {
      super();
      this.assetIds = param1;
      this.priority = param2;
   }
}
