package wom.controller.event
{
   import flash.events.Event;
   
   public class ExecuteWatchPostUnitEvent extends Event
   {
      
      public static const EXECUTE_WATCHPOST_UNIT:String = "executeWatchPostUnit";
      
      private var _unitTypeId:int;
      
      public function ExecuteWatchPostUnitEvent(param1:String, param2:int)
      {
         super(param1);
         _unitTypeId = param2;
      }
      
      override public function clone() : Event
      {
         return new ExecuteWatchPostUnitEvent(type,_unitTypeId);
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
   }
}

