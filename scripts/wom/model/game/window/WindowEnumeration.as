package wom.model.game.window
{
   import peak.util.BiMap;
   
   public class WindowEnumeration
   {
      
      public static const DEFAULT:int = 0;
      
      public static const BEASTCAVE:int = 1;
      
      public static const BEASTKEEPER:int = 2;
      
      public static const WATCHPOST:int = 3;
      
      public static const CITYCENTER:int = 4;
      
      public static const TRAININGCHAMBER:int = 5;
      
      public static const RECRUITMENTCHAMBER:int = 6;
      
      public static const PIGEONPOST:int = 7;
      
      public static const HIRINGQUARTERS:int = 8;
      
      public static const EXECUTIONALGUILLOTINE:int = 9;
      
      public static const CITYPLANNER:int = 10;
      
      public static const CENTRALHIRING:int = 11;
      
      public static const BUILDSHOWCASE:int = 12;
      
      public static const INBOX:int = 13;
      
      public static const FREEGIFTPANEL:int = 14;
      
      public static const SENDGIFT:int = 15;
      
      public static const GETGOLD:int = 16;
      
      public static const INVENTORY:int = 17;
      
      public static const STORE:int = 18;
      
      public static const INVITEFRIENDS:int = 19;
      
      public static const BEASTSELECTOR:int = 20;
      
      public static const QUEST:int = 21;
      
      public static const LEADERBOARD:int = 22;
      
      public static const ATTACKLOG:int = 23;
      
      public static const BATTLEREPORT:int = 24;
      
      public static const REPAIRALL:int = 25;
      
      public static const REPAIRSITE:int = 26;
      
      public static const JOBCAPACITYREACHED:int = 27;
      
      public static const BECOMEAFAN:int = 28;
      
      public static const HIGHLIGHT_FRIEND_VIEW:int = 29;
      
      public static const CONSTRUCTBUILDINGWINDOW:int = 30;
      
      public static const CAMPAIGN_MAP:int = 31;
      
      public static const CITYPLANNERSAVE:int = 32;
      
      public static const BATTLEREPORTDETAIL:int = 33;
      
      public static const GIFTGOLD:int = 34;
      
      public static const DONOTHING:int = 35;
      
      public static const QUITALLIANCE:int = 36;
      
      public static const KICKOUTALLIANCE:int = 37;
      
      public static const MAP:int = 38;
      
      public static const EVENTSTOREITEM:int = 39;
      
      public static const UPLOADCAPS:int = 40;
      
      public static const BUILD_BEAST_KEEPER:int = 41;
      
      public static const NOT_ENOUGH_GOLD:int = 42;
      
      public static const DEFAULT_TOP_OFF_RESOURCES:int = 43;
      
      public static const CONSTRUCT_TOP_OFF_RESOURCES:int = 44;
      
      public static const CAPACITY_EXCEED:int = 45;
      
      public static const BLACKSMITH:int = 46;
      
      public static const UPGRADE:int = 47;
      
      public static const FORTIFY:int = 48;
      
      public static const MOBILE_QUEST_DETAIL:int = 200;
      
      public static const MOBILE_HIRE_WORKER:int = 201;
      
      public static const MOBILE_STORE_ITEM_PURCHASED:int = 202;
      
      public static const MOBILE_SETTINGS:int = 203;
      
      public static const MOBILE_CONTACT_SUPPORT:int = 204;
      
      public static const MOBILE_FB_CONNECT:int = 205;
      
      public static const MOBILE_SOCIAL_WINDOW:int = 206;
      
      public static const MOBILE_ALLIANCE_WINDOW:int = 207;
      
      public static const MOBILE_SELL_BUILDING:int = 208;
      
      public static const BUILD:int = -1;
      
      public static const CONSTRUCTIONSITE:int = -2;
      
      public static const ALLYWATCHPOSTFRIENDVIEW:int = -3;
      
      public static const ALLYWATCHPOSTOWNVIEW:int = -4;
      
      public static const ATTACKOUTPOST:int = -5;
      
      public static const TUSKHORN:int = -8;
      
      public static const GENERALINFORMATION:int = -9;
      
      public static const MESSAGEBOX:int = -11;
      
      private var _type:int;
      
      private var _attributes:Object;
      
      public function WindowEnumeration(param1:int, param2:Object)
      {
         super();
         _type = param1;
         _attributes = param2;
      }
      
      public static function getBuildingTypeIdMap() : BiMap
      {
         var _loc1_:BiMap = new BiMap();
         _loc1_.put(1,29);
         _loc1_.put(2,30);
         _loc1_.put(3,37);
         _loc1_.put(4,10);
         _loc1_.put(5,18);
         _loc1_.put(6,17);
         _loc1_.put(7,28);
         _loc1_.put(8,20);
         _loc1_.put(9,27);
         _loc1_.put(10,26);
         _loc1_.put(11,21);
         return _loc1_;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get attributes() : Object
      {
         return _attributes;
      }
   }
}

