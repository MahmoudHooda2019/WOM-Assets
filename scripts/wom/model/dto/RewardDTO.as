package wom.model.dto
{
   public class RewardDTO
   {
      
      private var _visualId:String;
      
      private var _amount:int;
      
      private var _textualAmount:String;
      
      public function RewardDTO(param1:int = 0, param2:String = "")
      {
         super();
         _amount = param1;
         _textualAmount = param2;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get textualAmount() : String
      {
         return _textualAmount;
      }
      
      public function get visualId() : String
      {
         return _visualId;
      }
      
      public function set visualId(param1:String) : void
      {
         _visualId = param1;
      }
   }
}

