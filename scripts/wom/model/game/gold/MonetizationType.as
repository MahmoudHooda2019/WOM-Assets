package wom.model.game.gold
{
   public class MonetizationType
   {
      
      public static const UNKNOWN:MonetizationType = new MonetizationType(0,"Unknown");
      
      public static const ADD_GOLD:MonetizationType = new MonetizationType(1,"AddGold");
      
      public static const GET_GOLD:MonetizationType = new MonetizationType(2,"GetGold");
      
      public static const FINISH_BUILDING:MonetizationType = new MonetizationType(3,"FinishBuilding");
      
      public static const NOT_ENOUGH_GOLD:MonetizationType = new MonetizationType(4,"NotEnoughGold");
      
      private var _id:int;
      
      private var _name:String;
      
      public function MonetizationType(param1:int, param2:String)
      {
         super();
         this._id = param1;
         this._name = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

