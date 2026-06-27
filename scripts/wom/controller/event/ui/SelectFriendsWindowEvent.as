package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class SelectFriendsWindowEvent extends Event
   {
      
      public static const SHOW:String = "showSelectFriendsWindow";
      
      private var _requestType:int;
      
      private var _inventoryItemId:int;
      
      private var _vectorPosition:Object;
      
      private var _stackable:Object;
      
      public function SelectFriendsWindowEvent(param1:String, param2:int, param3:int, param4:Object = null, param5:Object = null)
      {
         super(param1);
         _requestType = param2;
         _inventoryItemId = param3;
         _vectorPosition = param4 != null ? param4 : -1;
         _stackable = param5;
      }
      
      override public function clone() : Event
      {
         return new SelectFriendsWindowEvent(type,_requestType,_inventoryItemId,_vectorPosition,_stackable);
      }
      
      public function get requestType() : int
      {
         return _requestType;
      }
      
      public function get inventoryItemId() : int
      {
         return _inventoryItemId;
      }
      
      public function get vectorPosition() : int
      {
         return int(_vectorPosition);
      }
      
      public function get stackable() : Object
      {
         return _stackable;
      }
   }
}

