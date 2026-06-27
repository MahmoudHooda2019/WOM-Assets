package wom.controller.event
{
   import flash.events.Event;
   
   public class ExternalInterfaceEvent extends Event
   {
      
      public static const OPEN_INBOX_WINDOW:String = "openInboxWindow";
      
      public static const RETRIEVE_REQUEST_RESPONSE:String = "retrieveRequestResponse";
      
      public static const RETRIEVE_BLOCKED_FRIENDS:String = "retrieveBlockedFriends";
      
      public static const RETRIEVE_PAYMENT_INFORMATION:String = "retrievePaymentInformation";
      
      public static const PAYMENT_INFORMATION_UPDATED:String = "paymentInformationUpdated";
      
      public static const RETRIEVE_SEND_REQUEST_RESPONSE:String = "retrieveSendRequestResponse";
      
      public static const RETRIEVE_INVITE_FRIENDS_RESPONSE:String = "retrieveInviteFriendsResponse";
      
      public static const RETRIEVE_PURCHASE_RESPONSE:String = "retrievePurchaseResponse";
      
      public static const RETRIEVE_ANNOUNCEMENTS_RESPONSE:String = "retrieveAnnouncementsResponse";
      
      public static const TEXT_INPUT_RESPONSE:String = "textInputResponse";
      
      public static const SET_FRIENDS_LIST:String = "setFriendsList";
      
      public static const SET_INVITABLE_FRIENDS:String = "setInvitableFriends";
      
      public static const RESPONSE_ERROR:String = "error";
      
      private var _response:Object;
      
      public function ExternalInterfaceEvent(param1:String, param2:Object)
      {
         super(param1);
         _response = param2;
      }
      
      override public function clone() : Event
      {
         return new ExternalInterfaceEvent(type,_response);
      }
      
      public function get response() : Object
      {
         return _response;
      }
   }
}

