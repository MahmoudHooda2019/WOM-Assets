package wom.view.mediator.ui.mainframe.city
{
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.WindowCreationEvent;
   import wom.controller.event.mobile.MobileConstructableOptionsEvent;
   import wom.controller.event.mobile.MobileSharingPermissionsViewEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.tutorial.TutorialVisibleItemsEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileUserNotificationViewEvent;
   import wom.controller.event.ui.UserNotificationEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.WomScreenType;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.mediator.ui.mainframe.*;
   import wom.view.screen.popups.event.MobileEventAnnouncementPopUp;
   import wom.view.screen.popups.event.MobileEventPopUp;
   import wom.view.screen.windows.event.MobileEventStoreWindow;
   import wom.view.screen.windows.map.MobileMapListWindow;
   import wom.view.ui.mainframe.city.MobileCityUILayer;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileCityUILayerMediator extends MobileUILayerMediator
   {
      
      [Inject]
      public var view:MobileCityUILayer;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function MobileCityUILayerMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addViewListener("mobileUserNotificationViewEventCompleted",forwardUserNotificationEvent,MobileUserNotificationViewEvent);
         addContextListener("allianceSummaryUpdated",onAllianceSummaryUpdated,ModelUpdateEvent);
         addContextListener("getResourcePanelPosition",onResourcePanelPositionRequested,TutorialReferencePositionEvent);
         addContextListener("getMenuPanelPosition",onMenuPanelPositionRequested,TutorialReferencePositionEvent);
         addContextListener("getWorkerPanelPosition",onWorkerPanelPositionRequested,TutorialReferencePositionEvent);
         addContextListener("getProtectionPanelPosition",onProtectionPanelPositionRequested,TutorialReferencePositionEvent);
         addContextListener("getReconPointsBarPosition",onReconPointsBarPositionRequested,TutorialReferencePositionEvent);
         addContextListener("getMenuPanelBuildButtonPosition",onMenuPanelBuildButtonPositionRequested,TutorialReferencePositionEvent);
         addContextListener("getMenuPanelUpgradeButtonPosition",onMenuPanelUpgradeButtonPositionRequested,TutorialReferencePositionEvent);
         addContextListener("getMenuPanelWarButtonPosition",onMenuPanelWarButtonPositionRequested,TutorialReferencePositionEvent);
         addContextListener("updateVisibleOfTutorialItems",onUpdateVisibleOfTutorialItems,TutorialVisibleItemsEvent);
         addContextListener("authenticationCompleted",onAuthenticationCompleted,ModelUpdateEvent);
         addContextListener("mobileSpecialOfferUpdated",onMobileSpecialOfferUpdated,ModelUpdateEvent);
         addContextListener("mobileConstructableOptionsShow",onMobileConstructableOptionsEvent,MobileConstructableOptionsEvent);
         addContextListener("mobileConstructableOptionsClose",onMobileConstructableOptionsEvent,MobileConstructableOptionsEvent);
         addContextListener("mobileSharingPermissionsViewShow",onMobileSharingPermissionsViewEvent,MobileSharingPermissionsViewEvent);
         addContextListener("mobileSharingPermissionsViewClose",onMobileSharingPermissionsViewEvent,MobileSharingPermissionsViewEvent);
         addContextListener("eventTimersUpdated",onEventTimersUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.eventAnnouncementView,"touch",onEventAnnouncementViewClicked,Event);
         eventMap.mapStarlingListener(view.eventView,"touch",onEventViewClicked,Event);
         eventMap.mapStarlingListener(view.eventStoreView,"touch",onEventStoreViewClicked,Event);
         eventMap.mapStarlingListener(view.settingsView,"touch",onSettingsClicked,TouchEvent);
         eventMap.mapStarlingListener(view.returnButton,"triggered",onReturnButtonClicked,Event);
         eventMap.mapStarlingListener(view.listViewButton,"triggered",onListViewButtonClicked,Event);
         eventMap.mapListener(view.specialOfferTimer,"timer",onSpecialOfferTimerComplete,TimerEvent);
         updateAllianceLogo();
         authenticationCompleted();
      }
      
      private function onMobileSharingPermissionsViewEvent(param1:MobileSharingPermissionsViewEvent) : void
      {
         view.sharingPermissionsView = param1.view;
      }
      
      private function onSpecialOfferTimerComplete(param1:TimerEvent) : void
      {
         view.checkSpecialOfferPanel(false);
      }
      
      private function onMobileSpecialOfferUpdated(param1:ModelUpdateEvent) : void
      {
         view.checkSpecialOfferPanel(userInfo.mobileSpecialOffer && userInfo.mobileSpecialOffer.itemCount > 0);
         var _loc2_:Number = userInfo.mobileSpecialOffer.expireDate * 1000 - new Date().getTime();
         view.specialOfferTimer.reset();
         view.specialOfferTimer.repeatCount = 1;
         view.specialOfferTimer.delay = _loc2_;
         view.specialOfferTimer.start();
      }
      
      private function authenticationCompleted() : void
      {
         if(userInfo && userInfo.profile)
         {
            view.gameIdTextField.text = userInfo.profile.gameId;
         }
      }
      
      private function onAuthenticationCompleted(param1:ModelUpdateEvent) : void
      {
         authenticationCompleted();
         updateEventImageNames();
      }
      
      private function onAllianceSummaryUpdated(param1:ModelUpdateEvent) : void
      {
         updateAllianceLogo();
      }
      
      private function updateAllianceLogo() : void
      {
         view.menuPanel.updateAllianceLogo(allianceInfo.myAllianceSummary);
      }
      
      private function updateEventImageNames() : void
      {
         view.updateEventButtonWithImageName(documentConfiguration.eventButtonImageName);
         view.updateEventAnnouncementButtonWithImageName(documentConfiguration.eventAnnounceButtonImageName);
      }
      
      private function onReturnButtonClicked(param1:Event) : void
      {
         dispatch(new ActivateScreenEvent("activate",WomScreenType.CITY));
      }
      
      private function onListViewButtonClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileMapListWindow()));
      }
      
      private function onUpdateVisibleOfTutorialItems(param1:TutorialVisibleItemsEvent) : void
      {
         if(param1.categoryMap && "cityUiLayer" in param1.categoryMap && param1.categoryMap["cityUiLayer"] is Array)
         {
            view.updateVisibleOfTutorialItems(param1.categoryMap["cityUiLayer"] as Array);
         }
      }
      
      private function onMobileConstructableOptionsEvent(param1:MobileConstructableOptionsEvent) : void
      {
         view.constructableOptionsView = param1.view;
         if(param1.view)
         {
            dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
         }
      }
      
      private function onEventTimersUpdated(param1:ModelUpdateEvent) : void
      {
         view.eventAnnouncementVisible = userInfo.eventStartTime > 0;
         view.eventVisible = userInfo.eventStartTime <= 0 && userInfo.eventEndTime > 0;
         view.eventStoreVisible = userInfo.eventEndTime <= 0 && userInfo.eventStoreEndTime > 0;
         if(userInfo.eventEndTime > 0 || userInfo.eventStartTime > 0 || userInfo.eventStoreEndTime > 0)
         {
            addContextListener("tick",onTick);
         }
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         var _loc2_:Number = NaN;
         if(userInfo.eventEndTime > 0 || userInfo.eventStartTime > 0 || userInfo.eventStoreEndTime > 0)
         {
            _loc2_ = 0;
            if(userInfo.eventStartTime > 0)
            {
               _loc2_ = userInfo.eventStartTime;
               view.eventAnnouncementVisible = true;
               view.eventVisible = false;
               view.eventStoreVisible = false;
            }
            else if(userInfo.eventStartTime <= 0 && userInfo.eventEndTime > 0)
            {
               _loc2_ = userInfo.eventEndTime;
               view.eventAnnouncementVisible = false;
               view.eventVisible = true;
               view.eventStoreVisible = false;
            }
            else if(userInfo.eventEndTime <= 0 && userInfo.eventStoreEndTime > 0)
            {
               _loc2_ = userInfo.eventStoreEndTime;
               view.eventAnnouncementVisible = false;
               view.eventVisible = false;
               view.eventStoreVisible = true;
            }
            view.eventView.label = view.eventAnnouncementView.label = view.eventStoreView.label = _loc2_ > 60000 ? LocalizedDateTimeUtil.getUserFriendlyTimeWithoutSeconds(_loc2_) : LocalizedDateTimeUtil.getUserFriendlyTime(_loc2_);
         }
         else
         {
            removeContextListener("tick",onTick);
            view.eventVisible = view.eventAnnouncementVisible = view.eventStoreVisible = false;
         }
      }
      
      private function onEventAnnouncementViewClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.eventAnnouncementView,"ended");
         if(_loc2_)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileEventAnnouncementPopUp(documentConfiguration.eventAnnounceBackgroundImageName)));
         }
      }
      
      private function onEventViewClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.eventView,"ended");
         if(_loc2_)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileEventPopUp()));
         }
      }
      
      private function onEventStoreViewClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.eventStoreView,"ended");
         if(_loc2_)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileEventStoreWindow()));
         }
      }
      
      private function onResourcePanelPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         sendPanelPosition(view.resourcePanelPosition,param1.objectToBeAligned);
      }
      
      private function onMenuPanelPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         sendPanelPosition(view.menuPanelPosition,param1.objectToBeAligned);
      }
      
      private function onMenuPanelBuildButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         sendPanelPosition(view.menuPanelPosition,param1.objectToBeAligned,view.menuPanel.buildMenuButton);
      }
      
      private function onMenuPanelUpgradeButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         sendPanelPosition(view.menuPanelPosition,param1.objectToBeAligned);
      }
      
      private function onMenuPanelWarButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         sendPanelPosition(view.menuPanelPosition,param1.objectToBeAligned,view.menuPanel.warMenuButton);
      }
      
      private function onWorkerPanelPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         sendPanelPosition(view.workerPanelPosition,param1.objectToBeAligned);
      }
      
      private function onProtectionPanelPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         sendPanelPosition(view.protectionPanelPosition,param1.objectToBeAligned,view.protectionPanel);
      }
      
      private function sendPanelPosition(param1:Point, param2:int, param3:Object = null) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param2,param1,null,param3));
      }
      
      private function forwardUserNotificationEvent(param1:MobileUserNotificationViewEvent) : void
      {
         dispatch(new UserNotificationEvent("userNotificationEventCompleted"));
      }
      
      private function onSettingsClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.settingsView,"ended");
         if(_loc2_)
         {
            dispatch(new WindowCreationEvent("createWindow",new WindowEnumeration(203,{})));
         }
      }
      
      private function onReconPointsBarPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         sendPanelPosition(view.reconPointsBarPosition,param1.objectToBeAligned);
      }
   }
}

