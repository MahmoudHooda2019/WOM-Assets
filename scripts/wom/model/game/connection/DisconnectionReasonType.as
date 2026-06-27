package wom.model.game.connection
{
   public class DisconnectionReasonType
   {
      
      public static const INVALID:DisconnectionReasonType = new DisconnectionReasonType(-1,"ui.popups.disconnection.unknown.header","ui.popups.disconnection.unknown.message","ui.popups.disconnection.unknown.button");
      
      public static const UNKNOWN_REASON:DisconnectionReasonType = new DisconnectionReasonType(0,"ui.popups.disconnection.unknown.header","ui.popups.disconnection.unknown.message","ui.popups.disconnection.unknown.button");
      
      public static const IDLE:DisconnectionReasonType = new DisconnectionReasonType(1,"ui.popups.disconnection.idle.header","ui.popups.disconnection.idle.message","ui.popups.disconnection.idle.button");
      
      public static const MULTIPLE_SESSION:DisconnectionReasonType = new DisconnectionReasonType(2,"ui.popups.disconnection.unknown.header","ui.popups.disconnection.unknown.message","ui.popups.disconnection.unknown.button");
      
      public static const INVALID_COMBAT:DisconnectionReasonType = new DisconnectionReasonType(3,"ui.popups.disconnection.unknown.header","ui.popups.disconnection.unknown.message","ui.popups.disconnection.unknown.button");
      
      public static const CAPTCHA_NOT_RECEIVED:DisconnectionReasonType = new DisconnectionReasonType(4,"ui.popups.disconnection.captcha.header","ui.popups.disconnection.captcha.message","ui.popups.disconnection.captcha.button");
      
      public static const ACCOUNT_MERGE:DisconnectionReasonType = new DisconnectionReasonType(5,"","","");
      
      private var _id:int;
      
      private var _headerI18nKey:String;
      
      private var _disconnectionMessageI18nKey:String;
      
      private var _actionI18nKey:String;
      
      public function DisconnectionReasonType(param1:int, param2:String, param3:String, param4:String)
      {
         super();
         _id = param1;
         _headerI18nKey = param2;
         _disconnectionMessageI18nKey = param3;
         _actionI18nKey = param4;
      }
      
      public static function determineDisconnectionReason(param1:int) : DisconnectionReasonType
      {
         var _loc2_:DisconnectionReasonType = UNKNOWN_REASON;
         switch(param1)
         {
            case IDLE._id:
               _loc2_ = IDLE;
               break;
            case CAPTCHA_NOT_RECEIVED._id:
               _loc2_ = CAPTCHA_NOT_RECEIVED;
               break;
            case ACCOUNT_MERGE._id:
               _loc2_ = ACCOUNT_MERGE;
         }
         return _loc2_;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get headerI18nKey() : String
      {
         return _headerI18nKey;
      }
      
      public function get disconnectionMessageI18nKey() : String
      {
         return _disconnectionMessageI18nKey;
      }
      
      public function get actionI18nKey() : String
      {
         return _actionI18nKey;
      }
   }
}

