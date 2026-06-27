package wom.model.dto
{
   public class UnitTypeAmountDTO
   {
      
      private var _id:int;
      
      private var _amount:int;
      
      public function UnitTypeAmountDTO(param1:int, param2:int)
      {
         super();
         _id = param1;
         _amount = param2;
      }
      
      public static function deserialize(param1:Object) : UnitTypeAmountDTO
      {
         return new UnitTypeAmountDTO(param1.id,param1.amount);
      }
      
      public function get id() : int
      {
         return _id;
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

