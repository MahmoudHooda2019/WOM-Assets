package wom.model.configuration
{
   import flash.utils.Dictionary;
   import peak.config.BaseDocumentConfiguration;
   import peak.serialization.json.PJSON;
   import peak.util.Base64;
   import peak.util.DateTimeUtil;
   import wom.model.game.AnnouncementInfo;
   import wom.model.game.Profile;
   import wom.model.game.friend.DefaultFriendInfo;
   import wom.model.game.friend.FriendInfo;
   import wom.model.game.settings.ClientSettingsInfo;
   import wom.model.message.util.CoatOfArmsDeserializeUtil;
   
   public class WomDocumentConfiguration extends BaseDocumentConfiguration
   {
      
      private var _settings:ClientSettingsInfo;
      
      private var _friends:Vector.<FriendInfo>;
      
      private var _invitableFriends:Vector.<FriendInfo>;
      
      private var _womFriends:Dictionary = new Dictionary();
      
      private var _axess:String = null;
      
      private var _newUser:Boolean = false;
      
      private var _showFreeCoins:Boolean = false;
      
      private var _showSpecialOffer:Boolean = false;
      
      private var _announcements:Vector.<AnnouncementInfo> = new Vector.<AnnouncementInfo>();
      
      private var _showSupersonicAd:Boolean = false;
      
      private var _promo:Boolean = false;
      
      private var _enableFriendAttack:Boolean = false;
      
      private var _spinCost:int = 50;
      
      private var _discountedSpinCost:int = 25;
      
      private var _promotionStartTime:Number = 946684800;
      
      private var _promotionEndTime:Number = 949276800;
      
      private var _eventAnnounceButtonImageName:String = "EventRevengeOfTheClansIcon1";
      
      private var _eventButtonImageName:String = "EventRevengeOfTheClansIcon2";
      
      private var _eventAnnounceBackgroundImageName:String = "EventRevengeOfTheClansBackgroundBefore";
      
      private var _eventOngoingBackgroundImageName:String = "EventRevengeOfTheClansBackground";
      
      private var _eventHowToBackgroundImageName:String = "EventRevengeOfTheClansBackgroundHowTo";
      
      private var _eventAvatarImageName:String = "RevengeOfTheClansMap";
      
      private var _trainEventItems:Boolean = true;
      
      private var _ultimateBpThreshold:Number = 3199;
      
      private var _minKValue:Number = 5;
      
      private var _medKValue:Number = 8;
      
      private var _maxKValue:Number = 10;
      
      private var _tournamentKValue:Number = 3;
      
      private var _discountEnabled:Boolean = false;
      
      private var _discountAmount:int = 0;
      
      private var _logEnabled:Boolean = false;
      
      private var _remoteAssetUrlPrefix:String = "http://wom-a.akamaihd.net/static/swf/r/";
      
      private var _remoteAssetCrossdomain:String = "https://womassets-a.akamaihd.net/crossdomain.xml";
      
      private var _validationThresholdBeastHealth:Number = 0.4;
      
      private var _validationThresholdBuildingHealths:Number = 0.4;
      
      private var _validationThresholdLootedResources:Number = 0.4;
      
      private var _enableAndroidRater:Boolean = true;
      
      private var _peakPayEnabled:Boolean = false;
      
      public function WomDocumentConfiguration()
      {
         super();
      }
      
      public function init() : void
      {
         parameters.loginTime = DateTimeUtil.getUTCFormattedDateAndTimeDescendingOrderFromDate(new Date());
         if(parameters.ip)
         {
            parameters.serverUrl = parameters.ip;
         }
         if(parameters.port)
         {
            parameters.serverPort = parameters.port;
         }
         if(parameters.gameid)
         {
            parameters.user = parameters.gameid;
         }
         parameters.buildRef = "5d76f1ccf4143e4c6f0e5bfdcd4c8129322a3cd3";
         parameters.buildTime = "150126.140619";
         extractSettings();
         if(parameters.visual)
         {
            parameters.visual = Base64.decode(parameters.visual);
         }
         if(parameters.lang_definitions)
         {
            parameters.lang_definitions = Base64.decode(parameters.lang_definitions);
         }
         extractFriends();
         if(parameters.axess)
         {
            axess = parameters.axess;
         }
         if("promo" in parameters && parameters.promo == "true")
         {
            _promo = true;
         }
         extractOptionalParameters();
      }
      
      public function get friends() : Vector.<FriendInfo>
      {
         return _friends;
      }
      
      public function set friends(param1:Vector.<FriendInfo>) : void
      {
         _friends = param1;
      }
      
      public function get invitableFriends() : Vector.<FriendInfo>
      {
         return _invitableFriends;
      }
      
      public function set invitableFriends(param1:Vector.<FriendInfo>) : void
      {
         _invitableFriends = param1;
      }
      
      public function get womFriends() : Dictionary
      {
         return _womFriends;
      }
      
      public function set womFriends(param1:Dictionary) : void
      {
         _womFriends = param1;
      }
      
      public function get settings() : ClientSettingsInfo
      {
         return _settings;
      }
      
      public function set settings(param1:ClientSettingsInfo) : void
      {
         _settings = param1;
      }
      
      public function get axess() : String
      {
         return _axess;
      }
      
      public function set axess(param1:String) : void
      {
         _axess = param1;
      }
      
      public function get newUser() : Boolean
      {
         return _newUser;
      }
      
      public function set newUser(param1:Boolean) : void
      {
         _newUser = param1;
      }
      
      public function get showFreeCoins() : Boolean
      {
         return _showFreeCoins;
      }
      
      public function set showFreeCoins(param1:Boolean) : void
      {
         _showFreeCoins = param1;
      }
      
      public function get showSupersonicAd() : Boolean
      {
         return _showSupersonicAd;
      }
      
      public function set showSupersonicAd(param1:Boolean) : void
      {
         _showSupersonicAd = param1;
      }
      
      public function get showSpecialOffer() : Boolean
      {
         return _showSpecialOffer;
      }
      
      public function set showSpecialOffer(param1:Boolean) : void
      {
         _showSpecialOffer = param1;
      }
      
      public function get announcements() : Vector.<AnnouncementInfo>
      {
         return _announcements;
      }
      
      public function set announcements(param1:Vector.<AnnouncementInfo>) : void
      {
         _announcements = param1;
      }
      
      public function extractFriends() : void
      {
         var _loc5_:String = null;
         var _loc4_:FriendInfo = null;
         womFriends = new Dictionary();
         var _loc3_:Dictionary = new Dictionary();
         if("womfriends" in parameters && parameters.womfriends != null)
         {
            for each(var _loc2_ in PJSON.decode(Base64.decode(parameters.womfriends)))
            {
               if(_loc2_.length >= 3)
               {
                  _loc4_ = new DefaultFriendInfo(null,new Profile(_loc2_[0],_loc2_[1],null),_loc2_.length >= 3 ? CoatOfArmsDeserializeUtil.createCoatOfArmsInfo(_loc2_[2]) : null);
                  womFriends[_loc4_.profile.gameId] = _loc4_;
                  _loc3_[_loc4_.profile.platformId] = _loc4_;
               }
            }
         }
         friends = new Vector.<FriendInfo>();
         invitableFriends = new Vector.<FriendInfo>();
         if("friends" in parameters && parameters.friends != null)
         {
            for each(var _loc1_ in PJSON.decode(Base64.decode(parameters.friends)))
            {
               if(isNaN(_loc1_[0]))
               {
                  _loc5_ = _loc1_.length >= 2 ? _loc1_[1] : null;
               }
               else
               {
                  _loc5_ = _loc1_[0];
               }
               if(_loc5_ in _loc3_)
               {
                  _loc4_ = _loc3_[_loc5_];
                  _loc4_.name = _loc1_[1];
               }
               else
               {
                  _loc4_ = new DefaultFriendInfo(_loc1_[1],new Profile(null,_loc5_,null));
               }
               friends.push(_loc4_);
            }
         }
      }
      
      private function addProfilesToBeTested(param1:Dictionary) : void
      {
      }
      
      public function extractSettings() : void
      {
         var _loc1_:Object = null;
         if("newuser" in parameters && parameters.newuser == "true")
         {
            newUser = true;
            settings = new ClientSettingsInfo(true,true,true);
         }
         else if(parameters.settings)
         {
            _loc1_ = PJSON.decode(Base64.decode(parameters.settings));
            settings = new ClientSettingsInfo(_loc1_.soundEnabled,_loc1_.musicEnabled,_loc1_.splashEnabled);
         }
         else
         {
            settings = new ClientSettingsInfo(true,true,true);
         }
      }
      
      public function extractOptionalParameters() : void
      {
         var _loc2_:Object = null;
         var _loc1_:String = null;
         if("oparams" in parameters && parameters.oparams != null)
         {
            try
            {
               _loc1_ = Base64.decode(parameters.oparams);
               _loc2_ = PJSON.decode(_loc1_);
            }
            catch(e:Error)
            {
               _loc2_ = {};
            }
            if("sc" in _loc2_ && _loc2_.sc != null)
            {
               _spinCost = int(_loc2_.sc);
            }
            if("dsc" in _loc2_ && _loc2_.dsc != null)
            {
               _discountedSpinCost = int(_loc2_.dsc);
            }
            if("pst" in _loc2_ && _loc2_.pst != null)
            {
               _promotionStartTime = Number(_loc2_.pst);
            }
            if("pet" in _loc2_ && _loc2_.pet != null)
            {
               _promotionEndTime = Number(_loc2_.pet);
            }
            if("eabin" in _loc2_ && _loc2_.eabin != null)
            {
               _eventAnnounceButtonImageName = String(_loc2_.eabin);
            }
            if("ebim" in _loc2_ && _loc2_.ebim != null)
            {
               _eventButtonImageName = String(_loc2_.ebim);
            }
            if("eapbim" in _loc2_ && _loc2_.eapbim != null)
            {
               _eventAnnounceBackgroundImageName = String(_loc2_.eapbim);
            }
            if("eopbim" in _loc2_ && _loc2_.eopbim != null)
            {
               _eventOngoingBackgroundImageName = String(_loc2_.eopbim);
            }
            if("ehbim" in _loc2_ && _loc2_.ehbim != null)
            {
               _eventHowToBackgroundImageName = String(_loc2_.ehbim);
            }
            if("emain" in _loc2_ && _loc2_.emain != null)
            {
               _eventAvatarImageName = String(_loc2_.emain);
            }
            if("tei" in _loc2_ && _loc2_.tei != null)
            {
               _trainEventItems = _loc2_.tei == "true";
            }
            if("ultimatebp" in _loc2_ && _loc2_.ultimatebp != null)
            {
               _ultimateBpThreshold = Number(_loc2_.ultimatebp);
            }
            if("minkvalue" in _loc2_ && _loc2_.minkvalue != null)
            {
               _minKValue = Number(_loc2_.minkvalue);
            }
            if("medkvalue" in _loc2_ && _loc2_.eapbim != null)
            {
               _medKValue = Number(_loc2_.medkvalue);
            }
            if("maxkvalue" in _loc2_ && _loc2_.maxkvalue != null)
            {
               _maxKValue = Number(_loc2_.maxkvalue);
            }
            if("tournamentkvalue" in _loc2_ && _loc2_.tournamentkvalue != null)
            {
               _tournamentKValue = Number(_loc2_.tournamentkvalue);
            }
            if("disce" in _loc2_ && _loc2_.disce != null)
            {
               _discountEnabled = _loc2_.disce == "true";
            }
            if("disca" in _loc2_ && _loc2_.disca != null)
            {
               _discountAmount = int(_loc2_.disca);
            }
            if("loge" in _loc2_ && _loc2_.loge != null)
            {
               _logEnabled = _loc2_.loge == "true";
            }
            if("raup" in _loc2_ && _loc2_.raup != null)
            {
               _remoteAssetUrlPrefix = _loc2_.raup;
            }
            if("racd" in _loc2_ && _loc2_.racd != null)
            {
               _remoteAssetCrossdomain = _loc2_.racd;
            }
            if("efa" in _loc2_ && _loc2_.efa != null)
            {
               _enableFriendAttack = _loc2_.efa == "true";
            }
            if("validthresbeast" in _loc2_ && _loc2_.validthresbeast != null)
            {
               _validationThresholdBeastHealth = Number(_loc2_.validthresbeast);
            }
            if("validthresbuilding" in _loc2_ && _loc2_.validthresbuilding != null)
            {
               _validationThresholdBuildingHealths = Number(_loc2_.validthresbuilding);
            }
            if("validthresloot" in _loc2_ && _loc2_.validthresloot != null)
            {
               _validationThresholdLootedResources = Number(_loc2_.validthresloot);
            }
            if("eandrt" in _loc2_ && _loc2_.eandrt != null)
            {
               _enableAndroidRater = _loc2_.eandrt == "true";
            }
            if("npay" in _loc2_ && _loc2_.npay != null)
            {
               _peakPayEnabled = _loc2_.npay == "true";
            }
         }
      }
      
      public function get promo() : Boolean
      {
         return _promo;
      }
      
      public function set promo(param1:Boolean) : void
      {
         _promo = param1;
      }
      
      public function get discountedSpinCost() : int
      {
         return _discountedSpinCost;
      }
      
      public function get spinCost() : int
      {
         return _spinCost;
      }
      
      public function get promotionStartTime() : Number
      {
         return _promotionStartTime;
      }
      
      public function get promotionEndTime() : Number
      {
         return _promotionEndTime;
      }
      
      public function get eventAnnounceButtonImageName() : String
      {
         return _eventAnnounceButtonImageName;
      }
      
      public function get eventButtonImageName() : String
      {
         return _eventButtonImageName;
      }
      
      public function get eventAnnounceBackgroundImageName() : String
      {
         return _eventAnnounceBackgroundImageName;
      }
      
      public function get eventOngoingBackgroundImageName() : String
      {
         return _eventOngoingBackgroundImageName;
      }
      
      public function get eventHowToBackgroundImageName() : String
      {
         return _eventHowToBackgroundImageName;
      }
      
      public function get eventAvatarImageName() : String
      {
         return _eventAvatarImageName;
      }
      
      public function get ultimateBpThreshold() : Number
      {
         return _ultimateBpThreshold;
      }
      
      public function get minKValue() : Number
      {
         return _minKValue;
      }
      
      public function get medKValue() : Number
      {
         return _medKValue;
      }
      
      public function get maxKValue() : Number
      {
         return _maxKValue;
      }
      
      public function get tournamentKValue() : Number
      {
         return _tournamentKValue;
      }
      
      public function get discountEnabled() : Boolean
      {
         return _discountEnabled;
      }
      
      public function get discountAmount() : int
      {
         return _discountAmount;
      }
      
      public function get trainEventItems() : Boolean
      {
         return _trainEventItems;
      }
      
      public function get logEnabled() : Boolean
      {
         return _logEnabled;
      }
      
      public function get remoteAssetUrlPrefix() : String
      {
         return _remoteAssetUrlPrefix;
      }
      
      public function get remoteAssetCrossdomain() : String
      {
         return _remoteAssetCrossdomain;
      }
      
      public function get enableFriendAttack() : Boolean
      {
         return _enableFriendAttack;
      }
      
      public function get validationThresholdBeastHealth() : Number
      {
         return _validationThresholdBeastHealth;
      }
      
      public function get validationThresholdBuildingHealths() : Number
      {
         return _validationThresholdBuildingHealths;
      }
      
      public function get validationThresholdLootedResources() : Number
      {
         return _validationThresholdLootedResources;
      }
      
      public function get enableAndroidRater() : Boolean
      {
         return _enableAndroidRater;
      }
      
      public function get peakPayEnabled() : Boolean
      {
         return _peakPayEnabled;
      }
   }
}

