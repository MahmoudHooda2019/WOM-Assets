package wom.service.mobile
{
   import com.distriqt.extension.pushnotifications.PushNotifications;
   import com.distriqt.extension.pushnotifications.events.PushNotificationEvent;
   import org.robotlegs.mvcs.Actor;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.mobile.MobileConnectionServiceInfo;
   
   public class MobilePushNotificationsService extends Actor
   {
      
      private static const TAG:String = "ANE-SERVICE";
      
      public static const DEV_KEY:String = "284b1f2c9cd3a119b43c7da3b6f30e76ca840e92FUtVhD2TalB5zYStgu5sDitsv/fpZG8BU91/U8kcE5qWeMkNoJ4a+hoSH5Gf36kkY0obOvPc5NXnU0tbE15bWg==";
      
      public static const GCM_SENDER_ID:String = "402490198999";
      
      private static var INITIALIZED:Boolean = false;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      public function MobilePushNotificationsService()
      {
         super();
      }
      
      public function init() : void
      {
         if(INITIALIZED)
         {
            return;
         }
         INITIALIZED = true;
         PushNotifications.init("284b1f2c9cd3a119b43c7da3b6f30e76ca840e92FUtVhD2TalB5zYStgu5sDitsv/fpZG8BU91/U8kcE5qWeMkNoJ4a+hoSH5Gf36kkY0obOvPc5NXnU0tbE15bWg==");
         trace("PN Supported: " + String(PushNotifications.isSupported));
         trace("PN Version: " + PushNotifications.service.version);
         PushNotifications.service.addEventListener("pushnotifications:notification",onPushNotificationReceived);
         PushNotifications.service.addEventListener("pushnotifications:register:success",onRegisterSuccess);
         PushNotifications.service.addEventListener("pushnotifications:unregistered",onUnregisterSuccess);
         PushNotifications.service.addEventListener("pushnotifications:error",onNotificationError);
         PushNotifications.service.register("402490198999");
      }
      
      private function onRegisterSuccess(param1:PushNotificationEvent) : void
      {
         trace("ANE-SERVICE","PushNotification registration succeeded with reg ID:" + param1.data);
         var _loc2_:String = PushNotifications.service.getDeviceToken();
         notifyServerWithDeviceToken(_loc2_);
      }
      
      private function onUnregisterSuccess(param1:PushNotificationEvent) : void
      {
         trace("ANE-SERVICE","PushNotification unregistration succeeded with reg ID:",param1.data);
      }
      
      private function onPushNotificationReceived(param1:PushNotificationEvent) : void
      {
         trace("ANE-SERVICE","Remote Push Notification received!",param1.data);
      }
      
      private function onNotificationError(param1:PushNotificationEvent) : void
      {
         trace("ANE-SERVICE","Push Notification ERROR" + param1.data);
      }
      
      private function notifyServerWithDeviceToken(param1:String) : void
      {
         dispatch(new MobileExternalInterfaceEvent("deviceTokenNotification",{"deviceToken":param1}));
      }
   }
}

