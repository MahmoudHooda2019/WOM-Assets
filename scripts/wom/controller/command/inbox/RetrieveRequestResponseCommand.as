package wom.controller.command.inbox
{
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.serialization.json.PJSON;
   import peak.util.NumberUtil;
   import wom.controller.PCommand;
   import wom.controller.event.ExternalInterfaceEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.inbox.InboxEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.game.Profile;
   import wom.model.game.Thorzain;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceInvitationInfo;
   import wom.model.game.friend.FriendInfo;
   import wom.model.game.friend.InboxInfo;
   import wom.model.game.friend.request.AllianceInvitationRequestInfo;
   import wom.model.game.friend.request.GiftRequestInfo;
   import wom.model.game.friend.request.InviteFromInboxRequestInfo;
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
   import wom.view.screen.popups.InboxEmptyPopUp;
   import wom.view.screen.windows.inbox.InboxWindow;
   
   public class RetrieveRequestResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:ExternalInterfaceEvent;
      
      [Inject]
      public var inboxInfo:InboxInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function RetrieveRequestResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc27_:* = undefined;
         var _loc22_:* = undefined;
         var _loc25_:Boolean = false;
         var _loc1_:Boolean = false;
         var _loc23_:* = null;
         var _loc13_:PartTypeDIO = null;
         var _loc20_:int = 0;
         var _loc17_:Profile = null;
         var _loc19_:int = 0;
         var _loc8_:Object = null;
         var _loc14_:RequestInfo = null;
         var _loc7_:int = 0;
         var _loc10_:* = undefined;
         var _loc2_:* = undefined;
         var _loc16_:PartRequestInfo = null;
         var _loc11_:PartRequestInfo = null;
         var _loc15_:GiftRequestInfo = null;
         var _loc4_:GiftRequestInfo = null;
         var _loc26_:int = 0;
         var _loc9_:Number = NaN;
         var _loc5_:* = undefined;
         var _loc18_:int = 0;
         var _loc28_:* = undefined;
         var _loc24_:int = 0;
         var _loc6_:* = undefined;
         var _loc12_:* = undefined;
         log(LoggerContexts.INFRASTRUCTURE,"RetrieveRequestResponseCommand response",event.response);
         if(event.response != null)
         {
            _loc8_ = PJSON.decode(String(event.response));
            if("requests" in _loc8_ && "types" in _loc8_ && "type" in _loc8_)
            {
               if(_loc8_.type == 0)
               {
                  inboxInfo.clearRequests();
               }
               for(var _loc21_ in inboxInfo.requests)
               {
                  if(_loc21_ in _loc8_.types)
                  {
                     inboxInfo.counts[_loc21_] = _loc8_.types[_loc21_];
                  }
               }
               if(7 in _loc8_.types)
               {
                  var _loc30_:* = 3;
                  var _loc29_:* = inboxInfo.counts[_loc30_] + _loc8_.types[7];
                  inboxInfo.counts[_loc30_] = _loc29_;
               }
               if(14 in _loc8_.types)
               {
                  _loc29_ = 13;
                  _loc30_ = inboxInfo.counts[_loc29_] + _loc8_.types[14];
                  inboxInfo.counts[_loc29_] = _loc30_;
               }
               if(15 in _loc8_.types)
               {
                  _loc30_ = 13;
                  _loc29_ = inboxInfo.counts[_loc30_] + _loc8_.types[15];
                  inboxInfo.counts[_loc30_] = _loc29_;
               }
               for each(var _loc3_ in _loc8_.requests)
               {
                  if(_loc3_.state == "accepted" || _loc3_.state == "rejected")
                  {
                     continue;
                  }
                  switch((_loc19_ = int(_loc3_.type)) - 1)
                  {
                     case 0:
                        _loc17_ = determineFriendProfile(_loc3_);
                        _loc14_ = new StaffRequestInfo(Number(_loc3_.id),Number(_loc3_.reqid),_loc19_,_loc17_,_loc3_.state);
                        _loc10_ = new Vector.<RequestInfo>();
                        _loc10_.push(_loc14_);
                        inboxInfo.requests[1].push(_loc10_);
                        break;
                     case 1:
                        _loc17_ = determineFriendProfile(_loc3_);
                        _loc13_ = domainInfo.getPart(int(_loc3_.subtype));
                        if(_loc13_ != null)
                        {
                           _loc14_ = new PartRequestInfo(Number(_loc3_.id),Number(_loc3_.reqid),_loc19_,_loc17_,_loc3_.state,_loc13_);
                           _loc25_ = false;
                           _loc16_ = _loc14_ as PartRequestInfo;
                           for each(_loc27_ in inboxInfo.requests[2])
                           {
                              if(_loc27_.length < 24)
                              {
                                 _loc11_ = _loc27_[0] as PartRequestInfo;
                                 if(_loc16_.partDIO.id == _loc11_.partDIO.id && _loc16_.state == _loc11_.state)
                                 {
                                    _loc1_ = false;
                                    for each(_loc23_ in _loc27_)
                                    {
                                       if(_loc14_.friendProfile.toString() == _loc23_.friendProfile.toString())
                                       {
                                          _loc1_ = true;
                                          break;
                                       }
                                    }
                                    if(!_loc1_)
                                    {
                                       _loc27_.push(_loc14_);
                                       _loc25_ = true;
                                       break;
                                    }
                                 }
                              }
                           }
                           if(!_loc25_)
                           {
                              _loc27_ = new Vector.<RequestInfo>();
                              _loc27_.push(_loc14_);
                              inboxInfo.requests[2].push(_loc27_);
                           }
                        }
                        break;
                     case 2:
                     case 6:
                        _loc17_ = determineFriendProfile(_loc3_);
                        _loc7_ = int(String(_loc3_.subtype).substr(0,3));
                        if(InventoryItemCategory.resourceInventoryItems.indexOf(_loc7_) > -1)
                        {
                           _loc13_ = domainInfo.getPart(_loc7_);
                           _loc20_ = int(String(_loc3_.subtype).substr(3,5));
                        }
                        else
                        {
                           _loc13_ = domainInfo.getPart(int(_loc3_.subtype));
                           _loc20_ = 0;
                        }
                        if(_loc13_ != null)
                        {
                           _loc14_ = new GiftRequestInfo(Number(_loc3_.id),Number(_loc3_.reqid),3,_loc17_,_loc3_.state,_loc13_,_loc19_ == 7,_loc20_);
                           _loc25_ = false;
                           _loc15_ = _loc14_ as GiftRequestInfo;
                           for each(_loc22_ in inboxInfo.requests[3])
                           {
                              if(_loc22_.length < 24)
                              {
                                 _loc4_ = _loc22_[0] as GiftRequestInfo;
                                 if(_loc15_.partDIO.id == _loc4_.partDIO.id && _loc15_.thankYou == _loc4_.thankYou && _loc15_.resourceGiftBonusPercent == _loc4_.resourceGiftBonusPercent)
                                 {
                                    _loc1_ = false;
                                    for each(_loc23_ in _loc22_)
                                    {
                                       if(_loc14_.friendProfile.toString() == _loc23_.friendProfile.toString())
                                       {
                                          _loc1_ = true;
                                          break;
                                       }
                                    }
                                    if(!_loc1_)
                                    {
                                       _loc22_.push(_loc14_);
                                       _loc25_ = true;
                                       break;
                                    }
                                 }
                              }
                           }
                           if(!_loc25_)
                           {
                              _loc22_ = new Vector.<RequestInfo>();
                              _loc22_.push(_loc14_);
                              inboxInfo.requests[3].push(_loc22_);
                           }
                        }
                        break;
                     case 8:
                        _loc17_ = Thorzain.PROFILE;
                        _loc26_ = int(String(_loc3_.subtype).substr(0,1));
                        _loc9_ = Number(String(_loc3_.subtype).substr(1));
                        _loc14_ = new RewardRequestInfo(Number(_loc3_.id),NaN,_loc19_,_loc17_,_loc3_.state,_loc26_,_loc9_);
                        _loc5_ = new Vector.<RequestInfo>();
                        _loc5_.push(_loc14_);
                        inboxInfo.requests[9].push(_loc5_);
                        break;
                     case 10:
                        _loc17_ = determineFriendProfile(_loc3_);
                        _loc14_ = new WorkerStaffRequestInfo(Number(_loc3_.id),Number(_loc3_.reqid),_loc19_,_loc17_,_loc3_.state);
                        _loc2_ = new Vector.<RequestInfo>();
                        _loc2_.push(_loc14_);
                        inboxInfo.requests[11].push(_loc2_);
                        break;
                     case 12:
                        _loc18_ = int(_loc3_.subtype);
                        _loc14_ = new MysteryGoldRequestInfo(Number(_loc3_.id),_loc3_.state,_loc18_);
                        _loc28_ = new Vector.<RequestInfo>();
                        _loc28_.push(_loc14_);
                        inboxInfo.requests[13].push(_loc28_);
                        break;
                     case 13:
                        _loc24_ = int(_loc3_.subtype);
                        _loc14_ = new MysteryRpRequestInfo(Number(_loc3_.id),_loc3_.state,_loc24_);
                        _loc6_ = new Vector.<RequestInfo>();
                        _loc6_.push(_loc14_);
                        inboxInfo.requests[13].push(_loc6_);
                        break;
                     case 14:
                        _loc7_ = int(String(_loc3_.subtype).substr(0,3));
                        if(InventoryItemCategory.resourceInventoryItems.indexOf(_loc7_) > -1)
                        {
                           _loc13_ = domainInfo.getPart(_loc7_);
                           _loc20_ = int(String(_loc3_.subtype).substr(3,5));
                           _loc14_ = new MysteryResourceRequestInfo(Number(_loc3_.id),_loc3_.state,_loc13_,ResourceQuantityType.determineResourceQuantityType(_loc20_));
                           _loc12_ = new Vector.<RequestInfo>();
                           _loc12_.push(_loc14_);
                           inboxInfo.requests[13].push(_loc12_);
                        }
                  }
               }
            }
         }
         populateAllianceInvitationRequests();
         log(LoggerContexts.INFRASTRUCTURE,"RetrieveRequestResponseCommand inboxOpened: " + inboxInfo.inboxOpened);
         if(inboxInfo.inboxOpened)
         {
            dispatch(new InboxEvent("requestsUpdated"));
         }
         else
         {
            inboxInfo.inboxOpened = true;
            if(inboxInfo.totalCount > 0)
            {
               dispatch(new PopUpWindowEvent("showPopUpWindow",new InboxWindow(),0,null,null,false));
            }
            else
            {
               dispatch(new PopUpWindowEvent("showPopUpWindow",new InboxEmptyPopUp(),0,null,null,false));
            }
         }
      }
      
      private function determineFriendProfile(param1:Object) : Profile
      {
         return param1.fg != userInfo.profile.gameId ? new Profile(param1.fg,param1.ff,null) : new Profile(param1.tg,param1.tf,null);
      }
      
      private function populateAllianceInvitationRequests() : void
      {
         var _loc2_:* = undefined;
         if(allianceInfo.invitations.length > 0)
         {
            inboxInfo.requests[10].length = 0;
            inboxInfo.counts[10] = allianceInfo.invitations.length;
            for each(var _loc1_ in allianceInfo.invitations)
            {
               _loc2_ = new Vector.<RequestInfo>();
               _loc2_.push(new AllianceInvitationRequestInfo(_loc1_));
               inboxInfo.requests[10].push(_loc2_);
            }
         }
      }
      
      private function populateInviteFromInboxRequests() : void
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:int = NumberUtil.randomIntRange(1,100);
         if(_loc4_ > 5)
         {
            return;
         }
         var _loc2_:Vector.<Profile> = null;
         var _loc8_:Vector.<Profile> = new Vector.<Profile>();
         for each(var _loc6_ in documentConfiguration.friends)
         {
            if(!(_loc6_.profile.gameId in documentConfiguration.womFriends))
            {
               _loc8_.push(_loc6_.profile);
            }
         }
         var _loc1_:int = int(_loc8_.length);
         if(_loc1_ > 0)
         {
            if(_loc1_ <= 50)
            {
               _loc2_ = _loc8_;
            }
            else
            {
               _loc2_ = new Vector.<Profile>();
               while(_loc7_ < 50)
               {
                  _loc5_ = NumberUtil.randomIntRange(0,_loc8_.length - 1);
                  _loc2_.push(_loc8_[_loc5_]);
                  _loc8_.splice(_loc5_,1);
                  _loc7_++;
               }
            }
            inboxInfo.requests[12].length = 0;
            inboxInfo.counts[12] = 1;
            _loc3_ = new Vector.<RequestInfo>();
            _loc3_.push(new InviteFromInboxRequestInfo(_loc2_));
            inboxInfo.requests[12].push(_loc3_);
            inboxInfo.addFromClient["invite"] = 1;
            dispatch(new ModelUpdateEvent("inboxCountUpdated"));
         }
      }
   }
}

