package wom.model.game.friend.request
{
   import wom.model.game.Profile;
   
   public class RewardRequestInfo extends RequestInfo
   {
      
      public static const SUBTYPE_GOLD:int = 1;
      
      public static const SUBTYPE_RP:int = 2;
      
      private var _subtype:int;
      
      private var _amount:Number;
      
      public function RewardRequestInfo(param1:Number, param2:Number, param3:int, param4:Profile, param5:String, param6:int, param7:Number)
      {
         super(param1,param2,param3,param4,param5);
         _subtype = param6;
         _amount = param7;
      }
      
      public function get subtype() : int
      {
         return _subtype;
      }
      
      public function get amount() : Number
      {
         return _amount;
      }
   }
}

