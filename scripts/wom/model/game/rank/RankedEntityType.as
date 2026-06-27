package wom.model.game.rank
{
   public class RankedEntityType
   {
      
      public static const INVALID_RANKED_ENTITY:RankedEntityType = new RankedEntityType(0,"INVALID_RANKED_ENTITY");
      
      public static const USER:RankedEntityType = new RankedEntityType(1,"USER");
      
      public static const ALLIANCE:RankedEntityType = new RankedEntityType(2,"ALLIANCE");
      
      private var _id:int;
      
      private var _name:String;
      
      public function RankedEntityType(param1:int, param2:String)
      {
         super();
         _id = param1;
         _name = param2;
      }
      
      public static function determineRankedEntityType(param1:int) : RankedEntityType
      {
         var _loc2_:RankedEntityType = null;
         switch(param1)
         {
            case USER._id:
               _loc2_ = USER;
               break;
            case ALLIANCE._id:
               _loc2_ = ALLIANCE;
               break;
            default:
               _loc2_ = INVALID_RANKED_ENTITY;
         }
         return _loc2_;
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}

