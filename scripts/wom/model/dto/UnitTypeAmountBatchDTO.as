package wom.model.dto
{
   public class UnitTypeAmountBatchDTO
   {
      
      private var _unitTypeAmountDTO:UnitTypeAmountDTO;
      
      private var _amount:int;
      
      public function UnitTypeAmountBatchDTO(param1:UnitTypeAmountDTO, param2:int)
      {
         super();
         _unitTypeAmountDTO = param1;
         _amount = param2;
      }
      
      public function get unitTypeAmountDTO() : UnitTypeAmountDTO
      {
         return _unitTypeAmountDTO;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function set amount(param1:int) : void
      {
         _amount = param1;
      }
   }
}

