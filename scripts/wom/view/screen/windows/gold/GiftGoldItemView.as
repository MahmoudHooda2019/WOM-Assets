package wom.view.screen.windows.gold
{
   import fl.controls.RadioButton;
   import fl.controls.RadioButtonGroup;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.dto.gold.GoldProductDTO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomGiftGoldRadioButton;
   import wom.view.component.WomTextFormats;
   
   public class GiftGoldItemView extends Sprite implements View
   {
      
      private static const BACKGROUND_WIDTH:int = 300;
      
      private static const BACKGROUND_HEIGHT:int = 40;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _goldProductDTO:GoldProductDTO;
      
      private var _mobilePayment:Boolean;
      
      private var _background:DisplayObject;
      
      private var _radioButton:RadioButton;
      
      private var _radioButtonGroup:RadioButtonGroup;
      
      private var _goldAsset:DisplayObject;
      
      private var _goldAmountTextField:TextField;
      
      private var _goldAmountGoldTextField:TextField;
      
      private var _goldPriceTextField:TextField;
      
      public function GiftGoldItemView(param1:GoldProductDTO, param2:RadioButtonGroup, param3:Boolean = false)
      {
         super();
         _goldProductDTO = param1;
         _radioButtonGroup = param2;
         _mobilePayment = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _background = assetRepository.getDisplayObject("TooltipBackgroundSkin");
         _background.width = 300;
         _background.height = 40;
         addChild(_background);
         _radioButton = WomGiftGoldRadioButton.createAndAdd(this,_goldProductDTO.id,_radioButtonGroup);
         _goldAsset = assetRepository.getDisplayObject("GoldDouble");
         addChild(_goldAsset);
         _goldAmountTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
         _goldAmountTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_34;
         _goldAmountTextField.autoSize = "left";
         addChild(_goldAmountTextField);
         _goldAmountTextField.text = NumberUtil.format(_goldProductDTO.amountOfGold);
         _goldAmountGoldTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
         _goldAmountGoldTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _goldAmountGoldTextField.autoSize = "left";
         addChild(_goldAmountGoldTextField);
         var _temp_6:* = _goldAmountGoldTextField;
         var _loc1_:String = "ui.windows.giftgold.gold";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _goldPriceTextField = new CaptionTextField(WomTextFormats.BROWN_FILTER);
         _goldPriceTextField.defaultTextFormat = WomTextFormats.RIGHT_18;
         _goldPriceTextField.autoSize = "right";
         addChild(_goldPriceTextField);
         var _temp_10:* = _goldPriceTextField;
         var _temp_9:* = "ui.windows.gold.price";
         var _temp_8:* = NumberUtil.numberFormat(_goldProductDTO.localPrice);
         var _loc2_:String = _goldProductDTO.localCurrencyFormatted;
         var _loc3_:String = _temp_8;
         var _loc4_:String = _temp_9;
         _temp_10.text = peak.i18n.PText.INSTANCE.getText2(_loc4_,_loc3_,_loc2_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _background.x = _background.y = 0;
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_radioButton,_background,5);
         AlignmentUtil.alignAccordingToPositionOf(_goldAsset,_background,35,-2);
         _goldAmountTextField.x = 75;
         _goldAmountTextField.y = 40 - _goldAmountTextField.height >> 1 >> 0;
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_goldAmountGoldTextField,_goldAmountTextField,_goldAmountTextField.width + 2);
         _goldPriceTextField.x = 300 - _goldPriceTextField.width - 10;
         _goldPriceTextField.y = 40 - _goldPriceTextField.height >> 1 >> 0;
      }
      
      public function get goldProductDTO() : GoldProductDTO
      {
         return _goldProductDTO;
      }
      
      public function get goldAsset() : DisplayObject
      {
         return _goldAsset;
      }
      
      public function get mobilePayment() : Boolean
      {
         return _mobilePayment;
      }
      
      public function get radioButton() : RadioButton
      {
         return _radioButton;
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != _goldProductDTO.id)
         {
         }
      }
   }
}

