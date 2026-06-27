package wom.controller.command.ui
{
   import wom.controller.PCommand;
   import wom.controller.event.friend.GetSelectFriendsWindowEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.ui.SelectFriendsWindowEvent;
   import wom.model.game.UserInfo;
   
   public class GetSelectFriendsWindowCommand extends PCommand
   {
      
      [Inject]
      public var event:GetSelectFriendsWindowEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function GetSelectFriendsWindowCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(event.type == "getSelectFriendsWindow")
         {
            if(!(event.requestType in userInfo.blockedFriendsMap) || event.requestType != 3 && !(event.subType in userInfo.blockedFriendsMap[event.requestType]))
            {
               _loc2_ = -1;
               _loc1_ = event.stackable == null || event.stackable ? 1 : 0;
               dispatch(new MobileExternalInterfaceEvent("getBlockedFriends",{
                  "type":event.requestType,
                  "subtype":event.subType,
                  "subsubtype":_loc2_,
                  "extra":_loc1_
               }));
               return;
            }
            dispatch(new GetSelectFriendsWindowEvent("getSelectFriendsWindowReady",event.requestType,event.subType,event.stackable));
         }
         else
         {
            dispatch(new SelectFriendsWindowEvent("showSelectFriendsWindow",event.requestType,event.subType,0,event.stackable));
         }
      }
   }
}

