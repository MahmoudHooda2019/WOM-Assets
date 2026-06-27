package wom.view.screen.windows.store
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileInventoryItemRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _iventoryItemView:MobileInventoryItemView;
      
      private var inventoryItemInfoView:MobileInventoryItemInfoView;
      
      private var _inventoryItem:InventoryItemDTO;
      
      private var isItemVisible:Boolean = true;
      
      public function MobileInventoryItemRenderer(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         _iventoryItemView = new MobileInventoryItemView(param1);
         inventoryItemInfoView = new MobileInventoryItemInfoView(param1);
         addChild(_iventoryItemView);
         addChild(inventoryItemInfoView);
      }
      
      override public function get data() : Object
      {
         return _inventoryItem;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _inventoryItem = param1 as InventoryItemDTO;
            _iventoryItemView.updateInventoryItem(_inventoryItem);
            inventoryItemInfoView.updateInventoryItem(_inventoryItem);
            toggleViews();
         }
      }
      
      public function onHintButtonClicked() : void
      {
         isItemVisible = !isItemVisible;
         toggleViews();
      }
      
      private function toggleViews() : void
      {
         _iventoryItemView.visible = isItemVisible;
         inventoryItemInfoView.visible = !isItemVisible;
      }
      
      public function get iventoryItemView() : MobileInventoryItemView
      {
         return _iventoryItemView;
      }
      
      public function get inventoryItem() : InventoryItemDTO
      {
         return _inventoryItem;
      }
   }
}

