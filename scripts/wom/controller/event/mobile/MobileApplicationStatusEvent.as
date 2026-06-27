package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobileApplicationStatusEvent extends Event
   {
      
      public static const APPLICATION_DISCONNECTED:String = "disconnected";
      
      private var _autoReload:Boolean;
      
      private var _networkNotConnected:Boolean;
      
      public function MobileApplicationStatusEvent(param1:String, param2:Boolean, param3:Boolean = false)
      {
         super(param1);
         _autoReload = param2;
         _networkNotConnected = param3;
      }
      
      public function get autoReload() : Boolean
      {
         return _autoReload;
      }
      
      public function get networkNotConnected() : Boolean
      {
         return _networkNotConnected;
      }
   }
}

