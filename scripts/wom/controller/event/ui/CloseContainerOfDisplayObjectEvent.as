package wom.controller.event.ui
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import wom.model.game.window.WindowEnumeration;
   
   public class CloseContainerOfDisplayObjectEvent extends Event
   {
      
      public static const CLOSE:String = "close";
      
      public static const ADD_WINDOW_ENUMERATION:String = "addWindowEnumeration";
      
      private var _displayObject:DisplayObject;
      
      private var _checkCloseable:Boolean;
      
      private var _windowEnumeration:WindowEnumeration;
      
      public function CloseContainerOfDisplayObjectEvent(param1:String, param2:DisplayObject, param3:Boolean = false, param4:WindowEnumeration = null)
      {
         super(param1);
         _displayObject = param2;
         _checkCloseable = param3;
         _windowEnumeration = param4;
      }
      
      override public function clone() : Event
      {
         return new CloseContainerOfDisplayObjectEvent(type,_displayObject,_checkCloseable,_windowEnumeration);
      }
      
      public function get displayObject() : DisplayObject
      {
         return _displayObject;
      }
      
      public function get checkCloseable() : Boolean
      {
         return _checkCloseable;
      }
      
      public function get windowEnumeration() : WindowEnumeration
      {
         return _windowEnumeration;
      }
   }
}

