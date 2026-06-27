package wom.model.resource
{
   import starling.display.DisplayObject;
   import wom.model.game.Profile;
   
   public interface MobileWomAssetRepository
   {
      
      function getDisplayObject(param1:String) : DisplayObject;
      
      function getTexture(param1:String) : *;
      
      function getRemoteDisplayObject(param1:String, param2:Number, param3:Number, param4:String = null) : DisplayObject;
      
      function getFacebookPicture(param1:String, param2:Number = NaN, param3:Number = NaN, param4:String = null) : DisplayObject;
      
      function getAvatarByProfile(param1:Profile, param2:Number = NaN, param3:Number = NaN) : DisplayObject;
      
      function getMobileAvatar(param1:String) : DisplayObject;
   }
}

