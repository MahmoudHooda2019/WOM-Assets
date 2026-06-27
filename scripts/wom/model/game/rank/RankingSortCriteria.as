package wom.model.game.rank
{
   public class RankingSortCriteria
   {
      
      public static const INVALID_CRITERION:RankingSortCriteria = new RankingSortCriteria(0,"INVALID_CRITERION");
      
      public static const XP:RankingSortCriteria = new RankingSortCriteria(1,"XP");
      
      public static const LOOT:RankingSortCriteria = new RankingSortCriteria(2,"LOOT");
      
      public static const DAILY_XP:RankingSortCriteria = new RankingSortCriteria(3,"DAILY_XP");
      
      public static const DAILY_LOOT:RankingSortCriteria = new RankingSortCriteria(4,"DAILY_LOOT");
      
      public static const WEEKLY_XP:RankingSortCriteria = new RankingSortCriteria(5,"WEEKLY_XP");
      
      public static const WEEKLY_LOOT:RankingSortCriteria = new RankingSortCriteria(6,"WEEKLY_LOOT");
      
      public static const BP:RankingSortCriteria = new RankingSortCriteria(7,"BP");
      
      public static const DAILY_BP:RankingSortCriteria = new RankingSortCriteria(8,"DAILY_BP");
      
      public static const WEEKLY_BP:RankingSortCriteria = new RankingSortCriteria(9,"WEEKLY_BP");
      
      private var _id:int;
      
      private var _name:String;
      
      public function RankingSortCriteria(param1:int, param2:String)
      {
         super();
         this._id = param1;
         this._name = param2;
      }
      
      public static function determineRankingSortCriteria(param1:int) : RankingSortCriteria
      {
         var _loc2_:RankingSortCriteria = null;
         switch(param1)
         {
            case XP._id:
               _loc2_ = XP;
               break;
            case LOOT._id:
               _loc2_ = LOOT;
               break;
            case DAILY_XP._id:
               _loc2_ = DAILY_XP;
               break;
            case DAILY_LOOT._id:
               _loc2_ = DAILY_LOOT;
               break;
            case WEEKLY_XP._id:
               _loc2_ = WEEKLY_XP;
               break;
            case WEEKLY_LOOT._id:
               _loc2_ = WEEKLY_LOOT;
               break;
            case BP._id:
               _loc2_ = BP;
               break;
            case DAILY_BP._id:
               _loc2_ = DAILY_BP;
               break;
            case WEEKLY_BP._id:
               _loc2_ = WEEKLY_BP;
               break;
            default:
               _loc2_ = INVALID_CRITERION;
         }
         return _loc2_;
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}

