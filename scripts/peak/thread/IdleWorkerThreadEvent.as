package peak.thread
{
   import flash.events.Event;
   
   public class IdleWorkerThreadEvent extends Event
   {
      
      public static const IDLE:String = "idleWorkerThread";
      
      public var k:Boolean;
      
      public var m:String;
      
      public function IdleWorkerThreadEvent(param1:String, param2:Boolean, param3:String = "Root")
      {
         super(param1);
         this.k = param2;
         this.m = param3;
      }
      
      override public function clone() : Event
      {
         return new IdleWorkerThreadEvent(type,k);
      }
   }
}

