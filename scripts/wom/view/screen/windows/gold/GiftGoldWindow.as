package wom.view.screen.windows.gold
{
   import fl.controls.ComboBox;
   import fl.controls.RadioButtonGroup;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.dto.gold.GoldProductDTO;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomComboBox;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.screen.windows.friends.SelectFriendsView;
   import wom.view.util.GenericWindow;
   
   public class GiftGoldWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 626;
      
      private static const WINDOW_HEIGHT:int = 501;
      
      private static const MAX_VISIBLE_ITEM_VIEWS:uint = 8;
      
      public static const PAYMENT_METHOD_NON_MOBILE:uint = 0;
      
      public static const PAYMENT_METHOD_MOBILE:uint = 1;
      
      private var _goldProducts:Vector.<GoldProductDTO>;
      
      private var _mobileGoldProductsDict:Dictionary;
      
      private var _paymentMethod:uint;
      
      private var _clementineAsset:DisplayObject;
      
      private var _descTextField:TextField;
      
      private var _paymentMethodButton:WomButton;
      
      private var _selectedRadioButtonGroup:RadioButtonGroup;
      
      private var _itemViews:Vector.<GiftGoldItemView>;
      
      private var _selectFriendsView:SelectFriendsView;
      
      private var _summaryBackground:DisplayObject;
      
      private var _summaryFriendsTextField:TextField;
      
      private var _summaryAmountCurrencyBackground:Sprite;
      
      private var _summaryAmountTextField:TextField;
      
      private var _summaryCurrencyTextField:TextField;
      
      private var _lockBackground:Sprite;
      
      private var _lockAsset:DisplayObject;
      
      private var _lockTextField:TextField;
      
      private var _buyButton:WomButton;
      
      private var _selectCountryTextField:TextField;
      
      private var _selectCountryComboBox:ComboBox;
      
      public function GiftGoldWindow(param1:uint, param2:Vector.<WindowEnumeration> = null)
      {
         _paymentMethod = param1;
         super(626,501,param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.giftgold.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _clementineAsset = assetRepository.getDisplayObject("ClementineHurray");
         addChild(_clementineAsset);
         _descTextField = new CaptionTextField(WomTextFormats.BROWN_FILTER);
         _descTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         _descTextField.autoSize = "left";
         var _temp_4:* = _descTextField;
         var _loc2_:String = "ui.windows.giftgold.desc";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_descTextField);
         _paymentMethodButton = new WomBlueSmallButton();
         _paymentMethodButton.width = 157;
         addChild(_paymentMethodButton);
         _selectedRadioButtonGroup = new RadioButtonGroup("selectedRadioButtonGroup");
         _itemViews = new Vector.<GiftGoldItemView>();
         updateItemViews();
         _selectFriendsView = new SelectFriendsView(175,121,1,34,175,138,1,158,176,0,0,"BackgroundWhite");
         addChild(_selectFriendsView);
         _summaryBackground = assetRepository.getDisplayObject("BackgroundLight");
         _summaryBackground.width = 175;
         _summaryBackground.height = 85;
         addChild(_summaryBackground);
         _summaryFriendsTextField = new WomTextField();
         _summaryFriendsTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         _summaryFriendsTextField.autoSize = "left";
         _summaryFriendsTextField.text = "";
         addChild(_summaryFriendsTextField);
         _summaryAmountCurrencyBackground = new Sprite();
         addChild(_summaryAmountCurrencyBackground);
         _summaryAmountTextField = new CaptionTextField(WomTextFormats.NO_FILTER);
         _summaryAmountTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_30;
         _summaryAmountTextField.textColor = 0;
         _summaryAmountTextField.autoSize = "left";
         _summaryAmountTextField.text = "";
         _summaryAmountCurrencyBackground.addChild(_summaryAmountTextField);
         _summaryCurrencyTextField = new CaptionTextField(WomTextFormats.NO_FILTER);
         _summaryCurrencyTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _summaryCurrencyTextField.textColor = 0;
         _summaryCurrencyTextField.autoSize = "left";
         _summaryCurrencyTextField.text = "";
         _summaryAmountCurrencyBackground.addChild(_summaryCurrencyTextField);
         _lockBackground = new Sprite();
         addChild(_lockBackground);
         _lockAsset = assetRepository.getDisplayObject("Lock");
         _lockAsset.width = 22;
         _lockAsset.height = 28;
         _lockBackground.addChild(_lockAsset);
         _lockTextField = new WomTextField();
         _lockTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _lockTextField.autoSize = "left";
         var _temp_17:* = _lockTextField;
         var _loc3_:String = "ui.windows.gold.securepayment";
         _temp_17.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _lockBackground.addChild(_lockTextField);
         _buyButton = new WomGreenLargeButton();
         var _temp_19:* = _buyButton;
         var _loc4_:String = "ui.windows.giftgold.buy";
         _temp_19.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _buyButton.width = 231;
         addChild(_buyButton);
         _selectCountryTextField = new WomTextField();
         _selectCountryTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _selectCountryTextField.textColor = 6965821;
         _selectCountryTextField.autoSize = "left";
         var _temp_21:* = _selectCountryTextField;
         var _loc5_:String = "ui.windows.gold.selectcountry";
         _temp_21.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_selectCountryTextField);
         _selectCountryComboBox = new WomComboBox();
         _selectCountryComboBox.width = 55;
         addChild(_selectCountryComboBox);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         AlignmentUtil.alignAccordingToPositionOf(_clementineAsset,_background,-46,22);
         AlignmentUtil.alignAccordingToPositionOf(_descTextField,_background,115,30);
         AlignmentUtil.alignBelowOf(_selectCountryTextField,_descTextField,10);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_selectCountryComboBox,_selectCountryTextField,_selectCountryTextField.width + 10);
         _selectCountryTextField.visible = _selectCountryComboBox.visible = _paymentMethod == 1;
         if(_paymentMethod == 0)
         {
            _paymentMethodButton.setStyle("icon",assetRepository.getDisplayObject("MobilePaymentIcon"));
            var _temp_2:* = _paymentMethodButton;
            var _loc3_:String = "ui.windows.gold.mobile";
            _temp_2.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            _selectFriendsView.maxSelectable = 50;
         }
         else
         {
            _paymentMethodButton.setStyle("icon",assetRepository.getDisplayObject("OtherPaymentIcon"));
            var _temp_3:* = _paymentMethodButton;
            var _loc4_:String = "ui.windows.gold.nonmobile";
            _temp_3.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc4_);
            _selectFriendsView.maxSelectable = 1;
         }
         AlignmentUtil.alignAccordingToPositionOf(_paymentMethodButton,_background,626 - _paymentMethodButton.width - 28,29);
         _loc1_ = 0;
         while(_loc1_ < _itemViews.length)
         {
            AlignmentUtil.alignAccordingToPositionOf(_itemViews[_loc1_],_background,117,_loc1_ * 44 + 99);
            _loc1_++;
         }
         AlignmentUtil.alignAccordingToPositionOf(_selectFriendsView,_background,423,63);
         AlignmentUtil.alignAccordingToPositionOf(_summaryBackground,_background,424,362);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_summaryFriendsTextField,_summaryBackground,21);
         AlignmentUtil.alignRightWithYMarginOf(_summaryCurrencyTextField,_summaryAmountTextField,9,0);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_summaryAmountCurrencyBackground,_summaryBackground,35);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_buyButton,_background,_background.height - 38);
         _lockAsset.x = _lockAsset.y = 0;
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_lockTextField,_lockAsset,29);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_lockBackground,_summaryBackground,92);
      }
      
      public function updateItemViews() : void
      {
         var _loc2_:* = 0;
         var _loc1_:GiftGoldItemView = null;
         var _loc4_:* = 0;
         var _loc3_:GiftGoldItemView = null;
         if(_goldProducts != null && _goldProducts.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _goldProducts.length && _loc2_ < 8)
            {
               _loc1_ = new GiftGoldItemView(_goldProducts[_loc2_],_selectedRadioButtonGroup,_paymentMethod == 1);
               _itemViews.push(_loc1_);
               addChild(_loc1_);
               _loc2_++;
            }
            _loc4_ = uint(_paymentMethod == 1 ? 2 : 3);
            if(_loc4_ >= _itemViews.length)
            {
               _loc4_ = 0;
            }
            _loc3_ = _itemViews[_loc4_];
            _loc3_.radioButton.selected = true;
            _loc3_.update(_loc3_.goldProductDTO.id);
         }
      }
      
      public function clearItemViews() : void
      {
         for each(var _loc1_ in _itemViews)
         {
            if(contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
         _itemViews.length = 0;
      }
      
      public function updateGoldProducts(param1:Vector.<GoldProductDTO>) : void
      {
         _goldProducts = param1;
         clearItemViews();
         updateItemViews();
         updateSummary();
      }
      
      public function updateMobileGoldProductsDict(param1:Dictionary, param2:String = "--") : void
      {
         _mobileGoldProductsDict = param1;
         _selectCountryComboBox.removeAll();
         for(var _loc3_ in _mobileGoldProductsDict)
         {
            _selectCountryComboBox.addItem({
               "label":_loc3_,
               "data":_loc3_
            });
         }
         if(param2 in _mobileGoldProductsDict)
         {
            _selectCountryComboBox.selectedIndex = findItemIndex(param2);
            updateGoldProducts(_mobileGoldProductsDict[param2]);
         }
         else
         {
            updateGoldProducts(null);
         }
      }
      
      private function findItemIndex(param1:String) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _selectCountryComboBox.length)
         {
            if(_selectCountryComboBox.getItemAt(_loc2_).data == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function updateSummary() : void
      {
         var _loc3_:* = 0;
         var _loc2_:GoldProductDTO = null;
         for each(var _loc1_ in _itemViews)
         {
            if(_loc1_.radioButton.selected)
            {
               _loc3_ = _selectFriendsView.selectedData.length;
               _loc2_ = _loc1_.goldProductDTO;
               var _temp_3:* = _summaryFriendsTextField;
               var _temp_2:* = "ui.windows.giftgold.summary";
               var _temp_1:* = _loc3_;
               var _loc6_:int = _loc2_.amountOfGold;
               var _loc7_:uint = _temp_1;
               var _loc8_:String = _temp_2;
               _temp_3.text = peak.i18n.PText.INSTANCE.getText2(_loc8_,_loc7_,_loc6_);
               _summaryAmountTextField.text = NumberUtil.numberFormat(_loc2_.localPrice * _loc3_);
               _summaryCurrencyTextField.text = _loc2_.localCurrencyFormatted;
            }
         }
         drawLayout();
      }
      
      public function get clementineAsset() : DisplayObject
      {
         return _clementineAsset;
      }
      
      public function get lockAsset() : DisplayObject
      {
         return _lockAsset;
      }
      
      public function get selectFriendsView() : SelectFriendsView
      {
         return _selectFriendsView;
      }
      
      public function get paymentMethodButton() : WomButton
      {
         return _paymentMethodButton;
      }
      
      public function get paymentMethod() : uint
      {
         return _paymentMethod;
      }
      
      public function set paymentMethod(param1:uint) : void
      {
         _paymentMethod = param1;
      }
      
      public function get buyButton() : WomButton
      {
         return _buyButton;
      }
      
      public function get itemViews() : Vector.<GiftGoldItemView>
      {
         return _itemViews;
      }
      
      public function get selectCountryComboBox() : ComboBox
      {
         return _selectCountryComboBox;
      }
   }
}

