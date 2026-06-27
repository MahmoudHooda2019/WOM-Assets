package wom.model.game.viral
{
   import flash.utils.Dictionary;
   import wom.model.game.attack.GameModeType;
   
   public class UserNotification
   {
      
      public static const TYPE_STAFF:int = 1;
      
      public static const TYPE_PART:int = 2;
      
      public static const TYPE_CONSTRUCTION:int = 3;
      
      public static const TYPE_VISIT_THANKS:int = 4;
      
      public static const TYPE_ASK_FOR_MORE:int = 5;
      
      public static const TYPE_GIFT:int = 6;
      
      public static const TYPE_BEAST:int = 7;
      
      public static const TYPE_CATAPULT:int = 8;
      
      public static const TYPE_REPORT_CAPS:int = 9;
      
      public static const SUBTYPE_NONE:int = 0;
      
      public static const SUBTYPE_BUILDING_COMPLETED:int = 1;
      
      public static const SUBTYPE_BUILDING_UPGRADED:int = 2;
      
      public static const SUBTYPE_BUILDING_FORTIFIED:int = 3;
      
      public static const ASSET_ID_VISIT_THANKS:String = "RP41";
      
      public static const MOBILE_ASSET_ID_VISIT_THANKS:String = "IconRPL";
      
      public static const ADDITIONAL_INFO_BUILDING_TYPE_ID:String = "buildingTypeId";
      
      public static const ADDITIONAL_INFO_LEVEL:String = "level";
      
      public static var GAME_MODE:Dictionary = new Dictionary();
      
      GAME_MODE[1] = GameModeType.NORMAL;
      GAME_MODE[2] = GameModeType.NORMAL;
      GAME_MODE[3] = GameModeType.NORMAL;
      GAME_MODE[4] = GameModeType.VISIT;
      GAME_MODE[5] = GameModeType.NORMAL;
      GAME_MODE[6] = GameModeType.UNKNOWN;
      GAME_MODE[7] = GameModeType.NORMAL;
      GAME_MODE[8] = GameModeType.NORMAL;
      GAME_MODE[9] = GameModeType.NORMAL;
      
      private var _type:int;
      
      private var _subtype:int;
      
      private var _assetId:String;
      
      private var _text:String;
      
      private var _wallPostSuccess:Boolean;
      
      private var _additionalInfo:Dictionary;
      
      public function UserNotification(param1:int, param2:int, param3:String, param4:String, param5:Boolean = false)
      {
         super();
         _type = param1;
         _subtype = param2;
         _assetId = param3;
         _text = param4;
         _wallPostSuccess = param5;
         _additionalInfo = new Dictionary();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get subtype() : int
      {
         return _subtype;
      }
      
      public function get assetId() : String
      {
         return _assetId;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get wallPostSuccess() : Boolean
      {
         return _wallPostSuccess;
      }
      
      public function set wallPostSuccess(param1:Boolean) : void
      {
         _wallPostSuccess = param1;
      }
      
      public function get additionalInfo() : Dictionary
      {
         return _additionalInfo;
      }
   }
}

