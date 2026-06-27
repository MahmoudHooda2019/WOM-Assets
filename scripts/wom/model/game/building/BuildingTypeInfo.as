package wom.model.game.building
{
   public class BuildingTypeInfo
   {
      
      public static const CITY_CENTER:int = 10;
      
      public static const LUMBER_BLADE:int = 11;
      
      public static const STONE_GRINDER:int = 12;
      
      public static const STATUE_OF_MIGHT:int = 13;
      
      public static const IRON_SMELTER:int = 14;
      
      public static const STOCK_PILE:int = 15;
      
      public static const RECRUITMENT_CHAMBER:int = 17;
      
      public static const TRAININIG_CHAMBER:int = 18;
      
      public static const MERCENARY_BARRACKS:int = 19;
      
      public static const HIRING_QUARTERS:int = 20;
      
      public static const CENTRAL_HIRING_QUARTERS:int = 21;
      
      public static const CATAPULT:int = 23;
      
      public static const TUSK_HORN:int = 25;
      
      public static const CITY_PLANNER:int = 26;
      
      public static const EXECUTIONAL_GUILLOTINE:int = 27;
      
      public static const PIGEON_POST:int = 28;
      
      public static const BEAST_CAVE:int = 29;
      
      public static const BEAST_KEEPER:int = 30;
      
      public static const ARCHERS_TOWER:int = 31;
      
      public static const BOMBARD_TOWER:int = 32;
      
      public static const FLAMER_TOWER:int = 33;
      
      public static const GATLING_ARROW_TOWER:int = 34;
      
      public static const SKY_TOWER:int = 35;
      
      public static const BURNING_MIRRORS:int = 36;
      
      public static const WATCH_POST:int = 37;
      
      public static const FRIEND_WATCH_POST:int = 38;
      
      public static const BURIED_SPIKES:int = 39;
      
      public static const FIRE_TRAP:int = 40;
      
      public static const WALL:int = 41;
      
      public static const HOUSE_OF_BROTHERHOOD:int = 42;
      
      public static const ALLIANCE_BARRACKS:int = 43;
      
      public static const BLACKSMITH:int = 44;
      
      public static const BEAST_CANNON:int = 45;
      
      public static const BEAST_CAGE:int = 100000;
      
      public static const EXPAND_SIGN:int = 100001;
      
      private var _constructTypeId:int;
      
      private var _currentInstanceCount:int;
      
      private var _maxInstanceCount:int;
      
      public function BuildingTypeInfo(param1:int, param2:int, param3:int)
      {
         super();
         _constructTypeId = param1;
         _currentInstanceCount = param2;
         _maxInstanceCount = param3;
      }
      
      public function get constructTypeId() : int
      {
         return _constructTypeId;
      }
      
      public function get currentInstanceCount() : int
      {
         return _currentInstanceCount;
      }
      
      public function get maxInstanceCount() : int
      {
         return _maxInstanceCount;
      }
      
      public function set currentInstanceCount(param1:int) : void
      {
         _currentInstanceCount = param1;
      }
      
      public function set maxInstanceCount(param1:int) : void
      {
         _maxInstanceCount = param1;
      }
   }
}

