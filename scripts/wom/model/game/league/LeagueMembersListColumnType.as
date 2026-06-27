package wom.model.game.league
{
   import wom.model.resource.ListColumnType;
   
   public class LeagueMembersListColumnType extends ListColumnType
   {
      
      public static const UNSORTABLE:LeagueMembersListColumnType = new LeagueMembersListColumnType(0,compareNothing,compareNothing);
      
      public static const RANK:LeagueMembersListColumnType = new LeagueMembersListColumnType(1,compareRankAsc,compareRankDesc);
      
      public static const LEVEL:LeagueMembersListColumnType = new LeagueMembersListColumnType(2,compareLevelAsc,compareLevelDesc);
      
      public static const ALLIANCE:LeagueMembersListColumnType = new LeagueMembersListColumnType(3,compareAllianceAsc,compareAllianceDesc);
      
      public static const NAME:LeagueMembersListColumnType = new LeagueMembersListColumnType(4,compareNameAsc,compareNameDesc);
      
      public static const BATTLE_POINTS:LeagueMembersListColumnType = new LeagueMembersListColumnType(5,compareBattlePointsAsc,compareBattlePointsDesc);
      
      public function LeagueMembersListColumnType(param1:int, param2:Function, param3:Function)
      {
         super(param1,param2,param3);
      }
      
      private static function compareNothing(param1:LeagueMemberInfo, param2:LeagueMemberInfo) : Number
      {
         return 0;
      }
      
      private static function compareRankAsc(param1:LeagueMemberInfo, param2:LeagueMemberInfo) : Number
      {
         return compareNumbers(param1.rank,param2.rank,-1);
      }
      
      private static function compareRankDesc(param1:LeagueMemberInfo, param2:LeagueMemberInfo) : Number
      {
         return compareNumbers(param1.rank,param2.rank,1);
      }
      
      private static function compareLevelAsc(param1:LeagueMemberInfo, param2:LeagueMemberInfo) : Number
      {
         return compareNumbers(param1.level,param2.level,-1);
      }
      
      private static function compareLevelDesc(param1:LeagueMemberInfo, param2:LeagueMemberInfo) : Number
      {
         return compareNumbers(param1.level,param2.level,1);
      }
      
      private static function compareAllianceAsc(param1:LeagueMemberInfo, param2:LeagueMemberInfo) : Number
      {
         if(param1.allianceSummary == null && param2.allianceSummary == null)
         {
            return 0;
         }
         if(param1.allianceSummary != null && param2.allianceSummary == null)
         {
            return -1;
         }
         if(param1.allianceSummary == null && param2.allianceSummary != null)
         {
            return 1;
         }
         return compareStrings(param1.allianceSummary.name,param2.allianceSummary.name,-1);
      }
      
      private static function compareAllianceDesc(param1:LeagueMemberInfo, param2:LeagueMemberInfo) : Number
      {
         if(param1.allianceSummary == null && param2.allianceSummary == null)
         {
            return 0;
         }
         if(param1.allianceSummary != null && param2.allianceSummary == null)
         {
            return 1;
         }
         if(param1.allianceSummary == null && param2.allianceSummary != null)
         {
            return -1;
         }
         return compareStrings(param1.allianceSummary.name,param2.allianceSummary.name,1);
      }
      
      private static function compareNameAsc(param1:LeagueMemberInfo, param2:LeagueMemberInfo) : Number
      {
         return compareStrings(param1.name,param2.name,-1);
      }
      
      private static function compareNameDesc(param1:LeagueMemberInfo, param2:LeagueMemberInfo) : Number
      {
         return compareStrings(param1.name,param2.name,1);
      }
      
      private static function compareBattlePointsAsc(param1:LeagueMemberInfo, param2:LeagueMemberInfo) : Number
      {
         return compareNumbers(param1.battlePoints,param2.battlePoints,-1);
      }
      
      private static function compareBattlePointsDesc(param1:LeagueMemberInfo, param2:LeagueMemberInfo) : Number
      {
         return compareNumbers(param1.battlePoints,param2.battlePoints,1);
      }
   }
}

