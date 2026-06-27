package wom.view.screen.windows.store
{
   import peak.util.AlignmentUtil;
   import wom.model.game.store.StoreItemCategory;
   import wom.model.game.store.StoreItemInfo;
   import wom.view.util.PagingPanel;
   
   public class StoreCategoryPanel extends PagingPanel
   {
      
      private static const WIDTH:int = 690;
      
      private static const HEIGHT:int = 412;
      
      private static const VIEWS_PER_ROW:int = 3;
      
      private var items:Vector.<StoreItemInfo>;
      
      private var _itemViewList:Vector.<StoreItemView>;
      
      private var _category:StoreItemCategory;
      
      public function StoreCategoryPanel(param1:StoreItemCategory)
      {
         super(690,412,2,3);
         _category = param1;
         _itemViewList = new Vector.<StoreItemView>();
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
      }
      
      override public function drawLayout() : void
      {
         var _loc1_:StoreItemView = null;
         var _loc2_:StoreItemView = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _itemViewList.length)
         {
            _loc1_ = _itemViewList[_loc3_];
            if(_loc3_ == 0)
            {
               _itemViewList[_loc3_].x = 23;
               _itemViewList[_loc3_].y = 16;
            }
            else if(_loc3_ == _columnCount)
            {
               AlignmentUtil.alignHeightSpecifiedBelowOf(_loc1_,_itemViewList[0],14,_itemViewList[0].visibleHeight);
            }
            else
            {
               AlignmentUtil.alignWidthSpecifiedRightOf(_loc1_,_loc2_,4,_loc2_.visibleWidth);
            }
            _loc2_ = _loc1_;
            _loc3_++;
         }
         super.drawLayout();
      }
      
      private function clearAll() : void
      {
         var _loc1_:int = 0;
         if(_itemViewList != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _itemViewList.length)
            {
               if(contains(_itemViewList[_loc1_]))
               {
                  removeChild(_itemViewList[_loc1_]);
               }
               _loc1_++;
            }
         }
         _itemViewList = new Vector.<StoreItemView>();
      }
      
      public function updateWithItemList(param1:Vector.<StoreItemInfo>, param2:int) : void
      {
         this.items = param1;
         update(param2);
      }
      
      public function update(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:StoreItemView = null;
         _currentPageNumber = param1;
         clearAll();
         var _loc3_:int = itemCountPerPage();
         _loc4_ = _currentPageNumber * _loc3_;
         while(_loc4_ < _currentPageNumber * _loc3_ + _loc3_ && _loc4_ < items.length)
         {
            _loc2_ = new StoreItemView(items[_loc4_] as StoreItemInfo);
            addChild(_loc2_);
            _itemViewList.push(_loc2_);
            _loc4_++;
         }
         setPagingButtonsVisibility(items.length);
         drawLayout();
      }
      
      public function get category() : StoreItemCategory
      {
         return _category;
      }
   }
}

