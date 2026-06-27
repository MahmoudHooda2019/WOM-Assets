package wom.controller.event.ui
{
   import flash.events.Event;
   import starling.display.DisplayObject;
   import wom.model.game.window.WindowEnumeration;
   
   public class MobileCloseContainerOfDisplayObjectEvent extends Event
   {
      
      public static const CLOSE:String = "close";
      
      public static const ADD_WINDOW_ENUMERATION:String = "addWindowEnumeration";
      
      private var _displayObject:DisplayObject;
      
      private var _checkCloseable:Boolean;
      
      private var _windowEnumerations:Vector.<WindowEnumeration>;
      
      public function MobileCloseContainerOfDisplayObjectEvent(param1:String, param2:DisplayObject, param3:Boolean = false, param4:Vector.<WindowEnumeration> = null)
      {
         super(param1);
         _displayObject = param2;
         _checkCloseable = param3;
         _windowEnumerations = param4;
      }
      
      override public function clone() : Event
      {
         return new MobileCloseContainerOfDisplayObjectEvent(type,_displayObject,_checkCloseable,_windowEnumerations);
      }
      
      public function get displayObject() : DisplayObject
      {
         return _displayObject;
      }
      
      public function get checkCloseable() : Boolean
      {
         return _checkCloseable;
      }
      
      public function get windowEnumerations() : Vector.<WindowEnumeration>
      {
         return _windowEnumerations;
      }
   }
}

