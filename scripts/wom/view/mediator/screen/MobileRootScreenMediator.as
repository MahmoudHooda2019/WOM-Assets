package wom.view.mediator.screen
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.network.ClientEvent;
   import peak.resource.SoundPlayer;
   import peak.thread.IdleWorkerThreadEvent;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.Environment;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.GetGoldWindowEvent;
   import wom.controller.event.ui.LeaveGamePopUpEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.SelectFriendsWindowEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.UserInterfaceInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.WomScreenType;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.gold.PaymentInfo;
   import wom.model.game.quest.QuestInfo;
   import wom.model.message.request.ClaimQuestRequest;
   import wom.model.message.request.IdleWorkerRequest;
   import wom.service.facebook.FacebookAPIManager;
   import wom.service.kontagent.WomKontagentApi;
   import wom.view.screen.MobileCityPlannerScreen;
   import wom.view.screen.MobileCityScreen;
   import wom.view.screen.MobileLoadingScreen;
   import wom.view.screen.MobileManualAuthenticationScreen;
   import wom.view.screen.MobileMapScreen;
   import wom.view.screen.MobileRootScreen;
   import wom.view.screen.popups.MobileDisconnectPopUp;
   import wom.view.screen.popups.MobileDontKillMePopUp;
   import wom.view.screen.popups.MobileGuestNamingPopUp;
   import wom.view.screen.popups.MobileLeaveGamePopUp;
   import wom.view.screen.popups.facebook.MobileFBConfirmationPopUp;
   import wom.view.screen.popups.facebook.MobileFBProgressPopUp;
   import wom.view.screen.popups.quest.MobileQuestCompletedPopup;
   import wom.view.screen.popups.underattack.MobileAlreadyUnderAttackPopUp;
   import wom.view.screen.windows.friends.mobile.MobileSelectFriendsWindow;
   import wom.view.screen.windows.general.MobileContactSupportWindow;
   import wom.view.screen.windows.general.MobileGeneralInformationWindow;
   import wom.view.screen.windows.gold.MobileGetGoldWindow;
   import wom.view.screen.windows.map.MobileMapListWindow;
   import wom.view.screen.windows.settings.MobileSettingsWindow;
   import wom.view.ui.mainframe.city.MobileCityPlannerUILayer;
   import wom.view.ui.mainframe.city.MobileCityUILayer;
   import wom.view.ui.mainframe.combat.MobileCombatUILayer;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultCombatRechargePopUp;
   import wom.view.ui.mainframe.defend.MobileNPCAttackUILayer;
   import wom.view.ui.mainframe.visit.MobileVisitUILayer;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileRootScreenMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileRootScreen;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInterfaceInfo:UserInterfaceInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var paymentInfo:PaymentInfo;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      private var activateScreenAdditionalInfo:Dictionary;
      
      public function MobileRootScreenMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         addContextListener("questInfoUpdated",onQuestsUpdated,ModelUpdateEvent);
         addContextListener("activate",onScreenActivation,ActivateScreenEvent);
         addContextListener("activatePreviousScreen",onPreviousScreenActivation,ActivateScreenEvent);
         addContextListener("showPopUpWindow",onShowPopUp,MobilePopUpWindowEvent);
         addContextListener("closePopUpWindow",onClosePopUp,MobilePopUpWindowEvent);
         addContextListener("closeTopPopUpWindow",onCloseTopPopUp,MobilePopUpWindowEvent);
         addContextListener("showSecondaryPopUpWindow",onShowSecondaryPopUp,MobilePopUpWindowEvent);
         addContextListener("closeSecondaryPopUpWindow",onCloseSecondaryPopUp,MobilePopUpWindowEvent);
         addContextListener("delayPopUps",delayPopUps,MobilePopUpWindowEvent);
         addContextListener("showDelayedPopUps",showDelayedPopUps,MobilePopUpWindowEvent);
         addContextListener("showSelectFriendsWindow",showSelectFriendsWindow,SelectFriendsWindowEvent);
         addContextListener("showGetGoldWindow",showGetGoldWindow,GetGoldWindowEvent);
         addContextListener("close",onCloseContainerOfDisplayObject,MobileCloseContainerOfDisplayObjectEvent);
         addContextListener("addWindowEnumeration",onAddWindowEnumeration,MobileCloseContainerOfDisplayObjectEvent);
         addContextListener("gameModeChange",onGameModeChange,GameModeChangedEvent);
         addContextListener("getNewestPopUpPosition",onNewestPopUpPositionRequested,TutorialReferencePositionEvent);
         addContextListener("getNewestSecondaryPopUpPosition",onNewestSecondaryPopUpPositionRequested,TutorialReferencePositionEvent);
         addContextListener("idleWorkerThread",onIdleWorkerThread,IdleWorkerThreadEvent);
         addContextListener("connectionLostProcessed",onConnectionLostProcessed,ClientEvent);
         eventMap.mapStarlingListener(view.modalLayer,"touch",onModalClicked,TouchEvent);
         eventMap.mapStarlingListener(view.secondaryPopUpModalLayer,"touch",onSecondaryModalClicked,TouchEvent);
         Environment.stage.addEventListener("showLeaveGamePopUp",showLeaveGamePopUp,LeaveGamePopUpEvent);
         gameRootHolder.init();
      }
      
      private function showGetGoldWindow(param1:GetGoldWindowEvent) : void
      {
         if(view.getGoldWindow)
         {
            dispatch(new MobilePopUpWindowEvent("notifyClosingWindow",view.getGoldWindow));
         }
         view.getGoldWindow = new MobileGetGoldWindow(paymentInfo.goldProducts,param1.monetizationType,paymentInfo.getMobileGoldProductsLength() > 0,paymentInfo.topSellerGoldProductId,param1.windowEnumerations,param1.stackable);
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",view.getGoldWindow,param1.vectorPosition,null,null,false,userInfo.delayPopups));
      }
      
      private function showLeaveGamePopUp(param1:LeaveGamePopUpEvent) : void
      {
         if(view.leaveGamePopUp)
         {
            dispatch(new MobilePopUpWindowEvent("notifyClosingWindow",view.leaveGamePopUp));
         }
         view.leaveGamePopUp = new MobileLeaveGamePopUp();
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",view.leaveGamePopUp,param1.vectorPosition,null,null,false,userInfo.delayPopups));
      }
      
      private function onIdleWorkerThread(param1:IdleWorkerThreadEvent) : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new IdleWorkerRequest(param1.m,param1.k)));
      }
      
      private function showSelectFriendsWindow(param1:SelectFriendsWindowEvent) : void
      {
         if(view.selectFriendsWindow)
         {
            dispatch(new MobilePopUpWindowEvent("notifyClosingWindow",view.selectFriendsWindow));
         }
         view.selectFriendsWindow = new MobileSelectFriendsWindow(param1.requestType,param1.inventoryItemId,param1.stackable);
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",view.selectFriendsWindow,param1.vectorPosition,null,null,false,userInfo.delayPopups));
      }
      
      private function onGameModeChange(param1:GameModeChangedEvent) : void
      {
         if(!(view.uiLayer is MobileCombatUILayer) && (userInfo.gameMode == GameModeType.VISIT && visitInfo.isScout || userInfo.gameMode == GameModeType.ATTACK || userInfo.gameMode == GameModeType.TUSK_HORN))
         {
            view.initCombatUI();
         }
         else if(!(view.uiLayer is MobileCityUILayer) && userInfo.gameMode == GameModeType.NORMAL)
         {
            if(view.uiLayer && view.uiLayer is MobileVisitUILayer)
            {
            }
            view.initCityUI();
         }
         else if(!(view.uiLayer is MobileVisitUILayer) && (userInfo.gameMode == GameModeType.VISIT && !visitInfo.isScout))
         {
            if(view.uiLayer && view.uiLayer is MobileCityUILayer)
            {
            }
            view.initVisitUI();
         }
         else if(!(view.uiLayer is MobileNPCAttackUILayer) && userInfo.gameMode == GameModeType.DEFEND)
         {
            view.initNPCAttackUI();
         }
      }
      
      private function onQuestsUpdated(param1:ModelUpdateEvent) : void
      {
         checkCompletedQuests();
      }
      
      private function onPreviousScreenActivation(param1:ActivateScreenEvent) : void
      {
         if(view.previousScreenType != null)
         {
            param1.screen = view.previousScreenType;
            onScreenActivation(param1);
         }
      }
      
      private function onScreenActivation(param1:ActivateScreenEvent) : void
      {
         userInfo.currentScreen = param1.screen;
         userInfo.currentScreenIsCampaignMap = "mapScreenCampaignMode" in param1.additionalInfo;
         userInfo.tutorialsInfo.additionalInfo.lastOpenedPopup = null;
         userInfo.tutorialsInfo.additionalInfo.lastOpenedSecondaryPopup = null;
         activateScreenAdditionalInfo = param1.additionalInfo;
         if(param1.screen != WomScreenType.LOADING)
         {
            view.clearPopupLayers();
         }
         if(view.loadingLayer.ongoingShowAnimation)
         {
            eventMap.mapStarlingListener(view.loadingLayer,"change",onLoadingLayerTweenComplete,Event);
         }
         else
         {
            switchScreen(param1.screen,param1.onCompleteFunction);
         }
      }
      
      private function switchScreen(param1:WomScreenType, param2:Function = null) : void
      {
         var _loc3_:String = null;
         switch(param1)
         {
            case WomScreenType.MANUEL_AUTHENTICATION:
               view.changeScreen(new MobileManualAuthenticationScreen(activateScreenAdditionalInfo["users"]));
               break;
            case WomScreenType.MOBILE_CITY_PLANNER:
               view.changeScreen(new MobileCityPlannerScreen());
               view.initCityPlannerUI();
               break;
            case WomScreenType.LOADING:
               view.showLoadingLayer(param2);
               break;
            case WomScreenType.MAP:
               view.changeScreen(new MobileMapScreen());
               (view.uiLayer as MobileCityUILayer).mapMode();
               if(!userInfo.currentScreenIsCampaignMap)
               {
                  dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileMapListWindow()));
               }
               break;
            case WomScreenType.CITY:
               view.changeScreen(new MobileCityScreen());
               _loc3_ = "CityTheme";
               var _loc4_:String = "Ambient";
               soundPlayer.stopMusic();
               soundPlayer.playAmbientById(_loc4_);
               if(userInfo.gameMode == GameModeType.NORMAL)
               {
                  soundPlayer.playMusicListById([_loc3_,_loc3_,50000,_loc3_,_loc3_,_loc3_,100000,_loc3_,_loc3_,75000,_loc3_,_loc3_,_loc3_,150000]);
               }
               if(view.uiLayer is MobileCityUILayer)
               {
                  (view.uiLayer as MobileCityUILayer).defaultMode();
                  if(userInfo.gameMode == GameModeType.NORMAL)
                  {
                     checkPopUpStack();
                  }
               }
               else if(view.uiLayer is MobileCityPlannerUILayer)
               {
                  view.initCityUI();
                  (view.uiLayer as MobileCityUILayer).defaultMode();
                  if(userInfo.gameMode == GameModeType.NORMAL)
                  {
                     checkPopUpStack();
                  }
               }
               if(view.previousScreenType == WomScreenType.MAP)
               {
                  dispatch(new MobilePopUpWindowEvent("showDelayedPopUps",null));
               }
         }
         if(param1 != WomScreenType.LOADING)
         {
            setTimeout(view.hideLoadingLayer,30);
         }
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      private function onLoadingLayerTweenComplete(param1:Event) : void
      {
         if(userInfo.currentScreen != WomScreenType.LOADING)
         {
            switchScreen(userInfo.currentScreen);
         }
         else
         {
            view.clearPopupLayers();
         }
      }
      
      private function onShowPopUp(param1:MobilePopUpWindowEvent) : void
      {
         if(view.currentScreen is MobileLoadingScreen || param1.hideLoadingLayer)
         {
            view.hideLoadingLayer();
         }
         if(param1.delayPopupsBefore != null)
         {
            userInfo.delayPopups = param1.delayPopupsBefore;
         }
         var _loc2_:Boolean = userInfo.delayPopups;
         if(param1.delayPopupsAfter != null)
         {
            userInfo.delayPopups = param1.delayPopupsAfter;
         }
         if(!_loc2_ && (userInfo.gameMode == GameModeType.NORMAL || userInfo.gameMode == GameModeType.VISIT || userInfo.gameMode == GameModeType.UNKNOWN || (userInfo.gameMode == GameModeType.ATTACK || userInfo.gameMode == GameModeType.VISIT) && (param1.popUpWindowInfo.window is MobileAlreadyUnderAttackPopUp || param1.popUpWindowInfo.window is MobileGetGoldWindow || param1.popUpWindowInfo.window is MobileSettingsWindow || param1.popUpWindowInfo.window is MobileGeneralInformationWindow || param1.popUpWindowInfo.window is MobileContactSupportWindow) || param1.popUpWindowInfo.window is MobileDisconnectPopUp || param1.popUpWindowInfo.window is MobileDontKillMePopUp || param1.popUpWindowInfo.window is MobileCatapultCombatRechargePopUp))
         {
            if(view.popupLayer.numChildren <= 0 || param1.popUpWindowInfo.vectorPosition == 0)
            {
               closeAllSecondaryPopUps();
               stackPopUps();
               showPopUp(param1.popUpWindowInfo.window,param1.popUpWindowInfo.showModal,param1.popUpWindowInfo.customPosition);
            }
            else
            {
               showPopUpLater(param1);
            }
         }
         else
         {
            showPopUpLater(param1);
         }
      }
      
      private function showPopUpLater(param1:MobilePopUpWindowEvent) : void
      {
         if(param1.popUpWindowInfo.vectorPosition == -1)
         {
            view.popups.push(param1);
         }
         else
         {
            view.popups.splice(param1.popUpWindowInfo.vectorPosition,0,param1);
         }
      }
      
      private function showPopUp(param1:DisplayObject, param2:Boolean = true, param3:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(gameRootHolder.gameRoot)
         {
            gameRootHolder.gameRoot.beforeShowPopup();
         }
         view.popupLayer.addPopUpWindow(param1);
         if(!param3)
         {
            _loc5_ = int("windowWidth" in param1 ? param1["windowWidth"] : param1.width);
            _loc4_ = int("windowHeight" in param1 ? param1["windowHeight"] : param1.height);
            param1.x = int((contextView.stage.stageWidth - _loc5_) / 2);
            param1.y = int((contextView.stage.stageHeight - _loc4_) / 2);
         }
         view.modalLayer.visible ||= param2;
         onShowPopUpCompleted(param1);
      }
      
      private function onShowPopUpCompleted(param1:DisplayObject) : void
      {
         userInfo.tutorialsInfo.additionalInfo.lastOpenedPopup = param1;
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      private function onShowSecondaryPopUp(param1:MobilePopUpWindowEvent) : void
      {
         if(!userInfo.delayPopups)
         {
            showSecondaryPopUp(param1.popUpWindowInfo.window,param1.popUpWindowInfo.showModal,param1.popUpWindowInfo.customPosition);
         }
      }
      
      private function showSecondaryPopUp(param1:DisplayObject, param2:Boolean = true, param3:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         view.secondaryPopupLayer.addPopUpWindow(param1);
         if(!param3)
         {
            _loc5_ = int("windowWidth" in param1 ? param1["windowWidth"] : param1.width);
            _loc4_ = int("windowHeight" in param1 ? param1["windowHeight"] : param1.height);
            param1.x = int((contextView.stage.stageWidth - _loc5_) / 2);
            param1.y = int((contextView.stage.stageHeight - _loc4_) / 2);
         }
         view.secondaryPopUpModalLayer.visible ||= param2;
         onShowSecondaryPopUpCompleted(param1);
      }
      
      private function onShowSecondaryPopUpCompleted(param1:DisplayObject) : void
      {
         userInfo.tutorialsInfo.additionalInfo.lastOpenedSecondaryPopup = param1;
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      private function onCloseTopPopUp(param1:MobilePopUpWindowEvent) : void
      {
         if(view.popupLayer.numChildren > 0)
         {
            closePopUp(view.popupLayer.getChildAt(view.popupLayer.numChildren - 1));
         }
      }
      
      private function onClosePopUp(param1:MobilePopUpWindowEvent) : void
      {
         closePopUp(param1.popUpWindowInfo.window);
      }
      
      private function closePopUp(param1:DisplayObject) : void
      {
         if(view.popupLayer.contains(param1))
         {
            onClosePopUpCompleted(param1);
         }
         else
         {
            postProcessClosePopUp();
         }
      }
      
      private function onClosePopUpCompleted(param1:DisplayObject) : void
      {
         if(view.popupLayer.contains(param1))
         {
            view.popupLayer.removeChild(param1);
            userInfo.tutorialsInfo.additionalInfo.lastOpenedPopup = null;
            dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
         }
         postProcessClosePopUp();
      }
      
      private function postProcessClosePopUp() : void
      {
         checkPopUpModalLayer();
         checkPopUpStack();
      }
      
      private function checkPopUpModalLayer() : void
      {
         if(view.popupLayer.numChildren <= 0)
         {
            if(view.popups.length <= 0 || userInfo.delayPopups)
            {
               view.modalLayer.visible = false;
            }
            if(view.secondaryPopupLayer.numChildren <= 0)
            {
               dispatch(new MobilePopUpWindowEvent("allPopUpsClosed",null));
            }
            userInfo.tutorialsInfo.additionalInfo.lastOpenedPopup = null;
         }
         else
         {
            userInfo.tutorialsInfo.additionalInfo.lastOpenedPopup = view.popupLayer.getChildAt(view.popupLayer.numChildren - 1);
         }
      }
      
      private function checkPopUpStack() : void
      {
         if(!userInfo.delayPopups && view.popupLayer.numChildren <= 0 && view.popups.length > 0)
         {
            onShowPopUp(view.popups.shift());
         }
      }
      
      private function onCloseSecondaryPopUp(param1:MobilePopUpWindowEvent) : void
      {
         closeSecondaryPopUp(param1.popUpWindowInfo.window);
      }
      
      private function closeSecondaryPopUp(param1:DisplayObject) : void
      {
         if(view.secondaryPopupLayer.contains(param1))
         {
            onCloseSecondaryPopUpCompleted(param1);
         }
         else
         {
            postProcessCloseSecondaryPopUp();
         }
      }
      
      private function onCloseSecondaryPopUpCompleted(param1:DisplayObject) : void
      {
         if(view.secondaryPopupLayer.contains(param1))
         {
            view.secondaryPopupLayer.removeChild(param1);
         }
         postProcessCloseSecondaryPopUp();
      }
      
      private function postProcessCloseSecondaryPopUp() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < view.secondaryPopupLayer.numChildren)
         {
            _loc1_++;
            _loc2_++;
         }
         if(_loc1_ <= 0)
         {
            view.secondaryPopUpModalLayer.visible = false;
            if(view.popupLayer.numChildren <= 0)
            {
               dispatch(new MobilePopUpWindowEvent("allPopUpsClosed",null));
            }
            userInfo.tutorialsInfo.additionalInfo.lastOpenedSecondaryPopup = null;
         }
         else
         {
            userInfo.tutorialsInfo.additionalInfo.lastOpenedSecondaryPopup = view.secondaryPopupLayer.getChildAt(view.secondaryPopupLayer.numChildren - 1);
         }
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      private function closeAllSecondaryPopUps() : void
      {
         while(view.secondaryPopupLayer.numChildren > 0)
         {
            view.secondaryPopupLayer.removeChildAt(0);
         }
         postProcessCloseSecondaryPopUp();
      }
      
      private function onModalClicked(param1:TouchEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc6_:int = 0;
         var _loc2_:DisplayObject = null;
         var _loc5_:Sprite = null;
         var _loc3_:Touch = param1.getTouch(view.modalLayer,"ended");
         if(_loc3_)
         {
            _loc4_ = false;
            _loc6_ = view.popupLayer.numChildren - 1;
            while(_loc6_ >= 0)
            {
               _loc2_ = view.popupLayer.getChildAt(_loc6_);
               if(!(_loc2_ is MobileFBProgressPopUp) && !(_loc2_ is MobileFBConfirmationPopUp) && !(_loc2_ is MobileGuestNamingPopUp))
               {
                  if(_loc2_ is Sprite)
                  {
                     if(!_loc4_)
                     {
                        _loc4_ = true;
                        _loc5_ = _loc2_ as Sprite;
                        dispatch(new MobilePopUpWindowEvent("notifyClosingWindow",_loc5_));
                     }
                  }
                  else
                  {
                     view.popupLayer.removeChildAt(_loc6_);
                  }
               }
               _loc6_--;
            }
         }
      }
      
      private function onSecondaryModalClicked(param1:TouchEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Sprite = null;
         var _loc2_:Touch = param1.getTouch(view.secondaryPopUpModalLayer,"ended");
         if(_loc2_)
         {
            _loc4_ = view.secondaryPopupLayer.numChildren - 1;
            while(_loc4_ >= 0)
            {
               if(view.secondaryPopupLayer.getChildAt(_loc4_) is Sprite)
               {
                  _loc3_ = view.secondaryPopupLayer.getChildAt(_loc4_) as Sprite;
                  dispatch(new MobilePopUpWindowEvent("notifyClosingSecondaryWindow",_loc3_));
               }
               else
               {
                  view.secondaryPopupLayer.removeChildAt(_loc4_);
               }
               _loc4_--;
            }
         }
      }
      
      private function onCloseContainerOfDisplayObject(param1:MobileCloseContainerOfDisplayObjectEvent) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = null;
         if(view.popupLayer.contains(param1.displayObject))
         {
            _loc2_ = param1.displayObject.parent;
            while(_loc2_ != null && _loc2_ != view.popupLayer)
            {
               _loc3_ = _loc2_.parent;
               if(_loc3_ == view.popupLayer)
               {
                  break;
               }
               _loc2_ = _loc3_;
            }
            if(_loc2_ != null && _loc2_ != view.popupLayer)
            {
               if(param1.checkCloseable)
               {
                  dispatch(new MobilePopUpWindowEvent("notifyClosingCheckCloseableWindow",_loc2_));
               }
               else
               {
                  dispatch(new MobilePopUpWindowEvent("notifyClosingWindow",_loc2_));
               }
            }
         }
      }
      
      private function onAddWindowEnumeration(param1:MobileCloseContainerOfDisplayObjectEvent) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc2_:MobileGenericWindow = null;
         var _loc4_:int = 0;
         if(view.popupLayer.contains(param1.displayObject) && param1.windowEnumerations != null)
         {
            _loc3_ = getParentDisplayObjectContainer(param1.displayObject.parent);
            if(_loc3_ != null && _loc3_ != view.popupLayer && _loc3_ is MobileGenericWindow)
            {
               _loc2_ = _loc3_ as MobileGenericWindow;
               _loc4_ = 0;
               while(_loc4_ < param1.windowEnumerations.length)
               {
                  _loc2_.addWindowEnumeration(param1.windowEnumerations[_loc4_]);
                  _loc4_++;
               }
            }
         }
      }
      
      private function getParentDisplayObjectContainer(param1:DisplayObjectContainer) : DisplayObjectContainer
      {
         var _loc2_:DisplayObjectContainer = null;
         while(param1 != null && param1 != view.popupLayer)
         {
            _loc2_ = param1.parent;
            if(_loc2_ == view.popupLayer)
            {
               break;
            }
            param1 = _loc2_;
         }
         return param1;
      }
      
      private function checkCompletedQuests() : void
      {
         if(userInfo.quests != null)
         {
            for each(var _loc1_ in userInfo.quests)
            {
               if(_loc1_.completed && !_loc1_.claiming)
               {
                  if(userInfo.autoClaimQuests)
                  {
                     dispatch(new OutgoingMessageEvent("outgoingMessage",new ClaimQuestRequest(_loc1_.questId)));
                  }
                  else
                  {
                     _loc1_.claiming = true;
                     dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileQuestCompletedPopup(_loc1_,facebookAPIManager.getUserNameByProfile(userInfo.profile,false))));
                  }
                  return;
               }
            }
         }
      }
      
      private function onNewestPopUpPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         var _loc2_:Point = view.popupLayer.lastAddedWindowPosition;
         if(_loc2_ != null)
         {
            dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,_loc2_));
         }
      }
      
      private function onNewestSecondaryPopUpPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         var _loc2_:Point = view.secondaryPopupLayer.lastAddedWindowPosition;
         if(_loc2_ != null)
         {
            dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,_loc2_));
         }
      }
      
      private function delayPopUps(param1:MobilePopUpWindowEvent) : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"delayPopUps");
         userInfo.delayPopups = true;
         closeAllSecondaryPopUps();
         stackPopUps();
      }
      
      private function showDelayedPopUps(param1:MobilePopUpWindowEvent) : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"showDelayedPopUps");
         userInfo.delayPopups = false;
         checkPopUpStack();
      }
      
      private function stackPopUps() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:MobilePopUpWindowEvent = null;
         while(view.popupLayer.numChildren > 0)
         {
            _loc1_ = view.popupLayer.removeChildAt(0);
            if(!(_loc1_ is MobileGenericWindow) || (_loc1_ as MobileGenericWindow).stackable)
            {
               _loc2_ = new MobilePopUpWindowEvent("showPopUpWindow",_loc1_,0,view.modalLayer.visible,false,false,userInfo.delayPopups);
               view.popups.splice(0,0,_loc2_);
            }
         }
         checkPopUpModalLayer();
      }
      
      private function onConnectionLostProcessed(param1:ClientEvent) : void
      {
         removeContextListener("showPopUpWindow",onShowPopUp,MobilePopUpWindowEvent);
      }
   }
}

