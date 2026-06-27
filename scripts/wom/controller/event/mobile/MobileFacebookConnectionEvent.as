package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobileFacebookConnectionEvent extends Event
   {
      
      public static const SETUP:String = "setup";
      
      public static const CONNECT_TO_FACEBOOK:String = "connectToFacebook";
      
      public static const CONNECTION_CANCELLED:String = "connectionCancelled";
      
      public static const CONNECTION_ESTABLISHED:String = "connectionEstablished";
      
      public static const SEND_FACEBOOK_REQUEST:String = "sendFacebookRequest";
      
      public static const APPROVE_REQUEST_OVER_FACEBOOK:String = "approveRequestOverFacebook";
      
      public static const ACCEPT_AND_SEND_REQUEST_OVER_FACEBOOK:String = "acceptAndSendRequestOverFacebook";
      
      public static const UPLOAD_SCREENSHOT:String = "uploadScreenshot";
      
      public static const REAUTH_WITH_PUBLISH_PERMISSIONS:String = "reauthWithPublishPermissions";
      
      public static const UPLOAD_SCREENSHOT_WITH_PERMISSION:String = "uploadScreenshotWithPermission";
      
      private var _data:Object;
      
      public function MobileFacebookConnectionEvent(param1:String, param2:Object = null)
      {
         super(param1);
         _data = param2;
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

