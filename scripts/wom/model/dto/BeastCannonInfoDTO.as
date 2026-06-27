package wom.model.dto
{
   public class BeastCannonInfoDTO
   {
      
      private var _ammoAmount:int;
      
      private var _remainingTimeToRecharge:Number;
      
      public function BeastCannonInfoDTO(param1:int, param2:Number)
      {
         super();
         _ammoAmount = param1;
         _remainingTimeToRecharge = param2;
      }
      
      public function get ammoAmount() : int
      {
         return _ammoAmount;
      }
      
      public function get remainingTimeToRecharge() : Number
      {
         return _remainingTimeToRecharge;
      }
      
      public function set ammoAmount(param1:int) : void
      {
         _ammoAmount = param1;
      }
      
      public function set remainingTimeToRecharge(param1:Number) : void
      {
         _remainingTimeToRecharge = param1;
      }
   }
}

