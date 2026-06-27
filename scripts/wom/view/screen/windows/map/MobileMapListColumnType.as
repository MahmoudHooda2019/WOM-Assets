package wom.view.screen.windows.map
{
   import wom.model.dto.MapMemberInfo;
   import wom.model.resource.ListColumnType;
   
   public class MobileMapListColumnType extends ListColumnType
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
      
      public function MobileMapListColumnType(param1:int, param2:Function, param3:Function)
      {
         super(param1,param2,param3);
      }
      
      private static function compareNothing(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         return 0;
      }
      
      private static function compareNameAsc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         return compareStrings(param1.visibleName,param2.visibleName,-1);
      }
      
      private static function compareNameDesc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         return compareStrings(param1.visibleName,param2.visibleName,1);
      }
      
      private static function compareAllianceNamesAsc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         if(param1.alliance != null && param2.alliance == null)
         {
            return -1;
         }
         if(param1.alliance == null && param2.alliance != null)
         {
            return 1;
         }
         var _loc4_:String = param1.alliance == null ? "" : param1.alliance.name;
         var _loc3_:String = param2.alliance == null ? "" : param2.alliance.name;
         return compareStrings(_loc4_,_loc3_,-1);
      }
      
      private static function compareAllianceNamesDesc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         if(param1.alliance != null && param2.alliance == null)
         {
            return -1;
         }
         if(param1.alliance == null && param2.alliance != null)
         {
            return 1;
         }
         var _loc4_:String = param1.alliance == null ? "" : param1.alliance.name;
         var _loc3_:String = param2.alliance == null ? "" : param2.alliance.name;
         return compareStrings(_loc4_,_loc3_,1);
      }
      
      private static function compareLevelAsc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         return compareNumbers(param1.level,param2.level,-1);
      }
      
      private static function compareLevelDesc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         return compareNumbers(param1.level,param2.level,1);
      }
      
      private static function compareBattlesAsc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         return compareNumbers(param1.numberOfBattles,param2.numberOfBattles,-1);
      }
      
      private static function compareBattlesDesc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         return compareNumbers(param1.numberOfBattles,param2.numberOfBattles,1);
      }
      
      private static function compareDiplomacyAsc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         return compareNumbers(param1.playerRelation,param2.playerRelation,-1);
      }
      
      private static function compareDiplomacyDesc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         return compareNumbers(param1.playerRelation,param2.playerRelation,1);
      }
      
      private static function compareBattlePointsAsc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         if(param1.profile.isNpc)
         {
            return 1;
         }
         if(param2.profile.isNpc)
         {
            return -1;
         }
         return compareNumbers(param1.battlePoints,param2.battlePoints,-1);
      }
      
      private static function compareBattlePointsDesc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         return compareNumbers(param1.battlePoints,param2.battlePoints,1);
      }
      
      private static function compareTypeAsc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         var _loc4_:int = int(param1.isEventNpc) * -300 - int(param1.isAllianceEnemy) * 200 - int(param1.isRevanchist) * 100;
         var _loc3_:int = int(param2.isEventNpc) * -300 - int(param2.isAllianceEnemy) * 200 - int(param2.isRevanchist) * 100;
         return compareNumbers(_loc4_,_loc3_,-1);
      }
      
      private static function compareTypeDesc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         var _loc4_:int = int(param1.isEventNpc) * -300 - int(param1.isAllianceEnemy) * 200 - int(param1.isRevanchist) * 100;
         var _loc3_:int = int(param2.isEventNpc) * -300 - int(param2.isAllianceEnemy) * 200 - int(param2.isRevanchist) * 100;
         return compareNumbers(_loc4_,_loc3_,1);
      }
      
      private static function compareTypeAndLevelAsc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         var _loc4_:int = int(param1.isEventNpc) * -300 - int(param1.isAllianceEnemy) * 200 - int(param1.isRevanchist) * 100 + param1.level;
         var _loc3_:int = int(param2.isEventNpc) * -300 - int(param2.isAllianceEnemy) * 200 - int(param2.isRevanchist) * 100 + param2.level;
         return compareNumbers(_loc4_,_loc3_,-1);
      }
      
      private static function compareTypeAndLevelDesc(param1:MapMemberInfo, param2:MapMemberInfo) : Number
      {
         var _loc4_:int = int(param1.isEventNpc) * -300 - int(param1.isAllianceEnemy) * 200 - int(param1.isRevanchist) * 100 + param1.level;
         var _loc3_:int = int(param2.isEventNpc) * -300 - int(param2.isAllianceEnemy) * 200 - int(param2.isRevanchist) * 100 + param2.level;
         return compareNumbers(_loc4_,_loc3_,1);
      }
   }
}

