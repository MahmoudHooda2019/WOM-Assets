package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobileContactSupportResponseEvent extends Event
   {
      
      public static const CONTACT_SUPPORT_RESPONSE:String = "contactSupportResponse";
      
      public static const CONTACT_SUPPORT_FAILED:int = 1;
      
      public static const CONTACT_SUPPORT_SUCCESS:int = 2;
      
      private var _success:Boolean;
      
      public function MobileContactSupportResponseEvent(param1:int)
      {
         super("contactSupportResponse");
         _success = param1 == 2;
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
   }
}

