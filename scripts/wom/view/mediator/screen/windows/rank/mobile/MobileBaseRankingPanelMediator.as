package wom.view.mediator.screen.windows.rank.mobile
{
   import feathers.data.ListCollection;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.component.mobile.MPButton;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ranking.RankingWindowTabChangeEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.visit.StartVisitEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.rank.MobileRankingRow;
   import wom.model.message.request.GetRankingPageRequest;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.windows.rank.mobile.MobileBaseRankingPanel;
   import wom.view.screen.windows.rank.mobile.MobileRankingViewRenderer;
   
   public class MobileBaseRankingPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var baseRankingPanel:MobileBaseRankingPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      protected var newPageRequestInProgress:Boolean;
      
      protected var newPageReceived:Boolean;
      
      public function MobileBaseRankingPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(baseRankingPanel);
         newPageRequestInProgress = false;
         newPageReceived = false;
         baseRankingPanel.updateWithOwnGameId(userInfo.profile.gameId);
         mapListeners();
      }
      
      protected function requestFirstPage() : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetRankingPageRequest(null,1,false,baseRankingPanel.criterion.id,50)));
      }
      
      protected function mapListeners() : void
      {
         addContextListener("rankingTabChanged",onActivePanelUpdated,RankingWindowTabChangeEvent);
      }
      
      protected function onActivePanelUpdated(param1:RankingWindowTabChangeEvent) : void
      {
         if(param1.activePanel == baseRankingPanel)
         {
            mapActivePanelListeners();
         }
         else
         {
            unmapActivePanelListeners();
         }
      }
      
      private function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         updateName();
      }
      
      private function mapActivePanelListeners() : void
      {
         addContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         addContextListener("rankingInfoUpdated",onRankingInfoUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(baseRankingPanel.tabBar,"change",onTimeIntervalTabChange,Event);
         eventMap.mapStarlingListener(baseRankingPanel.rankingList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(baseRankingPanel.rankingList,"rendererRemove",onRendererRemoved,Event);
         eventMap.mapStarlingListener(baseRankingPanel.rankingList,"scrollComplete",onScrollComplete,Event);
         eventMap.mapStarlingListener(baseRankingPanel.rankingList,"scroll",onScroll,Event);
      }
      
      private function unmapActivePanelListeners() : void
      {
         removeContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         removeContextListener("rankingInfoUpdated",onRankingInfoUpdated,ModelUpdateEvent);
         eventMap.unmapStarlingListener(baseRankingPanel.tabBar,"change",onTimeIntervalTabChange,Event);
         eventMap.unmapStarlingListener(baseRankingPanel.rankingList,"rendererAdd",onRendererAdded,Event);
         eventMap.unmapStarlingListener(baseRankingPanel.rankingList,"rendererRemove",onRendererRemoved,Event);
         eventMap.unmapStarlingListener(baseRankingPanel.rankingList,"scrollComplete",onScrollComplete,Event);
         eventMap.unmapStarlingListener(baseRankingPanel.rankingList,"scroll",onScroll,Event);
      }
      
      private function updateName() : void
      {
         var _loc1_:ListCollection = null;
         var _loc4_:int = 0;
         var _loc3_:MobileRankingRow = null;
         var _loc2_:String = null;
         if(baseRankingPanel.rankingList && baseRankingPanel.rankingList.dataProvider)
         {
            _loc1_ = baseRankingPanel.rankingList.dataProvider;
            _loc4_ = 0;
            while(_loc4_ < _loc1_.data.length)
            {
               _loc3_ = _loc1_.data[_loc4_];
               _loc2_ = _loc3_.profile.mobileName ? _loc3_.profile.mobileName : facebookAPIManager.getUserNameByProfile(_loc3_.profile);
               if(_loc2_ != _loc3_.visibleName)
               {
                  _loc3_.visibleName = _loc2_;
                  _loc1_.updateItemAt(_loc4_);
               }
               _loc4_++;
            }
         }
      }
      
      protected function onScrollComplete(param1:Event) : void
      {
         if(newPageRequestInProgress && newPageReceived)
         {
            baseRankingPanel.rankingInfoUpdated(userInfo.rankingInfo);
            updateName();
         }
         newPageRequestInProgress = false;
         newPageReceived = false;
         baseRankingPanel.scrollCompleted();
      }
      
      protected function onScroll(param1:Event) : void
      {
         if(!newPageRequestInProgress)
         {
            if(baseRankingPanel.firstDataReceived && !userInfo.rankingInfo.isLastPage && baseRankingPanel.checkNextPageRequestConditions())
            {
               newPageRequestInProgress = true;
               dispatch(new OutgoingMessageEvent("outgoingMessage",new GetRankingPageRequest(null,baseRankingPanel.currentPage + 1,false,baseRankingPanel.criterion.id,50)));
            }
            else if(baseRankingPanel.firstDataReceived && baseRankingPanel.currentPage > 1 && baseRankingPanel.checkPreviousPageRequestConditions())
            {
               newPageRequestInProgress = true;
               dispatch(new OutgoingMessageEvent("outgoingMessage",new GetRankingPageRequest(null,baseRankingPanel.currentPage - 1,false,baseRankingPanel.criterion.id,50)));
            }
         }
      }
      
      protected function onTimeIntervalTabChange(param1:Event) : void
      {
         baseRankingPanel.updateCriterion();
         if(baseRankingPanel.tabBar.selectedIndex != -1)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetRankingPageRequest(null,1,false,baseRankingPanel.criterion.id,50)));
         }
      }
      
      protected function onRankingInfoUpdated(param1:ModelUpdateEvent) : void
      {
         if(newPageRequestInProgress)
         {
            newPageReceived = true;
         }
         else
         {
            baseRankingPanel.rankingInfoUpdated(userInfo.rankingInfo);
         }
      }
      
      private function onRendererAdded(param1:Event, param2:MobileRankingViewRenderer) : void
      {
         eventMap.mapStarlingListener(param2.enterCityButton,"triggered",onEnterCityClicked,Event);
      }
      
      private function onRendererRemoved(param1:Event, param2:MobileRankingViewRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.enterCityButton,"triggered",onEnterCityClicked,Event);
      }
      
      private function onEnterCityClicked(param1:Event) : void
      {
         var _loc2_:MobileRankingViewRenderer = checkRendererValidityForClickedButton(param1);
         if(_loc2_)
         {
            dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",baseRankingPanel));
            dispatch(new StartVisitEvent("startVisit",_loc2_.rankingRow.profile,false,true));
         }
      }
      
      private function checkRendererValidityForClickedButton(param1:Event) : MobileRankingViewRenderer
      {
         var _loc3_:MobileRankingViewRenderer = null;
         var _loc2_:MPButton = param1.target as MPButton;
         if(_loc2_.parent && _loc2_.parent is MobileRankingViewRenderer)
         {
            _loc3_ = _loc2_.parent as MobileRankingViewRenderer;
            if(_loc3_.rankingRow)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

