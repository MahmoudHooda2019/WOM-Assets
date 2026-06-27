package wom.controller.event.resource
{
   import flash.events.Event;
   
   public class BankResourcesEvent extends Event
   {
      
      public static const ALL:String = "bankAllResources";
      
      public static const INSTANCE:String = "bankInstanceResources";
      
      private var _instanceId:int;
      
      public function BankResourcesEvent(param1:String, param2:int = 0)
      {
         super(param1);
         _instanceId = param2;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      override public function clone() : Event
      {
         return new BankResourcesEvent(type,instanceId);
      }
   }
}

