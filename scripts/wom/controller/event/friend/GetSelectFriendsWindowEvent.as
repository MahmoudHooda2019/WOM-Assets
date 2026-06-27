package wom.controller.event.friend
{
   import flash.events.Event;
   
   public class GetSelectFriendsWindowEvent extends Event
   {
      
      public static const GET:String = "getSelectFriendsWindow";
      
      public static const READY:String = "getSelectFriendsWindowReady";
      
      private var _requestType:int;
      
      private var _subType:int;
      
      private var _stackable:Object;
      
      public function GetSelectFriendsWindowEvent(param1:String, param2:int, param3:int, param4:Object = null)
      {
         super(param1);
         _requestType = param2;
         _subType = param3;
         _stackable = param4;
      }
      
      override public function clone() : Event
      {
         return new GetSelectFriendsWindowEvent(type,_requestType,_subType,_stackable);
      }
      
      public function get requestType() : int
      {
         return _requestType;
      }
      
      public function get subType() : int
      {
         return _subType;
      }
      
      public function get stackable() : Object
      {
         return _stackable;
      }
   }
}

