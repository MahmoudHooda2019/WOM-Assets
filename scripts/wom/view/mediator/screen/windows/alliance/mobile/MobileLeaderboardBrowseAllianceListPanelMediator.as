package wom.view.mediator.screen.windows.alliance.mobile
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.RequestedAllianceUpdateEvent;
   import wom.controller.event.ranking.RankingWindowTabChangeEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceSortDirection;
   import wom.model.game.alliance.AllianceSortType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingInfoUtil;
   import wom.model.message.request.alliance.GetAlliancesPageRequest;
   import wom.model.message.request.alliance.JoinAllianceRequest;
   import wom.view.mediator.screen.windows.rank.mobile.MobileBaseRankingPanelMediator;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   import wom.view.screen.windows.alliance.mobile.MobileBrowseAllianceViewRenderer;
   import wom.view.screen.windows.alliance.mobile.MobileLeaderboardBrowseAllianceListPanel;
   
   public class MobileLeaderboardBrowseAllianceListPanelMediator extends MobileBaseRankingPanelMediator
   {
      
      [Inject]
      public var leaderboardAlliancesPanel:MobileLeaderboardBrowseAllianceListPanel;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileLeaderboardBrowseAllianceListPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
      }
      
      override protected function mapListeners() : void
      {
         addContextListener("rankingTabChanged",onActivePanelUpdated,RankingWindowTabChangeEvent);
         addContextListener("allianceRankingInfoUpdated",onAllianceRankingInfoUpdated,ModelUpdateEvent);
         addContextListener("allianceSummaryUpdated",onAllianceSummaryUpdated,ModelUpdateEvent);
         addContextListener("allianceIdRequested",onAllianceIdRequested,RequestedAllianceUpdateEvent);
         eventMap.mapStarlingListener(baseRankingPanel.tabBar,"change",onTimeIntervalTabChange,Event);
         eventMap.mapStarlingListener(baseRankingPanel.rankingList,"rendererAdd",onAllianceRendererAdded,Event);
         eventMap.mapStarlingListener(baseRankingPanel.rankingList,"rendererRemove",onAllianceRendererRemoved,Event);
         eventMap.mapStarlingListener(baseRankingPanel.rankingList,"scrollComplete",onScrollComplete,Event);
         eventMap.mapStarlingListener(baseRankingPanel.rankingList,"scroll",onScroll,Event);
      }
      
      override protected function onActivePanelUpdated(param1:RankingWindowTabChangeEvent) : void
      {
         if(param1.activePanel == leaderboardAlliancesPanel)
         {
            requestFirstPage();
         }
      }
      
      override protected function onScrollComplete(param1:Event) : void
      {
         if(newPageRequestInProgress && newPageReceived)
         {
            leaderboardAlliancesPanel.updateWithAlliances(allianceInfo.allianceRankingInfo,allianceInfo.myAllianceSummary);
         }
         newPageRequestInProgress = false;
         baseRankingPanel.scrollCompleted();
      }
      
      override protected function onScroll(param1:Event) : void
      {
         if(!newPageRequestInProgress)
         {
            if(baseRankingPanel.firstDataReceived && !allianceInfo.allianceRankingInfo.lastPage && baseRankingPanel.checkNextPageRequestConditions())
            {
               newPageRequestInProgress = true;
               dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAlliancesPageRequest(leaderboardAlliancesPanel.intervalCriterion,AllianceSortDirection.DESC,leaderboardAlliancesPanel.currentPage + 1,false,false,-1,50)));
            }
            else if(baseRankingPanel.firstDataReceived && baseRankingPanel.currentPage > 1 && baseRankingPanel.checkPreviousPageRequestConditions())
            {
               newPageRequestInProgress = true;
               dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAlliancesPageRequest(leaderboardAlliancesPanel.intervalCriterion,AllianceSortDirection.DESC,leaderboardAlliancesPanel.currentPage - 1,false,false,-1,50)));
            }
         }
      }
      
      private function onAllianceIdRequested(param1:RequestedAllianceUpdateEvent) : void
      {
         if(baseRankingPanel.rankingList && baseRankingPanel.rankingList.dataProvider)
         {
            baseRankingPanel.rankingList.invalidate();
         }
      }
      
      private function onAllianceSummaryUpdated(param1:ModelUpdateEvent) : void
      {
         var _loc2_:Boolean = allianceInfo.myAllianceSummary != null;
         if(leaderboardAlliancesPanel.myAllianceExists != _loc2_)
         {
            onAllianceRankingInfoUpdated(null);
         }
      }
      
      private function onAllianceRendererAdded(param1:Event, param2:MobileBrowseAllianceViewRenderer) : void
      {
         eventMap.mapStarlingListener(param2.joinButton,"triggered",onJoinClicked,Event);
      }
      
      private function onAllianceRendererRemoved(param1:Event, param2:MobileBrowseAllianceViewRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.joinButton,"triggered",onJoinClicked,Event);
      }
      
      private function onJoinClicked(param1:Event) : void
      {
         var _loc2_:MobileBrowseAllianceViewRenderer = checkRendererValidityForClickedButton(param1);
         if(_loc2_)
         {
            if(allianceInfo.myAllianceSummary != null)
            {
               var _temp_5:* = §§findproperty(MobilePopUpWindowEvent);
               var _temp_4:* = "showSecondaryPopUpWindow";
               var _temp_3:* = §§findproperty(MobileClementineChangableActionPopUp);
               var _temp_2:* = 2;
               var _loc3_:String = "ui.error.mademan";
               var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               var _loc4_:String = "ui.error.alliance.4.desc";
               dispatch(new MobilePopUpWindowEvent(_temp_4,new MobileClementineChangableActionPopUp(_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc4_),null)));
            }
            else if(_loc2_.alliance.id in allianceInfo.requestedAllianceIds)
            {
               var _temp_11:* = §§findproperty(MobilePopUpWindowEvent);
               var _temp_10:* = "showSecondaryPopUpWindow";
               var _temp_9:* = §§findproperty(MobileClementineChangableActionPopUp);
               var _temp_8:* = 2;
               var _loc5_:String = "ui.error.oops";
               var _temp_7:* = peak.i18n.PText.INSTANCE.getText0(_loc5_);
               var _loc6_:String = "ui.error.alliance.9.desc";
               dispatch(new MobilePopUpWindowEvent(_temp_10,new MobileClementineChangableActionPopUp(_temp_8,_temp_7,peak.i18n.PText.INSTANCE.getText0(_loc6_),null)));
            }
            else
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new JoinAllianceRequest(_loc2_.alliance.id)));
            }
         }
      }
      
      private function checkRendererValidityForClickedButton(param1:Event) : MobileBrowseAllianceViewRenderer
      {
         var _loc3_:MobileBrowseAllianceViewRenderer = null;
         var _loc2_:MPButton = param1.target as MPButton;
         if(_loc2_.parent && _loc2_.parent is MobileBrowseAllianceViewRenderer)
         {
            _loc3_ = _loc2_.parent as MobileBrowseAllianceViewRenderer;
            if(_loc3_.alliance)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      override protected function onTimeIntervalTabChange(param1:Event) : void
      {
         baseRankingPanel.updateCriterion();
         if(baseRankingPanel.tabBar.selectedIndex != -1 && leaderboardAlliancesPanel.intervalCriterion != AllianceSortType.TOURNAMENT)
         {
            requestFirstPage();
         }
      }
      
      override protected function requestFirstPage() : void
      {
         if(checkAllianceBuildingExists() && leaderboardAlliancesPanel.intervalCriterion != AllianceSortType.TOURNAMENT)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAlliancesPageRequest(leaderboardAlliancesPanel.intervalCriterion,AllianceSortDirection.DESC,1,false,false,-1,50)));
         }
      }
      
      private function checkAllianceBuildingExists() : Boolean
      {
         var _loc1_:BuildingInfo = BuildingInfoUtil.getBuildingByBuildingTypeId(city.buildings,42);
         return _loc1_ && _loc1_.level > 0;
      }
      
      private function onAllianceRankingInfoUpdated(param1:ModelUpdateEvent) : void
      {
         if(allianceInfo.allianceRankingInfo != null)
         {
            if(newPageRequestInProgress)
            {
               newPageReceived = true;
            }
            else
            {
               leaderboardAlliancesPanel.updateWithAlliances(allianceInfo.allianceRankingInfo,allianceInfo.myAllianceSummary);
            }
         }
      }
   }
}

