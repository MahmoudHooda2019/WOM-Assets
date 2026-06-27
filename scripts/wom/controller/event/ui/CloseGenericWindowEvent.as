package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.view.util.GenericWindow;
   
   public class CloseGenericWindowEvent extends Event
   {
      
      public static const CLOSE:String = "closeGenericWindow";
      
      private var _genericWindow:GenericWindow;
      
      public function CloseGenericWindowEvent(param1:String, param2:GenericWindow)
      {
         super(param1);
         _genericWindow = param2;
      }
      
      override public function clone() : Event
      {
         return new CloseGenericWindowEvent(type,_genericWindow);
      }
      
      public function get genericWindow() : GenericWindow
      {
         return _genericWindow;
      }
   }
}

