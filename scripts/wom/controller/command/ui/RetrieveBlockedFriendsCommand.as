package wom.controller.command.ui
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.util.Base64;
   import wom.controller.PCommand;
   import wom.controller.event.ExternalInterfaceEvent;
   import wom.controller.event.WindowCreationEvent;
   import wom.controller.event.friend.GetSelectFriendsWindowEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.Profile;
   import wom.model.game.UserInfo;
   import wom.model.game.friend.BlockedFriendInfo;
   import wom.model.game.friend.request.RequestInfo;
   import wom.model.game.viral.WallPostParams;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   
   public class RetrieveBlockedFriendsCommand extends PCommand
   {
      
      [Inject]
      public var event:ExternalInterfaceEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function RetrieveBlockedFriendsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc7_:int = 0;
         var _loc9_:Boolean = false;
         var _loc3_:* = undefined;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:String = null;
         var _loc2_:Object = event.response;
         if("type" in _loc2_ && "subtype" in _loc2_ && "data" in _loc2_ && "subsubtype" in _loc2_ && _loc2_.type in RequestInfo.blockableRequestTypes())
         {
            _loc7_ = int(_loc2_.type);
            _loc9_ = true;
            if("extra" in _loc2_ && _loc2_.extra == 0)
            {
               _loc9_ = false;
            }
            _loc3_ = new Vector.<BlockedFriendInfo>();
            if(_loc7_ == 4)
            {
               for each(_loc1_ in _loc2_.data)
               {
                  try
                  {
                     _loc3_.push(new BlockedFriendInfo(new Profile(null,_loc1_.fbid,null),getTimer() + 86400000));
                  }
                  catch(e:Error)
                  {
                     log(LoggerContexts.INFRASTRUCTURE,"error getting BlockedFriend (Invite) for",_loc1_);
                  }
               }
            }
            else if(_loc7_ == 5)
            {
               if(!(_loc2_.data is Array))
               {
                  try
                  {
                     _loc3_.push(new BlockedFriendInfo(userInfo.profile,getTimer() + int(_loc2_.data)));
                  }
                  catch(e:Error)
                  {
                     log(LoggerContexts.INFRASTRUCTURE,"error getting BlockedFriend (Wallpost) for",_loc2_);
                  }
               }
            }
            else
            {
               for each(_loc1_ in _loc2_.data)
               {
                  try
                  {
                     _loc3_.push(new BlockedFriendInfo(new Profile(_loc1_.gameid,_loc1_.fbid,null),getTimer() + int(_loc1_.timer)));
                  }
                  catch(e:Error)
                  {
                     log(LoggerContexts.INFRASTRUCTURE,"error getting BlockedFriend for",_loc1_);
                  }
               }
            }
            if(_loc7_ == 5)
            {
               _loc8_ = int(_loc2_.subtype);
               if(!(_loc7_ in userInfo.blockedFriendsMap))
               {
                  userInfo.blockedFriendsMap[_loc7_] = new Dictionary();
               }
               userInfo.blockedFriendsMap[_loc7_][_loc8_] = _loc3_;
               if(userInfo.blockedFriendsMap[_loc7_][_loc8_].length > 0)
               {
                  _loc6_ = 0;
                  for each(_loc4_ in userInfo.blockedFriendsMap[_loc7_][_loc8_])
                  {
                     if(_loc4_.expirationTimer > _loc6_)
                     {
                        _loc6_ = _loc4_.expirationTimer;
                     }
                  }
                  dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(201,0)));
               }
               else if(_loc2_.subsubtype != -1)
               {
                  dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(12,_loc8_,_loc2_.subsubtype)));
               }
               else
               {
                  dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(16,_loc8_)));
               }
            }
            else
            {
               userInfo.blockedFriendsMap[_loc7_] = _loc3_;
               if(_loc7_ == 3)
               {
                  if("checkGiftQuota" in _loc2_ && _loc2_.checkGiftQuota)
                  {
                     return;
                  }
                  if(_loc2_.subsubtype != "-1")
                  {
                     _loc5_ = Base64.decode(_loc2_.subsubtype);
                     for each(_loc4_ in _loc3_)
                     {
                        if(_loc4_.profile.toString() == _loc5_)
                        {
                           dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(87)));
                           return;
                        }
                     }
                     dispatch(new WindowCreationEvent("createWindow",new WindowEnumeration(14,{"friendId":_loc2_.subtype})));
                     return;
                  }
               }
               dispatch(new GetSelectFriendsWindowEvent("getSelectFriendsWindowReady",_loc7_,_loc2_.subtype,_loc9_));
            }
         }
      }
   }
}

