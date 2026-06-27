package wom.controller.command.friend
{
   import flash.utils.getTimer;
   import wom.controller.PCommand;
   import wom.controller.event.friend.UpdateBlockedFriendsEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.friend.BlockedFriendInfo;
   import wom.view.util.FriendUtil;
   
   public class UpdateBlockedFriendsCommand extends PCommand
   {
      
      [Inject]
      public var event:UpdateBlockedFriendsEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function UpdateBlockedFriendsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:int = event.requestType;
         if(_loc1_ == 1 || _loc1_ == 11 || _loc1_ == 2 || _loc1_ == 3)
         {
            updateBlockedFriends(event.to,_loc1_);
         }
      }
      
      private function updateBlockedFriends(param1:Array, param2:int) : void
      {
         var _loc4_:Vector.<BlockedFriendInfo> = getBlockedFriends(param2);
         var _loc5_:int = getTimer();
         for each(var _loc3_ in param1)
         {
            _loc4_.push(new BlockedFriendInfo(FriendUtil.getProfile(_loc3_),_loc5_ + 86400000));
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

