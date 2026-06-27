package wom.model.game.viral
{
   import flash.utils.Dictionary;
   
   public class ViralAction
   {
      
      public static const USER_LEVEL_UP:String = "userLevelUp";
      
      public static const QUEST_COMPLETED:String = "questCompleted";
      
      public static const SEASON_ENDED:String = "seasonEnded";
      
      public static const USER_IS_PLACED_INTO_LEAGUE:String = "userIsPlacedIntoALeague";
      
      public static const USER_IS_REMOVED_FROM_LEAGUE:String = "userIsRemovedFromLeague";
      
      public static const BUILDING_UPGRADED:String = "buildingUpgraded";
      
      public static const BUILDING_FORTIFIED:String = "buildingFortified";
      
      public static const UNIT_RECRUITED:String = "unitRecruited";
      
      public static const UNIT_TRAINED:String = "unitTrained";
      
      public static const FRIEND_WATCHPOST_HELPED:String = "friendWatchPostHelped";
      
      public static const TOURNAMENT_ENDED:String = "tournamentEnded";
      
      private var _type:String;
      
      private var _attributes:Dictionary;
      
      public function ViralAction(param1:String, param2:Dictionary)
      {
         super();
         _type = param1;
         _attributes = param2;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get attributes() : Dictionary
      {
         return _attributes;
      }
   }
}

