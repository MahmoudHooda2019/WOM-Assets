package wom.model.game.inventory
{
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class InventoryItemUnitDTO extends InventoryItemDTO
   {
      
      private var _unitTypeAmountDTO:UnitTypeAmountDTO;
      
      public function InventoryItemUnitDTO(param1:int, param2:String, param3:int, param4:int, param5:int, param6:ResourceAmountDTO, param7:UnitTypeAmountDTO)
      {
         super(param1,InventoryItemCategory.TAVERN,param2,param3,param4,param5,param6,ResourceQuantityType.DEFAULT);
         _unitTypeAmountDTO = param7;
      }
      
      public function get unitTypeAmountDTO() : UnitTypeAmountDTO
      {
         return _unitTypeAmountDTO;
      }
   }
}

