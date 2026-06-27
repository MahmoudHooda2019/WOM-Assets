package wom.view.screen.windows.inventory
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.util.AlignmentUtil;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class InventoryItemView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      protected var background:DisplayObject;
      
      protected var tooltipBg:DisplayObject;
      
      protected var bottomPin:DisplayObject;
      
      protected var _itemAsset:DisplayObject;
      
      protected var _unseenIndicatorAsset:DisplayObject;
      
      protected var itemTooltipTextField:TextField;
      
      protected var itemNameHeader:TextField;
      
      protected var itemCountTextField:TextField;
      
      protected var _inventoryItemDTO:InventoryItemDTO;
      
      public function InventoryItemView(param1:InventoryItemDTO)
      {
         super();
         this._inventoryItemDTO = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("ShinyBackgroundLarge");
         addChild(background);
         itemNameHeader = new CaptionTextField();
         itemNameHeader.wordWrap = true;
         itemNameHeader.multiline = true;
         itemNameHeader.defaultTextFormat = WomTextFormats.CENTER_16;
         itemNameHeader.width = background.width;
         itemNameHeader.height = 25;
         addChild(itemNameHeader);
         itemCountTextField = new WomTextField();
         itemCountTextField.defaultTextFormat = WomTextFormats.CENTER_20;
         itemCountTextField.textColor = 5909777;
         itemCountTextField.width = background.width;
         itemCountTextField.height = 25;
         addChild(itemCountTextField);
         _itemAsset = assetRepository.getDisplayObject(_inventoryItemDTO.visual);
         addChild(_itemAsset);
         itemCountTextField.text = _inventoryItemDTO.amount + "/20";
         if(_inventoryItemDTO.unseenIndicator)
         {
            _unseenIndicatorAsset = assetRepository.getDisplayObject("MainframeStashNewGift");
            addChild(_unseenIndicatorAsset);
         }
         tooltipBg = assetRepository.getDisplayObject("TooltipBackgroundSkin");
         tooltipBg.visible = false;
         tooltipBg.width = 124;
         tooltipBg.height = 80;
         addChild(tooltipBg);
         bottomPin = assetRepository.getDisplayObject("TooltipsBottomPin");
         bottomPin.visible = false;
         addChild(bottomPin);
         itemTooltipTextField = new WomTextField();
         itemTooltipTextField.autoSize = "left";
         itemTooltipTextField.defaultTextFormat = WomTextFormats.CENTER_16;
         itemTooltipTextField.multiline = true;
         itemTooltipTextField.wordWrap = true;
         itemTooltipTextField.width = tooltipBg.width - 5;
         itemTooltipTextField.text = "";
         itemTooltipTextField.visible = false;
         addChild(itemTooltipTextField);
      }
      
      public function drawLayout() : void
      {
         itemNameHeader.y = int(-itemNameHeader.height / 2);
         itemCountTextField.y = 10;
         AlignmentUtil.alignMiddleOf(_itemAsset,background);
         tooltipBg.x = -1;
         tooltipBg.y = -28;
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(bottomPin,tooltipBg,tooltipBg.height - bottomPin.height + 5);
         AlignmentUtil.alignMiddleOf(itemTooltipTextField,tooltipBg);
         if(_unseenIndicatorAsset)
         {
            AlignmentUtil.alignAccordingToPositionOf(_unseenIndicatorAsset,background,93,7);
         }
      }
      
      public function onMouseOver() : void
      {
      }
      
      public function onMouseOut() : void
      {
      }
      
      public function get inventoryItemDTO() : InventoryItemDTO
      {
         return _inventoryItemDTO;
      }
      
      public function get itemAsset() : DisplayObject
      {
         return _itemAsset;
      }
   }
}

