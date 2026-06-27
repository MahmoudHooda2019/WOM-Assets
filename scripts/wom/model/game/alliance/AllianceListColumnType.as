package wom.model.game.alliance
{
   import wom.model.resource.ListColumnType;
   
   public class AllianceListColumnType extends ListColumnType
   {
      
      public static const UNSORTABLE:AllianceListColumnType = new AllianceListColumnType(0,compareNothing,compareNothing);
      
      public static const RANK:AllianceListColumnType = new AllianceListColumnType(1,compareRankAsc,compareRankDesc);
      
      public static const NAME:AllianceListColumnType = new AllianceListColumnType(2,compareNameAsc,compareNameDesc);
      
      public static const MEMBERS:AllianceListColumnType = new AllianceListColumnType(3,compareMembersAsc,compareMembersDesc);
      
      public static const SCORE:AllianceListColumnType = new AllianceListColumnType(4,compareScoreAsc,compareScoreDesc);
      
      public static const MIN_SCORE:AllianceListColumnType = new AllianceListColumnType(5,compareMinScoreAsc,compareMinScoreDesc);
      
      public static const MIN_LEVEL:AllianceListColumnType = new AllianceListColumnType(6,compareMinLevelAsc,compareMinLevelDesc);
      
      public function AllianceListColumnType(param1:int, param2:Function, param3:Function)
      {
         super(param1,param2,param3);
      }
      
      private static function compareNothing(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return 0;
      }
      
      private static function compareRankAsc(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return compareNumbers(param1.rank,param2.rank,-1);
      }
      
      private static function compareRankDesc(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return compareNumbers(param1.rank,param2.rank,1);
      }
      
      private static function compareNameAsc(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return compareStrings(param1.name,param2.name,-1);
      }
      
      private static function compareNameDesc(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return compareStrings(param1.name,param2.name,1);
      }
      
      private static function compareMembersAsc(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return compareNumbers(param1.members,param2.members,-1);
      }
      
      private static function compareMembersDesc(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return compareNumbers(param1.members,param2.members,1);
      }
      
      private static function compareScoreAsc(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return compareNumbers(param1.score,param2.score,-1);
      }
      
      private static function compareScoreDesc(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return compareNumbers(param1.score,param2.score,1);
      }
      
      private static function compareMinScoreAsc(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return compareNumbers(param1.minScore,param2.minScore,-1);
      }
      
      private static function compareMinScoreDesc(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return compareNumbers(param1.minScore,param2.minScore,1);
      }
      
      private static function compareMinLevelAsc(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return compareNumbers(param1.minLevel,param2.minLevel,-1);
      }
      
      private static function compareMinLevelDesc(param1:AllianceDetailInfo, param2:AllianceDetailInfo) : Number
      {
         return compareNumbers(param1.minLevel,param2.minLevel,1);
      }
   }
}

