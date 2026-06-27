package wom.view.screen.windows.inventory
{
   import flash.display.DisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.InventoryItemDecorationDTO;
   import wom.model.game.inventory.InventoryItemPartDTO;
   import wom.model.game.inventory.InventoryItemResourceDTO;
   import wom.model.game.inventory.InventoryItemUnitDTO;
   import wom.view.util.PagingPanel;
   
   public class InventoryCategoryPanel extends PagingPanel
   {
      
      private static const WIDTH:int = 690;
      
      private static const HEIGHT:int = 412;
      
      private static const VIEWS_PER_ROW:int = 5;
      
      private var _category:InventoryItemCategory;
      
      private var _itemViewList:Vector.<InventoryItemView>;
      
      public function InventoryCategoryPanel(param1:InventoryItemCategory)
      {
         super(690,412,2,5);
         _category = param1;
         _itemViewList = new Vector.<InventoryItemView>();
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
      }
      
      public function updateWithItemList(param1:Vector.<*>, param2:int) : void
      {
         var _loc3_:int = 0;
         _currentPageNumber = param2;
         clearAll();
         _loc3_ = 0;
         while(_loc3_ < itemCountPerPage() && _loc3_ < param1.length)
         {
            createAndAddItemView(param1[_loc3_]);
            _loc3_++;
         }
         drawLayout();
      }
      
      private function createAndAddItemView(param1:*) : void
      {
         var _loc2_:InventoryItemView = null;
         if(param1 is InventoryItemResourceDTO)
         {
            _loc2_ = new ResourceInventoryItemView(param1 as InventoryItemResourceDTO);
         }
         else if(param1 is InventoryItemPartDTO)
         {
            _loc2_ = new PartInventoryItemView(param1 as InventoryItemPartDTO);
         }
         else if(param1 is InventoryItemUnitDTO)
         {
            _loc2_ = new UnitInventoryItemView(param1 as InventoryItemUnitDTO);
         }
         else if(param1 is InventoryItemDecorationDTO)
         {
            _loc2_ = new DecorationInventoryItemView(param1 as InventoryItemDecorationDTO);
         }
         if(_loc2_)
         {
            addChild(_loc2_);
            _itemViewList.push(_loc2_);
         }
      }
      
      private function clearAll() : void
      {
         var _loc1_:int = 0;
         if(_itemViewList != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _itemViewList.length && _loc1_ < itemCountPerPage())
            {
               if(contains(_itemViewList[_loc1_]))
               {
                  removeChild(_itemViewList[_loc1_]);
               }
               _loc1_++;
            }
         }
         _itemViewList = new Vector.<InventoryItemView>();
      }
      
      override public function drawLayout() : void
      {
         var _loc1_:InventoryItemView = null;
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         super.drawLayout();
         _loc3_ = 0;
         while(_loc3_ < _itemViewList.length)
         {
            _loc1_ = _itemViewList[_loc3_];
            if(_loc3_ == 0)
            {
               _itemViewList[_loc3_].x = 20;
               _itemViewList[_loc3_].y = 35;
            }
            else if(_loc3_ == 5)
            {
               AlignmentUtil.alignBelowOf(_loc1_,_itemViewList[0],28);
            }
            else
            {
               AlignmentUtil.alignRightOf(_loc1_,_loc2_,10);
            }
            _loc2_ = _loc1_;
            _loc3_++;
         }
      }
      
      public function get category() : InventoryItemCategory
      {
         return _category;
      }
      
      public function get itemViewList() : Vector.<InventoryItemView>
      {
         return _itemViewList;
      }
   }
}

