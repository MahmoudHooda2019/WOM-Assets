package wom.view.screen.windows.map
{
   import wom.model.component.attribute.data.MapTileData;
   import wom.model.resource.ListColumnType;
   
   public class MapListColumnType extends ListColumnType
   {
      
      public static const UNSORTABLE:MapListColumnType = new MapListColumnType(0,compareNothing,compareNothing);
      
      public static const NAME:MapListColumnType = new MapListColumnType(1,compareNameAsc,compareNameDesc);
      
      public static const LEVEL:MapListColumnType = new MapListColumnType(2,compareLevelAsc,compareLevelDesc);
      
      public static const BATTLES:MapListColumnType = new MapListColumnType(3,compareBattlesAsc,compareBattlesDesc);
      
      public static const DIPLOMACY:MapListColumnType = new MapListColumnType(4,compareDiplomacyAsc,compareDiplomacyDesc);
      
      public static const BATTLE_POINTS:MapListColumnType = new MapListColumnType(5,compareBattlePointsAsc,compareBattlePointsDesc);
      
      public static const TYPE:MapListColumnType = new MapListColumnType(6,compareTypeAsc,compareTypeDesc);
      
      public static const LEVEL_AND_TYPE:MapListColumnType = new MapListColumnType(7,compareTypeAndLevelAsc,compareTypeAndLevelDesc);
      
      public static const ALLIANCE:MapListColumnType = new MapListColumnType(8,compareAllianceNamesAsc,compareAllianceNamesDesc);
      
      public function MapListColumnType(param1:int, param2:Function, param3:Function)
      {
         super(param1,param2,param3);
      }
      
      private static function compareNothing(param1:MapTileData, param2:MapTileData) : Number
      {
         return 0;
      }
      
      private static function compareNameAsc(param1:MapTileData, param2:MapTileData) : Number
      {
         return compareStrings(param1.mapMemberInfo.visibleName,param2.mapMemberInfo.visibleName,-1);
      }
      
      private static function compareNameDesc(param1:MapTileData, param2:MapTileData) : Number
      {
         return compareStrings(param1.mapMemberInfo.visibleName,param2.mapMemberInfo.visibleName,1);
      }
      
      private static function compareAllianceNamesAsc(param1:MapTileData, param2:MapTileData) : Number
      {
         if(param1.mapMemberInfo.alliance != null && param2.mapMemberInfo.alliance == null)
         {
            return -1;
         }
         if(param1.mapMemberInfo.alliance == null && param2.mapMemberInfo.alliance != null)
         {
            return 1;
         }
         var _loc4_:String = param1.mapMemberInfo.alliance == null ? "" : param1.mapMemberInfo.alliance.name;
         var _loc3_:String = param2.mapMemberInfo.alliance == null ? "" : param2.mapMemberInfo.alliance.name;
         return compareStrings(_loc4_,_loc3_,-1);
      }
      
      private static function compareAllianceNamesDesc(param1:MapTileData, param2:MapTileData) : Number
      {
         if(param1.mapMemberInfo.alliance != null && param2.mapMemberInfo.alliance == null)
         {
            return -1;
         }
         if(param1.mapMemberInfo.alliance == null && param2.mapMemberInfo.alliance != null)
         {
            return 1;
         }
         var _loc4_:String = param1.mapMemberInfo.alliance == null ? "" : param1.mapMemberInfo.alliance.name;
         var _loc3_:String = param2.mapMemberInfo.alliance == null ? "" : param2.mapMemberInfo.alliance.name;
         return compareStrings(_loc4_,_loc3_,1);
      }
      
      private static function compareLevelAsc(param1:MapTileData, param2:MapTileData) : Number
      {
         return compareNumbers(param1.mapMemberInfo.level,param2.mapMemberInfo.level,-1);
      }
      
      private static function compareLevelDesc(param1:MapTileData, param2:MapTileData) : Number
      {
         return compareNumbers(param1.mapMemberInfo.level,param2.mapMemberInfo.level,1);
      }
      
      private static function compareBattlesAsc(param1:MapTileData, param2:MapTileData) : Number
      {
         return compareNumbers(param1.mapMemberInfo.numberOfBattles,param2.mapMemberInfo.numberOfBattles,-1);
      }
      
      private static function compareBattlesDesc(param1:MapTileData, param2:MapTileData) : Number
      {
         return compareNumbers(param1.mapMemberInfo.numberOfBattles,param2.mapMemberInfo.numberOfBattles,1);
      }
      
      private static function compareDiplomacyAsc(param1:MapTileData, param2:MapTileData) : Number
      {
         return compareNumbers(param1.mapMemberInfo.playerRelation,param2.mapMemberInfo.playerRelation,-1);
      }
      
      private static function compareDiplomacyDesc(param1:MapTileData, param2:MapTileData) : Number
      {
         return compareNumbers(param1.mapMemberInfo.playerRelation,param2.mapMemberInfo.playerRelation,1);
      }
      
      private static function compareBattlePointsAsc(param1:MapTileData, param2:MapTileData) : Number
      {
         if(param1.mapMemberInfo.profile.isNpc)
         {
            return 1;
         }
         if(param2.mapMemberInfo.profile.isNpc)
         {
            return -1;
         }
         return compareNumbers(param1.mapMemberInfo.battlePoints,param2.mapMemberInfo.battlePoints,-1);
      }
      
      private static function compareBattlePointsDesc(param1:MapTileData, param2:MapTileData) : Number
      {
         return compareNumbers(param1.mapMemberInfo.battlePoints,param2.mapMemberInfo.battlePoints,1);
      }
      
      private static function compareTypeAsc(param1:MapTileData, param2:MapTileData) : Number
      {
         var _loc4_:int = int(param1.mapMemberInfo.isEventNpc) * -300 - int(param1.mapMemberInfo.isAllianceEnemy) * 200 - int(param1.mapMemberInfo.isRevanchist) * 100;
         var _loc3_:int = int(param2.mapMemberInfo.isEventNpc) * -300 - int(param2.mapMemberInfo.isAllianceEnemy) * 200 - int(param2.mapMemberInfo.isRevanchist) * 100;
         return compareNumbers(_loc4_,_loc3_,-1);
      }
      
      private static function compareTypeDesc(param1:MapTileData, param2:MapTileData) : Number
      {
         var _loc4_:int = int(param1.mapMemberInfo.isEventNpc) * -300 - int(param1.mapMemberInfo.isAllianceEnemy) * 200 - int(param1.mapMemberInfo.isRevanchist) * 100;
         var _loc3_:int = int(param2.mapMemberInfo.isEventNpc) * -300 - int(param2.mapMemberInfo.isAllianceEnemy) * 200 - int(param2.mapMemberInfo.isRevanchist) * 100;
         return compareNumbers(_loc4_,_loc3_,1);
      }
      
      private static function compareTypeAndLevelAsc(param1:MapTileData, param2:MapTileData) : Number
      {
         var _loc4_:int = int(param1.mapMemberInfo.isEventNpc) * -300 - int(param1.mapMemberInfo.isAllianceEnemy) * 200 - int(param1.mapMemberInfo.isRevanchist) * 100 + param1.mapMemberInfo.level;
         var _loc3_:int = int(param2.mapMemberInfo.isEventNpc) * -300 - int(param2.mapMemberInfo.isAllianceEnemy) * 200 - int(param2.mapMemberInfo.isRevanchist) * 100 + param2.mapMemberInfo.level;
         return compareNumbers(_loc4_,_loc3_,-1);
      }
      
      private static function compareTypeAndLevelDesc(param1:MapTileData, param2:MapTileData) : Number
      {
         var _loc4_:int = int(param1.mapMemberInfo.isEventNpc) * -300 - int(param1.mapMemberInfo.isAllianceEnemy) * 200 - int(param1.mapMemberInfo.isRevanchist) * 100 + param1.mapMemberInfo.level;
         var _loc3_:int = int(param2.mapMemberInfo.isEventNpc) * -300 - int(param2.mapMemberInfo.isAllianceEnemy) * 200 - int(param2.mapMemberInfo.isRevanchist) * 100 + param2.mapMemberInfo.level;
         return compareNumbers(_loc4_,_loc3_,1);
      }
   }
}

