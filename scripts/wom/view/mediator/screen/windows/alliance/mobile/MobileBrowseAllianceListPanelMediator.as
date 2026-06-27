package wom.view.mediator.screen.windows.alliance.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.BrowseAllianceEvent;
   import wom.controller.event.alliance.RequestedAllianceUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceRankingInfo;
   import wom.model.game.alliance.AllianceSortDirection;
   import wom.model.game.alliance.AllianceSortType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.message.request.alliance.GetAlliancesPageRequest;
   import wom.model.message.request.alliance.GetRequestedAlliancesRequest;
   import wom.model.message.request.alliance.JoinAllianceRequest;
   import wom.model.message.request.alliance.SearchAllianceRequest;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.alliance.mobile.MobileBrowseAllianceListPanel;
   import wom.view.screen.windows.alliance.mobile.MobileBrowseAllianceViewRenderer;
   import wom.view.ui.common.MobileListHeaderView;
   
   public class MobileBrowseAllianceListPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBrowseAllianceListPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      protected var newPageRequestInProgress:Boolean;
      
      protected var newPageReceived:Boolean;
      
      public function MobileBrowseAllianceListPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         mapListeners();
         checkCreateButton();
         performServerRequests();
      }
      
      protected function performServerRequests() : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetRequestedAlliancesRequest()));
         if(view.alliances == null || view.alliances.length <= 0)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAlliancesPageRequest(AllianceSortType.RANK,AllianceSortDirection.ASC,1,false,false,-1,50)));
         }
      }
      
      protected function mapListeners() : void
      {
         eventMap.mapStarlingListener(view.headerRank,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.headerName,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.headerMembers,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.headerScore,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.headerMinScore,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.headerMinLevel,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.searchTextInput,"focusOut",onSearchInputFocusOut,Event);
         eventMap.mapStarlingListener(view.searchButton,"triggered",onSearchButtonClicked,Event);
         eventMap.mapStarlingListener(view.cancelSearchButton,"triggered",onCancelSearchButtonClicked,Event);
         eventMap.mapStarlingListener(view.createAllianceButton,"triggered",onCreateAllianceClicked,Event);
         addContextListener("allianceRankingInfoUpdated",onAllianceRankingInfoUpdated,ModelUpdateEvent);
         addContextListener("allianceSearchResultUpdated",onAllianceSearchResultUpdated,ModelUpdateEvent);
         addContextListener("allianceSummaryUpdated",onCreateButtonConstraintsUpdated,ModelUpdateEvent);
         addContextListener("goldAmountUpdated",onCreateButtonConstraintsUpdated,ModelUpdateEvent);
         addContextListener("allianceIdRequested",onAllianceIdRequested,RequestedAllianceUpdateEvent);
         eventMap.mapStarlingListener(view.allianceList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.allianceList,"rendererRemove",onRendererRemoved,Event);
         eventMap.mapStarlingListener(view.allianceList,"scrollComplete",onScrollComplete,Event);
         eventMap.mapStarlingListener(view.allianceList,"scroll",onScroll,Event);
      }
      
      private function onScrollComplete(param1:Event) : void
      {
         if(view.searchButton.visible)
         {
            if(newPageRequestInProgress && newPageReceived)
            {
               view.update(allianceInfo.allianceRankingInfo,true);
            }
            newPageRequestInProgress = false;
            view.scrollCompleted();
         }
      }
      
      private function onScroll(param1:Event) : void
      {
         var _loc2_:AllianceRankingInfo = null;
         if(!newPageRequestInProgress && view.searchButton.visible)
         {
            if(view.firstDataReceived && !allianceInfo.allianceRankingInfo.lastPage && view.checkNextPageRequestConditions())
            {
               newPageRequestInProgress = true;
               _loc2_ = allianceInfo.allianceRankingInfo;
               dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAlliancesPageRequest(_loc2_.sortType,_loc2_.sortDirection,_loc2_.pageOrder + 1,false,false,-1,50)));
            }
            else if(view.firstDataReceived && view.currentPage > 1 && view.checkPreviousPageRequestConditions())
            {
               newPageRequestInProgress = true;
               _loc2_ = allianceInfo.allianceRankingInfo;
               dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAlliancesPageRequest(_loc2_.sortType,_loc2_.sortDirection,_loc2_.pageOrder - 1,false,false,-1,50)));
            }
         }
      }
      
      private function onAllianceIdRequested(param1:RequestedAllianceUpdateEvent) : void
      {
         if(view.allianceList && view.allianceList.dataProvider)
         {
            view.allianceList.invalidate();
         }
      }
      
      private function onRendererAdded(param1:Event, param2:MobileBrowseAllianceViewRenderer) : void
      {
         eventMap.mapStarlingListener(param2.infoButton,"triggered",onInfoClicked,Event);
         eventMap.mapStarlingListener(param2.joinButton,"triggered",onJoinClicked,Event);
      }
      
      private function onRendererRemoved(param1:Event, param2:MobileBrowseAllianceViewRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.infoButton,"triggered",onInfoClicked,Event);
         eventMap.unmapStarlingListener(param2.joinButton,"triggered",onJoinClicked,Event);
      }
      
      private function onInfoClicked(param1:Event) : void
      {
         var _loc2_:MobileBrowseAllianceViewRenderer = checkRendererValidityForClickedButton(param1);
         if(_loc2_)
         {
            dispatch(new BrowseAllianceEvent("generalInfo",_loc2_.alliance));
         }
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
      
      private function onHeaderClicked(param1:TouchEvent) : void
      {
         var _loc5_:MobileListHeaderView = null;
         var _loc3_:AllianceSortDirection = null;
         var _loc4_:GetAlliancesPageRequest = null;
         var _loc2_:Touch = param1.getTouch(view,"ended");
         if(view.headersEnabled && _loc2_ && param1.currentTarget && param1.currentTarget is MobileListHeaderView)
         {
            _loc5_ = param1.currentTarget as MobileListHeaderView;
            if(_loc5_ == view.sortedHeader)
            {
               _loc3_ = view.sortDirection == AllianceSortDirection.ASC ? AllianceSortDirection.DESC : AllianceSortDirection.ASC;
            }
            else
            {
               _loc3_ = AllianceSortDirection.ASC;
            }
            switch(_loc5_)
            {
               case view.headerRank:
                  _loc4_ = new GetAlliancesPageRequest(AllianceSortType.RANK,_loc3_,1,false,false,-1,50);
                  break;
               case view.headerScore:
                  _loc4_ = new GetAlliancesPageRequest(AllianceSortType.BP,_loc3_,1,false,false,-1,50);
                  break;
               case view.headerMembers:
                  _loc4_ = new GetAlliancesPageRequest(AllianceSortType.MEMBER_COUNT,_loc3_,1,false,false,-1,50);
                  break;
               case view.headerMinScore:
                  _loc4_ = new GetAlliancesPageRequest(AllianceSortType.MIN_SCORE,_loc3_,1,true,false,-1,50);
                  break;
               case view.headerMinLevel:
                  _loc4_ = new GetAlliancesPageRequest(AllianceSortType.MIN_LEVEL,_loc3_,1,true,false,-1,50);
            }
            if(_loc4_ != null)
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",_loc4_));
            }
         }
      }
      
      private function onSearchInputFocusOut(param1:Event) : void
      {
         view.updateSearchInputCase();
      }
      
      private function onSearchButtonClicked(param1:Event) : void
      {
         var _loc2_:String = view.searchTextInput.text;
         if(_loc2_ && _loc2_ != "")
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new SearchAllianceRequest(_loc2_)));
         }
      }
      
      private function onCancelSearchButtonClicked(param1:Event) : void
      {
         view.updateCancelSearchButtonVisibility(false);
         var _loc2_:AllianceRankingInfo = allianceInfo.allianceRankingInfo;
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAlliancesPageRequest(_loc2_.sortType,_loc2_.sortDirection,_loc2_.pageOrder,false,false,-1,50)));
      }
      
      private function checkLevel2HouseOfBrotherhood() : Boolean
      {
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.buildingTypeId == 42)
            {
               return _loc1_.level >= 2;
            }
         }
         return false;
      }
      
      private function onCreateAllianceClicked(param1:Event) : void
      {
         if(allianceInfo.myAllianceSummary != null)
         {
            var _temp_5:* = §§findproperty(MobilePopUpWindowEvent);
            var _temp_4:* = "showSecondaryPopUpWindow";
            var _temp_3:* = §§findproperty(MobileClementineChangableActionPopUp);
            var _temp_2:* = 2;
            var _loc2_:String = "ui.error.mademan";
            var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc2_);
            var _loc3_:String = "ui.error.alliance.4.desc";
            dispatch(new MobilePopUpWindowEvent(_temp_4,new MobileClementineChangableActionPopUp(_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc3_),null)));
         }
         else if(!checkLevel2HouseOfBrotherhood())
         {
            var _temp_11:* = §§findproperty(MobilePopUpWindowEvent);
            var _temp_10:* = "showSecondaryPopUpWindow";
            var _temp_9:* = §§findproperty(MobileClementineChangableActionPopUp);
            var _temp_8:* = 2;
            var _loc4_:String = "domain.building.42.name";
            var _temp_7:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
            var _loc5_:String = "ui.windows.alliance.browse.create.lvl2building";
            dispatch(new MobilePopUpWindowEvent(_temp_10,new MobileClementineChangableActionPopUp(_temp_8,_temp_7,peak.i18n.PText.INSTANCE.getText0(_loc5_),null)));
         }
         else if(userInfo.numberOfGolds < 50)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
         }
         else
         {
            dispatch(new BrowseAllianceEvent("createAllianceClicked",null));
         }
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
               view.update(allianceInfo.allianceRankingInfo,true);
            }
         }
      }
      
      private function onAllianceSearchResultUpdated(param1:ModelUpdateEvent) : void
      {
         if(allianceInfo.searchedAllianceRankingInfo != null)
         {
            view.update(allianceInfo.searchedAllianceRankingInfo,false);
            view.updateCancelSearchButtonVisibility(true);
         }
      }
      
      protected function checkCreateButton() : void
      {
         view.updateCreateButtonEnabling(allianceInfo.myAllianceSummary);
      }
      
      private function onCreateButtonConstraintsUpdated(param1:ModelUpdateEvent) : void
      {
         checkCreateButton();
      }
   }
}

