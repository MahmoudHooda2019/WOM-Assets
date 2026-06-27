package wom.view.mediator.screen.windows.rank.mobile
{
   import peak.component.mobile.MPButton;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ranking.RankingWindowTabChangeEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingInfoUtil;
   import wom.model.game.league.LeagueManager;
   import wom.model.message.request.GetRankingPageRequest;
   import wom.model.message.request.league.GetLeagueMembersRequest;
   import wom.view.mediator.util.MobileButtonTabbedWindowMediator;
   import wom.view.screen.windows.alliance.mobile.MobileLeaderboardBrowseAllianceListPanel;
   import wom.view.screen.windows.rank.mobile.MobileBaseRankingPanel;
   import wom.view.screen.windows.rank.mobile.MobileLeaderboardWindow;
   
   public class MobileLeaderboardWindowMediator extends MobileButtonTabbedWindowMediator
   {
      
      [Inject]
      public var view:MobileLeaderboardWindow;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileLeaderboardWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         view.updateAllianceButtonEnabling(checkAllianceBuildingExists());
         getLeagueMembersRequest();
         dispatch(new RankingWindowTabChangeEvent("rankingTabChanged",view.activePanel));
      }
      
      private function checkAllianceBuildingExists() : Boolean
      {
         var _loc1_:BuildingInfo = BuildingInfoUtil.getBuildingByBuildingTypeId(city.buildings,42);
         return _loc1_ && _loc1_.level > 0;
      }
      
      override protected function onTabButtonClicked(param1:Event) : void
      {
         super.onTabButtonClicked(param1);
         if(view.activePanel is MobileBaseRankingPanel && !(view.activePanel is MobileLeaderboardBrowseAllianceListPanel))
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetRankingPageRequest(null,1,false,(view.activePanel as MobileBaseRankingPanel).criterion.id,50)));
         }
         else if(param1.target as MPButton == view.leaguesButton)
         {
            getLeagueMembersRequest();
         }
         dispatch(new RankingWindowTabChangeEvent("rankingTabChanged",view.activePanel));
      }
      
      private function getLeagueMembersRequest() : void
      {
         if(leagueManager.myLeague != null)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetLeagueMembersRequest()));
         }
         else
         {
            dispatch(new ModelUpdateEvent("leagueMembersRankingInfoUpdated"));
         }
      }
   }
}

