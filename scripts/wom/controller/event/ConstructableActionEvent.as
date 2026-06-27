package wom.controller.event
{
   import flash.events.Event;
   import wom.model.component.enum.ActionType;
   
   public class ConstructableActionEvent extends Event
   {
      
      public static const EXECUTE:String = "execute";
      
      public static const LAST_BUILDING_ACTION_TIME_INTERVAL:int = 100;
      
      private var _actionType:ActionType;
      
      private var _instanceId:int;
      
      private var _windowSpecificAttributes:Object;
      
      public function ConstructableActionEvent(param1:String, param2:ActionType, param3:int, param4:Object = null)
      {
         super(param1);
         _actionType = param2;
         _instanceId = param3;
         _windowSpecificAttributes = param4 != null ? param4 : {};
      }
      
      override public function clone() : Event
      {
         return new ConstructableActionEvent(type,_actionType,_instanceId,_windowSpecificAttributes);
      }
      
      public function get actionType() : ActionType
      {
         return _actionType;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get windowSpecificAttributes() : Object
      {
         return _windowSpecificAttributes;
      }
   }
}

