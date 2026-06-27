package wom.model.game.defense
{
   public class NPCAttackDirection
   {
      
      public static const TUSK_HORN:NPCAttackDirection = new NPCAttackDirection(-1,"TuskHorn",0,0);
      
      public static const UNKNOWN:NPCAttackDirection = new NPCAttackDirection(0,"Unknown",0,0);
      
      public static const NORTH_WEST:NPCAttackDirection = new NPCAttackDirection(1,"NorthWest",-1,0);
      
      public static const SOUTH_WEST:NPCAttackDirection = new NPCAttackDirection(2,"SouthWest",0,1);
      
      public static const SOUTH_EAST:NPCAttackDirection = new NPCAttackDirection(3,"SouthEast",1,0);
      
      public static const NORTH_EAST:NPCAttackDirection = new NPCAttackDirection(4,"NorthEast",0,-1);
      
      private var _id:int;
      
      private var _name:String;
      
      private var _xDirection:int;
      
      private var _yDirection:int;
      
      public function NPCAttackDirection(param1:int, param2:String, param3:int, param4:int)
      {
         super();
         _id = param1;
         _name = param2;
         _xDirection = param3;
         _yDirection = param4;
      }
      
      public static function determineDirectionFromServerDirectionId(param1:int) : NPCAttackDirection
      {
         return determineDirectionFromId(param1 + 1);
      }
      
      public static function determineDirectionFromId(param1:int) : NPCAttackDirection
      {
         switch(param1)
         {
            case TUSK_HORN.id:
               return TUSK_HORN;
            case UNKNOWN.id:
               return UNKNOWN;
            case SOUTH_WEST.id:
               return SOUTH_WEST;
            case SOUTH_EAST.id:
               return SOUTH_EAST;
            case NORTH_WEST.id:
               return NORTH_WEST;
            case NORTH_EAST.id:
               return NORTH_EAST;
            default:
               return UNKNOWN;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get xDirection() : int
      {
         return _xDirection;
      }
      
      public function get yDirection() : int
      {
         return _yDirection;
      }
   }
}

