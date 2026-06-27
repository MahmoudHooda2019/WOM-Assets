package wom.view.screen.windows.inventory
{
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.inventory.InventoryItemUnitDTO;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueMiniButton;
   
   public class UnitInventoryItemView extends InventoryItemView
   {
      
      protected var _useButton:WomButton;
      
      private var _inventoryItemUnitDTO:InventoryItemUnitDTO;
      
      public function UnitInventoryItemView(param1:InventoryItemUnitDTO)
      {
         super(param1);
         _inventoryItemUnitDTO = param1;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = itemNameHeader;
         var _loc1_:String = "domain.units." + _inventoryItemUnitDTO.unitTypeAmountDTO.id + ".name";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         itemNameHeader.height = itemNameHeader.textHeight + 4;
         _useButton = new WomBlueMiniButton();
         var _temp_3:* = _useButton;
         var _loc2_:String = "ui.windows.inventory.use";
         _temp_3.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _useButton.width = 95;
         _useButton.visible = false;
         addChild(_useButton);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         _itemAsset.y -= 5;
         _useButton.visible = true;
         _useButton.y = 102;
         AlignmentUtil.alignMiddleXAxisOf(_useButton,background);
      }
      
      override public function onMouseOver() : void
      {
         var _temp_3:* = itemTooltipTextField;
         var _temp_2:* = "ui.windows.inventory.unittooltip";
         var _temp_1:* = _inventoryItemUnitDTO.unitTypeAmountDTO.amount;
         var _loc1_:String = "domain.units." + _inventoryItemUnitDTO.unitTypeAmountDTO.id + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:int = _temp_1;
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
      
      public function get inventoryItemUnitDTO() : InventoryItemUnitDTO
      {
         return _inventoryItemUnitDTO;
      }
   }
}

