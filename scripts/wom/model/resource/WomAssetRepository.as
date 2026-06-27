package wom.model.resource
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import peak.resource.AssetRepository;
   import peak.resource.asset.display.AssetDisplayObject;
   import wom.model.game.Profile;
   
   public interface WomAssetRepository extends AssetRepository
   {
      
      function getBitmap(param1:String) : Bitmap;
      
      function getBitmapDataClone(param1:String) : BitmapData;
      
      function getFacebookPicture(param1:String) : AssetDisplayObject;
      
      function getMobileAvatar(param1:String) : AssetDisplayObject;
      
      function getAvatarByProfile(param1:Profile) : AssetDisplayObject;
      
      function getRemoteAnnouncementAsset(param1:String, param2:String) : AssetDisplayObject;
   }
}

