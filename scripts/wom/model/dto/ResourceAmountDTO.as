package wom.model.dto
{
   public class ResourceAmountDTO
   {
      
      private var _resourceType:int;
      
      private var _resourceAmount:Number;
      
      public function ResourceAmountDTO(param1:int, param2:Number)
      {
         super();
         _resourceType = param1;
         _resourceAmount = param2;
      }
      
      public static function deserialize(param1:Object) : ResourceAmountDTO
      {
         return new ResourceAmountDTO(param1.id,param1.amount);
      }
      
      public function get resourceType() : int
      {
         return _resourceType;
      }
      
      public function get resourceAmount() : Number
      {
         return _resourceAmount;
      }
      
      public function set resourceAmount(param1:Number) : void
      {
         _resourceAmount = param1;
      }
   }
}

