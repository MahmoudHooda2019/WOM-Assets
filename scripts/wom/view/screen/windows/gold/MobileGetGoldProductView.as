package wom.view.screen.windows.gold
{
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.dto.gold.GoldProductDTO;
   import wom.model.game.gold.MonetizationType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileGetGoldProductView extends Sprite implements View
   {
      
      private static const BG_WIDTH:int = 308;
      
      private static const BG_HEIGHT:int = 285;
      
      private static const SMALL_STACK_RATIO:Number = 0.46;
      
      private static const MEDIUM_STACK_RATIO:Number = 0.54;
      
      private static const LARGE_STACK_RATIO:Number = 0.62;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _background:DisplayObject;
      
      private var goldIcon:DisplayObject;
      
      private var topSellerRibbon:DisplayObject;
      
      private var saveTextField:MobileWomTextField;
      
      private var goldAmountTextField:MobileCaptionTextField;
      
      private var _buyButton:MobileWomButton;
      
      private var goldStack0:DisplayObject;
      
      private var goldStack1:DisplayObject;
      
      private var goldStack2:DisplayObject;
      
      private var _goldProductDTO:GoldProductDTO;
      
      private var _monetizationType:MonetizationType;
      
      private var _topSeller:Boolean;
      
      private var _savePercentage:int;
      
      private var _index:int;
      
      private var topSellerLabel:MobileWomTextField;
      
      private var topSellerSprite:Sprite;
      
      public function MobileGetGoldProductView(param1:GoldProductDTO, param2:MonetizationType, param3:Boolean, param4:Number, param5:int)
      {
         super();
         _goldProductDTO = param1;
         _monetizationType = param2;
         _topSeller = param3;
         _savePercentage = param4;
         _index = param5;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         drawBackground();
         saveTextField = new MobileWomTextField();
         saveTextField.textRendererProperties.textFormat = getWomTextFormat(23);
         addChild(saveTextField);
         saveTextField.visible = _savePercentage > 0;
         var _temp_3:* = saveTextField;
         var _temp_2:* = "ui.windows.gold.savepercentage";
         var _loc1_:String = String(_savePercentage);
         var _loc2_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_);
         goldIcon = assetRepository.getDisplayObject("IconGoldL");
         addChild(goldIcon);
         goldAmountTextField = new MobileCaptionTextField();
         goldAmountTextField.textRendererProperties.textFormat = getCaptionTextFormat(42);
         addChild(goldAmountTextField);
         goldAmountTextField.text = String(_goldProductDTO.amountOfGold);
         _buyButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         _buyButton.width = 216;
         _buyButton.setPaddings(30,30,180);
         addChild(_buyButton);
         var _temp_10:* = _buyButton;
         var _loc3_:String = "ui.windows.gold.buy";
         var _temp_9:* = peak.i18n.PText.INSTANCE.getText0(_loc3_) + " ";
         var _temp_8:* = "m.ui.windows.gold.price";
         var _temp_7:* = NumberUtil.numberFormat(_goldProductDTO.localPrice);
         var _loc4_:String = _goldProductDTO.localCurrencyFormatted;
         var _loc5_:String = _temp_7;
         var _loc6_:String = _temp_8;
         _temp_10.label = _temp_9 + peak.i18n.PText.INSTANCE.getText2(_loc6_,_loc5_,_loc4_);
         if(_topSeller)
         {
            topSellerSprite = new Sprite();
            topSellerRibbon = assetRepository.getDisplayObject("MobileTopSellerAsset");
            topSellerRibbon.width = 154;
            topSellerSprite.addChild(topSellerRibbon);
            topSellerLabel = new MobileCaptionTextField();
            topSellerLabel.textRendererProperties.textFormat = getCaptionTextFormat(21,"center");
            topSellerLabel.textRendererProperties.wordWrap = true;
            topSellerLabel.width = topSellerRibbon.width;
            topSellerSprite.addChild(topSellerLabel);
            var _temp_14:* = topSellerLabel;
            var _loc7_:String = "ui.windows.gold.topseller";
            _temp_14.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            topSellerSprite.rotation = -0.24444444444444444 * 3.141592653589793;
            addChild(topSellerSprite);
         }
      }
      
      public function drawBackground() : void
      {
         _background = assetRepository.getDisplayObject("MobileBeigeBackground");
         _background.width = 308;
         _background.height = 285;
         addChild(_background);
         switch(_index)
         {
            case 0:
               goldStack0 = getSmallGoldStack();
               break;
            case 1:
               goldStack0 = getMediumGoldStack();
               break;
            case 2:
               goldStack0 = getLargeGoldStack();
               break;
            case 3:
               goldStack0 = getSmallGoldStack();
               goldStack1 = getLargeGoldStack();
               break;
            case 4:
               goldStack0 = getMediumGoldStack();
               goldStack1 = getLargeGoldStack();
               break;
            case 5:
               goldStack0 = getSmallGoldStack();
               goldStack1 = getMediumGoldStack();
               goldStack2 = getLargeGoldStack();
         }
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(goldIcon,_background,90,180);
         MobileAlignmentUtil.alignAccordingToPositionOf(goldAmountTextField,_background,126,195);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_buyButton,_background,244);
         MobileAlignmentUtil.alignAccordingToPositionOf(saveTextField,_background,175,14);
         if(_topSeller)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(topSellerSprite,_background,-34,70);
            MobileAlignmentUtil.alignMiddleOf(topSellerLabel,topSellerRibbon);
            topSellerLabel.x -= 8;
            topSellerLabel.y -= 8;
         }
         switch(_index)
         {
            case 0:
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(goldStack0,_background,82);
               break;
            case 1:
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(goldStack0,_background,76);
               break;
            case 2:
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(goldStack0,_background,68);
               break;
            case 3:
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(goldStack0,_background,50);
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(goldStack1,_background,65);
               break;
            case 4:
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(goldStack0,_background,45);
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(goldStack1,_background,65);
               break;
            case 5:
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(goldStack0,_background,30);
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(goldStack1,_background,49);
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(goldStack2,_background,65);
         }
      }
      
      public function get buyButton() : MobileWomButton
      {
         return _buyButton;
      }
      
      public function get goldProductDTO() : GoldProductDTO
      {
         return _goldProductDTO;
      }
      
      private function getSmallGoldStack() : DisplayObject
      {
         return getGoldStackBySize(0.46);
      }
      
      private function getMediumGoldStack() : DisplayObject
      {
         return getGoldStackBySize(0.54);
      }
      
      private function getLargeGoldStack() : DisplayObject
      {
         return getGoldStackBySize(0.62);
      }
      
      private function getGoldStackBySize(param1:Number) : DisplayObject
      {
         var _loc2_:DisplayObject = assetRepository.getDisplayObject("FBGoldStack");
         _loc2_.scaleX = _loc2_.scaleY = param1;
         addChild(_loc2_);
         return _loc2_;
      }
   }
}

