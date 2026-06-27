package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.enum.ActionType;
   
   public class BuildingTooltipEvent extends Event
   {
      
      public static const SHOW:String = "showBuildingTooltip";
      
      public static const CLOSE:String = "closeBuildingTooltip";
      
      private var _building:Building;
      
      private var _actionType:ActionType;
      
      private var _help:Boolean;
      
      public function BuildingTooltipEvent(param1:String, param2:ActionType = null, param3:Building = null, param4:Boolean = false)
      {
         super(param1);
         _building = param3;
         _actionType = param2;
         _help = param4;
      }
      
      public function get building() : Building
      {
         return _building;
      }
      
      public function get actionType() : ActionType
      {
         return _actionType;
      }
      
      public function get help() : Boolean
      {
         return _help;
      }
   }
}

