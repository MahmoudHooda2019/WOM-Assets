package wom.view.screen.windows.blacksmith
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileBlacksmithInventoryRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var _itemData:Object;
      
      private var _slotView:MobileBlacksmithInventorySlotView;
      
      private var _assetRepository:MobileWomAssetRepository;
      
      private var _blacksmithCurrentLevel:int;
      
      public function MobileBlacksmithInventoryRenderer(param1:MobileWomAssetRepository, param2:int)
      {
         super();
         _assetRepository = param1;
         _blacksmithCurrentLevel = param2;
      }
      
      override public function get data() : Object
      {
         return _itemData;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _itemData = param1;
            slotView.updateInfo(_itemData.eventInventoryItemInfo,_itemData.eventItemDIO,_itemData.index);
         }
      }
      
      public function get slotView() : MobileBlacksmithInventorySlotView
      {
         if(!_slotView)
         {
            _slotView = new MobileBlacksmithInventorySlotView(_assetRepository,_blacksmithCurrentLevel);
            addChild(_slotView);
         }
         return _slotView;
      }
   }
}

