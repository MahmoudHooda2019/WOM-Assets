package wom.model.game.friend.request
{
   public class MysteryRpRequestInfo extends MysteryGiftRequestInfo
   {
      
      private var _amount:int;
      
      public function MysteryRpRequestInfo(param1:Number, param2:String, param3:int)
      {
         super(param1,14,param2);
         _amount = param3;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}

