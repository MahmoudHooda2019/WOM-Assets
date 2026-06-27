package wom.model.game.inventory
{
   import wom.model.dto.ResourceAmountDTO;
   
   public class InventoryItemDecorationDTO extends InventoryItemDTO
   {
      
      private var _decorationId:int;
      
      public function InventoryItemDecorationDTO(param1:int, param2:String, param3:int, param4:int, param5:int, param6:ResourceAmountDTO, param7:int, param8:InventoryItemCategory)
      {
         super(param1,param8,param2,param3,param4,param5,param6,ResourceQuantityType.DEFAULT);
         _decorationId = param7;
      }
      
      public function get decorationId() : int
      {
         return _decorationId;
      }
   }
}

