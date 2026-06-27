package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class GiftWindowEvent extends Event
   {
      
      public static const SHOW_GIFT_WINDOW:String = "showGiftWindow";
      
      private var _friendId:String;
      
      private var _stackable:Object;
      
      public function GiftWindowEvent(param1:String, param2:String = null, param3:Object = null)
      {
         super(param1);
         _friendId = param2;
         _stackable = param3;
      }
      
      override public function clone() : Event
      {
         return new GiftWindowEvent(type,_friendId,_stackable);
      }
      
      public function get friendId() : String
      {
         return _friendId;
      }
      
      public function get stackable() : Object
      {
         return _stackable;
      }
   }
}

