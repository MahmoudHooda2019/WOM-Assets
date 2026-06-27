package wom.service.mobile
{
   import flash.desktop.NativeApplication;
   import flash.net.SharedObject;
   import peak.serialization.json.PJSON;
   
   public class EncryptedLocalStoreUtil
   {
      
      public static const KEY_PEAK_TOKEN:String = "Peak-Token_2";
      
      public static const KEY_PEAK_TOKEN_EXPIRES:String = "Peak-Token-Expires_2";
      
      public static const KEY_LAST_LOGIN_TYPE:String = "Peak-Last-Login-Type_2";
      
      public static const KEY_FB_ID:String = "Peak-FB-Id_2";
      
      public static const KEY_FB_TOKEN:String = "Peak-FB-Token_2";
      
      public static const KEY_MOBILE_UDID:String = "Peak-UDID_2";
      
      public static const KEY_IS_DEV:String = "Peak-Is-Dev_2";
      
      public static const KEY_LANGUAGE:String = "Peak-Language";
      
      public static const KEY_FB_WALLPOST:String = "Peak-FB-Wallpost";
      
      public static const KEY_FIRST_TIME_LOAD:String = "Peak-First-Time-Load";
      
      public static const KEY_APPLICATION_RATER:String = "Peak-Application-Rater";
      
      public static const KEY_IN_APP_PURCHASE:String = "Peak-In-App-Purchase";
      
      public static const KEY_SUCCESSFUL_AUTH:String = "Peak-Successful-Auth";
      
      private static const PATH:String = "WoMSharedObjects";
      
      private static var _versionLabel:String = null;
      
      public function EncryptedLocalStoreUtil()
      {
         super();
      }
      
      private static function getVersionLabel(param1:Boolean) : String
      {
         var _loc3_:XML = null;
         var _loc2_:Namespace = null;
         if(!param1)
         {
            return "";
         }
         if(!_versionLabel)
         {
            _loc3_ = NativeApplication.nativeApplication.applicationDescriptor;
            _loc2_ = _loc3_.namespace();
            _versionLabel = _loc3_._loc2_::versionLabel;
         }
         return _versionLabel;
      }
      
      public static function getLocalData(param1:String, param2:Boolean = false) : String
      {
         var _loc3_:SharedObject = SharedObject.getLocal("WoMSharedObjects");
         var _loc4_:String = _loc3_.data[param1 + getVersionLabel(param2)];
         trace(PJSON.encode(_loc3_.data));
         if(_loc4_)
         {
            return _loc4_;
         }
         trace("No data found for " + param1);
         return null;
      }
      
      public static function setLocalData(param1:String, param2:Object, param3:Boolean = false) : void
      {
         var _loc4_:SharedObject = SharedObject.getLocal("WoMSharedObjects");
         _loc4_.data[param1 + getVersionLabel(param3)] = param2;
         _loc4_.flush();
      }
      
      public static function removeLocalData(param1:String, param2:Boolean = false) : void
      {
         setLocalData(param1,null,param2);
      }
      
      public static function getTokenExpires(param1:String, param2:Boolean = false) : Number
      {
         var _loc3_:String = EncryptedLocalStoreUtil.getLocalData(param1,param2);
         if(_loc3_)
         {
            return Number(_loc3_);
         }
         return -1;
      }
      
      public static function removeAllData() : void
      {
         var _loc1_:SharedObject = SharedObject.getLocal("WoMSharedObjects");
         _loc1_.clear();
      }
      
      public static function getSuccessfulAuth() : int
      {
         var _loc1_:String = EncryptedLocalStoreUtil.getLocalData("Peak-Successful-Auth",true);
         return _loc1_ ? int(_loc1_) : 0;
      }
      
      public static function increaseSuccessfulAuth() : void
      {
         var _loc1_:int = getSuccessfulAuth();
         _loc1_++;
         EncryptedLocalStoreUtil.setLocalData("Peak-Successful-Auth",_loc1_,true);
      }
   }
}

