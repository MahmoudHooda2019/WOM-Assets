package wom.controller.command
{
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   import peak.logging.LoggerContexts;
   import peak.logging.ShippingLoggerTarget;
   import peak.logging.log;
   import wom.controller.PCommand;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.ExternalInterfaceEvent;
   import wom.controller.event.MaintenanceEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.mobile.MobileApplicationRaterEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.mobile.MobileInAppPurchaseEvent;
   import wom.controller.event.mobile.MobilePushNotificationsEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.GameTickTimer;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.ABMode;
   import wom.model.game.UserInfo;
   import wom.model.game.WomScreenType;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.friend.FriendInfo;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.game.store.StoreDiscountInfo;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.store.StoreItemCurrencyType;
   import wom.model.message.request.GetNewCaptchaRequest;
   import wom.model.message.request.StatusRequest;
   import wom.model.message.request.UserStatusRequest;
   import wom.model.message.response.AuthResponse;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.service.facebook.FacebookAPIManager;
   import wom.service.kontagent.WomKontagentApi;
   import wom.service.mobile.EncryptedLocalStoreUtil;
   import wom.service.mobile.MobileConnectionService;
   import wom.view.screen.popups.MobileAuthErrorPopup;
   
   public class HandleAuthResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var gameTickTimer:GameTickTimer;
      
      [Inject]
      public var logShipper:ShippingLoggerTarget;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      [Inject]
      public var facebookApiManager:FacebookAPIManager;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var storeInfo:StoreInfo;
      
      [Inject]
      public var mobileConnectionService:MobileConnectionService;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      public function HandleAuthResponseCommand()
      {
         super();
      }
      
      private static function determineABMode(param1:String) : ABMode
      {
         var _loc2_:ABMode = null;
         switch(param1)
         {
            case ABMode.MODE_A.id:
               _loc2_ = ABMode.MODE_A;
               break;
            case ABMode.MODE_B.id:
               _loc2_ = ABMode.MODE_B;
               break;
            default:
               _loc2_ = ABMode.MODE_A;
         }
         return _loc2_;
      }
      
      override public function execute() : void
      {
         var _loc4_:* = undefined;
         var _loc3_:AuthResponse = messageReceivedEvent.message as AuthResponse;
         userInfo.authResponseReceived = true;
         documentConfiguration.setParameter("allianceName",_loc3_.allianceName);
         allianceInfo.allianceSig = _loc3_.allianceSig;
         if(_loc3_.success)
         {
            configureGameTickTimer(_loc3_.serverTime);
            userInfo.serverSpeed = _loc3_.serverSpeed;
            userInfo.loginServerTime = _loc3_.serverTime;
            userInfo.profile = _loc3_.profile;
            dispatch(new ModelUpdateEvent("authenticationCompleted"));
            logShipper.userId = userInfo.profile.gameId;
            mobileConnectionServiceInfo.authenticatedToGameServer = true;
            if(documentConfiguration.hasParameter("manualAuthentication"))
            {
               mobileConnectionService.manualAuthenticateDoNotUse(userInfo.profile.platformId);
            }
            EncryptedLocalStoreUtil.increaseSuccessfulAuth();
            dispatch(new MobilePushNotificationsEvent("setupMobilePushNotificationsService"));
            dispatch(new MobileInAppPurchaseEvent("setupMobileInAppPurchaseService"));
            dispatch(new MobileApplicationRaterEvent("setupMobileApplicationRater"));
            dispatch(new MobileApplicationRaterEvent("significantEvent"));
            dispatch(new MobileExternalInterfaceEvent("getProductsInfo"));
            dispatch(new MobileExternalInterfaceEvent("notifyLoginTrack"));
            dispatch(new MobileExternalInterfaceEvent("inboxCount"));
            dispatch(new MobileExternalInterfaceEvent("notifyAppRating"));
            dispatch(new MobileExternalInterfaceEvent("getBlockedFriends",{
               "type":3,
               "subtype":-1,
               "subsubtype":-1,
               "extra":-1,
               "checkGiftQuota":true
            }));
            for(var _loc1_ in _loc3_.friendIdToExperienceMap)
            {
               for each(var _loc2_ in documentConfiguration.friends)
               {
                  if(_loc2_.profile.gameId == _loc1_)
                  {
                     _loc2_.experiencePoints = _loc3_.friendIdToExperienceMap[_loc1_];
                     break;
                  }
               }
            }
            if("tutorial-funnel-test" in _loc3_.abTestPairs)
            {
               userInfo.abModeTutorial = determineABMode(_loc3_.abTestPairs["tutorial-funnel-test"]);
            }
            checkNewUserKontagentEvents(_loc3_.abTestPairs);
            if(facebookApiManager.getUserNameByProfile(userInfo.profile,false,true) != userInfo.profile.gameId)
            {
               dispatch(new ModelUpdateEvent("platformUsersUpdated"));
            }
            else
            {
               _loc4_ = new Vector.<ProfileIdPair>();
               _loc4_.push(new ProfileIdPair(userInfo.profile.platformId,userInfo.profile.avatar));
               dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc4_));
            }
            dispatch(new ModelUpdateEvent("friendsUpdated"));
            dispatch(new OutgoingMessageEvent("outgoingMessage",new UserStatusRequest()));
            dispatch(new OutgoingMessageEvent("outgoingMessage",new StatusRequest()));
            if(userInfo.currentScreen != WomScreenType.LOADING)
            {
               dispatch(new ActivateScreenEvent("activate",WomScreenType.LOADING));
            }
            if(ExternalInterface.available)
            {
               ExternalInterface.call("gameClient.ready");
            }
            else if(documentConfiguration.hasParameter("paymentInformation"))
            {
               dispatch(new ExternalInterfaceEvent("retrievePaymentInformation",documentConfiguration.getParameter("paymentInformation")));
            }
            dispatch(new TutorialEvent("createTutorials"));
            if(_loc3_.maintenanceTime > 0 && _loc3_.maintenanceMode)
            {
               dispatch(new MaintenanceEvent("maintenance",_loc3_.maintenanceTime,_loc3_.maintenanceMode));
            }
            if(_loc3_.storeDiscountPercentage > 0 && _loc3_.storeDiscountPercentage <= 100 && _loc3_.storeDiscountRemainingDuration > 0)
            {
               storeInfo.discount = new StoreDiscountInfo(StoreItemCurrencyType.GOLD,(100 - _loc3_.storeDiscountPercentage) / 100,_loc3_.storeDiscountRemainingDuration);
               storeInfo.discount.excludedStoreItemIds[1001] = true;
               storeInfo.discount.excludedStoreItemIds[2003] = true;
               storeInfo.discount.excludedStoreItemIds[2004] = true;
               storeInfo.discount.excludedStoreItemIds[2005] = true;
               storeInfo.discount.excludedStoreItemIds[2006] = true;
               storeInfo.discount.excludedStoreItemIds[2007] = true;
               dispatch(new ModelUpdateEvent("storeItemDiscountUpdated"));
            }
         }
         else
         {
            log(LoggerContexts.INFRASTRUCTURE,"Authentication failed!");
            if(_loc3_.resultCode == 3 || _loc3_.resultCode == 9)
            {
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileAuthErrorPopup(_loc3_.resultCode),0,false,null,false,true,true));
            }
            else if(_loc3_.resultCode == 10)
            {
               userInfo.captchaEnabled = true;
               dispatch(new OutgoingMessageEvent("outgoingMessage",new GetNewCaptchaRequest()));
            }
         }
      }
      
      private function configureGameTickTimer(param1:Number) : void
      {
         var _loc2_:Date = new Date();
         gameTickTimer.configure(_loc2_.getTime() - param1);
      }
      
      private function checkNewUserKontagentEvents(param1:Dictionary) : void
      {
         var _loc2_:String = null;
         if(documentConfiguration.newUser)
         {
            for(var _loc3_ in param1)
            {
               _loc2_ = param1[_loc3_];
               kontagentApi.trackCustomEvent(_loc3_ + "-" + _loc2_,{"subtype1":_loc3_},false);
            }
         }
      }
   }
}

