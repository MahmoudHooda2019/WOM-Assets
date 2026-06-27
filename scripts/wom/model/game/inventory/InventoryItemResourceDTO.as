package wom.model.game.inventory
{
   import wom.model.dto.ResourceAmountDTO;
   
   public class InventoryItemResourceDTO extends InventoryItemDTO
   {
      
      public function InventoryItemResourceDTO(param1:int, param2:String, param3:int, param4:int, param5:int, param6:ResourceAmountDTO, param7:ResourceQuantityType)
      {
         super(param1,determineCategory(param7),param2,param3,param4,param5,param6,param7);
      }
      
      private function determineCategory(param1:ResourceQuantityType) : InventoryItemCategory
      {
         var _loc2_:InventoryItemCategory = InventoryItemCategory.RESOURCE;
         if(param1 == ResourceQuantityType.ONE_PERCENT || param1 == ResourceQuantityType.FOUR_PERCENT)
         {
            _loc2_ = InventoryItemCategory.TAVERN;
         }
         return _loc2_;
      }
   }
}

