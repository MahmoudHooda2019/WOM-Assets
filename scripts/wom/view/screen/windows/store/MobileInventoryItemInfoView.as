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
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getWomTextFormat;
   
   public class MobileInventoryItemInfoView extends Sprite
   {
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _inventoryItem:InventoryItemDTO;
      
      private var background:DisplayObject;
      
      private var descriptionTextField:MPTextField;
      
      private var _hintButton:MPRigidButton;
      
      public function MobileInventoryItemInfoView(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileBeigeBackground");
         background.width = 260;
         background.height = 216;
         background.y = 11;
         addChild(background);
         descriptionTextField = new MobileWomTextField();
         descriptionTextField.width = 180;
         descriptionTextField.textRendererProperties.textFormat = getWomTextFormat(21,"center");
         descriptionTextField.textRendererProperties.wordWrap = true;
         addChild(descriptionTextField);
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _hintButton.addEventListener("triggered",onHintButtonClicked);
         addChild(_hintButton);
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         background.y = 10;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(descriptionTextField,background,75);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,background,234,-10);
      }
      
      public function updateInventoryItem(param1:InventoryItemDTO) : void
      {
         var _loc6_:InventoryItemDecorationDTO = null;
         var _loc5_:InventoryItemPartDTO = null;
         var _loc9_:* = undefined;
         var _loc4_:String = null;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:InventoryItemResourceDTO = null;
         var _loc2_:InventoryItemUnitDTO = null;
         _inventoryItem = param1;
         if(param1 is InventoryItemDecorationDTO)
         {
            _loc6_ = InventoryItemDecorationDTO(param1);
            var _temp_3:* = descriptionTextField;
            var _temp_2:* = "ui.windows.inventory.decorationtooltip";
            var _loc10_:String = "domain.decoration." + _loc6_.decorationId + ".name";
            var _loc11_:* = peak.i18n.PText.INSTANCE.getText0(_loc10_);
            var _loc12_:String = _temp_2;
            _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc12_,_loc11_);
         }
         else if(param1 is InventoryItemPartDTO)
         {
            _loc5_ = InventoryItemPartDTO(param1);
            _loc9_ = _loc5_.usedInBuildingIds;
            _loc4_ = "";
            _loc8_ = 0;
            while(_loc8_ < _loc9_.length)
            {
               _loc7_ = _loc9_[_loc8_];
               var _loc13_:String;
               var _loc14_:String;
               _loc4_ += _loc7_ == -1 ? (_loc13_ = "ui.windows.inventory.worker",peak.i18n.PText.INSTANCE.getText0(_loc13_)) : (_loc14_ = "domain.building." + _loc7_ + ".name",peak.i18n.PText.INSTANCE.getText0(_loc14_));
               if(_loc8_ != _loc9_.length - 1)
               {
                  _loc4_ += "/";
               }
               _loc8_++;
            }
            var _temp_8:* = descriptionTextField;
            var _temp_7:* = "ui.windows.inventory.parttooltip2";
            var _temp_6:* = _loc4_;
            var _temp_5:* = _loc5_.sellingPrice.resourceAmount;
            var _loc15_:String = "domain.resource." + _loc5_.sellingPrice.resourceType + ".name";
            var _loc16_:* = peak.i18n.PText.INSTANCE.getText0(_loc15_);
            var _loc17_:Number = _temp_5;
            var _loc18_:String = _temp_6;
            var _loc19_:String = _temp_7;
            _temp_8.text = peak.i18n.PText.INSTANCE.getText3(_loc19_,_loc18_,_loc17_,_loc16_);
         }
         else if(param1 is InventoryItemResourceDTO)
         {
            _loc3_ = InventoryItemResourceDTO(param1);
            var _temp_11:* = descriptionTextField;
            var _temp_10:* = "ui.windows.inventory.resourcetooltip";
            var _temp_9:* = _loc3_.sellingPrice.resourceAmount;
            var _loc20_:String = "domain.resource." + _loc3_.sellingPrice.resourceType + ".name";
            var _loc21_:* = peak.i18n.PText.INSTANCE.getText0(_loc20_);
            var _loc22_:Number = _temp_9;
            var _loc23_:String = _temp_10;
            _temp_11.text = peak.i18n.PText.INSTANCE.getText2(_loc23_,_loc22_,_loc21_);
         }
         else if(param1 is InventoryItemUnitDTO)
         {
            _loc2_ = InventoryItemUnitDTO(param1);
            var _temp_14:* = descriptionTextField;
            var _temp_13:* = "ui.windows.inventory.unittooltip";
            var _temp_12:* = _loc2_.unitTypeAmountDTO.amount;
            var _loc24_:String = "domain.units." + _loc2_.unitTypeAmountDTO.id + ".name";
            var _loc25_:* = peak.i18n.PText.INSTANCE.getText0(_loc24_);
            var _loc26_:int = _temp_12;
            var _loc27_:String = _temp_13;
            _temp_14.text = peak.i18n.PText.INSTANCE.getText2(_loc27_,_loc26_,_loc25_);
         }
         drawLayout();
      }
      
      private function onHintButtonClicked(param1:Event) : void
      {
         (this.parent as MobileInventoryItemRenderer).onHintButtonClicked();
      }
   }
}

