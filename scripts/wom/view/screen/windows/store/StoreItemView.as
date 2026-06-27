package wom.view.screen.windows.store
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.component.PTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import wom.model.game.store.StoreItemCurrencyType;
   import wom.model.game.store.StoreItemInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.AutoSizingCaptionTextField;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomGreenMediumButton;
   import wom.view.util.LineUtil;
   
   public class StoreItemView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var background:DisplayObject;
      
      private var _itemAsset:DisplayObject;
      
      private var _itemBackground:DisplayObject;
      
      private var lockedIcon:DisplayObject;
      
      private var itemNameHeader:TextField;
      
      private var itemDescriptionTextField:PTextField;
      
      private var currencyIcon:DisplayObject;
      
      private var originalCurrencyIcon:DisplayObject;
      
      private var costTextField:TextField;
      
      private var originalCostTextField:TextField;
      
      private var discountLineContainer:Sprite;
      
      private var sublineTextField:TextField;
      
      private var _cooldownTextField:TextField;
      
      private var _storeItemInfo:StoreItemInfo;
      
      private var _buyButton:WomGreenMediumButton;
      
      public function StoreItemView(param1:StoreItemInfo)
      {
         super();
         this._storeItemInfo = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:Number = 0.6;
         background = assetRepository.getDisplayObject("BackgroundDark");
         background.width = 210;
         background.height = 185;
         addChild(background);
         _itemBackground = assetRepository.getDisplayObject("StoreConstructionTabPatlangac");
         addChild(_itemBackground);
         _itemAsset = assetRepository.getDisplayObject(_storeItemInfo.asset);
         _itemAsset.alpha = _storeItemInfo.locked ? _loc1_ : 1;
         addChild(_itemAsset);
         itemNameHeader = new AutoSizingCaptionTextField();
         itemNameHeader.alpha = _storeItemInfo.locked ? _loc1_ : 1;
         itemNameHeader.defaultTextFormat = WomTextFormats.CENTER_16;
         itemNameHeader.width = background.width;
         itemNameHeader.height = 17;
         addChild(itemNameHeader);
         itemDescriptionTextField = new WomTextField();
         itemDescriptionTextField.extraCharWidth = 1.5;
         itemDescriptionTextField.wordWrap = true;
         itemDescriptionTextField.multiline = true;
         itemDescriptionTextField.defaultTextFormat = Languages.activeLanguageId == "ar" ? WomTextFormats.RIGHT_16 : WomTextFormats.FONT_SIZE_16;
         itemDescriptionTextField.width = 105;
         itemDescriptionTextField.height = 120;
         itemDescriptionTextField.text = _storeItemInfo.description;
         itemDescriptionTextField.alpha = _storeItemInfo.locked ? _loc1_ : 1;
         addChild(itemDescriptionTextField);
         itemNameHeader.text = storeItemInfo.name;
         itemNameHeader.height = itemNameHeader.textHeight + 4;
         lockedIcon = assetRepository.getDisplayObject("Lock");
         lockedIcon.visible = _storeItemInfo.locked;
         addChild(lockedIcon);
         var _loc2_:String = _storeItemInfo.currency == StoreItemCurrencyType.RECON_POINTS ? "Rp" : "Gold";
         var _loc3_:Boolean = !_storeItemInfo.locked && (_storeItemInfo.currency == StoreItemCurrencyType.RECON_POINTS || _storeItemInfo.currency == StoreItemCurrencyType.GOLD);
         originalCurrencyIcon = assetRepository.getDisplayObject(_loc2_);
         originalCurrencyIcon.visible = false;
         originalCurrencyIcon.scaleX = originalCurrencyIcon.scaleY = 0.55;
         addChild(originalCurrencyIcon);
         currencyIcon = assetRepository.getDisplayObject(_loc2_);
         currencyIcon.visible = _loc3_;
         currencyIcon.scaleX = currencyIcon.scaleY = 0.75;
         addChild(currencyIcon);
         originalCostTextField = new CaptionTextField();
         originalCostTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         originalCostTextField.autoSize = "left";
         originalCostTextField.visible = false;
         addChild(originalCostTextField);
         originalCostTextField.text = String(_storeItemInfo.getPrice(null));
         costTextField = new CaptionTextField();
         costTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_24;
         costTextField.autoSize = "left";
         costTextField.visible = _loc3_;
         addChild(costTextField);
         costTextField.text = originalCostTextField.text;
         discountLineContainer = new Sprite();
         discountLineContainer.visible = false;
         addChild(discountLineContainer);
         _buyButton = new WomGreenMediumButton();
         _buyButton.textField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         var _temp_15:* = _buyButton;
         var _loc5_:String = "ui.windows.store." + (_storeItemInfo.currency == StoreItemCurrencyType.FREE ? "free" : "buy");
         _temp_15.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _buyButton.visible = !_storeItemInfo.locked;
         _buyButton.width = 95;
         addChild(_buyButton);
         sublineTextField = new CaptionTextField();
         sublineTextField.defaultTextFormat = WomTextFormats.CENTER_14;
         sublineTextField.width = background.width;
         sublineTextField.height = 17;
         sublineTextField.text = _storeItemInfo.subline;
         sublineTextField.alpha = _storeItemInfo.locked ? _loc1_ : 1;
         addChild(sublineTextField);
         _cooldownTextField = new CaptionTextField();
         _cooldownTextField.defaultTextFormat = WomTextFormats.CENTER_14;
         _cooldownTextField.width = background.width;
         _cooldownTextField.height = 17;
         _cooldownTextField.visible = _storeItemInfo.locked && (_storeItemInfo.effectCooldown || _storeItemInfo.buyCooldown);
         _cooldownTextField.alpha = _storeItemInfo.locked ? _loc1_ : 1;
         addChild(_cooldownTextField);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         itemNameHeader.y = int(-itemNameHeader.height / 2);
         _itemAsset.x = (_itemBackground.width - _itemAsset.width) / 2 << 0;
         _itemAsset.y = (_itemBackground.height - _itemAsset.height) / 2 << 0;
         itemDescriptionTextField.x = Languages.activeLanguageId == "ar" ? 92 : 102;
         itemDescriptionTextField.y = 12;
         lockedIcon.x = background.width - 27;
         lockedIcon.y = -11;
         AlignmentUtil.alignAccordingToPositionOf(currencyIcon,background,27,135);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(costTextField,currencyIcon,currencyIcon.width + 2);
         AlignmentUtil.alignAccordingToPositionOf(_buyButton,background,104,118);
         AlignmentUtil.alignAboveWithXMarginOf(originalCurrencyIcon,currencyIcon,7,0);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(originalCostTextField,originalCurrencyIcon,originalCurrencyIcon.width + 1);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(discountLineContainer,originalCurrencyIcon,-5);
         sublineTextField.y = background.height - 20;
         AlignmentUtil.alignAboveOf(_cooldownTextField,sublineTextField);
      }
      
      public function get storeItemInfo() : StoreItemInfo
      {
         return _storeItemInfo;
      }
      
      public function get buyButton() : WomGreenMediumButton
      {
         return _buyButton;
      }
      
      public function get itemAsset() : DisplayObject
      {
         return _itemAsset;
      }
      
      public function get itemBackground() : DisplayObject
      {
         return _itemBackground;
      }
      
      public function get cooldownTextField() : TextField
      {
         return _cooldownTextField;
      }
      
      public function get visibleWidth() : int
      {
         return background.width;
      }
      
      public function get visibleHeight() : int
      {
         return background.height;
      }
      
      public function updateCost(param1:int) : void
      {
         costTextField.text = String(param1);
         var _loc2_:Boolean = costTextField.visible && param1 < _storeItemInfo.getOriginalPrice();
         if(_loc2_)
         {
            discountLineContainer.graphics.clear();
            LineUtil.drawHorizontalSeparatorLine(discountLineContainer,0,originalCurrencyIcon.width + originalCostTextField.width + 10,7407881,7407881,null,0.8,0.3);
         }
         originalCurrencyIcon.visible = originalCostTextField.visible = discountLineContainer.visible = _loc2_;
         drawLayout();
      }
   }
}

