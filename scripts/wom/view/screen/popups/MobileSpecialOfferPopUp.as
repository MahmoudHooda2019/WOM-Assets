package wom.view.screen.popups
{
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import wom.model.dto.MobileSpecialOfferDTO;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileSpecialOfferPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 613;
      
      private static const WINDOW_HEIGHT:int = 395;
      
      private var goldBackground:DisplayObject;
      
      private var goldIcon:DisplayObject;
      
      private var goldAmountTextField:MobileCaptionTextField;
      
      private var goldPriceTextField:MobileCaptionTextField;
      
      private var discountAsset:DisplayObject;
      
      private var discountLabel:MobileCaptionTextField;
      
      private var discountPercentageTextField:MobileCaptionTextField;
      
      private var packagesLeftTextField:MobileWomTextField;
      
      private var _offerTimeLeftTextField:MobileWomTextField;
      
      private var _specialOfferDTO:MobileSpecialOfferDTO;
      
      public function MobileSpecialOfferPopUp()
      {
         super(613,395);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _imageAsset = assetRepository.getDisplayObject("MPose4");
         addChild(_imageAsset);
         _speechBubble = new MobileSpeechBubbleView(374,"",null,null,222,68);
         addChild(_speechBubble);
         goldBackground = assetRepository.getDisplayObject("MobileYellowBackground");
         goldBackground.width = 322;
         goldBackground.height = 134;
         addChild(goldBackground);
         goldIcon = assetRepository.getDisplayObject("IconGoldL");
         addChild(goldIcon);
         goldAmountTextField = new MobileCaptionTextField();
         goldAmountTextField.textRendererProperties.textFormat = getCaptionTextFormat(42);
         addChild(goldAmountTextField);
         goldPriceTextField = new MobileCaptionTextField();
         goldPriceTextField.textRendererProperties.textFormat = getCaptionTextFormat(38);
         addChild(goldPriceTextField);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _actionButton.width = 280;
         var _temp_8:* = _actionButton;
         var _loc1_:String = "m.ui.popups.specialoffer.buynow";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_actionButton);
         discountAsset = assetRepository.getDisplayObject("DiscountLabel");
         addChild(discountAsset);
         discountLabel = new MobileCaptionTextField();
         discountLabel.textRendererProperties.textFormat = getCaptionTextFormat(23);
         addChild(discountLabel);
         var _temp_11:* = discountLabel;
         var _loc2_:String = "m.ui.popups.specialoffer.discountlabel";
         _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         discountPercentageTextField = new MobileCaptionTextField();
         discountPercentageTextField.textRendererProperties.textFormat = getCaptionTextFormat(38);
         addChild(discountPercentageTextField);
         packagesLeftTextField = new MobileWomTextField();
         packagesLeftTextField.textRendererProperties.textFormat = getWomTextFormat(25);
         addChild(packagesLeftTextField);
         _offerTimeLeftTextField = new MobileWomTextField();
         _offerTimeLeftTextField.textRendererProperties.textFormat = getWomTextFormat(25);
         addChild(_offerTimeLeftTextField);
      }
      
      private function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-4,_windowHeight - 8 - _imageAsset.height);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,340);
         MobileAlignmentUtil.alignAccordingToPositionOf(discountAsset,_background,-45,-20);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,210,30);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(discountPercentageTextField,discountAsset,60);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(discountLabel,discountAsset,90);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(goldBackground,_speechBubble,25);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(packagesLeftTextField,_speechBubble,180);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_offerTimeLeftTextField,_speechBubble,226);
         MobileAlignmentUtil.alignAccordingToPositionOf(goldIcon,goldBackground,45,21);
         MobileAlignmentUtil.alignAccordingToPositionOf(goldAmountTextField,goldBackground,85,34);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(goldPriceTextField,goldBackground,74);
      }
      
      public function updateWithSpecialOfferInfo(param1:MobileSpecialOfferDTO) : void
      {
         _specialOfferDTO = param1;
         setHeader(param1.title);
         var _temp_3:* = goldAmountTextField;
         var _temp_2:* = "m.ui.popups.specialoffer.gold";
         var _loc2_:String = String(param1.goldAmount);
         var _loc3_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         goldPriceTextField.text = param1.currencySymbol + " " + NumberUtil.numberFormat(param1.price);
         var _temp_5:* = discountPercentageTextField;
         var _temp_4:* = "m.ui.popups.specialoffer.discountpercentage";
         var _loc4_:String = String(param1.offerPercentage);
         var _loc5_:String = _temp_4;
         _temp_5.text = peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_);
         var _temp_7:* = packagesLeftTextField;
         var _temp_6:* = "m.ui.popups.specialoffer.packagesleft";
         var _loc6_:int = param1.itemCount;
         var _loc7_:String = _temp_6;
         _temp_7.text = peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_);
         var _temp_9:* = _offerTimeLeftTextField;
         var _temp_8:* = "m.ui.popups.specialoffer.offertimeleft";
         var _loc8_:String = DateTimeUtil.getUserFriendlyTime(param1.expireDate - new Date().getTime());
         var _loc9_:String = _temp_8;
         _temp_9.text = peak.i18n.PText.INSTANCE.getText1(_loc9_,_loc8_);
         drawLayout();
      }
      
      public function get offerTimeLeftTextField() : MobileWomTextField
      {
         return _offerTimeLeftTextField;
      }
      
      public function get specialOfferDTO() : MobileSpecialOfferDTO
      {
         return _specialOfferDTO;
      }
   }
}

