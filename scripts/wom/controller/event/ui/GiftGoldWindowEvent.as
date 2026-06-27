package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.window.WindowEnumeration;
   
   public class GiftGoldWindowEvent extends Event
   {
      
      public static const SHOW:String = "showGiftGoldWindow";
      
      private var _paymentMethod:Object;
      
      private var _vectorPosition:Object;
      
      private var _windowEnumerations:Vector.<WindowEnumeration>;
      
      public function GiftGoldWindowEvent(param1:String, param2:Object, param3:Object = null, param4:Vector.<WindowEnumeration> = null)
      {
         super(param1);
         _paymentMethod = param2 != null ? param2 : 0;
         _vectorPosition = param3 != null ? param3 : -1;
         _windowEnumerations = param4;
      }
      
      override public function clone() : Event
      {
         return new GiftGoldWindowEvent(type,_paymentMethod,_vectorPosition,_windowEnumerations);
      }
      
      public function get paymentMethod() : uint
      {
         return uint(_paymentMethod);
      }
      
      public function get vectorPosition() : int
      {
         return int(_vectorPosition);
      }
      
      public function get windowEnumerations() : Vector.<WindowEnumeration>
      {
         return _windowEnumerations;
      }
   }
}

