package wom.view.screen.windows.inventory
{
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.inventory.InventoryItemResourceDTO;
   import wom.model.game.inventory.ResourceQuantityType;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueMiniButton;
   import wom.view.component.button.colored.WomBrownMiniButton;
   
   public class ResourceInventoryItemView extends InventoryItemView
   {
      
      private var _useButton:WomButton;
      
      private var _useAllButton:WomButton;
      
      private var _inventoryItemResourceDTO:InventoryItemResourceDTO;
      
      public function ResourceInventoryItemView(param1:InventoryItemResourceDTO)
      {
         super(param1);
         _inventoryItemResourceDTO = param1;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         if(_inventoryItemResourceDTO && _inventoryItemResourceDTO.resourceGiftBonusQuantity == ResourceQuantityType.ONE_PERCENT || _inventoryItemResourceDTO.resourceGiftBonusQuantity == ResourceQuantityType.FOUR_PERCENT)
         {
            var _temp_4:* = itemNameHeader;
            var _temp_3:* = _inventoryItemResourceDTO.resourceGiftBonusQuantity.i18nKey;
            var _loc1_:String = "domain.resource." + _inventoryItemResourceDTO.sellingPrice.resourceType + ".name";
            var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
            var _loc3_:String = _temp_3;
            _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         }
         else
         {
            var _temp_6:* = itemNameHeader;
            var _temp_5:* = "domain.parts." + _inventoryItemResourceDTO.id + ".name2";
            var _loc4_:String = _inventoryItemResourceDTO.resourceGiftBonusQuantity.i18nKey;
            var _loc5_:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
            var _loc6_:String = _temp_5;
            _temp_6.text = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
         }
         itemNameHeader.height = itemNameHeader.textHeight + 4;
         _useButton = new WomBlueMiniButton();
         var _temp_8:* = _useButton;
         var _loc7_:String = "ui.windows.inventory.use";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _useButton.width = 95;
         addChild(_useButton);
         _useAllButton = new WomBrownMiniButton();
         var _temp_10:* = _useAllButton;
         var _loc8_:String = "ui.windows.inventory.useall";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         _useAllButton.width = 95;
         addChild(_useAllButton);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         _useButton.y = 102;
         AlignmentUtil.alignMiddleXAxisOf(_useButton,background);
         AlignmentUtil.alignBelowOf(_useAllButton,_useButton,1);
      }
      
      override public function onMouseOver() : void
      {
         var _temp_3:* = itemTooltipTextField;
         var _temp_2:* = "ui.windows.inventory.resourcetooltip";
         var _temp_1:* = _inventoryItemResourceDTO.sellingPrice.resourceAmount;
         var _loc1_:String = "domain.resource." + _inventoryItemResourceDTO.sellingPrice.resourceType + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:Number = _temp_1;
         var _loc4_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText2(_loc4_,_loc3_,_loc2_);
         tooltipBg.visible = bottomPin.visible = itemTooltipTextField.visible = true;
         drawLayout();
      }
      
      override public function onMouseOut() : void
      {
         tooltipBg.visible = bottomPin.visible = itemTooltipTextField.visible = false;
      }
      
      public function get useButton() : WomButton
      {
         return _useButton;
      }
      
      public function get useAllButton() : WomButton
      {
         return _useAllButton;
      }
   }
}

