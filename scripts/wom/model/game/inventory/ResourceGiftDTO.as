package wom.model.game.inventory
{
   public class ResourceGiftDTO
   {
      
      private var _id:int;
      
      private var _resourceGiftAmountTypeId:int;
      
      private var _amount:int;
      
      public function ResourceGiftDTO(param1:int, param2:int, param3:int)
      {
         super();
         _id = param1;
         _resourceGiftAmountTypeId = param2;
         _amount = param3;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get resourceGiftAmountTypeId() : int
      {
         return _resourceGiftAmountTypeId;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}

