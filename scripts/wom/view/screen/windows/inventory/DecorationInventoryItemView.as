package wom.view.screen.windows.inventory
{
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.inventory.InventoryItemDecorationDTO;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueMiniButton;
   
   public class DecorationInventoryItemView extends InventoryItemView
   {
      
      protected var _useButton:WomButton;
      
      private var _inventoryItemDecorationDTO:InventoryItemDecorationDTO;
      
      public function DecorationInventoryItemView(param1:InventoryItemDecorationDTO)
      {
         super(param1);
         _inventoryItemDecorationDTO = param1;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = itemNameHeader;
         var _loc1_:String = "domain.decoration." + _inventoryItemDecorationDTO.decorationId + ".name";
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
         _useButton.visible = true;
         _useButton.y = 102;
         AlignmentUtil.alignMiddleXAxisOf(_useButton,background);
      }
      
      override public function onMouseOver() : void
      {
         var _temp_2:* = itemTooltipTextField;
         var _temp_1:* = "ui.windows.inventory.decorationtooltip";
         var _loc1_:String = "domain.decoration." + _inventoryItemDecorationDTO.decorationId + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
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
      
      public function get inventoryItemDecorationDTO() : InventoryItemDecorationDTO
      {
         return _inventoryItemDecorationDTO;
      }
   }
}

