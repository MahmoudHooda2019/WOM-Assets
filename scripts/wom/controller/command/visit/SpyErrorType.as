package wom.controller.command.visit
{
   public class SpyErrorType
   {
      
      public static const SUCCESS:SpyErrorType = new SpyErrorType(0,0);
      
      public static const GENERAL_FAILURE:SpyErrorType = new SpyErrorType(1,31);
      
      public static const TARGET_ONLINE:SpyErrorType = new SpyErrorType(2,31);
      
      public static const TARGET_IS_BEING_SPIED:SpyErrorType = new SpyErrorType(3,32);
      
      public static const TARGET_IS_UNDER_ATTACK:SpyErrorType = new SpyErrorType(4,31);
      
      public static const CAN_NOT_SPY_OWN_CITY:SpyErrorType = new SpyErrorType(5,31);
      
      public static const TARGET_LEVEL_NOT_SUFFICIENT:SpyErrorType = new SpyErrorType(6,31);
      
      public static const NO_SUCH_CITY:SpyErrorType = new SpyErrorType(7,31);
      
      public static const NO_SUCH_USER_TO_SPY:SpyErrorType = new SpyErrorType(8,31);
      
      public static const TARGET_IS_UNDER_PROTECTION:SpyErrorType = new SpyErrorType(9,31);
      
      public static const NO_SUCH_NPC_TO_SPY:SpyErrorType = new SpyErrorType(10,31);
      
      public static const TARGET_IS_COMPLETELY_DESTROYED:SpyErrorType = new SpyErrorType(11,31);
      
      public static const INSUFFICIENT_GOLDS:SpyErrorType = new SpyErrorType(12,33);
      
      public static const TARGET_NOT_A_MAP_MEMBER:SpyErrorType = new SpyErrorType(13,31);
      
      public static const SERVER_IN_MAINTENANCE:SpyErrorType = new SpyErrorType(14,22);
      
      public static const DEFENDER_IN_OWN_ALLIANCE:SpyErrorType = new SpyErrorType(15,35);
      
      public static const CAN_NOT_SPY_FRIEND_CITY:SpyErrorType = new SpyErrorType(16,37);
      
      private var id:int;
      
      private var _errorPopupCode:int;
      
      public function SpyErrorType(param1:int, param2:int)
      {
         super();
         this.id = param1;
         this._errorPopupCode = param2;
      }
      
      public static function determineSpyErrorType(param1:int) : SpyErrorType
      {
         var _loc2_:SpyErrorType = GENERAL_FAILURE;
         switch(param1)
         {
            case SUCCESS.id:
               _loc2_ = SUCCESS;
               break;
            case GENERAL_FAILURE.id:
               _loc2_ = GENERAL_FAILURE;
               break;
            case TARGET_ONLINE.id:
               _loc2_ = TARGET_ONLINE;
               break;
            case TARGET_IS_BEING_SPIED.id:
               _loc2_ = TARGET_IS_BEING_SPIED;
               break;
            case TARGET_IS_UNDER_ATTACK.id:
               _loc2_ = TARGET_IS_UNDER_ATTACK;
               break;
            case CAN_NOT_SPY_OWN_CITY.id:
               _loc2_ = CAN_NOT_SPY_OWN_CITY;
               break;
            case TARGET_LEVEL_NOT_SUFFICIENT.id:
               _loc2_ = TARGET_LEVEL_NOT_SUFFICIENT;
               break;
            case NO_SUCH_CITY.id:
               _loc2_ = NO_SUCH_CITY;
               break;
            case NO_SUCH_USER_TO_SPY.id:
               _loc2_ = NO_SUCH_USER_TO_SPY;
               break;
            case TARGET_IS_UNDER_PROTECTION.id:
               _loc2_ = TARGET_IS_UNDER_PROTECTION;
               break;
            case NO_SUCH_NPC_TO_SPY.id:
               _loc2_ = NO_SUCH_NPC_TO_SPY;
               break;
            case TARGET_IS_COMPLETELY_DESTROYED.id:
               _loc2_ = TARGET_IS_COMPLETELY_DESTROYED;
               break;
            case INSUFFICIENT_GOLDS.id:
               _loc2_ = INSUFFICIENT_GOLDS;
               break;
            case TARGET_NOT_A_MAP_MEMBER.id:
               _loc2_ = TARGET_NOT_A_MAP_MEMBER;
               break;
            case SERVER_IN_MAINTENANCE.id:
               _loc2_ = SERVER_IN_MAINTENANCE;
               break;
            case DEFENDER_IN_OWN_ALLIANCE.id:
               _loc2_ = DEFENDER_IN_OWN_ALLIANCE;
               break;
            case CAN_NOT_SPY_FRIEND_CITY.id:
               _loc2_ = CAN_NOT_SPY_FRIEND_CITY;
         }
         return _loc2_;
      }
      
      public function get errorPopupCode() : int
      {
         return _errorPopupCode;
      }
   }
}

