package wom.model.game.alliance
{
   import wom.model.resource.ListColumnType;
   
   public class AllianceMemberListColumnType extends ListColumnType
   {
      
      public static const DIRECTION_LEADER_FIRST_ASCENDING:int = -2;
      
      public static const DIRECTION_LEADER_FIRST_DESCENDING:int = 2;
      
      public static const UNSORTABLE:AllianceMemberListColumnType = new AllianceMemberListColumnType(0,compareNothing,compareNothing);
      
      public static const LEVEL:AllianceMemberListColumnType = new AllianceMemberListColumnType(1,compareLevelAsc,compareLevelDesc);
      
      public static const NAME:AllianceMemberListColumnType = new AllianceMemberListColumnType(2,compareNameAsc,compareNameDesc);
      
      public static const BATTLE_POINTS:AllianceMemberListColumnType = new AllianceMemberListColumnType(3,compareBattlePointsAsc,compareBattlePointsDesc);
      
      public static const CONTRIBUTION_POINTS:AllianceMemberListColumnType = new AllianceMemberListColumnType(4,compareContributionPointsAsc,compareContributionPointsDesc);
      
      public static const BATTLE_POINTS_LEADER_FIRST:AllianceMemberListColumnType = new AllianceMemberListColumnType(5,compareBattlePointsLeaderFirstAsc,compareBattlePointsLeaderFirstDesc);
      
      public static const CONTRIBUTION_POINTS_LEADER_FIRST:AllianceMemberListColumnType = new AllianceMemberListColumnType(6,compareContributionPointsLeaderFirstAsc,compareContributionPointsLeaderFirstDesc);
      
      public static const TOURNAMENT_CONTRIBUTION_POINTS:AllianceMemberListColumnType = new AllianceMemberListColumnType(7,compareTournamentPointsAsc,compareTournamentPointsDesc);
      
      public function AllianceMemberListColumnType(param1:int, param2:Function, param3:Function)
      {
         super(param1,param2,param3);
      }
      
      private static function compareNothing(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         return 0;
      }
      
      private static function compareLevelAsc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         return compareNumbers(param1.level,param2.level,-1);
      }
      
      private static function compareLevelDesc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         return compareNumbers(param1.level,param2.level,1);
      }
      
      private static function compareNameAsc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         return compareStrings(param1.name,param2.name,-1);
      }
      
      private static function compareNameDesc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         return compareStrings(param1.name,param2.name,1);
      }
      
      private static function compareBattlePointsAsc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         return compareNumbers(param1.battlePoints,param2.battlePoints,-1);
      }
      
      private static function compareBattlePointsDesc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         return compareNumbers(param1.battlePoints,param2.battlePoints,1);
      }
      
      private static function compareContributionPointsAsc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         return compareNumbers(param1.contributionPoints,param2.contributionPoints,-1);
      }
      
      private static function compareContributionPointsDesc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         return compareNumbers(param1.contributionPoints,param2.contributionPoints,1);
      }
      
      private static function compareBattlePointsLeaderFirstAsc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         if(param1.isLeader)
         {
            return -2;
         }
         if(param2.isLeader)
         {
            return 2;
         }
         return compareNumbers(param1.battlePoints,param2.battlePoints,-1);
      }
      
      private static function compareBattlePointsLeaderFirstDesc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         if(param1.isLeader)
         {
            return -2;
         }
         if(param2.isLeader)
         {
            return 2;
         }
         return compareNumbers(param1.battlePoints,param2.battlePoints,1);
      }
      
      private static function compareContributionPointsLeaderFirstAsc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         if(param1.isLeader)
         {
            return -2;
         }
         if(param2.isLeader)
         {
            return 2;
         }
         return compareNumbers(param1.contributionPoints,param2.contributionPoints,-1);
      }
      
      private static function compareContributionPointsLeaderFirstDesc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         if(param1.isLeader)
         {
            return -2;
         }
         if(param2.isLeader)
         {
            return 2;
         }
         return compareNumbers(param1.contributionPoints,param2.contributionPoints,1);
      }
      
      private static function compareTournamentPointsAsc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         return compareNumbers(param1.tournamentContributionPoint,param2.tournamentContributionPoint,-1);
      }
      
      private static function compareTournamentPointsDesc(param1:AllianceMemberInfo, param2:AllianceMemberInfo) : Number
      {
         return compareNumbers(param1.tournamentContributionPoint,param2.tournamentContributionPoint,1);
      }
   }
}

