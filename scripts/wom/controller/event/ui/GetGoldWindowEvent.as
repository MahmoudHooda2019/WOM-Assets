package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.window.WindowEnumeration;
   
   public class GetGoldWindowEvent extends Event
   {
      
      public static const SHOW:String = "showGetGoldWindow";
      
      private var _windowEnumerations:Vector.<WindowEnumeration>;
      
      private var _monetizationType:MonetizationType;
      
      private var _vectorPosition:Object;
      
      private var _stackable:Object;
      
      public function GetGoldWindowEvent(param1:String, param2:MonetizationType, param3:Vector.<WindowEnumeration> = null, param4:Object = null, param5:Object = null)
      {
         super(param1);
         _monetizationType = param2;
         _windowEnumerations = param3;
         _vectorPosition = param4 != null ? param4 : -1;
         _stackable = param5;
      }
      
      override public function clone() : Event
      {
         return new GetGoldWindowEvent(type,_monetizationType,_windowEnumerations,_vectorPosition,_stackable);
      }
      
      public function get windowEnumerations() : Vector.<WindowEnumeration>
      {
         return _windowEnumerations;
      }
      
      public function get vectorPosition() : int
      {
         return int(_vectorPosition);
      }
      
      public function get monetizationType() : MonetizationType
      {
         return _monetizationType;
      }
      
      public function get stackable() : Object
      {
         return _stackable;
      }
   }
}

