package wom.controller.command.user
{
   import flash.utils.getTimer;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.serialization.json.PJSON;
   import wom.controller.PCommand;
   import wom.controller.event.ExternalInterfaceEvent;
   import wom.model.game.Profile;
   import wom.model.game.UserInfo;
   import wom.model.game.friend.BlockedFriendInfo;
   
   public class RetrieveInviteFriendsResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:ExternalInterfaceEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function RetrieveInviteFriendsResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:Object = null;
         try
         {
            _loc1_ = PJSON.decode(String(event.response));
         }
         catch(e:Error)
         {
            log(LoggerContexts.UNEXPECTED,"Unexpected response from sendRequestResponse",event.response);
         }
         if("to" in _loc1_ && _loc1_.to.length > 0)
         {
            updateBlockedFriends(_loc1_.to,4);
         }
      }
      
      private function updateBlockedFriends(param1:Array, param2:int) : void
      {
         var _loc4_:Vector.<BlockedFriendInfo> = getBlockedFriends(param2);
         var _loc5_:int = getTimer();
         for each(var _loc3_ in param1)
         {
            _loc4_.push(new BlockedFriendInfo(new Profile(null,_loc3_.fbid,null),_loc5_ + 86400000));
         }
         userInfo.blockedFriendsMap[param2] = _loc4_;
      }
      
      private function getBlockedFriends(param1:int) : Vector.<BlockedFriendInfo>
      {
         var _loc2_:Vector.<BlockedFriendInfo> = userInfo.blockedFriendsMap[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new Vector.<BlockedFriendInfo>();
         }
         return _loc2_;
      }
   }
}

