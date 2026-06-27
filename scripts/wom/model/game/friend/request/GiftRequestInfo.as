package wom.model.game.friend.request
{
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.game.Profile;
   
   public class GiftRequestInfo extends RequestInfo
   {
      
      private var _partDIO:PartTypeDIO;
      
      private var _thankYou:Boolean;
      
      private var _resourceGiftBonusPercent:int;
      
      public function GiftRequestInfo(param1:Number, param2:Number, param3:int, param4:Profile, param5:String, param6:PartTypeDIO, param7:Boolean, param8:int)
      {
         super(param1,param2,param3,param4,param5);
         _partDIO = param6;
         _thankYou = param7;
         _resourceGiftBonusPercent = param8;
      }
      
      public function get partDIO() : PartTypeDIO
      {
         return _partDIO;
      }
      
      public function get thankYou() : Boolean
      {
         return _thankYou;
      }
      
      public function get resourceGiftBonusPercent() : int
      {
         return _resourceGiftBonusPercent;
      }
   }
}

