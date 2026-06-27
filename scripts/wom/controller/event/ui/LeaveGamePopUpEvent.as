package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.window.WindowEnumeration;
   
   public class LeaveGamePopUpEvent extends Event
   {
      
      public static const SHOW:String = "showLeaveGamePopUp";
      
      private var _windowEnumerations:Vector.<WindowEnumeration>;
      
      private var _vectorPosition:Object;
      
      public function LeaveGamePopUpEvent(param1:String, param2:Vector.<WindowEnumeration> = null, param3:Object = null)
      {
         super(param1);
         _windowEnumerations = param2;
         _vectorPosition = param3 != null ? param3 : -1;
      }
      
      override public function clone() : Event
      {
         return new LeaveGamePopUpEvent(type,_windowEnumerations,_vectorPosition);
      }
      
      public function get windowEnumerations() : Vector.<WindowEnumeration>
      {
         return _windowEnumerations;
      }
      
      public function get vectorPosition() : int
      {
         return int(_vectorPosition);
      }
   }
}

