package wom.model.component.enum
{
   public class ActionType
   {
      
      public static const INVALID:ActionType = new ActionType(-1,"arrow");
      
      public static const ARROW:ActionType = new ActionType(0,"arrow");
      
      public static const CLEAR_OUT:ActionType = new ActionType(1,"ClearOutCursor");
      
      public static const ENTER_BUILDING:ActionType = new ActionType(2,"EnterBuildingCursor");
      
      public static const FORTIFY:ActionType = new ActionType(3,"FortifyCursor");
      
      public static const HARVEST:ActionType = new ActionType(4,"HarvestCursor");
      
      public static const HARVEST_ALL:ActionType = new ActionType(5,"HarvestAllCursor");
      
      public static const HARVEST_GOLD:ActionType = new ActionType(6,"HarvestGoldCursor");
      
      public static const MOVE:ActionType = new ActionType(7,"MoveCursor");
      
      public static const RECYCLE:ActionType = new ActionType(8,"RecycleCursor");
      
      public static const REMAINING_HELP_1:ActionType = new ActionType(9,"RemainingHelp1Cursor");
      
      public static const REMAINING_HELP_2:ActionType = new ActionType(10,"RemainingHelp2Cursor");
      
      public static const REMAINING_HELP_3:ActionType = new ActionType(11,"RemainingHelp3Cursor");
      
      public static const REMAINING_HELP_4:ActionType = new ActionType(12,"RemainingHelp4Cursor");
      
      public static const REMAINING_HELP_5:ActionType = new ActionType(13,"RemainingHelp5Cursor");
      
      public static const SPEEDUP:ActionType = new ActionType(14,"SpeedUpCursor");
      
      public static const UPGRADE:ActionType = new ActionType(15,"UpgradeCursor");
      
      public static const ACTIVATE:ActionType = new ActionType(16,"EnterBuildingCursor");
      
      public static const CONSTRUCTION_SITE:ActionType = new ActionType(17,"SpeedUpCursor");
      
      public static const BUILD:ActionType = new ActionType(18,"arrow");
      
      public static const actionTypes:Array = [ARROW,CLEAR_OUT,ENTER_BUILDING,FORTIFY,HARVEST,HARVEST_ALL,HARVEST_GOLD,MOVE,RECYCLE,REMAINING_HELP_1,REMAINING_HELP_2,REMAINING_HELP_3,REMAINING_HELP_4,REMAINING_HELP_5,SPEEDUP,UPGRADE,ACTIVATE,CONSTRUCTION_SITE,BUILD];
      
      private var _id:int;
      
      private var _visual:String;
      
      public function ActionType(param1:int, param2:String)
      {
         super();
         _id = param1;
         _visual = param2;
      }
      
      public static function getActionType(param1:int) : ActionType
      {
         return actionTypes[param1];
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get visual() : String
      {
         return _visual;
      }
   }
}

