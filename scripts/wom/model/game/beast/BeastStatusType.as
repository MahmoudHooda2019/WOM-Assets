package wom.model.game.beast
{
   public class BeastStatusType
   {
      
      public static const NON_RAISED:BeastStatusType = new BeastStatusType(0,"NonRaised");
      
      public static const IN_CAVE:BeastStatusType = new BeastStatusType(1,"InCave");
      
      public static const IN_KEEPER:BeastStatusType = new BeastStatusType(2,"InKeeper");
      
      private var _id:int;
      
      private var _name:String;
      
      public function BeastStatusType(param1:int, param2:String)
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

