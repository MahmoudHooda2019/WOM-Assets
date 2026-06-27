package wom.model.game.attack
{
   public class GameModeType
   {
      
      public static const UNKNOWN:GameModeType = new GameModeType(0,"Unknown");
      
      public static const NORMAL:GameModeType = new GameModeType(1,"Normal");
      
      public static const DEFEND:GameModeType = new GameModeType(2,"Defend");
      
      public static const ATTACK:GameModeType = new GameModeType(3,"Attack");
      
      public static const VISIT:GameModeType = new GameModeType(4,"Visit");
      
      public static const TUSK_HORN:GameModeType = new GameModeType(5,"TuskHorn");
      
      private var _id:int;
      
      private var _name:String;
      
      public function GameModeType(param1:int, param2:String)
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

