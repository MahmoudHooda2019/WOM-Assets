package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.component.enum.ActionType;
   
   public class ActionSelectEvent extends Event
   {
      
      public static const ACTION_SELECT:String = "actionSelect";
      
      public static const SELECTION_SUCCESS:String = "selectionSuccess";
      
      public static const SELECTION_FAILURE:String = "selectionFailure";
      
      private var _actionType:ActionType;
      
      public function ActionSelectEvent(param1:String, param2:ActionType)
      {
         super(param1);
         this._actionType = param2;
      }
      
      override public function clone() : Event
      {
         return new ActionSelectEvent(type,_actionType);
      }
      
      public function get actionType() : ActionType
      {
         return _actionType;
      }
   }
}

