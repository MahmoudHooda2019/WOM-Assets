package wom.view.screen.windows.store
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.game.inventory.InventoryItemDecorationDTO;
   import wom.model.game.inventory.InventoryItemPartDTO;
   import wom.model.game.inventory.InventoryItemResourceDTO;
   import wom.model.game.inventory.InventoryItemUnitDTO;
   import wom.model.game.inventory.ResourceQuantityType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileInventoryItemView extends Sprite
   {
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var itemNameTF:MPTextField;
      
      private var itemCountTF:MPTextField;
      
      private var itemAsset:DisplayObject;
      
      private var _hintButton:MPRigidButton;
      
      private var _inventoryItem:InventoryItemDTO;
      
      private var _useButton:MobileWomButton;
      
      private var _useAllButton:MobileWomButton;
      
      private var _sellButton:MobileWomButton;
      
      private var _sellAllButton:MobileWomButton;
      
      public function MobileInventoryItemView(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         initLayout();
      }
      
      private function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileBeigeBackground");
         background.width = 260;
         background.height = 216;
         addChild(background);
         itemNameTF = new MobileCaptionTextField();
         itemNameTF.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
         itemNameTF.width = 260;
         addChild(itemNameTF);
         itemCountTF = new MobileWomTextField();
         itemCountTF.width = 50;
         itemCountTF.textRendererProperties.textFormat = getWomTextFormat(21,"center");
         addChild(itemCountTF);
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _hintButton.addEventListener("triggered",onHintButtonClicked);
         addChild(_hintButton);
         _useButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Small");
         var _temp_6:* = _useButton;
         var _loc1_:String = "ui.windows.inventory.use";
         _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _useButton.width = 88;
         addChild(_useButton);
         _useAllButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Small");
         var _temp_8:* = _useAllButton;
         var _loc2_:String = "ui.windows.inventory.useall";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _useAllButton.width = 123;
         addChild(_useAllButton);
         _sellButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Small");
         var _temp_10:* = _sellButton;
         var _loc3_:String = "ui.windows.inventory.sell";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _sellButton.width = 88;
         addChild(_sellButton);
         _sellAllButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Small");
         var _temp_12:* = _sellAllButton;
         var _loc4_:String = "ui.windows.inventory.recycleall";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _sellAllButton.width = 123;
         addChild(_sellAllButton);
      }
      
      public function updateInventoryItem(param1:InventoryItemDTO) : void
      {
         var _loc3_:InventoryItemUnitDTO = null;
         var _loc5_:InventoryItemDecorationDTO = null;
         var _loc4_:InventoryItemPartDTO = null;
         var _loc2_:InventoryItemResourceDTO = null;
         _inventoryItem = param1;
         if(itemAsset != null && contains(itemAsset))
         {
            removeChild(itemAsset);
         }
         itemCountTF.text = _inventoryItem.amount + "/20";
         if(isUnitItem)
         {
            _loc3_ = InventoryItemUnitDTO(_inventoryItem);
            var _temp_3:* = itemNameTF;
            var _loc6_:String = "domain.units." + _loc3_.unitTypeAmountDTO.id + ".name";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         }
         else if(isDecorationItem)
         {
            _loc5_ = InventoryItemDecorationDTO(_inventoryItem);
            var _temp_4:* = itemNameTF;
            var _loc7_:String = "domain.decoration." + _loc5_.decorationId + ".name";
            _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         }
         else if(isPartItem)
         {
            _loc4_ = InventoryItemPartDTO(_inventoryItem);
            var _temp_5:* = itemNameTF;
            var _loc8_:String = "domain.parts." + _loc4_.id + ".name2";
            _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         }
         else if(isResourceItem)
         {
            _loc2_ = InventoryItemResourceDTO(_inventoryItem);
            if(_loc2_.resourceGiftBonusQuantity == ResourceQuantityType.ONE_PERCENT || _loc2_.resourceGiftBonusQuantity == ResourceQuantityType.FOUR_PERCENT)
            {
               var _temp_8:* = itemNameTF;
               var _temp_7:* = _loc2_.resourceGiftBonusQuantity.i18nKey;
               var _loc9_:String = "domain.resource." + _loc2_.sellingPrice.resourceType + ".name";
               var _loc10_:* = peak.i18n.PText.INSTANCE.getText0(_loc9_);
               var _loc11_:String = _temp_7;
               _temp_8.text = peak.i18n.PText.INSTANCE.getText1(_loc11_,_loc10_);
            }
            else
            {
               var _temp_10:* = itemNameTF;
               var _temp_9:* = "domain.parts." + _loc2_.id + ".name2";
               var _loc12_:String = _loc2_.resourceGiftBonusQuantity.i18nKey;
               var _loc13_:* = peak.i18n.PText.INSTANCE.getText0(_loc12_);
               var _loc14_:String = _temp_9;
               _temp_10.text = peak.i18n.PText.INSTANCE.getText1(_loc14_,_loc13_);
            }
         }
         itemAsset = assetRepository.getDisplayObject(_inventoryItem.visual);
         addChild(itemAsset);
         _useButton.visible = isDecorationItem || isResourceItem || isUnitItem;
         _useAllButton.visible = isResourceItem;
         _sellButton.visible = _sellAllButton.visible = isPartItem;
         _useButton.isEnabled = true;
         _useAllButton.isEnabled = true;
         _sellButton.isEnabled = true;
         _sellAllButton.isEnabled = true;
         drawLayout();
      }
      
      public function get isResourceItem() : Boolean
      {
         return _inventoryItem is InventoryItemResourceDTO;
      }
      
      public function get resourceItem() : InventoryItemResourceDTO
      {
         return InventoryItemResourceDTO(_inventoryItem);
      }
      
      public function get isPartItem() : Boolean
      {
         return _inventoryItem is InventoryItemPartDTO;
      }
      
      public function get partItem() : InventoryItemPartDTO
      {
         return InventoryItemPartDTO(_inventoryItem);
      }
      
      public function get isDecorationItem() : Boolean
      {
         return _inventoryItem is InventoryItemDecorationDTO;
      }
      
      public function get decorationItem() : InventoryItemDecorationDTO
      {
         return InventoryItemDecorationDTO(_inventoryItem);
      }
      
      public function get isUnitItem() : Boolean
      {
         return _inventoryItem is InventoryItemUnitDTO;
      }
      
      public function get unitItem() : InventoryItemUnitDTO
      {
         return InventoryItemUnitDTO(_inventoryItem);
      }
      
      public function get isTournamentItem() : Boolean
      {
         return _inventoryItem.id == 122 || _inventoryItem.id == 123 || _inventoryItem.id == 124;
      }
      
      public function drawLayout() : void
      {
         background.y = 10;
         itemAsset.x = (background.width - itemAsset.width) / 2;
         itemAsset.y = background.y + (background.height - itemAsset.height) / 2;
         if(isTournamentItem)
         {
            itemAsset.x += 28;
            itemAsset.y += 3;
         }
         itemCountTF.validate();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(itemCountTF,background,20);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,background,234,-10);
         var _loc1_:int = _useAllButton.visible ? 22 : 92;
         MobileAlignmentUtil.alignAccordingToPositionOf(_useButton,background,_loc1_,187);
         MobileAlignmentUtil.alignRightOf(_useAllButton,_useButton,7);
         MobileAlignmentUtil.alignAccordingToPositionOf(_sellButton,background,22,187);
         MobileAlignmentUtil.alignRightOf(_sellAllButton,_sellButton,7);
      }
      
      private function onHintButtonClicked(param1:Event) : void
      {
         (this.parent as MobileInventoryItemRenderer).onHintButtonClicked();
      }
      
      public function get useButton() : MobileWomButton
      {
         return _useButton;
      }
      
      public function get useAllButton() : MobileWomButton
      {
         return _useAllButton;
      }
      
      public function get sellButton() : MobileWomButton
      {
         return _sellButton;
      }
      
      public function get inventoryItem() : InventoryItemDTO
      {
         return _inventoryItem;
      }
      
      public function get sellAllButton() : MobileWomButton
      {
         return _sellAllButton;
      }
   }
}

