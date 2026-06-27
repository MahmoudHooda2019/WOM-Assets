package wom.view.screen.windows.store
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import feathers.layout.TiledColumnsLayout;
   import peak.component.mobile.MPList;
   import starling.display.Sprite;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileInventoryCategoryPanel extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _category:InventoryItemCategory;
      
      private var _itemList:MPList;
      
      private var _items:Vector.<*>;
      
      private var _initialized:Boolean = false;
      
      private var _panelWidth:int;
      
      private var _panelHeight:int;
      
      public function MobileInventoryCategoryPanel(param1:InventoryItemCategory, param2:int, param3:int)
      {
         super();
         _category = param1;
         _panelWidth = param2;
         _panelHeight = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:TiledColumnsLayout = new TiledColumnsLayout();
         _loc1_.useSquareTiles = false;
         _loc1_.tileHorizontalAlign = "left";
         _itemList = new MPList();
         _itemList.layout = _loc1_;
         _itemList.itemRendererFactory = storeItemRenderer;
         _itemList.width = _panelWidth;
         _itemList.height = _panelHeight;
         _itemList.horizontalScrollPolicy = "on";
         _itemList.verticalScrollPolicy = "off";
         addChild(_itemList);
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         _itemList.x = 26;
         _itemList.y = 70;
      }
      
      private function storeItemRenderer() : IListItemRenderer
      {
         var _loc1_:MobileInventoryItemRenderer = new MobileInventoryItemRenderer(assetRepository);
         _loc1_.width = 280;
         _loc1_.height = 241;
         return _loc1_;
      }
      
      public function updateWithItemList(param1:Vector.<*>, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         if(_items != null)
         {
            _items.length = 0;
         }
         _items = new Vector.<*>();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _items.push(param1[_loc3_]);
            _loc3_++;
         }
         if(param2 && visible)
         {
            initItemListDataProvider();
         }
      }
      
      public function get category() : InventoryItemCategory
      {
         return _category;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1 && !_initialized && _itemList)
         {
            _initialized = true;
            initItemListDataProvider();
         }
         super.visible = param1;
      }
      
      private function initItemListDataProvider() : void
      {
         _itemList.dataProvider = new ListCollection(_items);
         _itemList.validate();
      }
      
      public function get itemList() : MPList
      {
         return _itemList;
      }
   }
}

