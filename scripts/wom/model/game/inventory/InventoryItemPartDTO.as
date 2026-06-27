package wom.model.game.inventory
{
   import wom.model.dto.ResourceAmountDTO;
   
   public class InventoryItemPartDTO extends InventoryItemDTO
   {
      
      private var _usedInBuildingIds:Vector.<int>;
      
      public function InventoryItemPartDTO(param1:int, param2:String, param3:int, param4:int, param5:int, param6:ResourceAmountDTO, param7:Vector.<int>)
      {
         super(param1,InventoryItemCategory.PARTS,param2,param3,param4,param5,param6,ResourceQuantityType.DEFAULT);
         _usedInBuildingIds = param7;
      }
      
      public function get usedInBuildingIds() : Vector.<int>
      {
         return _usedInBuildingIds;
      }
   }
}

