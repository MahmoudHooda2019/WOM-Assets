package wom.controller.command.mobile
{
   import com.distriqt.extension.facebookapi.FacebookAPI;
   import com.distriqt.extension.facebookapi.events.FacebookAPIEvent;
   import com.distriqt.extension.facebookapi.objects.FacebookAppRequestParams;
   import com.distriqt.extension.facebookapi.objects.FacebookGraphRequest;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   import org.robotlegs.mvcs.StarlingCommand;
   import peak.i18n.PText;
   import peak.serialization.json.PJSON;
   import peak.util.passParameters2;
   import wom.controller.event.friend.UpdateBlockedFriendsEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.mobile.MobileFacebookConnectionEvent;
   import wom.controller.event.mobile.MobileSharingPermissionsViewEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.Profile;
   import wom.model.game.UserInfo;
   import wom.model.game.friend.request.PartRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.ResourceQuantityType;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.windows.social.MobileSocialMainWindow;
   import wom.view.ui.common.MobileSharingPermissionsView;
   
   public class HandleMobileFacebookConnectionCommand extends StarlingCommand
   {
      
      private static const FB_APP_ID:String = "406229512723084";
      
      public static const DISTRIQT_DEV_KEY:String = "afff548c52ff380e95c77ef2f2807b038d807aebMBnK9NlVorkKCoa3J0c38vqOoYXjIjSoUIjE7iqhokUL4c40tE36oajT7br8Ot7t3kXre/eHV4U9NfbKtX3i3WEkkfS+Es4CwrmREg2ZEJWci1B9tctalqv8rgVewea6AN2yieYUPS4QTrwwaAaimtRmRVlcDITDubvzaw5Ciq48asNBcnkzp/ZUsfCgOHXXW3aSAOzjSWPU6hpUboNBTM/rOADjujyxpxkjOxhurd6F7M64DoXiLU2l/RDRym2/GvUppSmmzc3G0VMeFyzpaRtJo/sywJCh0PIN7O6ETP9tWv3tNE10oHwFDHgYTDYfWERlJoFNh3OjzIbTE5DQaA==";
      
      [Inject]
      public var event:MobileFacebookConnectionEvent;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var facebookApiManager:FacebookAPIManager;
      
      public function HandleMobileFacebookConnectionCommand()
      {
         super();
      }
      
      private static function facebookSendRequestComplete(param1:Object, param2:Object) : Object
      {
         var _loc4_:URLVariables = null;
         var _loc3_:Array = null;
         if(param1 && "request" in param1 && param1["request"])
         {
            _loc4_ = new URLVariables(param1["request"]);
            if("request" in _loc4_ && _loc4_.request != null)
            {
               _loc3_ = [];
               for(var _loc5_ in _loc4_)
               {
                  if(_loc5_.indexOf("to") == 0)
                  {
                     _loc3_.push(_loc4_[_loc5_]);
                  }
               }
               return {
                  "requestId":_loc4_.request,
                  "to":_loc3_
               };
            }
         }
         return null;
      }
      
      override public function execute() : void
      {
         switch(event.type)
         {
            case "setup":
               init();
               break;
            case "connectToFacebook":
               connectToFacebook();
               break;
            case "connectionCancelled":
               mobileConnectionServiceInfo.facebookId = null;
               mobileConnectionServiceInfo.facebookToken = null;
               if(FacebookAPI.isSupported)
               {
                  FacebookAPI.service.closeSession(true);
               }
               break;
            case "sendFacebookRequest":
               fbSendRequest();
               break;
            case "approveRequestOverFacebook":
               approveRequestOverFacebook();
               break;
            case "acceptAndSendRequestOverFacebook":
               acceptAndSendRequestOverFacebook();
               break;
            case "uploadScreenshot":
               uploadScreenshot();
               break;
            case "reauthWithPublishPermissions":
               reauthWithPermission();
               break;
            case "uploadScreenshotWithPermission":
               uploadScreenshotWithPermission();
         }
      }
      
      private function reauthWithPermissionSuccess() : void
      {
         dispatch(new MobileExternalInterfaceEvent("checkWallPostLocalStore"));
         dispatch(new MobileFacebookConnectionEvent("uploadScreenshotWithPermission"));
      }
      
      private function reauthWithPermission() : void
      {
         if(!FacebookAPI.isSupported)
         {
            return;
         }
         FacebookAPI.service.addEventListener("facebookapi:permissions:get:completed",onGetPermissionsCompleted);
         FacebookAPI.service.getCurrentPermissions();
      }
      
      private function onGetPermissionsCompleted(param1:FacebookAPIEvent) : void
      {
         var _loc3_:Dictionary = null;
         var _loc4_:Array = null;
         FacebookAPI.service.removeEventListener("facebookapi:permissions:get:completed",onGetPermissionsCompleted);
         if(param1.data && "permissions" in param1.data && param1.data["permissions"] && param1.data["permissions"] is Array)
         {
            _loc3_ = new Dictionary();
            for each(var _loc2_ in param1.data["permissions"])
            {
               _loc3_[_loc2_["permission"]] = _loc2_["status"];
            }
            _loc4_ = [];
            checkPermission(_loc3_,_loc4_,"public_profile");
            checkPermission(_loc3_,_loc4_,"user_friends");
            checkPermission(_loc3_,_loc4_,"publish_actions");
            if(_loc4_.length > 0)
            {
               FacebookAPI.service.addEventListener("facebookapi:permissions:request:completed",onRequestPermissionsCompleted);
               FacebookAPI.service.requestPermissions(_loc4_,false);
            }
            else
            {
               reauthWithPermissionSuccess();
            }
         }
      }
      
      private function checkPermission(param1:Dictionary, param2:Array, param3:String) : void
      {
         if(!(param3 in param1) || param1[param3] != "granted")
         {
            param2.push(param3);
         }
      }
      
      private function onRequestPermissionsCompleted(param1:FacebookAPIEvent) : void
      {
         FacebookAPI.service.removeEventListener("facebookapi:permissions:request:completed",onRequestPermissionsCompleted);
         reauthWithPermissionSuccess();
      }
      
      private function init() : void
      {
         FacebookAPI.init(DISTRIQT_DEV_KEY);
         if(FacebookAPI.isSupported)
         {
            FacebookAPI.service.initialiseApp(FB_APP_ID);
            FacebookAPI.service.publishInstall(FB_APP_ID);
         }
      }
      
      private function addEventListeners() : void
      {
         FacebookAPI.service.addEventListener("facebookapi:session:open:cancelled",onSessionOpenCancelled);
         FacebookAPI.service.addEventListener("facebookapi:session:open:disabled",onSessionOpenDisabled);
         FacebookAPI.service.addEventListener("facebookapi:session:open:error",onSessionOpenError);
         FacebookAPI.service.addEventListener("facebookapi:session:opened",onSessionOpened);
      }
      
      private function removeEventListeners() : void
      {
         FacebookAPI.service.removeEventListener("facebookapi:session:open:cancelled",onSessionOpenCancelled);
         FacebookAPI.service.removeEventListener("facebookapi:session:open:disabled",onSessionOpenDisabled);
         FacebookAPI.service.removeEventListener("facebookapi:session:open:error",onSessionOpenError);
         FacebookAPI.service.removeEventListener("facebookapi:session:opened",onSessionOpened);
      }
      
      private function connectToFacebook() : void
      {
         if(FacebookAPI.isSupported && !FacebookAPI.service.isSessionOpen())
         {
            addEventListeners();
            FacebookAPI.service.createSession(["public_profile","user_friends"],false,true);
         }
         else
         {
            requestMe();
         }
      }
      
      private function onSessionOpenCancelled(param1:FacebookAPIEvent) : void
      {
         removeEventListeners();
         dispatch(new MobileFacebookConnectionEvent("connectionCancelled"));
      }
      
      private function onSessionOpenDisabled(param1:FacebookAPIEvent) : void
      {
         removeEventListeners();
         dispatch(new MobileFacebookConnectionEvent("connectionCancelled"));
      }
      
      private function onSessionOpenError(param1:FacebookAPIEvent) : void
      {
         removeEventListeners();
         dispatch(new MobileFacebookConnectionEvent("connectionCancelled"));
      }
      
      private function onSessionOpened(param1:FacebookAPIEvent) : void
      {
         removeEventListeners();
         if(param1.data && param1.data.userId && param1.data.accessToken)
         {
            onFacebookConnectionCompleted(param1.data.userId,param1.data.accessToken);
         }
      }
      
      private function requestMe() : void
      {
         FacebookAPI.service.addEventListener("facebookapi:graphrequest:completed",onGraphRequestCompleted);
         FacebookAPI.service.addEventListener("facebookapi:graphrequest:error",onGraphRequestError);
         var _loc1_:FacebookGraphRequest = new FacebookGraphRequest("/me?fields=id");
         _loc1_.method = "GET";
         FacebookAPI.service.graphRequest(_loc1_);
      }
      
      protected function onGraphRequestCompleted(param1:FacebookAPIEvent) : void
      {
         FacebookAPI.service.removeEventListener("facebookapi:graphrequest:completed",onGraphRequestCompleted);
         FacebookAPI.service.removeEventListener("facebookapi:graphrequest:error",onGraphRequestError);
         var _loc2_:String = FacebookAPI.service.getAccessToken();
         if(_loc2_ && param1.data && "id" in param1.data && param1.data["id"])
         {
            onFacebookConnectionCompleted(param1.data["id"],_loc2_);
         }
         else
         {
            dispatch(new MobileFacebookConnectionEvent("connectionCancelled"));
         }
      }
      
      protected function onGraphRequestError(param1:FacebookAPIEvent) : void
      {
         FacebookAPI.service.removeEventListener("facebookapi:graphrequest:completed",onGraphRequestCompleted);
         FacebookAPI.service.removeEventListener("facebookapi:graphrequest:error",onGraphRequestError);
         dispatch(new MobileFacebookConnectionEvent("connectionCancelled"));
      }
      
      private function onFacebookConnectionCompleted(param1:String, param2:String) : void
      {
         dispatch(new MobileFacebookConnectionEvent("connectionEstablished"));
         if(mobileConnectionServiceInfo.authenticatedToGameServer)
         {
            if(mobileConnectionServiceInfo.isConnectedWithFacebook())
            {
               if(mobileConnectionServiceInfo.facebookId == param1)
               {
                  switch(event.type)
                  {
                     case "sendFacebookRequest":
                     case "approveRequestOverFacebook":
                     case "acceptAndSendRequestOverFacebook":
                     case "uploadScreenshot":
                        execute();
                  }
               }
            }
            else
            {
               mobileConnectionServiceInfo.facebookId = param1;
               mobileConnectionServiceInfo.facebookToken = param2;
               dispatch(new MobileExternalInterfaceEvent("notifyFBLogin"));
            }
         }
         else
         {
            mobileConnectionServiceInfo.facebookId = param1;
            mobileConnectionServiceInfo.facebookToken = param2;
            dispatch(new MobileExternalInterfaceEvent("connectToWebServer"));
         }
      }
      
      private function fbSendRequest() : void
      {
         var _loc2_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:String = null;
         var _loc5_:String = null;
         var _loc3_:FacebookAppRequestParams = null;
         if(!FacebookAPI.isSupported)
         {
            return;
         }
         if(FacebookAPI.service.isSessionOpen())
         {
            _loc2_ = [];
            for(var _loc7_ in event.data.toDict)
            {
               _loc2_.push(_loc7_);
            }
            _loc6_ = int(event.data.requestType);
            if(_loc6_ == 4)
            {
               _loc4_ = 0;
               _loc1_ = "Come join me in the fearless battle against my opponents. I\'ll give you some gold to get you started!";
            }
            else
            {
               _loc4_ = int(event.data.subType);
               if(_loc6_ == 1 || _loc6_ == 11)
               {
                  var _loc10_:String = "ui.windows.inbox.requesttype." + _loc6_ + ".title";
                  _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc10_);
               }
               else if(_loc6_ == 2)
               {
                  var _temp_3:* = "ui.windows.inbox.requesttype.2.title.sent";
                  var _loc11_:String = "domain.parts." + _loc4_ + ".name2";
                  var _loc12_:* = peak.i18n.PText.INSTANCE.getText0(_loc11_);
                  var _loc13_:String = _temp_3;
                  _loc1_ = peak.i18n.PText.INSTANCE.getText1(_loc13_,_loc12_);
               }
               else if(_loc6_ == 3)
               {
                  if(InventoryItemCategory.resourceInventoryItems.indexOf(_loc4_) > -1)
                  {
                     var _loc14_:String = ResourceQuantityType.determineResourceQuantityType(userInfo.resourceGiftBonusPercent).i18nKey;
                     _loc5_ = peak.i18n.PText.INSTANCE.getText0(_loc14_);
                     var _temp_5:* = "ui.windows.inbox.requesttype.3.title";
                     var _temp_4:* = "domain.parts." + _loc4_ + ".name2";
                     var _loc15_:String = _loc5_;
                     var _loc16_:String = _temp_4;
                     var _loc17_:* = peak.i18n.PText.INSTANCE.getText1(_loc16_,_loc15_);
                     var _loc18_:String = _temp_5;
                     _loc1_ = peak.i18n.PText.INSTANCE.getText1(_loc18_,_loc17_);
                  }
                  else
                  {
                     var _temp_6:* = "ui.windows.inbox.requesttype.3.title";
                     var _loc19_:String = "domain.parts." + _loc4_ + ".name2";
                     var _loc20_:* = peak.i18n.PText.INSTANCE.getText0(_loc19_);
                     var _loc21_:String = _temp_6;
                     _loc1_ = peak.i18n.PText.INSTANCE.getText1(_loc21_,_loc20_);
                  }
               }
            }
            _loc3_ = new FacebookAppRequestParams();
            _loc3_.app_id = FB_APP_ID;
            _loc3_.message = _loc1_;
            _loc3_.to = _loc2_;
            FacebookAPI.service.openRequestsDialog(_loc3_,passParameters2(onFbSendRequestComplete,_loc6_,event.data.toDict,_loc4_));
         }
         else
         {
            connectToFacebook();
         }
      }
      
      private function updateBlockedFriends(param1:int, param2:Array, param3:Dictionary) : void
      {
         var _loc5_:Object = null;
         var _loc7_:Profile = null;
         var _loc4_:Array = [];
         for each(var _loc6_ in param2)
         {
            if(_loc6_ in param3)
            {
               _loc7_ = param3[_loc6_] as Profile;
               _loc5_ = {"fbid":_loc6_};
               if(_loc7_.gameId)
               {
                  _loc5_.gameid = _loc7_.gameId;
               }
               _loc4_.push(_loc5_);
            }
         }
         dispatch(new UpdateBlockedFriendsEvent("updateBlockedFriends",param1,_loc4_));
      }
      
      private function onFbSendRequestComplete(param1:Object, param2:Object, param3:int, param4:Dictionary, param5:int) : void
      {
         var _loc7_:Object = null;
         var _loc6_:Object = facebookSendRequestComplete(param1,param2);
         if(_loc6_ && _loc6_.to.length > 0)
         {
            _loc7_ = {
               "reqid":_loc6_.requestId,
               "to":_loc6_.to,
               "type":param3,
               "subtype":param5
            };
            if(InventoryItemCategory.resourceInventoryItems.indexOf(param5) > -1)
            {
               _loc7_.extra = userInfo.resourceGiftBonusPercent;
            }
            else
            {
               _loc7_.extra = 0;
            }
            updateBlockedFriends(param3,_loc6_.to,param4);
            dispatch(new MobileExternalInterfaceEvent("sendRequest",_loc7_));
         }
         if(param3 == 3)
         {
            dispatch(new MobilePopUpWindowEvent("closeTopPopUpWindow",null));
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileSocialMainWindow()));
         }
      }
      
      private function approveRequestOverFacebook() : void
      {
         var _loc4_:* = null;
         var _loc2_:Array = null;
         var _loc1_:String = null;
         var _loc3_:FacebookAppRequestParams = null;
         if(!FacebookAPI.isSupported)
         {
            return;
         }
         if(FacebookAPI.service.isSessionOpen())
         {
            _loc2_ = [];
            for each(_loc4_ in event.data.requests)
            {
               if(_loc4_.friendProfile && _loc4_.friendProfile.platformId)
               {
                  _loc2_.push(_loc4_.friendProfile.platformId);
               }
            }
            if(_loc2_.length > 0)
            {
               var _temp_3:* = "ui.windows.inbox.requesttype." + _loc4_.type + ".title." + "approved";
               var _loc7_:String = "domain.parts." + (_loc4_ as PartRequestInfo).partDIO.id + ".name2";
               var _loc8_:* = peak.i18n.PText.INSTANCE.getText0(_loc7_);
               var _loc9_:String = _temp_3;
               _loc1_ = peak.i18n.PText.INSTANCE.getText1(_loc9_,_loc8_);
               _loc3_ = new FacebookAppRequestParams();
               _loc3_.app_id = FB_APP_ID;
               _loc3_.message = _loc1_;
               _loc3_.to = _loc2_;
               FacebookAPI.service.openRequestsDialog(_loc3_);
            }
         }
         else
         {
            connectToFacebook();
         }
      }
      
      private function acceptAndSendRequestOverFacebook() : void
      {
         var _loc5_:* = null;
         var _loc2_:Array = null;
         var _loc4_:Array = null;
         var _loc1_:String = null;
         var _loc3_:FacebookAppRequestParams = null;
         if(!FacebookAPI.isSupported)
         {
            return;
         }
         if(FacebookAPI.service.isSessionOpen())
         {
            _loc2_ = [];
            _loc4_ = [];
            for each(_loc5_ in event.data.requests)
            {
               if(_loc5_.friendProfile && _loc5_.friendProfile.platformId)
               {
                  _loc2_.push(_loc5_.friendProfile.platformId);
               }
               _loc4_.push(_loc5_.id);
            }
            if(_loc2_.length > 0)
            {
               var _loc8_:String = "ui.windows.inbox.requesttype.3.titlethankyou";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc8_);
               _loc3_ = new FacebookAppRequestParams();
               _loc3_.app_id = FB_APP_ID;
               _loc3_.message = _loc1_;
               _loc3_.to = _loc2_;
               FacebookAPI.service.openRequestsDialog(_loc3_,passParameters2(onAcceptAndSendRequestOverFacebookComplete,_loc4_));
            }
         }
         else
         {
            connectToFacebook();
         }
      }
      
      private function onAcceptAndSendRequestOverFacebookComplete(param1:Object, param2:Object, param3:Array) : void
      {
         var _loc5_:Object = null;
         var _loc4_:Object = facebookSendRequestComplete(param1,param2);
         if(_loc4_ && _loc4_.to.length > 0)
         {
            _loc5_ = {
               "reqid":_loc4_.requestId,
               "to":_loc4_.to,
               "ids":param3
            };
            dispatch(new MobileExternalInterfaceEvent("acceptAndSendRequest",_loc5_));
         }
      }
      
      private function uploadScreenshot() : void
      {
         var _loc2_:URLRequest = null;
         var _loc1_:URLLoader = null;
         if(!FacebookAPI.isSupported)
         {
            return;
         }
         if(FacebookAPI.service.isSessionOpen())
         {
            facebookApiManager.screenshotBitmapData = event.data as BitmapData;
            _loc2_ = new URLRequest("https://graph.facebook.com/v2.2/me/permissions/?access_token=" + FacebookAPI.service.getAccessToken());
            _loc2_.method = "GET";
            _loc1_ = new URLLoader(_loc2_);
            _loc1_.addEventListener("complete",isPermissionGrantedComplete);
            _loc1_.addEventListener("ioError",onIOError);
         }
         else
         {
            connectToFacebook();
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         trace(param1.toString());
      }
      
      private function permissionNotGranted() : void
      {
      }
      
      private function isPermissionGrantedComplete(param1:Event) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         if(param1.target.data)
         {
            _loc3_ = PJSON.decode(param1.target.data);
            if(_loc3_.data && _loc3_.data is Array)
            {
               _loc4_ = _loc3_.data as Array;
               for each(var _loc2_ in _loc4_)
               {
                  if(_loc2_.permission == "publish_actions" && _loc2_.status == "granted")
                  {
                     uploadScreenshotWithPermission();
                     return;
                  }
               }
            }
         }
         dispatch(new MobilePopUpWindowEvent("closeTopPopUpWindow",null));
         dispatch(new MobileSharingPermissionsViewEvent("mobileSharingPermissionsViewShow",new MobileSharingPermissionsView()));
      }
      
      private function uploadScreenshotWithPermission() : void
      {
         var _loc1_:FacebookGraphRequest = null;
         if(facebookApiManager.screenshotBitmapData != null)
         {
            _loc1_ = new FacebookGraphRequest("/me/photos");
            _loc1_.method = "POST";
            _loc1_.image = facebookApiManager.screenshotBitmapData;
            FacebookAPI.service.graphRequest(_loc1_);
            facebookApiManager.screenshotBitmapData = null;
         }
      }
   }
}

