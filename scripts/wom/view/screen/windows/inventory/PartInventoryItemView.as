package wom.view.screen.windows.inventory
{
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.inventory.InventoryItemPartDTO;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBrownMiniButton;
   import wom.view.component.button.colored.WomGreenMiniButton;
   
   public class PartInventoryItemView extends InventoryItemView
   {
      
      protected var _sellButton:WomButton;
      
      protected var _sellAllButton:WomButton;
      
      private var _inventoryItemPartDTO:InventoryItemPartDTO;
      
      public function PartInventoryItemView(param1:InventoryItemPartDTO)
      {
         super(param1);
         _inventoryItemPartDTO = param1;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = itemNameHeader;
         var _loc1_:String = "domain.parts." + _inventoryItemPartDTO.id + ".name2";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         itemNameHeader.height = itemNameHeader.textHeight + 4;
         _sellButton = new WomGreenMiniButton();
         var _temp_3:* = _sellButton;
         var _loc2_:String = "ui.windows.inventory.sell";
         _temp_3.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _sellButton.width = 95;
         addChild(_sellButton);
         _sellAllButton = new WomBrownMiniButton();
         var _temp_5:* = _sellAllButton;
         var _loc3_:String = "ui.windows.inventory.recycleall";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _sellAllButton.width = 95;
         addChild(_sellAllButton);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         _sellButton.y = 102;
         AlignmentUtil.alignMiddleXAxisOf(_sellButton,background);
         AlignmentUtil.alignBelowOf(_sellAllButton,_sellButton,1);
      }
      
      override public function onMouseOver() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Vector.<int> = _inventoryItemPartDTO.usedInBuildingIds;
         var _loc1_:String = "";
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc3_];
            var _loc5_:String;
            var _loc6_:String;
            _loc1_ += _loc2_ == -1 ? (_loc5_ = "ui.windows.inventory.worker",peak.i18n.PText.INSTANCE.getText0(_loc5_)) : (_loc6_ = "domain.building." + _loc2_ + ".name",peak.i18n.PText.INSTANCE.getText0(_loc6_));
            if(_loc3_ != _loc4_.length - 1)
            {
               _loc1_ += "/";
            }
            _loc3_++;
         }
         var _temp_4:* = itemTooltipTextField;
         var _temp_3:* = "ui.windows.inventory.parttooltip2";
         var _temp_2:* = _loc1_;
         var _temp_1:* = _inventoryItemPartDTO.sellingPrice.resourceAmount;
         var _loc7_:String = "domain.resource." + _inventoryItemPartDTO.sellingPrice.resourceType + ".name";
         var _loc8_:* = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         var _loc9_:Number = _temp_1;
         var _loc10_:String = _temp_2;
         var _loc11_:String = _temp_3;
         _temp_4.text = peak.i18n.PText.INSTANCE.getText3(_loc11_,_loc10_,_loc9_,_loc8_);
         tooltipBg.visible = bottomPin.visible = itemTooltipTextField.visible = true;
         drawLayout();
      }
      
      override public function onMouseOut() : void
      {
         tooltipBg.visible = bottomPin.visible = itemTooltipTextField.visible = false;
      }
      
      public function get sellButton() : WomButton
      {
         return _sellButton;
      }
      
      public function get sellAllButton() : WomButton
      {
         return _sellAllButton;
      }
   }
}

