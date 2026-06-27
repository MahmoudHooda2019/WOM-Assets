package wom.view.screen.windows.store
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import feathers.layout.TiledColumnsLayout;
   import peak.component.mobile.MPList;
   import starling.display.Sprite;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.store.StoreItemCategory;
   import wom.model.game.store.StoreItemInfo;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileStoreCategoryPanel extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      [Inject]
      public var storeInfo:StoreInfo;
      
      private var _category:StoreItemCategory;
      
      private var _itemsData:Vector.<Object> = new Vector.<Object>();
      
      private var _itemList:MPList;
      
      private var _initialized:Boolean = false;
      
      private var _panelWidth:int;
      
      private var _panelHeight:int;
      
      private var _instanceId:int;
      
      public function MobileStoreCategoryPanel(param1:StoreItemCategory, param2:int, param3:int, param4:int)
      {
         super();
         _category = param1;
         _panelWidth = param2;
         _panelHeight = param3;
         _instanceId = param4;
      }
      
      public function get category() : StoreItemCategory
      {
         return _category;
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
         _itemList.y = 60;
      }
      
      private function storeItemRenderer() : IListItemRenderer
      {
         var _loc1_:MobileStoreItemRenderer = new MobileStoreItemRenderer(assetRepository,storeInfo);
         _loc1_.width = 280;
         _loc1_.height = 251;
         return _loc1_;
      }
      
      public function updateWithItemList(param1:Vector.<StoreItemInfo>, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         if(_itemsData != null)
         {
            _itemsData.length = 0;
         }
         _itemsData = new Vector.<Object>();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _itemsData.push({
               "storeItemInfo":param1[_loc3_],
               "showStoreItemView":true
            });
            _loc3_++;
         }
         if(param2 && visible)
         {
            initItemListDataProvider();
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1 && _itemList)
         {
            _initialized = true;
            initItemListDataProvider();
         }
         super.visible = param1;
      }
      
      private function initItemListDataProvider() : void
      {
         if(_itemList)
         {
            _itemList.dataProvider = new ListCollection(_itemsData);
            _itemList.validate();
         }
      }
      
      public function get initialized() : Boolean
      {
         return _initialized;
      }
      
      public function set initialized(param1:Boolean) : void
      {
         _initialized = param1;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get itemList() : MPList
      {
         return _itemList;
      }
      
      public function get itemsData() : Vector.<Object>
      {
         return _itemsData;
      }
   }
}

