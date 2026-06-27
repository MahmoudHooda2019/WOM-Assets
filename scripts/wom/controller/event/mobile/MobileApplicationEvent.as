package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobileApplicationEvent extends Event
   {
      
      public static const RESTART:String = "restartMobileApplication";
      
      public static const FLASH_VARS_COMPLETED:String = "flashVarsCompleted";
      
      public static const ACTIVATE_LOGIN_SCREEN:String = "activateLoginScreen";
      
      public static const DEACTIVATE_LOGIN_SCREEN:String = "deactivateLoginScreen";
      
      public function MobileApplicationEvent(param1:String)
      {
         super(param1);
      }
   }
}

