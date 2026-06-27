package wom.controller.command.mobile
{
   import com.adobe.crypto.HMAC;
   import com.adobe.crypto.SHA256;
   import com.distriqt.extension.facebookapi.FacebookAPI;
   import com.distriqt.extension.inappbilling.Purchase;
   import com.freshplanet.ane.AirDeviceId;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   import org.robotlegs.mvcs.StarlingCommand;
   import peak.i18n.PText;
   import peak.serialization.json.PJSON;
   import peak.util.Base64;
   import peak.util.passParameters;
   import wom.controller.command.ConnectToGameServerCommand;
   import wom.controller.command.bootstrap.BootstrapFacebookCacheCommand;
   import wom.controller.event.ExternalInterfaceEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.mobile.MobileAlertDialogsEvent;
   import wom.controller.event.mobile.MobileApplicationEvent;
   import wom.controller.event.mobile.MobileContactSupportResponseEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.mobile.MobileInAppPurchaseEvent;
   import wom.controller.event.mobile.MobileSharingPermissionsViewEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.UserNotificationEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.dto.MobileSpecialOfferDTO;
   import wom.model.dto.gold.GoldProductDTO;
   import wom.model.game.Profile;
   import wom.model.game.UserInfo;
   import wom.model.game.friend.DefaultFriendInfo;
   import wom.model.game.friend.FriendInfo;
   import wom.model.game.friend.InboxInfo;
   import wom.model.game.gold.PaymentInfo;
   import wom.model.game.viral.UserNotification;
   import wom.model.game.viral.WallPostParams;
   import wom.model.message.util.CoatOfArmsDeserializeUtil;
   import wom.model.mobile.MobileAlertDialog;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.service.kontagent.WomKontagentApi;
   import wom.service.mobile.EncryptedLocalStoreUtil;
   import wom.service.mobile.MobileApplicationRaterService;
   import wom.service.mobile.MobileExternalPages;
   import wom.util.HasoffersUtil;
   import wom.view.screen.popups.facebook.MobileFBGetGoldPopUp;
   import wom.view.screen.popups.facebook.MobileFBProgressPopUp;
   import wom.view.ui.common.MobileSharingPermissionsView;
   
   public class MobileExternalInterfaceEventCommand extends StarlingCommand
   {
      
      private static const SECRET:String = "PeakRocks2013z0_!";
      
      private static const HANDSHAKE:String = "handshake";
      
      private static const AUTHENTICATE:String = "authenticate";
      
      private static const INBOX_RETRIEVE:String = "inbox/retrieve";
      
      private static const INBOX_ACCEPT:String = "inbox/accept";
      
      private static const INBOX_APPROVE:String = "inbox/approve";
      
      private static const INBOX_REJECT:String = "inbox/reject";
      
      private static const INBOX_SEND:String = "inbox/send";
      
      private static const INBOX_ACCEPT_AND_SEND:String = "inbox/acceptAndSend";
      
      private static const INBOX_COUNT:String = "inbox/count";
      
      private static const GET_BLOCKED_FRIENDS:String = "inbox/getBlockedFriends";
      
      private static const REGISTER_PUSH_NOTIFICATION:String = "notify/updateDeviceToken";
      
      private static const NOTIFY_ANDROID_SUCCESSFULL_PURCHASE:String = "payment/android/validate";
      
      private static const NOTIFY_IOS_SUCCESSFULL_PURCHASE:String = "payment/ios/validate";
      
      private static const GET_PRODUCT_INFOS:String = "payment/information";
      
      private static const SET_LANGUAGE:String = "language/set";
      
      private static const GET_LANGUAGES:String = "language/all";
      
      private static const GET_EXTERNAL_URLs:String = "external/getUrls";
      
      private static const NOTIFY_APPLICATION_RATING:String = "rateApp";
      
      private static const NOTIFY_FB_LOGIN:String = "notify/fbLogin";
      
      private static const NOTIFY_CHOOSE_WEB_ACCOUNT:String = "notify/chooseWebAccount";
      
      private static const NOTIFY_CHOOSE_GUEST_ACCOUNT:String = "notify/chooseMobileAccount";
      
      private static const CONTACT_SUPPORT:String = "contact";
      
      private static const TRACK_LOGIN:String = "trackLogin";
      
      private static const MAKE_WALLPOST:String = "inbox/makeWallPost";
      
      private static const GET_MOBILE_OFFER:String = "offer/get";
      
      private static const GET_ANNOUNCEMENTS:String = "announcement/all";
      
      private static const SET_ANNOUNCEMENT_AS_SEEN:String = "announcement/seen";
      
      private static const UPDATE_CLIENT_SETTINGS:String = "client/updateSettings";
      
      private static const INVALID_HANDSHAKE:int = 1;
      
      private static const MISSING_PLATFORM_INFORMATION:int = 2;
      
      private static const INVALID_PLATFORM_ID:int = 3;
      
      private static const INVALID_OR_EXPIRED_SESSION:int = 4;
      
      private static const UNDER_MAINTENANCE:int = 5;
      
      private static const FAILED_TO_INITIALIZE_SESSION:int = 6;
      
      private static const REQUEST_USER_COUNT_ZERO:int = 7;
      
      private static const NO_SUCH_ANNOUNCEMENT:int = 8;
      
      private static const NO_SUCH_LANGUAGE:int = 9;
      
      private static const MISSING_PARAMETERS:int = 10;
      
      private static const REGISTRATION_FAILED:int = 11;
      
      private static const INVALID_IOS_PAYMENT:int = 12;
      
      private static const INVALID_ANDROID_PAYMENT:int = 13;
      
      private static const SUPPORT_TICKET_FAILED:int = 14;
      
      private static const APPLICATION_ALREADY_RATED:int = 15;
      
      private static const ACCOUNT_MERGE_FAILED:int = 16;
      
      private static const FB_LOGIN_FAILED:int = 17;
      
      public static const END_POINT:String = "https://wom.peakgames.net/";
      
      public static const MOBILE_END_POINT:String = END_POINT + "mobile/";
      
      [Inject]
      public var event:MobileExternalInterfaceEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var mobileExternalPages:MobileExternalPages;
      
      [Inject]
      public var paymentInfo:PaymentInfo;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var inboxInfo:InboxInfo;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      public function MobileExternalInterfaceEventCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         switch(event.type)
         {
            case "connectToWebServer":
               if(mobileConnectionServiceInfo.peakToken && !isPeakTokenExpired())
               {
                  authenticateToWeb();
               }
               else
               {
                  handshake(false);
               }
               break;
            case "acceptRequest":
               acceptRequest(event.data);
               break;
            case "approveRequest":
               approveRequest(event.data);
               break;
            case "getBlockedFriends":
               getBlockedFriends(event.data);
               break;
            case "getExternalURLs":
               getExternalURLs(event.data);
               break;
            case "getProductsInfo":
               getProductsInfo(event.data);
               break;
            case "notifySuccessfullPurchase":
               notifySuccessfullPurchase(event.data);
               break;
            case "rejectRequest":
               rejectRequest(event.data);
               break;
            case "retrieveRequests":
               retrieveRequests(event.data);
               break;
            case "deviceTokenNotification":
               sendDeviceToken(event.data);
               break;
            case "sendRequest":
               sendRequest(event.data);
               break;
            case "acceptAndSendRequest":
               acceptAndSendRequest(event.data);
               break;
            case "setLanguage":
               setLanguage(event.data);
               break;
            case "contactSupport":
               contactSupport(event.data);
               break;
            case "notifyFBLogin":
               notifyFBLogin(event.data);
               break;
            case "notifyChooseAccount":
               notifyChooseAccount(event.data);
               break;
            case "notifyLoginTrack":
               notifyLoginTrack();
               break;
            case "makeWallPost":
               makeWallPost(event.data);
               break;
            case "inboxCount":
               inboxCount();
               break;
            case "checkWallPostLocalStore":
               checkWallPostLocalStore();
               break;
            case "notifyAppRating":
               notifyApplicationRating();
               break;
            case "checkInAppBilling":
               checkInAppPurchaseLocalStore();
               break;
            case "getAnnouncements":
               getAnnouncements();
               break;
            case "setAnnouncementAsSeen":
               setAnnouncementAsSeen(event.data);
               break;
            case "updateClientSettings":
               updateClientSettings(event.data);
         }
      }
      
      private function checkInAppPurchaseLocalStore() : void
      {
         var _loc2_:Object = null;
         var _loc3_:URLVariables = null;
         var _loc1_:String = EncryptedLocalStoreUtil.getLocalData("Peak-In-App-Purchase");
         if(_loc1_)
         {
            _loc2_ = PJSON.decode(_loc1_);
            _loc3_ = new URLVariables();
            _loc3_["token"] = _loc2_.token;
            _loc3_["amount"] = _loc2_.amount;
            _loc3_["currency"] = _loc2_.currency;
            _loc3_["product"] = _loc2_.product;
            _loc3_["receipt"] = _loc2_.receipt;
            postToWebAPI("payment/ios/validate",_loc3_,onNotifySuccessfullPurchaseComplete,null);
            EncryptedLocalStoreUtil.removeLocalData("Peak-In-App-Purchase");
         }
      }
      
      private function setAnnouncementAsSeen(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc2_["id"] = param1;
         postToWebAPI("announcement/seen",_loc2_,null,null);
      }
      
      private function getAnnouncements() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["token"] = mobileConnectionServiceInfo.peakToken;
         postToWebAPI("announcement/all",_loc1_,onGetAnnouncementsComplete,null);
      }
      
      private function onGetAnnouncementsComplete(param1:Object) : void
      {
         if(param1 != null)
         {
            dispatch(new ExternalInterfaceEvent("retrieveAnnouncementsResponse",param1));
         }
      }
      
      private function notifyLoginTrack() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["token"] = mobileConnectionServiceInfo.peakToken;
         postToWebAPI("trackLogin",_loc1_,onNotifyLoginTrack,null);
      }
      
      private function onNotifyLoginTrack(param1:Object) : void
      {
         trace(param1);
      }
      
      private function authenticateToWeb() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["token"] = mobileConnectionServiceInfo.peakToken;
         postToWebAPI("authenticate",_loc1_,onAuthenticateCompleted,null);
      }
      
      private function onAuthenticateCompleted(param1:Object) : void
      {
         mobileConnectionServiceInfo.authenticatedToWeb = true;
         if(mobileConnectionServiceInfo.isConnectedWithFacebook())
         {
            EncryptedLocalStoreUtil.setLocalData("Peak-FB-Id_2",mobileConnectionServiceInfo.facebookId);
            EncryptedLocalStoreUtil.setLocalData("Peak-FB-Token_2",mobileConnectionServiceInfo.facebookToken);
         }
         EncryptedLocalStoreUtil.setLocalData("Peak-Last-Login-Type_2",mobileConnectionServiceInfo.loginType);
         dispatch(new MobileExternalInterfaceEvent("connectionEstablished"));
         connectToGameServer(param1);
      }
      
      private function connectToGameServer(param1:Object) : void
      {
         if(!mobileConnectionServiceInfo.authenticatedToGameServer)
         {
            if(!(documentConfiguration.hasParameter("lang") && documentConfiguration.hasParameter("lang_definitions")))
            {
               throw new Error("THERE IS NO LANGUAGE DEFINITON!!!!!!");
            }
            param1.lang = documentConfiguration.getParameter("lang");
            param1.lang_definitions = documentConfiguration.getParameter("lang_definitions");
            documentConfiguration.parameters = param1;
            documentConfiguration.init();
            commandMap.execute(ConnectToGameServerCommand);
            commandMap.execute(BootstrapFacebookCacheCommand);
         }
         else
         {
            trace("ALREADY LOGGED ON GAME SERVER");
         }
      }
      
      private function handshake(param1:Boolean) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc8_:String = null;
         var _loc3_:int = AirDeviceId.getInstance().isOnIOS ? 1 : 2;
         if(mobileConnectionServiceInfo.isConnectedWithFacebook())
         {
            _loc6_ = mobileConnectionServiceInfo.facebookId;
            _loc7_ = mobileConnectionServiceInfo.facebookToken;
         }
         if(AirDeviceId.getInstance().isOnAndroid)
         {
            _loc8_ = AirDeviceId.getInstance().getID("");
         }
         else
         {
            _loc2_ = AirDeviceId.getInstance().getID("");
            _loc4_ = AirDeviceId.getInstance().getIDFV();
         }
         var _loc5_:String = PJSON.encode({
            "platform":_loc3_,
            "fbid":_loc6_,
            "fb_token":_loc7_,
            "ios_udid":_loc2_,
            "ios_ifv":_loc4_,
            "and_id":_loc8_,
            "mobile_udid":mobileConnectionServiceInfo.mobileUdId
         });
         trace("JSON",_loc5_);
         var _loc10_:String = HMAC.hash("PeakRocks2013z0_!",_loc5_,SHA256);
         var _loc9_:URLVariables = new URLVariables();
         _loc9_["body"] = _loc5_;
         _loc9_["sig"] = _loc10_;
         postToWebAPI("handshake",_loc9_,passParameters(onHandshakeCallCompleted,param1),null);
      }
      
      private function onHandshakeCallCompleted(param1:Object, param2:Boolean) : void
      {
         var _loc3_:MobileExternalInterfaceEvent = null;
         mobileConnectionServiceInfo.peakToken = param1.token;
         EncryptedLocalStoreUtil.setLocalData("Peak-Token_2",mobileConnectionServiceInfo.peakToken);
         mobileConnectionServiceInfo.peakTokenExpires = param1.expires;
         EncryptedLocalStoreUtil.setLocalData("Peak-Token-Expires_2",mobileConnectionServiceInfo.peakTokenExpires);
         if(!EncryptedLocalStoreUtil.getLocalData("Peak-UDID_2"))
         {
            kontagentApi.trackCustomEvent("ApplicationAdded");
         }
         mobileConnectionServiceInfo.mobileUdId = param1.mobile_udid;
         EncryptedLocalStoreUtil.setLocalData("Peak-UDID_2",mobileConnectionServiceInfo.mobileUdId);
         if(param2)
         {
            while(mobileConnectionServiceInfo.invalidWebCalls.length > 0)
            {
               _loc3_ = mobileConnectionServiceInfo.invalidWebCalls.shift();
               dispatch(_loc3_);
            }
         }
         else
         {
            authenticateToWeb();
         }
      }
      
      private function isPeakTokenExpired() : Boolean
      {
         var _loc1_:Number = mobileConnectionServiceInfo.peakTokenExpires;
         if(_loc1_ * 1000 < new Date().getTime())
         {
            return true;
         }
         return false;
      }
      
      private function notifyChooseAccount(param1:Object) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc3_["fbid"] = mobileConnectionServiceInfo.facebookId;
         _loc3_["access_token"] = mobileConnectionServiceInfo.facebookToken;
         var _loc2_:String = param1.isWebSelected ? "notify/chooseWebAccount" : "notify/chooseMobileAccount";
         postToWebAPI(_loc2_,_loc3_,passParameters(onNotifyChooseAccountComplete,param1.isWebSelected),null);
         var _temp_6:* = §§findproperty(MobileAlertDialogsEvent);
         var _temp_5:* = "showMobileAlertDialog";
         var _temp_4:* = §§findproperty(MobileAlertDialog);
         var _temp_3:* = 2;
         var _temp_2:* = 3;
         var _loc4_:String = "m.ui.popups.accountmerge.title";
         var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc5_:String = "m.ui.popups.accountmerge.message";
         dispatch(new MobileAlertDialogsEvent(_temp_5,new MobileAlertDialog(_temp_3,_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc5_),null,null,false)));
      }
      
      private function onNotifyChooseAccountComplete(param1:Object, param2:Boolean) : void
      {
         mobileConnectionServiceInfo.loginType = "FB";
         EncryptedLocalStoreUtil.setLocalData("Peak-FB-Id_2",mobileConnectionServiceInfo.facebookId);
         EncryptedLocalStoreUtil.setLocalData("Peak-FB-Token_2",mobileConnectionServiceInfo.facebookToken);
         EncryptedLocalStoreUtil.setLocalData("Peak-Last-Login-Type_2","FB");
         EncryptedLocalStoreUtil.removeLocalData("Peak-UDID_2");
         EncryptedLocalStoreUtil.removeLocalData("Peak-Token_2");
         EncryptedLocalStoreUtil.removeLocalData("Peak-Token-Expires_2");
         trace("NOTIFY CHOOSE LOGIN AND RESTART");
         dispatch(new MobileAlertDialogsEvent("dismissDialog",null,0,1));
         dispatch(new MobileAlertDialogsEvent("dismissDialog",null,3,2));
         dispatch(new MobileApplicationEvent("restartMobileApplication"));
      }
      
      private function contactSupport(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc2_["category"] = param1.category;
         _loc2_["subject"] = param1.subject;
         _loc2_["body"] = param1.body;
         _loc2_["email"] = param1.email;
         _loc2_["device"] = param1.device;
         postToWebAPI("contact",_loc2_,onContactSupportComplete,null);
      }
      
      private function onContactSupportComplete(param1:Object) : void
      {
         if(param1 != null && param1.success == false)
         {
            dispatch(new MobileContactSupportResponseEvent(1));
         }
         else
         {
            dispatch(new MobileContactSupportResponseEvent(2));
         }
      }
      
      private function notifyFBLogin(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc2_["fbid"] = mobileConnectionServiceInfo.facebookId;
         _loc2_["access_token"] = mobileConnectionServiceInfo.facebookToken;
         postToWebAPI("notify/fbLogin",_loc2_,onNotifyFBLoginComplete,null);
      }
      
      private function onNotifyFBLoginComplete(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Boolean = false;
         if(param1 && param1.levels != null)
         {
            _loc3_ = int(param1.levels.web);
            _loc2_ = int(param1.levels.guest);
            _loc4_ = param1.levels.prefer == "web";
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileFBProgressPopUp(_loc3_,_loc2_,_loc4_)));
         }
         else
         {
            mobileConnectionServiceInfo.loginType = "FB";
            EncryptedLocalStoreUtil.setLocalData("Peak-FB-Id_2",mobileConnectionServiceInfo.facebookId);
            EncryptedLocalStoreUtil.setLocalData("Peak-FB-Token_2",mobileConnectionServiceInfo.facebookToken);
            EncryptedLocalStoreUtil.setLocalData("Peak-Last-Login-Type_2","FB");
            trace("NOTIFY FB LOGIN AND RESTART");
            dispatch(new MobileAlertDialogsEvent("dismissDialog",null,0,1));
            dispatch(new MobileAlertDialogsEvent("dismissDialog",null,3,2));
            dispatch(new MobileApplicationEvent("restartMobileApplication"));
         }
      }
      
      private function extractFriends(param1:Object, param2:Object) : void
      {
         var _loc7_:String = null;
         var _loc6_:FriendInfo = null;
         documentConfiguration.womFriends = new Dictionary();
         var _loc5_:Dictionary = new Dictionary();
         for each(var _loc4_ in param2)
         {
            if(_loc4_.length >= 3)
            {
               _loc6_ = new DefaultFriendInfo(null,new Profile(_loc4_[0],_loc4_[1],null),_loc4_.length >= 3 ? CoatOfArmsDeserializeUtil.createCoatOfArmsInfo(_loc4_[2]) : null);
               documentConfiguration.womFriends[_loc6_.profile.gameId] = _loc6_;
               _loc5_[_loc6_.profile.platformId] = _loc6_;
            }
         }
         documentConfiguration.friends = new Vector.<FriendInfo>();
         for each(var _loc3_ in param1)
         {
            if(isNaN(_loc3_[0]))
            {
               _loc7_ = _loc3_.length >= 2 ? _loc3_[1] : null;
            }
            else
            {
               _loc7_ = _loc3_[0];
            }
            if(_loc7_ in _loc5_)
            {
               _loc6_ = _loc5_[_loc7_];
               _loc6_.name = _loc3_[1];
            }
            else
            {
               _loc6_ = new DefaultFriendInfo(_loc3_[1],new Profile(null,_loc7_,null));
            }
            documentConfiguration.friends.push(_loc6_);
         }
      }
      
      private function acceptRequest(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc2_["ids"] = PJSON.encode(param1["ids"]);
         postToWebAPI("inbox/accept",_loc2_,onAcceptRequestComplete,null);
      }
      
      private function onAcceptRequestComplete(param1:Object) : void
      {
      }
      
      private function approveRequest(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc2_["ids"] = PJSON.encode(param1["ids"]);
         postToWebAPI("inbox/approve",_loc2_,onApproveRequestComplete,null);
      }
      
      private function onApproveRequestComplete(param1:Object) : void
      {
      }
      
      private function getBlockedFriends(param1:Object) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc3_["type"] = param1["type"];
         _loc3_["subtype"] = param1["subtype"];
         var _loc2_:Boolean = "checkGiftQuota" in param1 && param1["checkGiftQuota"];
         postToWebAPI("inbox/getBlockedFriends",_loc3_,passParameters(onGetBlockedFriendsComplete,param1["subsubtype"],param1["extra"],_loc2_),null);
      }
      
      private function onGetBlockedFriendsComplete(param1:Object, param2:int, param3:int, param4:Boolean) : void
      {
         param1.subsubtype = param2;
         param1.extra = param3;
         param1.checkGiftQuota = param4;
         dispatch(new ExternalInterfaceEvent("retrieveBlockedFriends",param1));
      }
      
      private function getExternalURLs(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         postToWebAPI("external/getUrls",_loc2_,onGetExternalURLsComplete,null);
      }
      
      private function onGetExternalURLsComplete(param1:Object) : void
      {
         mobileExternalPages.externalPages = new Dictionary();
         for each(var _loc2_ in param1)
         {
            mobileExternalPages.externalPages[_loc2_.name] = _loc2_.url;
         }
      }
      
      private function getProductsInfo(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         postToWebAPI("payment/information",_loc2_,onProductsInfoReceived,null);
      }
      
      private function onProductsInfoReceived(param1:Object) : void
      {
         var _loc3_:String = null;
         if(param1.packages)
         {
            for each(var _loc2_ in param1.packages)
            {
               _loc3_ = "peakpay_id" in _loc2_ && _loc2_.peakpay_id != null ? _loc2_.peakpay_id : null;
               paymentInfo.goldProducts.push(new GoldProductDTO(_loc2_.name,_loc2_.gold,_loc2_.usd,"$",_loc2_.usd,NaN,_loc3_));
            }
         }
         if(param1.offer)
         {
            userInfo.mobileSpecialOffer = MobileSpecialOfferDTO.deserialize(param1.offer);
         }
         dispatch(new MobileInAppPurchaseEvent("retreiveProductsFromStore"));
      }
      
      private function notifyApplicationRating() : void
      {
         var _loc2_:URLVariables = null;
         var _loc1_:String = EncryptedLocalStoreUtil.getLocalData("Peak-Application-Rater",true);
         if(_loc1_ && _loc1_ == "true" && !MobileApplicationRaterService.RATED)
         {
            MobileApplicationRaterService.RATED = true;
            _loc2_ = new URLVariables();
            _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
            _loc2_["v2"] = true;
            postToWebAPI("rateApp",_loc2_,onNotifyApplicationRatingCOmplete,null);
         }
      }
      
      private function onNotifyApplicationRatingCOmplete(param1:Object) : void
      {
         trace("APPLICATION RATING IS COMPLETED!!!");
      }
      
      private function notifySuccessfullPurchase(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:Purchase = param1.purchase;
         trace("Notify Web Server With Successfull Purchase",_loc3_.productId,_loc3_.developerPayload,_loc3_.signature);
         var _loc4_:URLVariables = new URLVariables();
         _loc4_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc4_["amount"] = param1.amount;
         _loc4_["currency"] = param1.currency;
         _loc4_["product"] = _loc3_.productId;
         if(AirDeviceId.getInstance().isOnIOS)
         {
            _loc2_ = Base64.encode(_loc3_.transactionReceipt);
            _loc4_["receipt"] = _loc2_;
            EncryptedLocalStoreUtil.setLocalData("Peak-In-App-Purchase",PJSON.encode({
               "token":mobileConnectionServiceInfo.peakToken,
               "amount":param1.amount,
               "currency":param1.currency,
               "product":_loc3_.productId,
               "receipt":_loc2_
            }));
            postToWebAPI("payment/ios/validate",_loc4_,onNotifySuccessfullPurchaseComplete,null);
         }
         else if(AirDeviceId.getInstance().isOnAndroid)
         {
            _loc4_["payment"] = _loc3_.originalMessage;
            _loc4_["signature"] = _loc3_.signature;
            postToWebAPI("payment/android/validate",_loc4_,onNotifySuccessfullPurchaseComplete,null);
         }
      }
      
      private function onNotifySuccessfullPurchaseComplete(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc2_:GoldProductDTO = null;
         trace("Successfull Purchase Info Sent");
         EncryptedLocalStoreUtil.removeLocalData("Peak-In-App-Purchase");
         var _loc3_:Purchase = new Purchase(param1.product,param1.amount);
         if(param1.offer == true)
         {
            if(userInfo.mobileSpecialOffer)
            {
               userInfo.mobileSpecialOffer.itemCount--;
               dispatch(new ModelUpdateEvent("mobileSpecialOfferUpdated"));
            }
         }
         _loc4_ = 0;
         while(_loc4_ < paymentInfo.goldProducts.length)
         {
            _loc2_ = paymentInfo.goldProducts[_loc4_];
            if(_loc2_.id == _loc3_.productId)
            {
               kontagentApi.trackRevenue(documentConfiguration.getParameter("kid"),_loc2_.priceUSD * 100);
               break;
            }
            _loc4_++;
         }
         if(param1.first_time == true)
         {
            HasoffersUtil.trackAction("849494704");
         }
         dispatch(new MobileInAppPurchaseEvent("consumePurchase",{"purchase":_loc3_}));
      }
      
      private function rejectRequest(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc2_["ids"] = PJSON.encode(param1["ids"]);
         postToWebAPI("inbox/reject",_loc2_,onRejectRequestComplete,null);
      }
      
      private function onRejectRequestComplete(param1:Object) : void
      {
      }
      
      private function retrieveRequests(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         if("type" in param1)
         {
            _loc2_["type"] = param1["type"];
         }
         if("limit" in param1)
         {
            _loc2_["limit"] = param1["limit"];
         }
         if("offset" in param1)
         {
            _loc2_["offset"] = param1["offset"];
         }
         postToWebAPI("inbox/retrieve",_loc2_,onRetrieveRequestsComplete,null);
      }
      
      private function onRetrieveRequestsComplete(param1:Object) : void
      {
         dispatch(new MobileExternalInterfaceEvent("retrieveRequestResponse",param1));
      }
      
      private function updateClientSettings(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc2_["data"] = param1;
         postToWebAPI("client/updateSettings",_loc2_,onUpdateSettingsComplete,null);
      }
      
      private function onUpdateSettingsComplete(param1:Object) : void
      {
         trace("Update settings complete");
      }
      
      private function sendDeviceToken(param1:Object) : void
      {
         trace("Notify Web Server with Device Token");
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc2_["devicetoken"] = param1["deviceToken"];
         postToWebAPI("notify/updateDeviceToken",_loc2_,onSendDeviceTokenComplete,null);
      }
      
      private function onSendDeviceTokenComplete(param1:Object) : void
      {
         trace("Device Token Sent");
      }
      
      private function sendRequest(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc2_["reqid"] = param1["reqid"];
         _loc2_["to"] = PJSON.encode(param1["to"]);
         _loc2_["type"] = param1["type"];
         _loc2_["subtype"] = param1["subtype"];
         _loc2_["extra"] = param1["extra"];
         postToWebAPI("inbox/send",_loc2_,onSendRequestComplete,null);
      }
      
      private function onSendRequestComplete(param1:Object) : void
      {
         dispatch(new ExternalInterfaceEvent("retrieveSendRequestResponse",param1));
      }
      
      private function acceptAndSendRequest(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc2_["reqid"] = param1["reqid"];
         _loc2_["to"] = PJSON.encode(param1["to"]);
         _loc2_["ids"] = PJSON.encode(param1["ids"]);
         postToWebAPI("inbox/acceptAndSend",_loc2_,onAcceptAndSendRequestComplete,null);
      }
      
      private function onAcceptAndSendRequestComplete(param1:Object) : void
      {
      }
      
      private function setLanguage(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc2_["id"] = param1.webApiId;
         postToWebAPI("language/set",_loc2_,passParameters(onSetLanguageComplete,param1.id),null);
      }
      
      private function onSetLanguageComplete(param1:Object, param2:String) : void
      {
         EncryptedLocalStoreUtil.setLocalData("Peak-Language",param2);
         dispatch(new MobileApplicationEvent("restartMobileApplication"));
      }
      
      private function postToWebAPI(param1:String, param2:URLVariables, param3:Function, param4:Function) : void
      {
         var _loc6_:URLRequest = new URLRequest(MOBILE_END_POINT + param1);
         _loc6_.method = "POST";
         _loc6_.data = param2;
         var _loc5_:URLLoader = new URLLoader(_loc6_);
         if(param3 != null)
         {
            _loc5_.addEventListener("complete",passParameters(externalInterfaceCallHandler,param3));
         }
         _loc5_.addEventListener("ioError",onIOError);
         if(param4 == null)
         {
            param4 = onHttpStatus;
         }
         _loc5_.addEventListener("httpResponseStatus",param4);
      }
      
      private function externalInterfaceCallHandler(param1:Event, param2:Function) : void
      {
         var _loc5_:String = null;
         var _loc3_:String = null;
         var _loc4_:Object = PJSON.decode(param1.target.data);
         if(_loc4_.success == true)
         {
            param2(_loc4_.data);
         }
         else
         {
            switch(_loc4_.data.errorCode)
            {
               case 4:
                  trace();
                  mobileConnectionServiceInfo.invalidWebCalls.push(this.event);
                  handshake(true);
                  break;
               case 17:
                  trace("FB CONNECT on GUEST MODE FAILED!!!!",_loc4_.data.errorReason);
                  mobileConnectionServiceInfo.facebookId = null;
                  mobileConnectionServiceInfo.facebookToken = null;
               case 14:
                  dispatch(new MobileContactSupportResponseEvent(1));
                  break;
               case 5:
                  _loc5_ = "";
                  var _loc6_:String = "m.ui.popups.maintenance.messagenew";
                  var _loc7_:String;
                  _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc6_) == "[notext]" ? "WoM is currently under maintanence, please try again later." : (_loc7_ = "m.ui.popups.maintenance.messagenew",peak.i18n.PText.INSTANCE.getText0(_loc7_));
                  dispatch(new MobileAlertDialogsEvent("dismissDialog",null,3,2));
                  var _temp_8:* = §§findproperty(MobileAlertDialogsEvent);
                  var _temp_7:* = "showMobileAlertDialog";
                  var _temp_6:* = §§findproperty(MobileAlertDialog);
                  var _temp_5:* = 1;
                  var _temp_4:* = 0;
                  var _temp_3:* = _loc5_;
                  var _temp_2:* = _loc3_;
                  var _loc8_:String = "m.ui.popups.disconnect.reload";
                  dispatch(new MobileAlertDialogsEvent(_temp_7,new MobileAlertDialog(_temp_5,_temp_4,_temp_3,_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc8_),null,false)));
                  break;
               case 16:
                  trace("MERGE FAILED!!!!");
                  mobileConnectionServiceInfo.facebookId = null;
                  mobileConnectionServiceInfo.facebookToken = null;
            }
            trace("ERRORR",_loc4_.data.errorReason);
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         trace("IO ERROR OCCURED",param1.toString());
      }
      
      private function onHttpStatus(param1:HTTPStatusEvent) : void
      {
         trace("status",param1.toString());
      }
      
      private function makeWallPost(param1:Object) : void
      {
         var _loc2_:WallPostParams = param1 as WallPostParams;
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["token"] = mobileConnectionServiceInfo.peakToken;
         _loc3_["id"] = _loc2_.id;
         if(_loc2_.p1)
         {
            _loc3_["p1"] = _loc2_.p1;
         }
         if(_loc2_.p2)
         {
            _loc3_["p2"] = _loc2_.p2;
         }
         if(_loc2_.p3)
         {
            _loc3_["p3"] = _loc2_.p3;
         }
         if(!mobileConnectionServiceInfo.isConnectedWithFacebook())
         {
            saveWallPost(_loc2_);
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFBGetGoldPopUp()));
            return;
         }
         isPermissionGranted(_loc3_,_loc2_);
      }
      
      private function isPermissionGranted(param1:URLVariables, param2:WallPostParams) : void
      {
         var _loc4_:URLRequest = new URLRequest("https://graph.facebook.com/v2.2/me/permissions/?access_token=" + FacebookAPI.service.getAccessToken());
         _loc4_.method = "GET";
         var _loc3_:URLLoader = new URLLoader(_loc4_);
         _loc3_.addEventListener("complete",passParameters(isPermissionGrantedComplete,param1,param2));
         _loc3_.addEventListener("ioError",onIOError);
      }
      
      private function isPermissionGrantedComplete(param1:Event, param2:URLVariables, param3:WallPostParams) : void
      {
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         if(param1.target.data)
         {
            _loc5_ = PJSON.decode(param1.target.data);
            if(_loc5_.data && _loc5_.data is Array)
            {
               _loc6_ = _loc5_.data as Array;
               for each(var _loc4_ in _loc6_)
               {
                  if(_loc4_.permission == "publish_actions" && _loc4_.status == "granted")
                  {
                     postToWebAPI("inbox/makeWallPost",param2,passParameters(onMakeWallPostComplete,param2),null);
                     return;
                  }
               }
            }
         }
         saveWallPost(param3);
         dispatch(new MobileSharingPermissionsViewEvent("mobileSharingPermissionsViewShow",new MobileSharingPermissionsView()));
      }
      
      private function saveWallPost(param1:WallPostParams) : void
      {
         var _loc3_:Array = null;
         var _loc2_:String = EncryptedLocalStoreUtil.getLocalData("Peak-FB-Wallpost");
         if(_loc2_)
         {
            _loc3_ = PJSON.decode(_loc2_);
         }
         else
         {
            _loc3_ = [];
         }
         _loc3_.push(param1);
         EncryptedLocalStoreUtil.setLocalData("Peak-FB-Wallpost",PJSON.encode(_loc3_));
      }
      
      private function onMakeWallPostComplete(param1:Object, param2:URLVariables) : void
      {
         var _loc4_:PartTypeDIO = null;
         var _loc3_:String = null;
         if(param1 && param1 != null && param1 != "error")
         {
            switch(param2["id"])
            {
               case 12:
               case 16:
                  if("p1" in param2 && param2["p1"] != null)
                  {
                     _loc4_ = domainInfo.getPart(param2["p1"]);
                     if(_loc4_ != null)
                     {
                        _loc3_ = _loc4_.visual;
                        var _temp_10:* = §§findproperty(UserNotificationEvent);
                        var _temp_9:* = "userNotificationEventShow";
                        var _temp_8:* = §§findproperty(UserNotification);
                        var _temp_7:* = 5;
                        var _temp_6:* = 0;
                        var _temp_5:* = _loc3_;
                        var _loc5_:String = "ui.notification.askformore";
                        dispatch(new UserNotificationEvent(_temp_9,new UserNotification(_temp_7,_temp_6,_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc5_))));
                     }
                  }
            }
         }
      }
      
      private function checkWallPostLocalStore() : void
      {
         var _loc3_:Array = null;
         var _loc2_:Object = null;
         var _loc4_:WallPostParams = null;
         var _loc1_:String = EncryptedLocalStoreUtil.getLocalData("Peak-FB-Wallpost");
         if(_loc1_)
         {
            _loc3_ = PJSON.decode(_loc1_);
            while(_loc3_.length > 0)
            {
               _loc2_ = _loc3_.pop();
               _loc4_ = new WallPostParams(_loc2_.id,_loc2_.p1,_loc2_.p2,_loc2_.p3);
               makeWallPost(_loc4_);
            }
            EncryptedLocalStoreUtil.removeLocalData("Peak-FB-Wallpost");
         }
      }
      
      private function inboxCount() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["token"] = mobileConnectionServiceInfo.peakToken;
         postToWebAPI("inbox/count",_loc1_,onInboxCountComplete,null);
      }
      
      private function onInboxCountComplete(param1:Object) : void
      {
         if(param1 && "total" in param1 && param1["total"] != null)
         {
            inboxInfo.addFromWeb = param1["total"];
            dispatch(new ModelUpdateEvent("inboxCountUpdated"));
         }
      }
   }
}

