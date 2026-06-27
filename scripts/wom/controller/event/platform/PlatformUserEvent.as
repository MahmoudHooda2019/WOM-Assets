package wom.controller.event.platform
{
   import flash.events.Event;
   import wom.model.game.friend.ProfileIdPair;
   
   public class PlatformUserEvent extends Event
   {
      
      public static const GET_USER_INFO:String = "getPlatformUserInfo";
      
      private var _profileIdPairs:Vector.<ProfileIdPair>;
      
      public function PlatformUserEvent(param1:String, param2:Vector.<ProfileIdPair>)
      {
         super(param1);
         _profileIdPairs = param2;
      }
      
      override public function clone() : Event
      {
         return new PlatformUserEvent(type,_profileIdPairs);
      }
      
      public function get profileIdPairs() : Vector.<ProfileIdPair>
      {
         return _profileIdPairs;
      }
   }
}

