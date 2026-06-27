package wom.controller.event.friend
{
   import flash.events.Event;
   
   public class UpdateBlockedFriendsEvent extends Event
   {
      
      public static const UPDATE:String = "updateBlockedFriends";
      
      private var _requestType:int;
      
      private var _to:Array;
      
      public function UpdateBlockedFriendsEvent(param1:String, param2:int, param3:Array)
      {
         super(param1);
         _requestType = param2;
         _to = param3;
      }
      
      override public function clone() : Event
      {
         return new UpdateBlockedFriendsEvent(type,_requestType,_to);
      }
      
      public function get requestType() : int
      {
         return _requestType;
      }
      
      public function get to() : Array
      {
         return _to;
      }
   }
}

