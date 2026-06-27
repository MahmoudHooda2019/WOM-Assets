package wom.service.mobile
{
   import org.robotlegs.mvcs.Actor;
   import peak.i18n.PText;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.mobile.MobileAlertDialogsEvent;
   import wom.controller.event.mobile.MobileApplicationEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.mobile.MobileFacebookConnectionEvent;
   import wom.model.game.WomScreenType;
   import wom.model.mobile.MobileAlertDialog;
   import wom.model.mobile.MobileConnectionServiceInfo;
   
   public class MobileConnectionService extends Actor
   {
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      public function MobileConnectionService()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         loadData();
         dispatch(new MobileFacebookConnectionEvent("setup"));
      }
      
      private function loadData() : void
      {
         mobileConnectionServiceInfo.reset();
         mobileConnectionServiceInfo.peakToken = EncryptedLocalStoreUtil.getLocalData("Peak-Token_2");
         mobileConnectionServiceInfo.peakTokenExpires = EncryptedLocalStoreUtil.getTokenExpires("Peak-Token-Expires_2");
         mobileConnectionServiceInfo.loginType = EncryptedLocalStoreUtil.getLocalData("Peak-Last-Login-Type_2");
         mobileConnectionServiceInfo.facebookId = EncryptedLocalStoreUtil.getLocalData("Peak-FB-Id_2");
         mobileConnectionServiceInfo.facebookToken = EncryptedLocalStoreUtil.getLocalData("Peak-FB-Token_2");
         mobileConnectionServiceInfo.mobileUdId = EncryptedLocalStoreUtil.getLocalData("Peak-UDID_2");
         mobileConnectionServiceInfo.languageId = EncryptedLocalStoreUtil.getLocalData("Peak-Language");
         trace("Peak-Token_2",mobileConnectionServiceInfo.peakToken);
         trace("Peak-Token-Expires_2",mobileConnectionServiceInfo.peakTokenExpires);
         trace("Peak-Last-Login-Type_2",mobileConnectionServiceInfo.loginType);
         trace("Peak-Last-Login-Type_2",mobileConnectionServiceInfo.facebookId);
         trace("Peak-Last-Login-Type_2",mobileConnectionServiceInfo.facebookToken);
         trace("Peak-UDID_2",mobileConnectionServiceInfo.mobileUdId);
         trace("Peak-Language",mobileConnectionServiceInfo.languageId);
      }
      
      public function handleStartupConnection() : void
      {
         if(EncryptedLocalStoreUtil.getLocalData("Peak-Is-Dev_2") != null)
         {
            dispatch(new MobileApplicationEvent("activateLoginScreen"));
            return;
         }
         if(mobileConnectionServiceInfo.loginType != null)
         {
            if(mobileConnectionServiceInfo.loginType == "FB" && (!mobileConnectionServiceInfo.facebookId || !mobileConnectionServiceInfo.facebookToken))
            {
               EncryptedLocalStoreUtil.removeAllData();
               dispatch(new MobileApplicationEvent("activateLoginScreen"));
            }
            else
            {
               eventDispatcher.addEventListener("connectionFailed",onAuthanticateFailed);
               eventDispatcher.addEventListener("connectionEstablished",onAuthanticateSucceed);
               var _temp_8:* = §§findproperty(MobileAlertDialogsEvent);
               var _temp_7:* = "showMobileAlertDialog";
               var _temp_6:* = §§findproperty(MobileAlertDialog);
               var _temp_5:* = 2;
               var _temp_4:* = 3;
               var _loc1_:String = "m.ui.popups.loading.title";
               var _temp_3:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
               var _loc2_:String = "m.ui.popups.loading.message";
               dispatch(new MobileAlertDialogsEvent(_temp_7,new MobileAlertDialog(_temp_5,_temp_4,_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,null,false)));
               dispatch(new MobileExternalInterfaceEvent("connectToWebServer"));
            }
         }
         else
         {
            dispatch(new MobileApplicationEvent("activateLoginScreen"));
         }
      }
      
      public function loginWithFacebook() : void
      {
         mobileConnectionServiceInfo.reset();
         EncryptedLocalStoreUtil.removeLocalData("Peak-Is-Dev_2");
         mobileConnectionServiceInfo.loginType = "FB";
         eventDispatcher.addEventListener("connectionEstablished",onFacebookConnectionEstablished);
         eventDispatcher.addEventListener("connectionCancelled",onFacebookConnectionCancelled);
         var _temp_6:* = §§findproperty(MobileAlertDialogsEvent);
         var _temp_5:* = "showMobileAlertDialog";
         var _temp_4:* = §§findproperty(MobileAlertDialog);
         var _temp_3:* = 2;
         var _temp_2:* = 3;
         var _loc1_:String = "m.ui.popups.loading.title";
         var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc2_:String = "m.ui.popups.loading.message";
         dispatch(new MobileAlertDialogsEvent(_temp_5,new MobileAlertDialog(_temp_3,_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,null,false)));
         dispatch(new MobileFacebookConnectionEvent("connectToFacebook"));
      }
      
      private function onFacebookConnectionCancelled(param1:MobileFacebookConnectionEvent) : void
      {
         eventDispatcher.removeEventListener("connectionCancelled",onFacebookConnectionCancelled);
         eventDispatcher.removeEventListener("connectionEstablished",onFacebookConnectionEstablished);
         dispatch(new MobileAlertDialogsEvent("dismissDialog",null,3,2));
      }
      
      private function onFacebookConnectionEstablished(param1:MobileFacebookConnectionEvent) : void
      {
         eventDispatcher.removeEventListener("connectionCancelled",onFacebookConnectionCancelled);
         eventDispatcher.removeEventListener("connectionEstablished",onFacebookConnectionEstablished);
         dispatch(new MobileAlertDialogsEvent("dismissDialog",null,3,2));
         dispatch(new ActivateScreenEvent("activate",WomScreenType.LOADING));
         dispatch(new MobileApplicationEvent("deactivateLoginScreen"));
      }
      
      public function loginAsGuest() : void
      {
         mobileConnectionServiceInfo.reset();
         EncryptedLocalStoreUtil.removeLocalData("Peak-Is-Dev_2");
         mobileConnectionServiceInfo.loginType = "GUEST";
         eventDispatcher.addEventListener("connectionFailed",onAuthanticateFailed);
         eventDispatcher.addEventListener("connectionEstablished",onAuthanticateSucceed);
         var _temp_6:* = §§findproperty(MobileAlertDialogsEvent);
         var _temp_5:* = "showMobileAlertDialog";
         var _temp_4:* = §§findproperty(MobileAlertDialog);
         var _temp_3:* = 2;
         var _temp_2:* = 3;
         var _loc1_:String = "m.ui.popups.loading.title";
         var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc2_:String = "m.ui.popups.loading.message";
         dispatch(new MobileAlertDialogsEvent(_temp_5,new MobileAlertDialog(_temp_3,_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,null,false)));
         dispatch(new MobileExternalInterfaceEvent("connectToWebServer"));
      }
      
      private function onAuthanticateFailed(param1:MobileExternalInterfaceEvent) : void
      {
         eventDispatcher.removeEventListener("connectionFailed",onAuthanticateFailed);
         eventDispatcher.removeEventListener("connectionEstablished",onAuthanticateSucceed);
         dispatch(new MobileAlertDialogsEvent("dismissDialog",null,3,2));
      }
      
      private function onAuthanticateSucceed(param1:MobileExternalInterfaceEvent) : void
      {
         eventDispatcher.removeEventListener("connectionFailed",onAuthanticateFailed);
         eventDispatcher.removeEventListener("connectionEstablished",onAuthanticateSucceed);
         dispatch(new MobileAlertDialogsEvent("dismissDialog",null,3,2));
         dispatch(new ActivateScreenEvent("activate",WomScreenType.LOADING));
         dispatch(new MobileApplicationEvent("deactivateLoginScreen"));
      }
      
      public function manualAuthenticateDoNotUse(param1:String) : void
      {
         EncryptedLocalStoreUtil.setLocalData("Peak-Is-Dev_2","dev");
         mobileConnectionServiceInfo.authenticatedToWeb = true;
         mobileConnectionServiceInfo.loginType = "FB";
         mobileConnectionServiceInfo.facebookId = param1;
         mobileConnectionServiceInfo.facebookToken = "Emulator_Access_Token";
         dispatch(new MobileExternalInterfaceEvent("connectToWebServer"));
      }
   }
}

