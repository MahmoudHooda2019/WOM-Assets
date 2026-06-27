package wom.model.game.alliance
{
   public class AllianceSortType
   {
      
      public static const BP:AllianceSortType = new AllianceSortType(0);
      
      public static const MEMBER_COUNT:AllianceSortType = new AllianceSortType(1);
      
      public static const MIN_SCORE:AllianceSortType = new AllianceSortType(2);
      
      public static const MIN_LEVEL:AllianceSortType = new AllianceSortType(3);
      
      public static const RANK:AllianceSortType = new AllianceSortType(4);
      
      public static const DAILY_BP:AllianceSortType = new AllianceSortType(5);
      
      public static const WEEKLY_BP:AllianceSortType = new AllianceSortType(6);
      
      public static const TOURNAMENT:AllianceSortType = new AllianceSortType(7);
      
      private var _id:int;
      
      public function AllianceSortType(param1:int)
      {
         super();
         _id = param1;
      }
      
      public static function determineSortType(param1:int) : AllianceSortType
      {
         switch(param1)
         {
            case RANK.id:
               return RANK;
            case BP.id:
               return BP;
            case MEMBER_COUNT.id:
               return MEMBER_COUNT;
            case MIN_SCORE.id:
               return MIN_SCORE;
            case MIN_LEVEL.id:
               return MIN_LEVEL;
            case DAILY_BP.id:
               return DAILY_BP;
            case WEEKLY_BP.id:
               return WEEKLY_BP;
            default:
               return RANK;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}

