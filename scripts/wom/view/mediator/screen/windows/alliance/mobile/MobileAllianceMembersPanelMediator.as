package wom.view.mediator.screen.windows.alliance.mobile
{
   import feathers.data.ListCollection;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.component.mobile.MPButton;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.AllianceVisitEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceMemberInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.game.window.WindowEnumerationButton;
   import wom.model.message.request.alliance.CancelAllianceInvitationRequest;
   import wom.model.message.request.alliance.GetUnitsOfAllianceMemberRequest;
   import wom.model.message.request.alliance.InviteToAllianceRequest;
   import wom.model.message.request.alliance.RemoveRejectedAllianceInvitationRequest;
   import wom.model.message.request.alliance.ReplyToAllianceJoinRequestRequest;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceBarracksTransferWindow;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceMemberViewRenderer;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceMembersPanel;
   import wom.view.ui.common.MobileListHeaderView;
   
   public class MobileAllianceMembersPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileAllianceMembersPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileAllianceMembersPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         view.updateWithOwnGameId(userInfo.profile.gameId);
         mapListeners();
         view.membersList.validate();
      }
      
      protected function mapListeners() : void
      {
         eventMap.mapStarlingListener(view.headerLevel,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.headerName,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.headerBattlePoints,"touch",onHeaderClicked,TouchEvent);
         addContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         mapAllianceMemberListeners();
         eventMap.mapStarlingListener(view.membersList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.membersList,"rendererRemove",onRendererRemoved,Event);
      }
      
      protected function mapAllianceMemberListeners() : void
      {
         addContextListener("allianceMembersRankingInfoUpdated",onAllianceMembersRankingInfoUpdated,ModelUpdateEvent);
      }
      
      private function onAllianceMembersRankingInfoUpdated(param1:ModelUpdateEvent) : void
      {
         if(view.fromBrowseTab && allianceInfo.membersRankingInfo && view.allianceToBeViewed.id == allianceInfo.membersRankingInfo.allianceId)
         {
            view.updateWithMembers(allianceInfo.membersRankingInfo.members);
         }
      }
      
      private function onRendererAdded(param1:Event, param2:MobileAllianceMemberViewRenderer) : void
      {
         var _loc4_:int = 0;
         if(param2.rowType == 3 || param2.rowType == 8)
         {
            param2.allianceBarracksCapacity = param2.member.allianceBarracksLevel == 0 ? 0 : domainInfo.getBuilding(43).buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][param2.member.allianceBarracksLevel - 1];
         }
         param2.member.name = facebookAPIManager.getUserNameByProfile(param2.member.profile);
         param2.updateName();
         param2.updateButtonEnabling(userInfo.profile);
         if(param2.buttonView)
         {
            eventMap.mapStarlingListener(param2.buttonView,"triggered",onViewButtonClicked,Event);
         }
         if(param2.buttonAccept)
         {
            eventMap.mapStarlingListener(param2.buttonAccept,"triggered",onAcceptButtonClicked,Event);
         }
         if(param2.buttonReject)
         {
            eventMap.mapStarlingListener(param2.buttonReject,"triggered",onRejectButtonClicked,Event);
         }
         if(param2.buttonKickOut)
         {
            eventMap.mapStarlingListener(param2.buttonKickOut,"triggered",onKickOutButtonClicked,Event);
         }
         if(param2.buttonInvite)
         {
            eventMap.mapStarlingListener(param2.buttonInvite,"triggered",onInviteButtonClicked,Event);
         }
         if(param2.buttonCancelInvitation)
         {
            eventMap.mapStarlingListener(param2.buttonCancelInvitation,"triggered",onCancelInvitationButtonClicked,Event);
         }
         if(param2.buttonInvitationRejected)
         {
            eventMap.mapStarlingListener(param2.buttonInvitationRejected,"triggered",onInvitationRejectedButtonClicked,Event);
         }
         if(param2.buttonInvitationAccepted)
         {
            eventMap.mapStarlingListener(param2.buttonInvitationAccepted,"triggered",onInvitationAcceptedButtonClicked,Event);
         }
         if(param2.buttonReinforce)
         {
            _loc4_ = 0;
            for each(var _loc3_ in city.buildings)
            {
               if(_loc3_.buildingTypeId == 42)
               {
                  _loc4_ = _loc3_.level;
                  break;
               }
            }
            if(_loc4_ < 3)
            {
               param2.buttonReinforce.isEnabled = false;
            }
            else
            {
               eventMap.mapStarlingListener(param2.buttonReinforce,"triggered",onReinforceClicked,Event);
            }
         }
      }
      
      private function onRendererRemoved(param1:Event, param2:MobileAllianceMemberViewRenderer) : void
      {
         var _loc4_:int = 0;
         if(param2.buttonView)
         {
            eventMap.unmapStarlingListener(param2.buttonView,"triggered",onViewButtonClicked,Event);
         }
         if(param2.buttonAccept)
         {
            eventMap.unmapStarlingListener(param2.buttonAccept,"triggered",onAcceptButtonClicked,Event);
         }
         if(param2.buttonReject)
         {
            eventMap.unmapStarlingListener(param2.buttonReject,"triggered",onRejectButtonClicked,Event);
         }
         if(param2.buttonKickOut)
         {
            eventMap.unmapStarlingListener(param2.buttonKickOut,"triggered",onKickOutButtonClicked,Event);
         }
         if(param2.buttonInvite)
         {
            eventMap.unmapStarlingListener(param2.buttonInvite,"triggered",onInviteButtonClicked,Event);
         }
         if(param2.buttonCancelInvitation)
         {
            eventMap.unmapStarlingListener(param2.buttonCancelInvitation,"triggered",onCancelInvitationButtonClicked,Event);
         }
         if(param2.buttonInvitationRejected)
         {
            eventMap.unmapStarlingListener(param2.buttonInvitationRejected,"triggered",onInvitationRejectedButtonClicked,Event);
         }
         if(param2.buttonInvitationAccepted)
         {
            eventMap.unmapStarlingListener(param2.buttonInvitationAccepted,"triggered",onInvitationAcceptedButtonClicked,Event);
         }
         if(param2.buttonReinforce)
         {
            _loc4_ = 0;
            for each(var _loc3_ in city.buildings)
            {
               if(_loc3_.buildingTypeId == 42)
               {
                  _loc4_ = _loc3_.level;
                  break;
               }
            }
            if(_loc4_ < 3)
            {
               param2.buttonReinforce.isEnabled = false;
            }
            else
            {
               eventMap.unmapStarlingListener(param2.buttonReinforce,"triggered",onReinforceClicked,Event);
            }
         }
      }
      
      private function onReinforceClicked(param1:Event) : void
      {
         var _loc2_:MobileAllianceMemberViewRenderer = checkRendererValidityForClickedButton(param1);
         if(!_loc2_)
         {
            return;
         }
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileAllianceBarracksTransferWindow(_loc2_.member.profile.gameId,new <WindowEnumeration>[new WindowEnumeration(207,{
            "defaultPanel":2,
            "defaultTab":1
         })])));
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetUnitsOfAllianceMemberRequest(_loc2_.member.profile.gameId)));
         dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view));
      }
      
      private function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         updateName();
      }
      
      private function updateName() : void
      {
         var _loc2_:ListCollection = null;
         if(view.membersList && view.membersList.dataProvider)
         {
            _loc2_ = view.membersList.dataProvider;
            for each(var _loc1_ in _loc2_.data)
            {
               _loc1_.name = facebookAPIManager.getUserNameByProfile(_loc1_.profile);
            }
         }
         view.membersList.invalidate();
      }
      
      private function onViewButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileAllianceMemberViewRenderer = checkRendererValidityForClickedButton(param1);
         if(!_loc2_)
         {
            return;
         }
         dispatch(new AllianceVisitEvent("allianceVisit",_loc2_.member.profile));
      }
      
      private function onAcceptButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileAllianceMemberViewRenderer = checkRendererValidityForClickedButton(param1);
         if(!_loc2_)
         {
            return;
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new ReplyToAllianceJoinRequestRequest(_loc2_.member.profile.gameId,true)));
      }
      
      private function onRejectButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileAllianceMemberViewRenderer = checkRendererValidityForClickedButton(param1);
         if(!_loc2_)
         {
            return;
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new ReplyToAllianceJoinRequestRequest(_loc2_.member.profile.gameId,false)));
      }
      
      private function onKickOutButtonClicked(param1:Event) : void
      {
         var _loc2_:Vector.<WindowEnumerationButton> = new Vector.<WindowEnumerationButton>();
      }
      
      private function onInviteButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileAllianceMemberViewRenderer = checkRendererValidityForClickedButton(param1);
         if(!_loc2_)
         {
            return;
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new InviteToAllianceRequest(_loc2_.member.profile.gameId)));
      }
      
      private function onCancelInvitationButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileAllianceMemberViewRenderer = checkRendererValidityForClickedButton(param1);
         if(!_loc2_)
         {
            return;
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new CancelAllianceInvitationRequest(_loc2_.member.profile.gameId)));
      }
      
      private function onInvitationRejectedButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileAllianceMemberViewRenderer = checkRendererValidityForClickedButton(param1);
         if(!_loc2_)
         {
            return;
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new RemoveRejectedAllianceInvitationRequest(_loc2_.member.profile.gameId)));
      }
      
      private function onInvitationAcceptedButtonClicked(param1:Event) : void
      {
         var _loc5_:* = undefined;
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         var _loc3_:MobileAllianceMemberViewRenderer = checkRendererValidityForClickedButton(param1);
         if(!_loc3_)
         {
            return;
         }
         if(allianceInfo.myAllianceCandidates != null)
         {
            _loc5_ = allianceInfo.myAllianceCandidates.members;
            if(_loc5_ != null && _loc5_.length > 0)
            {
               _loc2_ = false;
               _loc4_ = 0;
               while(_loc4_ < _loc5_.length)
               {
                  if(_loc5_[_loc4_].profile.gameId == _loc3_.member.profile.gameId && _loc3_.member.type == 7)
                  {
                     _loc2_ = true;
                     break;
                  }
                  _loc4_++;
               }
               if(_loc2_)
               {
                  _loc5_.splice(_loc4_,1);
                  dispatch(new ModelUpdateEvent("myAllianceCandidatesUpdated"));
               }
            }
         }
      }
      
      private function checkRendererValidityForClickedButton(param1:Event) : MobileAllianceMemberViewRenderer
      {
         var _loc3_:MobileAllianceMemberViewRenderer = null;
         var _loc2_:MPButton = param1.target as MPButton;
         if(_loc2_.parent && _loc2_.parent is MobileAllianceMemberViewRenderer)
         {
            _loc3_ = _loc2_.parent as MobileAllianceMemberViewRenderer;
            if(_loc3_.member && _loc3_.rowType)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function onHeaderClicked(param1:TouchEvent) : void
      {
         var _loc3_:MobileListHeaderView = null;
         var _loc2_:Touch = param1.getTouch(view,"ended");
         if(_loc2_ != null && param1.currentTarget && param1.currentTarget is MobileListHeaderView)
         {
            _loc3_ = param1.currentTarget as MobileListHeaderView;
            view.headerClicked(_loc3_);
         }
      }
   }
}

