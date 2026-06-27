package wom.controller.event
{
   import flash.events.Event;
   
   public class WorkerUpdateEvent extends Event
   {
      
      public static const UPDATE_COUNT:String = "updateCount";
      
      public function WorkerUpdateEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new WorkerUpdateEvent(type);
      }
   }
}

