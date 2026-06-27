package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobileSelectEvent extends Event
   {
      
      public static const MOBILE_SELECT:String = "mobileSelect";
      
      private var _instanceId:int;
      
      private var _enterOnRegister:Boolean;
      
      private var _windowSpecificAttributes:Object;
      
      public function MobileSelectEvent(param1:int, param2:Boolean = false, param3:Object = null)
      {
         super("mobileSelect");
         _instanceId = param1;
         _enterOnRegister = param2;
         _windowSpecificAttributes = param3;
      }
      
      override public function clone() : Event
      {
         return new MobileSelectEvent(_instanceId,_enterOnRegister,_windowSpecificAttributes);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get enterOnRegister() : Boolean
      {
         return _enterOnRegister;
      }
      
      public function get windowSpecificAttributes() : Object
      {
         return _windowSpecificAttributes;
      }
   }
}

