package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobilePreSelectEvent extends Event
   {
      
      public static const MOBILE_PRE_SELECT:String = "mobilePreSelect";
      
      private var _instanceId:int;
      
      public function MobilePreSelectEvent(param1:int)
      {
         super("mobilePreSelect");
         _instanceId = param1;
      }
      
      override public function clone() : Event
      {
         return new MobilePreSelectEvent(_instanceId);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
   }
}

