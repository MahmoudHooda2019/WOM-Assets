package wom.view.screen.windows.gift.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileGiftItemViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      public static const WIDTH:int = 192;
      
      public static const HEIGHT:int = 149;
      
      private var _inventoryItemDTO:InventoryItemDTO;
      
      private var _assetRepository:MobileWomAssetRepository;
      
      private var _background:DisplayObject;
      
      private var _itemAsset:DisplayObject;
      
      private var _itemNameHeader:MPTextField;
      
      public function MobileGiftItemViewRenderer(param1:MobileWomAssetRepository)
      {
         super();
         _assetRepository = param1;
         _background = param1.getDisplayObject("MobileBeigeBackground");
         _background.width = 192;
         _background.height = 149;
         addChild(_background);
         _itemNameHeader = new MobileCaptionTextField();
         _itemNameHeader.textRendererProperties.textFormat = getCaptionTextFormat(23,"center");
         _itemNameHeader.textRendererProperties.wordWrap = true;
         _itemNameHeader.width = 192;
         addChild(_itemNameHeader);
         drawLayout();
      }
      
      override public function get data() : Object
      {
         return _inventoryItemDTO;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _inventoryItemDTO = param1 as InventoryItemDTO;
            if(_itemAsset && contains(_itemAsset))
            {
               removeChild(_itemAsset);
            }
            _itemAsset = _assetRepository.getDisplayObject(_inventoryItemDTO.visual);
            addChildAt(_itemAsset,1);
            if(_inventoryItemDTO.category == InventoryItemCategory.RESOURCE)
            {
               var _temp_5:* = _itemNameHeader;
               var _temp_4:* = "domain.parts." + _inventoryItemDTO.id + ".name2";
               var _loc2_:String = _inventoryItemDTO.resourceGiftBonusQuantity.i18nKey;
               var _loc3_:* = peak.i18n.PText.INSTANCE.getText0(_loc2_);
               var _loc4_:String = _temp_4;
               _temp_5.text = peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_);
            }
            else
            {
               var _temp_6:* = _itemNameHeader;
               var _loc5_:String = "domain.parts." + _inventoryItemDTO.id + ".name2";
               _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            }
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _itemNameHeader.y = int(-_itemNameHeader.height / 2);
         if(_itemAsset)
         {
            MobileAlignmentUtil.alignMiddleOf(_itemAsset,_background);
         }
      }
      
      public function get inventoryItemDTO() : InventoryItemDTO
      {
         return _inventoryItemDTO;
      }
   }
}

