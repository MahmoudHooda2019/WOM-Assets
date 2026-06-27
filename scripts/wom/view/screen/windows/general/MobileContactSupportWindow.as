package wom.view.screen.windows.general
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import mx.validators.EmailValidator;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPPickerList;
   import peak.component.mobile.MPPickerPopupList;
   import peak.component.mobile.MPTextArea;
   import peak.component.mobile.MPTextField;
   import peak.component.mobile.MPTextInput;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.events.Event;
   import wom.model.SupportCategoryType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextArea;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.MobileWomTextInput;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileFullScreenWindow;
   
   public class MobileContactSupportWindow extends MobileFullScreenWindow
   {
      
      [Inject]
      public var _assetRepository:MobileWomAssetRepository;
      
      private var _subjectInput:MPTextInput;
      
      private var _messageInput:MPTextArea;
      
      private var _issueCategory:MPPickerList;
      
      private var _subjectTF:MPTextField;
      
      private var _submitButton:MPButton;
      
      private var _emailInput:MPTextInput;
      
      private var _emailTF:MPTextField;
      
      public function MobileContactSupportWindow()
      {
         super(true);
      }
      
      override protected function initLayout() : void
      {
         var dataArray:ListCollection;
         var supportCategoryType:SupportCategoryType;
         super.initLayout();
         var _loc4_:String = "m.ui.windows.contactsupport.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         dataArray = new ListCollection();
         for each(supportCategoryType in SupportCategoryType.ALL_ISSUES)
         {
            var _temp_5:* = dataArray;
            var _temp_4:* = "text";
            var _loc5_:String = supportCategoryType.i18nKey;
            _temp_5.push({
               _temp_4:peak.i18n.PText.INSTANCE.getText0(_loc5_),
               "index":supportCategoryType.id
            });
         }
         _issueCategory = new MPPickerList();
         var _temp_7:* = _issueCategory;
         var _loc6_:String = "m.ui.windows.contactsupport.selectCategory";
         _temp_7.prompt = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _issueCategory.dataProvider = dataArray;
         var _temp_9:* = _issueCategory;
         var _temp_8:* = "text";
         var _loc7_:String = SupportCategoryType.TECHNICAL_ISSUES.i18nKey;
         _temp_9.typicalItem = {_temp_8:peak.i18n.PText.INSTANCE.getText0(_loc7_)};
         _issueCategory.selectedIndex = -1;
         addChild(_issueCategory);
         _issueCategory.labelField = "text";
         _issueCategory.width = 300;
         _issueCategory.listFactory = function():MPPickerPopupList
         {
            var _loc1_:MPPickerPopupList = new MPPickerPopupList();
            _loc1_.itemRendererFactory = pickerListItemRendererFactory;
            return _loc1_;
         };
         _issueCategory.buttonFactory = function():MobileWomButton
         {
            var _loc1_:MobileWomButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
            _loc1_.width = 300;
            _loc1_.defaultLabelProperties.autoSize = false;
            return _loc1_;
         };
         _issueCategory.validate();
         _subjectInput = new MobileWomTextInput();
         _subjectInput.promptProperties.textFormat = getWomTextFormat(21);
         _subjectInput.width = _background.width - _issueCategory.width - 50;
         addChild(_subjectInput);
         _subjectInput.addEventListener("focusIn",onSubjectInputFocused);
         _subjectTF = new MobileWomTextField();
         _subjectTF.textRendererProperties.textFormat = getWomTextFormat(25,"left",8882055);
         addChild(_subjectTF);
         var _temp_12:* = _subjectTF;
         var _loc8_:String = "m.ui.windows.contactsupport.subject";
         _temp_12.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         _messageInput = new MobileWomTextArea();
         _messageInput.width = _background.width - 50;
         _messageInput.height = 400;
         _messageInput.textEditorProperties.textFormat = getWomTextFormat(21);
         addChild(_messageInput);
         _emailInput = new MobileWomTextInput();
         _emailInput.width = 374;
         _emailInput.promptProperties.textFormat = getWomTextFormat(21);
         addChild(_emailInput);
         _emailInput.addEventListener("focusIn",onEmailInputFocused);
         _emailTF = new MobileWomTextField();
         _emailTF.textRendererProperties.textFormat = getWomTextFormat(25,"left",8882055);
         addChild(_emailTF);
         var _temp_16:* = _emailTF;
         var _loc9_:String = "m.ui.windows.contactsupport.email";
         _temp_16.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         _submitButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _submitButton.width = 129;
         var _temp_18:* = _submitButton;
         var _loc10_:String = "m.ui.windows.contactsupport.submit";
         _temp_18.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         addChild(_submitButton);
         drawLayout();
      }
      
      private function pickerListItemRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileContactIssueCategoryItemRenderer = new MobileContactIssueCategoryItemRenderer();
         _loc1_.width = 300;
         _loc1_.height = 50;
         return _loc1_;
      }
      
      private function onSubjectInputFocused(param1:Event) : void
      {
         if(_subjectTF.visible)
         {
            _subjectTF.visible = false;
            _subjectInput.removeEventListener("focusIn",onSubjectInputFocused);
         }
      }
      
      private function onEmailInputFocused(param1:Event) : void
      {
         if(_emailTF.visible)
         {
            _emailTF.visible = false;
            _emailInput.removeEventListener("focusIn",onEmailInputFocused);
         }
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_subjectInput,_background,_background.width - _subjectInput.width - _issueCategory.width >> 1,91);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_subjectTF,_subjectInput,10);
         MobileAlignmentUtil.alignRightOf(_issueCategory,_subjectInput,10);
         MobileAlignmentUtil.alignBelowOf(_messageInput,_subjectInput,7);
         MobileAlignmentUtil.alignBelowOf(_emailInput,_messageInput,10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_emailTF,_emailInput,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_submitButton,_messageInput,_messageInput.width - _submitButton.width,_messageInput.height + 10);
      }
      
      public function softKeyboardStateChanged(param1:Boolean) : void
      {
         if(param1)
         {
            _messageInput.height = 160;
         }
         else
         {
            _messageInput.height = 400;
         }
         drawLayout();
      }
      
      public function isReportValid() : Boolean
      {
         if(_subjectInput.text == "" || _temp_2 == peak.i18n.PText.INSTANCE.getText0(_loc1_))
         {
            return false;
         }
         if(_messageInput.text == "")
         {
            return false;
         }
         if(_emailInput.text == "" || _temp_4 == peak.i18n.PText.INSTANCE.getText0(_loc2_) || EmailValidator.validateEmail(new EmailValidator(),_emailInput.text,"").length > 0)
         {
            return false;
         }
         if(_issueCategory.selectedIndex == -1)
         {
            return false;
         }
         return true;
      }
      
      public function get submitButton() : MPButton
      {
         return _submitButton;
      }
      
      public function get subjectInput() : MPTextInput
      {
         return _subjectInput;
      }
      
      public function get messageInput() : MPTextArea
      {
         return _messageInput;
      }
      
      public function get emailInput() : MPTextInput
      {
         return _emailInput;
      }
      
      public function get chosenCategory() : int
      {
         return _issueCategory.selectedItem.index;
      }
   }
}

