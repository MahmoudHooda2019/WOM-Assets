package peak.resource.asset.core
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class MobileFacebookPicture extends MobileRemoteDisplayObjectContainer
   {
      
      private static const FACEBOOK_PICTURE_URL_PATTERN:String = "https://graph.facebook.com/v2.2/_/picture";
      
      public static const WIDTH:Number = 67;
      
      public static const HEIGHT:Number = 67;
      
      public function MobileFacebookPicture(param1:String, param2:DisplayObject, param3:Number = NaN, param4:Number = NaN, param5:Bitmap = null, param6:String = null)
      {
         super(param1,param6 ? param6 : "https://graph.facebook.com/v2.2/_/picture".replace("_",param1),param2,isNaN(param3) ? 67 : param3,isNaN(param4) ? 67 : param4,param5);
      }
      
      override protected function populateImageFromBitmap() : Image
      {
         var _loc1_:BitmapData = new BitmapData(bitmap.width,bitmap.height,true,0);
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(0,0);
         _loc2_.graphics.drawRoundRect(0,0,bitmap.width,bitmap.height,14,14);
         bitmap.mask = _loc2_;
         _loc1_.draw(bitmap);
         return new Image(Texture.fromBitmapData(_loc1_));
      }
   }
}

