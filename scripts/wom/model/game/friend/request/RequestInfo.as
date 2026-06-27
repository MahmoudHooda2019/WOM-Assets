package wom.model.game.friend.request
{
   import flash.utils.Dictionary;
   import wom.model.game.Profile;
   
   public class RequestInfo
   {
      
      public static const TYPE_STAFF:int = 1;
      
      public static const TYPE_PART:int = 2;
      
      public static const TYPE_GIFT:int = 3;
      
      public static const TYPE_INVITE:int = 4;
      
      public static const TYPE_WALLPOST:int = 5;
      
      public static const TYPE_THANK_YOU_RESOURCE_GIFT:int = 7;
      
      public static const TYPE_REWARD:int = 9;
      
      public static const TYPE_ALLIANCE_INVITE:int = 10;
      
      public static const TYPE_WORKER_STAFF:int = 11;
      
      public static const TYPE_INVITE_FROM_INBOX:int = 12;
      
      public static const TYPE_MYSTERY_GOLD:int = 13;
      
      public static const TYPE_MYSTERY_RP:int = 14;
      
      public static const TYPE_MYSTERY_RESOURCE:int = 15;
      
      public static const STATE_SENT:String = "sent";
      
      public static const STATE_APPROVED:String = "approved";
      
      public static const STATE_ACCEPTED:String = "accepted";
      
      public static const STATE_REJECTED:String = "rejected";
      
      public static const MAX_REQUESTS_AMOUNT_PER_INBOX_ROW:int = 24;
      
      public static const SEE_MORE:int = 20;
      
      private var _id:Number;
      
      private var _reqid:Number;
      
      private var _type:int;
      
      private var _friendProfile:Profile;
      
      private var _state:String;
      
      public function RequestInfo(param1:Number, param2:Number, param3:int, param4:Profile, param5:String)
      {
         super();
         _id = param1;
         _reqid = param2;
         _type = param3;
         _friendProfile = param4;
         _state = param5;
      }
      
      public static function blockableRequestTypes() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         _loc1_[1] = true;
         _loc1_[11] = true;
         _loc1_[2] = true;
         _loc1_[3] = true;
         _loc1_[4] = true;
         _loc1_[5] = true;
         return _loc1_;
      }
      
      public static function sortedRequestTypes() : Array
      {
         return [13,9,10,1,11,2,12,3];
      }
      
      public function get id() : Number
      {
         return _id;
      }
      
      public function get reqid() : Number
      {
         return _reqid;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get friendProfile() : Profile
      {
         return _friendProfile;
      }
      
      public function get state() : String
      {
         return _state;
      }
   }
}

