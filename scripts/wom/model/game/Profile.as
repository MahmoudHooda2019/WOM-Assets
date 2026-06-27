package wom.model.game
{
   import flash.utils.getDefinitionByName;
   
   public class Profile
   {
      
      public static const SHRIEKING_DRAGON:String = "NPC_1";
      
      public static const RAGING_BULL:String = "NPC_2";
      
      public static const DEMON_KING:String = "NPC_3";
      
      public static const IRON_HAND:String = "NPC_4";
      
      public static const EVENT_NPC:String = "NPC-6";
      
      private var _gameId:String;
      
      private var _platformId:String;
      
      private var _avatar:String;
      
      private var _mobileName:String;
      
      private var _mobileAvatarIndex:String;
      
      private var _npcId:String;
      
      private var _npcClan:String;
      
      public var invitableFriendPictureUrl:String = null;
      
      public function Profile(param1:String, param2:String, param3:String, param4:String = null, param5:String = null)
      {
         super();
         _gameId = param1;
         _platformId = param2;
         _avatar = param3;
         _npcId = param4;
         if(param3 != null && param3 != "")
         {
            _mobileAvatarIndex = param3.substr(0,1);
            _mobileName = param3.substr(2);
         }
         if(_npcId != null)
         {
            switch(_npcId)
            {
               case "NPC_1":
               case "NPC_2":
               case "NPC_3":
               case "NPC_4":
               case "NPC_5":
               case "NPC_D":
                  _npcClan = param4;
                  break;
               default:
                  _npcClan = "NPC-" + param5;
            }
         }
      }
      
      public static function deserialize(param1:Object) : Profile
      {
         if(param1.plyr && param1.plyr != null)
         {
            return new Profile(param1.plyr[0],param1.plyr[1],param1.plyr[2]);
         }
         return new Profile(null,null,null,param1.npcName);
      }
      
      public static function getAvatarAssetIdByProfile(param1:Profile) : String
      {
         var _loc2_:String = null;
         switch(param1.npcClan)
         {
            case "NPC_1":
               _loc2_ = "ShriekingDragonMap";
               break;
            case "NPC_2":
               _loc2_ = "RagingBullMap";
               break;
            case "NPC_3":
               _loc2_ = "DemonKingMap";
               break;
            case "NPC_4":
               _loc2_ = "IronHandMap";
               break;
            case "NPC_5":
               _loc2_ = "GermanicHunterAvatar";
               break;
            case "NPC_D":
               _loc2_ = "TutorialDefenderIcon";
         }
         return _loc2_;
      }
      
      public function get gameId() : String
      {
         return _gameId != null ? _gameId : (_npcId != null ? _npcId : null);
      }
      
      public function set gameId(param1:String) : void
      {
         _gameId = param1;
      }
      
      public function get platformId() : String
      {
         return _platformId;
      }
      
      public function set platformId(param1:String) : void
      {
         _platformId = param1;
      }
      
      public function get avatar() : String
      {
         return _avatar;
      }
      
      public function set avatar(param1:String) : void
      {
         _avatar = param1;
         _mobileAvatarIndex = avatar.substr(0,1);
         _mobileName = avatar.substr(2);
      }
      
      public function get npcId() : String
      {
         return _npcId;
      }
      
      public function set npcId(param1:String) : void
      {
         _npcId = param1;
      }
      
      public function get isNpc() : Boolean
      {
         return _npcId != null;
      }
      
      public function get npcClan() : String
      {
         return _npcClan;
      }
      
      public function toString() : String
      {
         return "Profile{g=" + _gameId + ",p=" + _platformId + ",s=" + _avatar + ",n=" + _npcId + "}";
      }
      
      public function get mobileName() : String
      {
         return _mobileName;
      }
      
      public function get mobileAvatarIndex() : String
      {
         return _mobileAvatarIndex;
      }
   }
}

