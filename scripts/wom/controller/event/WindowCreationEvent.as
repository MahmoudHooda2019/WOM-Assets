package wom.controller.event
{
   import flash.events.Event;
   import wom.model.game.window.WindowEnumeration;
   
   public class WindowCreationEvent extends Event
   {
      
      public static const CREATE_WINDOW:String = "createWindow";
      
      private var _windowEnumeration:WindowEnumeration;
      
      public function WindowCreationEvent(param1:String, param2:WindowEnumeration)
      {
         super(param1);
         _windowEnumeration = param2;
      }
      
      override public function clone() : Event
      {
         return new WindowCreationEvent(type,_windowEnumeration);
      }
      
      public function get windowEnumeration() : WindowEnumeration
      {
         return _windowEnumeration;
      }
   }
}

