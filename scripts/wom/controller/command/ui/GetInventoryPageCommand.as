package wom.controller.command.ui
{
   import wom.controller.PCommand;
   import wom.controller.event.ui.GetInventoryPageEvent;
   import wom.controller.event.ui.InventoryPageReadyEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.InventoryItemDTO;
   
   public class GetInventoryPageCommand extends PCommand
   {
      
      [Inject]
      public var event:GetInventoryPageEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function GetInventoryPageCommand()
      {
         super();
      }
      
      private static function sortResources(param1:InventoryItemDTO, param2:InventoryItemDTO) : int
      {
         if(param1.id == param2.id)
         {
            if(param1.resourceGiftBonusQuantity.id == param2.resourceGiftBonusQuantity.id)
            {
               return 0;
            }
            if(param1.resourceGiftBonusQuantity.id > param2.resourceGiftBonusQuantity.id)
            {
               return 1;
            }
            return -1;
         }
         if(param1.id > param2.id)
         {
            return 1;
         }
         return -1;
      }
      
      override public function execute() : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = event.pageNumber;
         var _loc2_:InventoryItemCategory = event.category;
         var _loc5_:Vector.<InventoryItemDTO> = getItemsByCategory(_loc2_);
         var _loc1_:int = Math.ceil(_loc5_.length / event.itemCountPerPage);
         var _loc4_:Vector.<*> = new Vector.<*>();
         if(_loc3_ == 2147483647)
         {
            _loc3_ = _loc1_ - 1;
         }
         if(_loc2_.id == InventoryItemCategory.RESOURCE.id)
         {
            _loc5_.sort(sortResources);
         }
         _loc6_ = _loc3_ * event.itemCountPerPage;
         while(_loc6_ < (_loc3_ + 1) * event.itemCountPerPage && _loc6_ < _loc5_.length)
         {
            _loc4_.push(_loc5_[_loc6_]);
            _loc6_++;
         }
         dispatch(new InventoryPageReadyEvent("inventoryPageReady",_loc3_,_loc5_.length,_loc4_,_loc2_));
      }
      
      public function getItemsByCategory(param1:InventoryItemCategory) : Vector.<InventoryItemDTO>
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<InventoryItemDTO> = new Vector.<InventoryItemDTO>();
         _loc3_ = 0;
         while(_loc3_ < userInfo.items.length)
         {
            if(userInfo.items[_loc3_].amount > 0)
            {
               if(userInfo.items[_loc3_].category.id == param1.id || param1.id == InventoryItemCategory.ALL.id)
               {
                  _loc2_.push(userInfo.items[_loc3_]);
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

