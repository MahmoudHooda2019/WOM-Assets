package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.window.WindowEnumeration;
   
   public class AttackLogWindowEvent extends Event
   {
      
      public static const SHOW:String = "showAttackLogWindow";
      
      private var _initialTabIndex:Object;
      
      private var _vectorPosition:Object;
      
      private var _windowEnumerations:Vector.<WindowEnumeration>;
      
      private var _stackable:Object;
      
      public function AttackLogWindowEvent(param1:String, param2:Object = null, param3:Object = null, param4:Vector.<WindowEnumeration> = null, param5:Object = null)
      {
         super(param1);
         _initialTabIndex = param2 != null ? param2 : 2;
         _vectorPosition = param3 != null ? param3 : -1;
         _windowEnumerations = param4;
         _stackable = param5;
      }
      
      override public function clone() : Event
      {
         return new AttackLogWindowEvent(type,_initialTabIndex,_vectorPosition,_windowEnumerations,_stackable);
      }
      
      public function get initialTabIndex() : int
      {
         return int(_initialTabIndex);
      }
      
      public function get vectorPosition() : int
      {
         return int(_vectorPosition);
      }
      
      public function get windowEnumerations() : Vector.<WindowEnumeration>
      {
         return _windowEnumerations;
      }
      
      public function get stackable() : Object
      {
         return _stackable;
      }
   }
}

