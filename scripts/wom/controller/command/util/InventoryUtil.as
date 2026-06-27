package wom.controller.command.util
{
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.DecorationTypeAmountDTO;
   import wom.model.dto.PartInfoDTO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.dto.UnitTypeAmountBatchDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.game.inventory.InventoryItemDecorationDTO;
   import wom.model.game.inventory.InventoryItemPartDTO;
   import wom.model.game.inventory.InventoryItemResourceDTO;
   import wom.model.game.inventory.InventoryItemUnitDTO;
   import wom.model.game.inventory.PartSellPriceCalculationUtil;
   import wom.model.game.inventory.ResourceGiftDTO;
   import wom.model.game.inventory.ResourceQuantityType;
   
   public class InventoryUtil
   {
      
      public function InventoryUtil()
      {
         super();
      }
      
      public static function markNewlyAddedItems(param1:Vector.<InventoryItemDTO>, param2:Vector.<InventoryItemDTO>) : void
      {
         var _loc3_:InventoryItemDTO = null;
         if(param1 && param2)
         {
            for each(var _loc4_ in param2)
            {
               _loc3_ = findItem(param1,_loc4_.id);
               if(!_loc3_ || _loc3_.unseenIndicator || _loc3_.amount < _loc4_.amount)
               {
                  _loc4_.unseenIndicator = true;
               }
            }
         }
      }
      
      public static function findItem(param1:Vector.<InventoryItemDTO>, param2:int) : InventoryItemDTO
      {
         for each(var _loc3_ in param1)
         {
            if(_loc3_.id == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function createItemsList(param1:DomainInfo, param2:CityStatusInfo, param3:Vector.<PartInfoDTO>, param4:Vector.<ResourceGiftDTO>, param5:Vector.<UnitTypeAmountBatchDTO>, param6:Vector.<DecorationTypeAmountDTO>) : Vector.<InventoryItemDTO>
      {
         var _loc10_:PartTypeDIO = null;
         var _loc11_:ResourceAmountDTO = null;
         var _loc7_:UnitTypeDIO = null;
         var _loc12_:DecorationTypeDIO = null;
         var _loc15_:* = null;
         var _loc17_:ResourceQuantityType = null;
         var _loc8_:BuildingTypeDIO = param1.getBuilding(10);
         var _loc13_:Vector.<InventoryItemDTO> = new Vector.<InventoryItemDTO>();
         for each(_loc15_ in param6)
         {
            _loc12_ = param1.getDecoration(_loc15_.id);
            _loc11_ = null;
            if(_loc12_.id == 122 || _loc12_.id == 123 || _loc12_.id == 124)
            {
               _loc13_.push(new InventoryItemDecorationDTO(_loc12_.id,_loc12_.visual,_loc15_.amount,0,0,_loc11_,_loc15_.id,InventoryItemCategory.TAVERN));
            }
         }
         for each(var _loc9_ in param3)
         {
            _loc10_ = param1.getPart(_loc9_.id);
            _loc11_ = param2.buildings == null ? null : PartSellPriceCalculationUtil.calculateSellPrice(_loc10_,param1.getBuilding(10),param2,ResourceQuantityType.DEFAULT);
            _loc13_.push(new InventoryItemPartDTO(_loc9_.id,_loc10_.visual,_loc9_.amount,_loc10_.buyingGoldPrice,_loc10_.buyingGoldPrice,_loc11_,_loc10_.usedInBuildingIds));
         }
         for each(var _loc14_ in param4)
         {
            _loc10_ = param1.getPart(_loc14_.id);
            _loc17_ = ResourceQuantityType.determineResourceQuantityType(_loc14_.resourceGiftAmountTypeId);
            _loc11_ = param2.buildings == null ? null : PartSellPriceCalculationUtil.calculateSellPrice(_loc10_,_loc8_,param2,_loc17_);
            _loc13_.push(new InventoryItemResourceDTO(_loc14_.id,_loc10_.visual,_loc14_.amount,_loc10_.buyingGoldPrice,_loc10_.buyingGoldPrice,_loc11_,_loc17_));
         }
         for each(var _loc16_ in param5)
         {
            _loc7_ = param1.getUnit(_loc16_.unitTypeAmountDTO.id);
            _loc11_ = null;
            _loc13_.push(new InventoryItemUnitDTO(_loc7_.id,_loc7_.assetName + "Portrait",_loc16_.amount,0,0,_loc11_,_loc16_.unitTypeAmountDTO));
         }
         for each(_loc15_ in param6)
         {
            _loc12_ = param1.getDecoration(_loc15_.id);
            _loc11_ = null;
            if(_loc12_.id != 122 && _loc12_.id != 123 && _loc12_.id != 124)
            {
               _loc13_.push(new InventoryItemDecorationDTO(_loc12_.id,_loc12_.visual,_loc15_.amount,0,0,_loc11_,_loc15_.id,InventoryItemCategory.TAVERN));
            }
         }
         return _loc13_;
      }
   }
}

