package wom.view.mediator.screen.windows.alliance.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.BrowseAllianceEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.message.request.alliance.GetAllianceMembersRequest;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.windows.alliance.mobile.MobileBrowseAlliancePanel;
   
   public class MobileBrowseAlliancePanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBrowseAlliancePanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function MobileBrowseAlliancePanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("generalInfo",onInfoButtonClickedFromAllianceList,BrowseAllianceEvent);
         addContextListener("backToAlliances",onBackToAlliancesRequested,BrowseAllianceEvent);
         addContextListener("createAllianceClicked",onCreateAllianceClicked,BrowseAllianceEvent);
      }
      
      private function onInfoButtonClickedFromAllianceList(param1:BrowseAllianceEvent) : void
      {
         getLeaderName(param1.alliance.leader);
         view.updateViewedAlliance(param1.alliance);
         view.updatePanelsVisibility(true,false,false,false);
         view.updateAllianceLeaderName(facebookAPIManager.getUserNameByProfile(param1.alliance.leader));
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAllianceMembersRequest(param1.alliance.id)));
      }
      
      private function getLeaderName(param1:Profile) : void
      {
         var _loc2_:* = undefined;
         if(param1 != null)
         {
            _loc2_ = new Vector.<ProfileIdPair>();
            _loc2_.push(new ProfileIdPair(param1.platformId,param1.avatar));
            dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc2_));
         }
      }
      
      private function onBackToAlliancesRequested(param1:BrowseAllianceEvent) : void
      {
         if(view.allianceToBeViewed != null)
         {
            allianceInfo.membersRankingInfo.members.length = 0;
            view.updateViewedAlliance(null);
            allianceInfo.membersRankingInfo = null;
         }
         view.updatePanelsVisibility(false,false,false,true);
      }
      
      private function onCreateAllianceClicked(param1:BrowseAllianceEvent) : void
      {
         view.updatePanelsVisibility(false,false,true,false);
      }
   }
}

