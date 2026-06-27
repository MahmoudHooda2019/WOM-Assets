package wom.controller.command.mobile
{
   import org.robotlegs.mvcs.StarlingCommand;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import wom.controller.event.inbox.InboxEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.game.Profile;
   import wom.model.game.Thorzain;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceInvitationInfo;
   import wom.model.game.friend.InboxInfo;
   import wom.model.game.friend.request.AllianceInvitationRequestInfo;
   import wom.model.game.friend.request.GiftRequestInfo;
   import wom.model.game.friend.request.MysteryGoldRequestInfo;
   import wom.model.game.friend.request.MysteryResourceRequestInfo;
   import wom.model.game.friend.request.MysteryRpRequestInfo;
   import wom.model.game.friend.request.PartRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   import wom.model.game.friend.request.RewardRequestInfo;
   import wom.model.game.friend.request.StaffRequestInfo;
   import wom.model.game.friend.request.WorkerStaffRequestInfo;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.ResourceQuantityType;
   import wom.view.screen.windows.inbox.mobile.MobileInboxWindow;
   
   public class MobileRetrieveRequestResponseCommand extends StarlingCommand
   {
      
      [Inject]
      public var event:MobileExternalInterfaceEvent;
      
      [Inject]
      public var inboxInfo:InboxInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function MobileRetrieveRequestResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc28_:* = undefined;
         var _loc23_:* = undefined;
         var _loc26_:Boolean = false;
         var _loc1_:Boolean = false;
         var _loc24_:* = null;
         var _loc13_:PartTypeDIO = null;
         var _loc21_:int = 0;
         var _loc18_:Profile = null;
         var _loc20_:int = 0;
         var _loc8_:Object = null;
         var _loc14_:RequestInfo = null;
         var _loc7_:int = 0;
         var _loc10_:* = undefined;
         var _loc2_:* = undefined;
         var _loc17_:PartRequestInfo = null;
         var _loc11_:PartRequestInfo = null;
         var _loc15_:GiftRequestInfo = null;
         var _loc4_:GiftRequestInfo = null;
         var _loc27_:int = 0;
         var _loc9_:Number = NaN;
         var _loc5_:* = undefined;
         var _loc19_:int = 0;
         var _loc29_:* = undefined;
         var _loc25_:int = 0;
         var _loc6_:* = undefined;
         var _loc12_:* = undefined;
         var _loc30_:* = undefined;
         log(LoggerContexts.INFRASTRUCTURE,"RetrieveRequestResponseCommand response",event.data);
         if(event.data != null)
         {
            _loc8_ = event.data;
            if("requests" in _loc8_ && "types" in _loc8_ && "type" in _loc8_)
            {
               if(_loc8_.type == 0)
               {
                  inboxInfo.clearRequests();
               }
               for(var _loc22_ in inboxInfo.requests)
               {
                  if(_loc22_ in _loc8_.types)
                  {
                     inboxInfo.counts[_loc22_] = _loc8_.types[_loc22_];
                  }
               }
               if(7 in _loc8_.types)
               {
                  var _loc32_:* = 3;
                  var _loc31_:* = inboxInfo.counts[_loc32_] + _loc8_.types[7];
                  inboxInfo.counts[_loc32_] = _loc31_;
               }
               if(14 in _loc8_.types)
               {
                  _loc31_ = 13;
                  _loc32_ = inboxInfo.counts[_loc31_] + _loc8_.types[14];
                  inboxInfo.counts[_loc31_] = _loc32_;
               }
               if(15 in _loc8_.types)
               {
                  _loc32_ = 13;
                  _loc31_ = inboxInfo.counts[_loc32_] + _loc8_.types[15];
                  inboxInfo.counts[_loc32_] = _loc31_;
               }
               for each(var _loc3_ in _loc8_.requests)
               {
                  if(_loc3_.state == "accepted" || _loc3_.state == "rejected")
                  {
                     continue;
                  }
                  switch((_loc20_ = int(_loc3_.type)) - 1)
                  {
                     case 0:
                        _loc18_ = determineFriendProfile(_loc3_);
                        _loc14_ = new StaffRequestInfo(Number(_loc3_.id),Number(_loc3_.reqid),_loc20_,_loc18_,_loc3_.state);
                        _loc10_ = new Vector.<RequestInfo>();
                        _loc10_.push(_loc14_);
                        inboxInfo.requests[1].push(_loc10_);
                        break;
                     case 1:
                        _loc18_ = determineFriendProfile(_loc3_);
                        _loc13_ = domainInfo.getPart(int(_loc3_.subtype));
                        if(_loc13_ != null)
                        {
                           _loc14_ = new PartRequestInfo(Number(_loc3_.id),Number(_loc3_.reqid),_loc20_,_loc18_,_loc3_.state,_loc13_);
                           _loc26_ = false;
                           _loc17_ = _loc14_ as PartRequestInfo;
                           for each(_loc28_ in inboxInfo.requests[2])
                           {
                              if(_loc28_.length < 24)
                              {
                                 _loc11_ = _loc28_[0] as PartRequestInfo;
                                 if(_loc17_.partDIO.id == _loc11_.partDIO.id && _loc17_.state == _loc11_.state)
                                 {
                                    _loc1_ = false;
                                    for each(_loc24_ in _loc28_)
                                    {
                                       if(_loc14_.friendProfile.toString() == _loc24_.friendProfile.toString())
                                       {
                                          _loc1_ = true;
                                          break;
                                       }
                                    }
                                    if(!_loc1_)
                                    {
                                       _loc28_.push(_loc14_);
                                       _loc26_ = true;
                                       break;
                                    }
                                 }
                              }
                           }
                           if(!_loc26_)
                           {
                              _loc28_ = new Vector.<RequestInfo>();
                              _loc28_.push(_loc14_);
                              inboxInfo.requests[2].push(_loc28_);
                           }
                        }
                        break;
                     case 2:
                     case 6:
                        _loc18_ = determineFriendProfile(_loc3_);
                        _loc7_ = int(String(_loc3_.subtype).substr(0,3));
                        if(InventoryItemCategory.resourceInventoryItems.indexOf(_loc7_) > -1)
                        {
                           _loc13_ = domainInfo.getPart(_loc7_);
                           _loc21_ = int(String(_loc3_.subtype).substr(3,5));
                        }
                        else
                        {
                           _loc13_ = domainInfo.getPart(int(_loc3_.subtype));
                           _loc21_ = 0;
                        }
                        if(_loc13_ != null)
                        {
                           _loc14_ = new GiftRequestInfo(Number(_loc3_.id),Number(_loc3_.reqid),3,_loc18_,_loc3_.state,_loc13_,_loc20_ == 7,_loc21_);
                           _loc26_ = false;
                           _loc15_ = _loc14_ as GiftRequestInfo;
                           for each(_loc23_ in inboxInfo.requests[3])
                           {
                              if(_loc23_.length < 24)
                              {
                                 _loc4_ = _loc23_[0] as GiftRequestInfo;
                                 if(_loc15_.partDIO.id == _loc4_.partDIO.id && _loc15_.thankYou == _loc4_.thankYou && _loc15_.resourceGiftBonusPercent == _loc4_.resourceGiftBonusPercent)
                                 {
                                    _loc1_ = false;
                                    for each(_loc24_ in _loc23_)
                                    {
                                       if(_loc14_.friendProfile.toString() == _loc24_.friendProfile.toString())
                                       {
                                          _loc1_ = true;
                                          break;
                                       }
                                    }
                                    if(!_loc1_)
                                    {
                                       _loc23_.push(_loc14_);
                                       _loc26_ = true;
                                       break;
                                    }
                                 }
                              }
                           }
                           if(!_loc26_)
                           {
                              _loc23_ = new Vector.<RequestInfo>();
                              _loc23_.push(_loc14_);
                              inboxInfo.requests[3].push(_loc23_);
                           }
                        }
                        break;
                     case 8:
                        _loc18_ = Thorzain.PROFILE;
                        _loc27_ = int(String(_loc3_.subtype).substr(0,1));
                        _loc9_ = Number(String(_loc3_.subtype).substr(1));
                        _loc14_ = new RewardRequestInfo(Number(_loc3_.id),NaN,_loc20_,_loc18_,_loc3_.state,_loc27_,_loc9_);
                        _loc5_ = new Vector.<RequestInfo>();
                        _loc5_.push(_loc14_);
                        inboxInfo.requests[9].push(_loc5_);
                        break;
                     case 10:
                        _loc18_ = determineFriendProfile(_loc3_);
                        _loc14_ = new WorkerStaffRequestInfo(Number(_loc3_.id),Number(_loc3_.reqid),_loc20_,_loc18_,_loc3_.state);
                        _loc2_ = new Vector.<RequestInfo>();
                        _loc2_.push(_loc14_);
                        inboxInfo.requests[11].push(_loc2_);
                        break;
                     case 12:
                        _loc19_ = int(_loc3_.subtype);
                        _loc14_ = new MysteryGoldRequestInfo(Number(_loc3_.id),_loc3_.state,_loc19_);
                        _loc29_ = new Vector.<RequestInfo>();
                        _loc29_.push(_loc14_);
                        inboxInfo.requests[13].push(_loc29_);
                        break;
                     case 13:
                        _loc25_ = int(_loc3_.subtype);
                        _loc14_ = new MysteryRpRequestInfo(Number(_loc3_.id),_loc3_.state,_loc25_);
                        _loc6_ = new Vector.<RequestInfo>();
                        _loc6_.push(_loc14_);
                        inboxInfo.requests[13].push(_loc6_);
                        break;
                     case 14:
                        _loc7_ = int(String(_loc3_.subtype).substr(0,3));
                        if(InventoryItemCategory.resourceInventoryItems.indexOf(_loc7_) > -1)
                        {
                           _loc13_ = domainInfo.getPart(_loc7_);
                           _loc21_ = int(String(_loc3_.subtype).substr(3,5));
                           _loc14_ = new MysteryResourceRequestInfo(Number(_loc3_.id),_loc3_.state,_loc13_,ResourceQuantityType.determineResourceQuantityType(_loc21_));
                           _loc12_ = new Vector.<RequestInfo>();
                           _loc12_.push(_loc14_);
                           inboxInfo.requests[13].push(_loc12_);
                        }
                  }
               }
            }
         }
         if(allianceInfo.invitations.length > 0)
         {
            inboxInfo.requests[10].length = 0;
            inboxInfo.counts[10] = allianceInfo.invitations.length;
            for each(var _loc16_ in allianceInfo.invitations)
            {
               _loc30_ = new Vector.<RequestInfo>();
               _loc30_.push(new AllianceInvitationRequestInfo(_loc16_));
               inboxInfo.requests[10].push(_loc30_);
            }
         }
         log(LoggerContexts.INFRASTRUCTURE,"RetrieveRequestResponseCommand inboxOpened: " + inboxInfo.inboxOpened);
         if(inboxInfo.inboxOpened)
         {
            dispatch(new InboxEvent("requestsUpdated"));
         }
         else
         {
            inboxInfo.inboxOpened = true;
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileInboxWindow(userInfo.profile.gameId),0,null,null,false));
         }
      }
      
      private function determineFriendProfile(param1:Object) : Profile
      {
         return param1.fg != userInfo.profile.gameId ? new Profile(param1.fg,param1.ff,param1.fs) : new Profile(param1.tg,param1.tf,param1.ts);
      }
   }
}

