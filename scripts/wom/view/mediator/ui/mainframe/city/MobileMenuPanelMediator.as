package wom.view.mediator.ui.mainframe.city
{
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.tutorial.TutorialVisibleItemsEvent;
   import wom.controller.event.ui.ActionSelectEvent;
   import wom.controller.event.ui.GetMapListWindowEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.UserInterfaceInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.friend.InboxInfo;
   import wom.model.game.quest.QuestInfo;
   import wom.model.game.quest.QuestUtil;
   import wom.model.game.report.AttackLog;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.tutorial.TutorialInfo;
   import wom.model.game.tutorial.TutorialState;
   import wom.service.kontagent.WomKontagentApi;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceWindow;
   import wom.view.screen.windows.build.MobileBuildShowcaseWindow;
   import wom.view.screen.windows.inbox.mobile.MobileInboxWindow;
   import wom.view.screen.windows.map.MobileMapListWindow;
   import wom.view.screen.windows.quest.MobileQuestDetailWindow;
   import wom.view.screen.windows.quest.MobileQuestWindow;
   import wom.view.screen.windows.rank.mobile.MobileLeaderboardWindow;
   import wom.view.screen.windows.social.MobileSocialMainWindow;
   import wom.view.screen.windows.store.MobileStoreWindow;
   import wom.view.ui.mainframe.city.MobileMenuPanel;
   
   public class MobileMenuPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileMenuPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      [Inject]
      public var userInterfaceInfo:UserInterfaceInfo;
      
      [Inject]
      public var storeInfo:StoreInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var inboxInfo:InboxInfo;
      
      internal var tooltipTimer:Timer;
      
      public function MobileMenuPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         updateQuestButtonVisibility();
         tooltipTimer = new Timer(300,1);
         tooltipTimer.addEventListener("timer",timerListener);
         eventMap.mapStarlingListener(view.buildMenuButton,"triggered",onBuildButtonClicked,Event);
         eventMap.mapStarlingListener(view.storeMenuButton,"triggered",onStoreButtonClicked,Event);
         eventMap.mapStarlingListener(view.allianceMenuButton,"triggered",onAllianceButtonClicked,Event);
         eventMap.mapStarlingListener(view.warMenuButton,"triggered",onWarButtonClicked,Event);
         addContextListener("selectionSuccess",onActionSelect,ActionSelectEvent);
         addContextListener("showMap",onMapRequested,GetMapListWindowEvent);
         addContextListener("attackLogsUpdated",onAttackLogsUpdated,ModelUpdateEvent);
         addContextListener("storeItemDiscountUpdated",toggleStoreButtonVisibility,ModelUpdateEvent);
         addContextListener("questInfoUpdated",onQuestInfoUpdated,ModelUpdateEvent);
         addContextListener("mandatoryTutorialsCompletionChanged",onMandatoryTutorialsCompletionChanged,TutorialEvent);
         addContextListener("updateVisibleOfTutorialItems",onUpdateVisibleOfTutorialItems,TutorialVisibleItemsEvent);
         addContextListener("getQuestPreviewViewPosition",onQuestPreviewViewPositionRequested,TutorialReferencePositionEvent);
         addContextListener("inboxCountUpdated",onInboxCountUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.inboxMenuButtonView.button,"triggered",onInboxButtonClicked,Event);
         eventMap.mapStarlingListener(view.rankingMenuButton,"triggered",onRankingButtonClicked,Event);
         eventMap.mapStarlingListener(view.questMenuButton,"triggered",onQuestButtonClicked,Event);
         eventMap.mapStarlingListener(view.friendsMenuButton,"triggered",onFriendsButtonClicked,Event);
         questInfoUpdated();
         inboxCountUpdated();
      }
      
      private function inboxCountUpdated() : void
      {
         view.inboxMenuButtonView.updateCounter(inboxInfo.addFromWeb + inboxInfo.totalAddFromClient());
         view.flattenIfInStage();
      }
      
      private function onInboxCountUpdated(param1:ModelUpdateEvent) : void
      {
         inboxCountUpdated();
      }
      
      private function onMandatoryTutorialsCompletionChanged(param1:TutorialEvent) : void
      {
         if(userInfo.mandatoryTutorialCompleted)
         {
            questInfoUpdated();
         }
      }
      
      private function questInfoUpdated() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:Boolean = false;
         if(userInfo.quests)
         {
            for each(var _loc3_ in userInfo.quests)
            {
               if(_loc3_.isNew)
               {
                  _loc3_.isNew = false;
                  _loc2_ = true;
               }
               if(_loc3_.progress)
               {
                  _loc3_.progress = false;
                  _loc1_ = true;
               }
            }
         }
         if(_loc2_)
         {
            showIndicators(true);
         }
         else if(_loc1_)
         {
            showIndicators(false);
         }
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      private function onQuestPreviewViewPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,view.questMenuButton.localToGlobal(new Point()),param1.additionalInfo,view.questMenuButton));
      }
      
      private function onQuestInfoUpdated(param1:ModelUpdateEvent) : void
      {
         updateQuestButtonVisibility();
         questInfoUpdated();
      }
      
      private function updateQuestButtonVisibility() : void
      {
         if(userInfo.quests && view.questMenuButtonVisibilityAccordingToTutorial)
         {
            view.questMenuButton.visible = userInfo.quests.length > 0;
         }
      }
      
      private function onUpdateVisibleOfTutorialItems(param1:TutorialVisibleItemsEvent) : void
      {
         if(param1.categoryMap && "menuPanel" in param1.categoryMap && param1.categoryMap["menuPanel"] is Array)
         {
            view.updateVisibleOfTutorialItems(param1.categoryMap["menuPanel"] as Array);
         }
      }
      
      private function toggleStoreButtonVisibility(param1:ModelUpdateEvent) : void
      {
         var _loc2_:Boolean = Boolean(storeInfo.discount);
      }
      
      public function timerListener(param1:TimerEvent) : void
      {
      }
      
      protected function onAttackLogsUpdated(param1:ModelUpdateEvent) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         for each(var _loc5_ in userInfo.attackLogs)
         {
            _loc4_ = _loc5_.attackStartInMillis;
            if(!_loc5_.attacker.isNpc && !_loc5_.isRead && (_loc4_ > userInfo.lastLogoutTime && _loc4_ < userInfo.loginServerTime))
            {
               _loc3_++;
            }
            if(!_loc5_.isRead)
            {
               _loc2_++;
            }
         }
         if(!userInterfaceInfo.attackLogIndicatorShown && _loc3_ > 0)
         {
            userInterfaceInfo.attackLogIndicatorShown = true;
         }
         return _loc3_ > 0;
      }
      
      protected function onActionSelect(param1:ActionSelectEvent) : void
      {
      }
      
      private function onStoreButtonClicked(param1:Event) : void
      {
         kontagentApi.trackUIEvent("store","ClickedStore");
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileStoreWindow(),0,null,null,false,userInfo.delayPopups));
      }
      
      private function onBuildButtonClicked(param1:Event) : void
      {
         kontagentApi.trackUIEvent("build","ClickedBuild");
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBuildShowcaseWindow()));
      }
      
      private function onAllianceButtonClicked(param1:Event) : void
      {
         var _loc3_:* = null;
         kontagentApi.trackUIEvent("alliance");
         var _loc2_:Boolean = false;
         for each(_loc3_ in city.buildings)
         {
            if(_loc3_.buildingTypeId == 42)
            {
               _loc2_ = true;
               break;
            }
         }
         if(_loc2_ && !_loc3_.incomplete)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileAllianceWindow()));
         }
         else
         {
            var _temp_6:* = §§findproperty(MobilePopUpWindowEvent);
            var _temp_5:* = "showPopUpWindow";
            var _temp_4:* = §§findproperty(MobileClementineChangableActionPopUp);
            var _temp_3:* = 2;
            var _loc6_:String = "ui.error.oops";
            var _temp_2:* = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            var _loc7_:String = "ui.error.noalliancebuilding";
            dispatch(new MobilePopUpWindowEvent(_temp_5,new MobileClementineChangableActionPopUp(_temp_3,_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc7_))));
         }
      }
      
      private function onWarButtonClicked(param1:Event) : void
      {
         warButtonClicked();
      }
      
      private function warButtonClicked(param1:Boolean = false) : void
      {
         kontagentApi.trackUIEvent("war","ClickedWar");
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileMapListWindow()));
      }
      
      private function onMapRequested(param1:GetMapListWindowEvent) : void
      {
         warButtonClicked(false);
      }
      
      private function onFriendsButtonClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileSocialMainWindow()));
      }
      
      private function checkTutorialQuest() : Boolean
      {
         var _loc1_:TutorialInfo = null;
         var _loc2_:TutorialState = null;
         var _loc3_:QuestInfo = null;
         if(userInfo.tutorialsInfo.enabled)
         {
            _loc1_ = "hq" in userInfo.tutorialsInfo.tutorials ? userInfo.tutorialsInfo.tutorials["hq"] : null;
            if(_loc1_ != null && !_loc1_.isCompleted)
            {
               _loc2_ = _loc1_.states[_loc1_.states[0].additionalInfo["stateIndexGoToQuest"]];
               _loc3_ = QuestUtil.getQuest(userInfo.quests,_loc2_.additionalInfo["questId"]);
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileQuestDetailWindow(_loc3_)));
               return true;
            }
         }
         return false;
      }
      
      private function onQuestButtonClicked(param1:Event) : void
      {
         if(!checkTutorialQuest())
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileQuestWindow()));
         }
      }
      
      private function onRankingButtonClicked(param1:Event) : void
      {
         kontagentApi.trackUIEvent("rank");
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileLeaderboardWindow(),0,null,null,false,userInfo.delayPopups));
      }
      
      private function onInboxButtonClicked(param1:Event) : void
      {
         kontagentApi.trackUIEvent("attack_log","ClickedAttackLog");
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileInboxWindow(userInfo.profile.gameId)));
      }
      
      private function showIndicators(param1:Boolean) : void
      {
         if(documentConfiguration.hasParameter("disabletutorials") && documentConfiguration.getParameter("disabletutorials"))
         {
            view.showIndicators(param1);
         }
         else if(userInfo.mandatoryTutorialCompleted)
         {
            view.showIndicators(param1);
         }
      }
   }
}

