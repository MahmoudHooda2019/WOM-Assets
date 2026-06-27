package wom.model.game.friend.request
{
   public class MysteryGoldRequestInfo extends MysteryGiftRequestInfo
   {
      
      private var _amount:int;
      
      public function MysteryGoldRequestInfo(param1:Number, param2:String, param3:int)
      {
         super(param1,13,param2);
         _amount = param3;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}

