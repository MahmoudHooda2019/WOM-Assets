package wom.model.game.inventory
{
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   
   public class InventoryItemDTO
   {
      
      public static const giftItems:Array = [10,14,18,22,26,20,101,102,103,104];
      
      private var _id:int;
      
      private var _category:InventoryItemCategory;
      
      private var _visual:String;
      
      private var _amount:int;
      
      private var _buyingGoldPrice:int;
      
      private var _buyingRPPrice:int;
      
      private var _sellingPrice:ResourceAmountDTO;
      
      private var _resourceGiftBonusQuantity:ResourceQuantityType;
      
      private var _unseenIndicator:Boolean;
      
      public function InventoryItemDTO(param1:int, param2:InventoryItemCategory, param3:String, param4:int, param5:int, param6:int, param7:ResourceAmountDTO, param8:ResourceQuantityType)
      {
         super();
         _id = param1;
         _category = param2;
         _visual = param3;
         _amount = param4;
         _buyingGoldPrice = param5;
         _buyingRPPrice = param6;
         _sellingPrice = param7;
         _resourceGiftBonusQuantity = param8;
         _unseenIndicator = false;
      }
      
      public static function retrieveGifts(param1:DomainInfo, param2:UserInfo, param3:CityStatusInfo) : Vector.<InventoryItemDTO>
      {
         var _loc5_:ResourceAmountDTO = null;
         var _loc7_:ResourceQuantityType = null;
         var _loc6_:Vector.<InventoryItemDTO> = new Vector.<InventoryItemDTO>();
         for each(var _loc4_ in param1.getItems())
         {
            if(giftItems.indexOf(_loc4_.id) > -1)
            {
               if(InventoryItemCategory.resourceInventoryItems.indexOf(_loc4_.id) > -1)
               {
                  _loc7_ = ResourceQuantityType.determineResourceQuantityType(param2.resourceGiftBonusPercent);
                  _loc5_ = PartSellPriceCalculationUtil.calculateSellPrice(_loc4_,param1.getBuilding(10),param3,_loc7_);
                  _loc6_.push(new InventoryItemResourceDTO(_loc4_.id,_loc4_.visual,1,_loc4_.buyingGoldPrice,_loc4_.buyingGoldPrice,_loc5_,_loc7_));
               }
               else
               {
                  _loc5_ = PartSellPriceCalculationUtil.calculateSellPrice(_loc4_,param1.getBuilding(10),param3,ResourceQuantityType.DEFAULT);
                  _loc6_.push(new InventoryItemPartDTO(_loc4_.id,_loc4_.visual,1,_loc4_.buyingGoldPrice,_loc4_.buyingGoldPrice,_loc5_,_loc4_.usedInBuildingIds));
               }
            }
         }
         return _loc6_;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get category() : InventoryItemCategory
      {
         return _category;
      }
      
      public function get visual() : String
      {
         return _visual;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get buyingGoldPrice() : int
      {
         return _buyingGoldPrice;
      }
      
      public function get buyingRPPrice() : int
      {
         return _buyingRPPrice;
      }
      
      public function set sellingPrice(param1:ResourceAmountDTO) : void
      {
         _sellingPrice = param1;
      }
      
      public function get sellingPrice() : ResourceAmountDTO
      {
         return _sellingPrice;
      }
      
      public function get resourceGiftBonusQuantity() : ResourceQuantityType
      {
         return _resourceGiftBonusQuantity;
      }
      
      public function get unseenIndicator() : Boolean
      {
         return _unseenIndicator;
      }
      
      public function set unseenIndicator(param1:Boolean) : void
      {
         _unseenIndicator = param1;
      }
   }
}

