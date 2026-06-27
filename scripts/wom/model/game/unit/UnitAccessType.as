package wom.model.game.unit
{
   public class UnitAccessType
   {
      
      public static const UNKNOWN:UnitAccessType = new UnitAccessType(0,"Unknown");
      
      public static const DEFAULT:UnitAccessType = new UnitAccessType(1,"Default");
      
      public static const EVENT:UnitAccessType = new UnitAccessType(2,"Event");
      
      public static const ALL:UnitAccessType = new UnitAccessType(3,"All");
      
      private var _id:int;
      
      private var _name:String;
      
      public function UnitAccessType(param1:int, param2:String)
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

