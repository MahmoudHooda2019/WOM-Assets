package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobileExternalInterfaceEvent extends Event
   {
      
      public static const CONNECT_TO_WEB_SERVER:String = "connectToWebServer";
      
      public static const WEB_SEND_REQUEST:String = "sendRequest";
      
      public static const WEB_ACCEPT_REQUEST:String = "acceptRequest";
      
      public static const WEB_RETRIEVE_REQUESTS:String = "retrieveRequests";
      
      public static const WEB_APPROVE_REQUEST:String = "approveRequest";
      
      public static const WEB_REJECT_REQUEST:String = "rejectRequest";
      
      public static const WEB_GET_BLOCKED_FRIENDS:String = "getBlockedFriends";
      
      public static const WEB_SEND_DEVICE_TOKEN:String = "deviceTokenNotification";
      
      public static const WEB_GET_PRODUCTS_INFO:String = "getProductsInfo";
      
      public static const WEB_NOTIFY_SUCCESSFULL_PURCHASE:String = "notifySuccessfullPurchase";
      
      public static const WEB_SET_LANGUAGE:String = "setLanguage";
      
      public static const WEB_GET_LANGUAGES:String = "getLanguages";
      
      public static const WEB_GET_EXTERNAL_URLs:String = "getExternalURLs";
      
      public static const WEB_NOTIFY_FB_LOGIN:String = "notifyFBLogin";
      
      public static const WEB_CONTACT_SUPPORT:String = "contactSupport";
      
      public static const WEB_NOTIFY_CHOOSE_ACCOUNT:String = "notifyChooseAccount";
      
      public static const WEB_LOGIN_TRACK:String = "notifyLoginTrack";
      
      public static const WEB_MAKE_WALLPOST:String = "makeWallPost";
      
      public static const WEB_INBOX_COUNT:String = "inboxCount";
      
      public static const WEB_GET_ANNOUNCEMENTS:String = "getAnnouncements";
      
      public static const WEB_SET_ANNOUNCEMENT_AS_SEEN:String = "setAnnouncementAsSeen";
      
      public static const WEB_UPDATE_CLIENT_SETTINGS:String = "updateClientSettings";
      
      public static const NOTIFY_APPLICATION_RATING:String = "notifyAppRating";
      
      public static const CHECK_IN_APP_PURCHASE_LOCAL_STORE:String = "checkInAppBilling";
      
      public static const RETRIEVE_REQUEST_RESPONSE:String = "retrieveRequestResponse";
      
      public static const ACCEPT_AND_SEND_REQUEST:String = "acceptAndSendRequest";
      
      public static const CHECK_WALLPOST_LOCAL_STORE:String = "checkWallPostLocalStore";
      
      public static const RETRIEVE_INVITABLE_FRIENDS:String = "retrieveInvitableFriends";
      
      public static const RETRIEVE_FRIENDS:String = "retrieveFriends";
      
      public static const WEB_CONNECTION_ESTABLISHED:String = "connectionEstablished";
      
      public static const WEB_CONNECTION_FAILED:String = "connectionFailed";
      
      private var _data:Object;
      
      public function MobileExternalInterfaceEvent(param1:String, param2:Object = null)
      {
         super(param1);
         _data = param2;
      }
      
      override public function clone() : Event
      {
         return new MobileExternalInterfaceEvent(type,_data);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

