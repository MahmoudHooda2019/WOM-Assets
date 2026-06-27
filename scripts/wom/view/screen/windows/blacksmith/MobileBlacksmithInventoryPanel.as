package wom.view.screen.windows.blacksmith
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import feathers.layout.TiledColumnsLayout;
   import peak.component.mobile.MPList;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.game.store.EventInventoryItemInfo;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileBlacksmithInventoryPanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 761;
      
      private static const HEIGHT:int = 150;
      
      private var _inventoryItemList:MPList;
      
      private var _blacksmithCurrentLevel:int;
      
      private var _lastModifiedItemIndex:int;
      
      public function MobileBlacksmithInventoryPanel(param1:int)
      {
         super(761,150);
         _lastModifiedItemIndex = param1;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _inventoryItemList = new MPList();
         _inventoryItemList.itemRendererFactory = blacksmithInventoryRendererFactory;
         var _loc1_:TiledColumnsLayout = new TiledColumnsLayout();
         _loc1_.gap = 18;
         _loc1_.useSquareTiles = false;
         _inventoryItemList.x = 22;
         _inventoryItemList.y = -13;
         _inventoryItemList.layout = _loc1_;
         _inventoryItemList.width = 723;
         _inventoryItemList.height = 200;
         _inventoryItemList.horizontalScrollPolicy = "on";
         _inventoryItemList.verticalScrollPolicy = "off";
         addChild(_inventoryItemList);
      }
      
      private function blacksmithInventoryRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileBlacksmithInventoryRenderer = new MobileBlacksmithInventoryRenderer(assetRepository,_blacksmithCurrentLevel);
         _loc1_.width = 100;
         _loc1_.height = 200;
         return _loc1_;
      }
      
      public function fillInventory(param1:Vector.<Object>) : void
      {
         var _loc6_:EventItemDIO = null;
         var _loc4_:EventInventoryItemInfo = null;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         for each(var _loc5_ in param1)
         {
            _loc6_ = _loc5_.itemDIO;
            _loc4_ = _loc5_.itemInfo;
            _loc2_.push({
               "eventItemDIO":_loc6_,
               "eventInventoryItemInfo":_loc4_,
               "index":_loc3_
            });
            _loc3_++;
         }
         while(_loc3_ < 12)
         {
            _loc2_.push({
               "eventItemDIO":null,
               "eventInventoryItemInfo":null,
               "index":_loc3_
            });
            _loc3_++;
         }
         _inventoryItemList.dataProvider = new ListCollection(_loc2_);
         scrollListToIndex(_lastModifiedItemIndex);
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "MobileDarkBackground";
      }
      
      public function get inventoryItemList() : MPList
      {
         return _inventoryItemList;
      }
      
      public function set blacksmithCurrentLevel(param1:int) : void
      {
         _blacksmithCurrentLevel = param1;
      }
      
      public function scrollListToIndex(param1:int) : void
      {
         if(param1 < 6)
         {
            _inventoryItemList.scrollToPosition(0,0,0);
         }
         else
         {
            _inventoryItemList.scrollToPosition(700,0,0);
         }
      }
      
      public function get lastModifiedItemIndex() : int
      {
         return _lastModifiedItemIndex;
      }
      
      public function set lastModifiedItemIndex(param1:int) : void
      {
         _lastModifiedItemIndex = param1;
      }
   }
}

