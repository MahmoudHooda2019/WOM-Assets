package wom.model.message.response
{
   import flash.utils.Dictionary;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.Profile;
   
   public class AuthResponse extends AbstractIncomingMessage
   {
      
      public static const SUCCESS:int = 0;
      
      public static const GENERAL_FAILURE:int = 1;
      
      public static const INVALID_USERNAME_PASSWORD:int = 2;
      
      public static const UNDER_ATTACK:int = 3;
      
      public static const CITY_BEING_SPIED:int = 9;
      
      public static const CAPTCHA_REQUIRED:int = 10;
      
      private var _success:Boolean;
      
      private var _serverSpeed:int;
      
      private var _serverTime:Number;
      
      private var _profile:Profile;
      
      private var _friendIdToExperienceMap:Dictionary;
      
      private var _resultCode:int;
      
      private var _abTestPairs:Dictionary;
      
      private var _maintenanceTime:Number;
      
      private var _maintenanceMode:String;
      
      private var _allianceName:String;
      
      private var _allianceSig:String;
      
      private var _storeDiscountPercentage:int;
      
      private var _storeDiscountRemainingDuration:Number;
      
      public function AuthResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _success = param1.success;
         _resultCode = param1.resultCode;
         if(_success)
         {
            _serverSpeed = 10;
            _friendIdToExperienceMap = new Dictionary();
            if("friendInfos" in param1 && param1.friendInfos != null)
            {
               for each(var _loc2_ in param1.friendInfos)
               {
                  _friendIdToExperienceMap[_loc2_.gameUid] = _loc2_.xp;
               }
            }
            if("serverSpeed" in param1)
            {
               _serverSpeed = param1["serverSpeed"];
            }
            _serverTime = "serverTime" in param1 ? param1["serverTime"] : new Date().getTime();
            _profile = new Profile(param1.plyr[0],param1.plyr[1],param1.plyr[2]);
            _abTestPairs = new Dictionary();
            if("abTestPairs" in param1 && param1.abTestPairs != null)
            {
               for each(var _loc3_ in param1.abTestPairs)
               {
                  log(LoggerContexts.INFRASTRUCTURE,"abTestPair",_loc3_);
                  _abTestPairs[_loc3_.key] = _loc3_.value;
               }
            }
            _maintenanceTime = param1.maintenanceTime;
            _maintenanceMode = param1.maintenanceType;
            _allianceName = param1.aname;
            _allianceSig = param1.asig;
            _storeDiscountPercentage = "sdp" in param1 ? param1.sdp : 0;
            _storeDiscountRemainingDuration = "sdd" in param1 ? param1.sdd : 0;
         }
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
      
      public function get serverSpeed() : int
      {
         return _serverSpeed;
      }
      
      public function get serverTime() : Number
      {
         return _serverTime;
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function get friendIdToExperienceMap() : Dictionary
      {
         return _friendIdToExperienceMap;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get abTestPairs() : Dictionary
      {
         return _abTestPairs;
      }
      
      public function get maintenanceTime() : Number
      {
         return _maintenanceTime;
      }
      
      public function get maintenanceMode() : String
      {
         return _maintenanceMode;
      }
      
      public function get allianceName() : String
      {
         return _allianceName;
      }
      
      public function get allianceSig() : String
      {
         return _allianceSig;
      }
      
      public function get storeDiscountPercentage() : int
      {
         return _storeDiscountPercentage;
      }
      
      public function get storeDiscountRemainingDuration() : Number
      {
         return _storeDiscountRemainingDuration;
      }
   }
}

