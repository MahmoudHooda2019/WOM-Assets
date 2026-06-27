package wom.model.game.hiring
{
   public class HiringPauseReasonType
   {
      
      public static const INVALID_PAUSE_REASON:HiringPauseReasonType = new HiringPauseReasonType(0,"Invalid pause reason");
      
      public static const UNPAUSED:HiringPauseReasonType = new HiringPauseReasonType(1,"Not paused");
      
      public static const HIRING_BUILDING_BEING_UPGRADED:HiringPauseReasonType = new HiringPauseReasonType(2,"Hiring building is being upgraded");
      
      public static const BARRACKS_CAPACITY_FULL:HiringPauseReasonType = new HiringPauseReasonType(3,"Barracks capacity is full");
      
      public static const HIRING_BUILDING_DAMAGED:HiringPauseReasonType = new HiringPauseReasonType(4,"Hiring building is damaged");
      
      public static const HIRING_BUILDING_DESTROYED:HiringPauseReasonType = new HiringPauseReasonType(5,"Hiring building is destroyed");
      
      public static const hiringPauseReasonTypes:Array = [UNPAUSED,HIRING_BUILDING_BEING_UPGRADED,BARRACKS_CAPACITY_FULL,HIRING_BUILDING_DAMAGED,HIRING_BUILDING_DESTROYED];
      
      private var _id:int;
      
      private var _name:String;
      
      public function HiringPauseReasonType(param1:int, param2:String)
      {
         super();
         this._id = param1;
         this._name = param2;
      }
      
      public static function determineHiringPauseReasonType(param1:int) : HiringPauseReasonType
      {
         var _loc2_:HiringPauseReasonType = HiringPauseReasonType.INVALID_PAUSE_REASON;
         switch(param1)
         {
            case UNPAUSED.id:
               _loc2_ = HiringPauseReasonType.UNPAUSED;
               break;
            case HIRING_BUILDING_BEING_UPGRADED.id:
               _loc2_ = HiringPauseReasonType.HIRING_BUILDING_BEING_UPGRADED;
               break;
            case BARRACKS_CAPACITY_FULL.id:
               _loc2_ = HiringPauseReasonType.BARRACKS_CAPACITY_FULL;
               break;
            case HIRING_BUILDING_DAMAGED.id:
               _loc2_ = HiringPauseReasonType.HIRING_BUILDING_DAMAGED;
               break;
            case HIRING_BUILDING_DESTROYED.id:
               _loc2_ = HiringPauseReasonType.HIRING_BUILDING_DESTROYED;
               break;
            default:
               _loc2_ = HiringPauseReasonType.INVALID_PAUSE_REASON;
         }
         return _loc2_;
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

