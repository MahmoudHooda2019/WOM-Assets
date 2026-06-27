package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileCloseGenericWindowEvent extends Event
   {
      
      public static const CLOSE:String = "mobileCloseGenericWindow";
      
      private var _mobileGenericWindow:MobileGenericWindow;
      
      public function MobileCloseGenericWindowEvent(param1:String, param2:MobileGenericWindow)
      {
         super(param1);
         _mobileGenericWindow = param2;
      }
      
      override public function clone() : Event
      {
         return new MobileCloseGenericWindowEvent(type,_mobileGenericWindow);
      }
      
      public function get mobileGenericWindow() : MobileGenericWindow
      {
         return _mobileGenericWindow;
      }
   }
}

