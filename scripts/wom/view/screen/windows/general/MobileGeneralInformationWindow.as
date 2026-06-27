package wom.view.screen.windows.general
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileGeneralInformationWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 582;
      
      private static const WINDOW_HEIGHT:int = 547;
      
      private var _topBackground:DisplayObject;
      
      private var _faqQuestionTF:MPTextField;
      
      private var _faqAnswerTF:MPTextField;
      
      private var _faqButton:MPButton;
      
      private var _midBackground:DisplayObject;
      
      private var _guidesQuestionTF:MPTextField;
      
      private var _guidesAnswerTF:MPTextField;
      
      private var _guidesButton:MPButton;
      
      private var _bottomBackground:DisplayObject;
      
      private var _contactQuestionTF:MPTextField;
      
      private var _contactAnswerTF:MPTextField;
      
      private var _contactButton:MPButton;
      
      public function MobileGeneralInformationWindow(param1:Vector.<WindowEnumeration> = null)
      {
         super(582,547,param1);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.generalinformation.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _topBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         _topBackground.width = 492;
         _topBackground.height = 125;
         addChild(_topBackground);
         _faqQuestionTF = createTextField("faqquestion");
         addChild(_faqQuestionTF);
         _faqAnswerTF = createTextField("faqanswer");
         addChild(_faqAnswerTF);
         _faqButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _faqButton.width = 132;
         addChild(_faqButton);
         var _temp_6:* = _faqButton;
         var _loc2_:String = "ui.windows.generalinformation.faq";
         _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _midBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         _midBackground.width = 492;
         _midBackground.height = 122;
         addChild(_midBackground);
         _guidesQuestionTF = createTextField("playerguidesquestion");
         addChild(_guidesQuestionTF);
         _guidesAnswerTF = createTextField("playerguidesanswer");
         addChild(_guidesAnswerTF);
         _guidesButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _guidesButton.width = 207;
         addChild(_guidesButton);
         var _temp_11:* = _guidesButton;
         var _loc3_:String = "ui.windows.generalinformation.playerguides";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _bottomBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         _bottomBackground.width = 492;
         _bottomBackground.height = 152;
         addChild(_bottomBackground);
         _contactQuestionTF = createTextField("contactsupportquestion");
         addChild(_contactQuestionTF);
         _contactAnswerTF = createTextField("contactsupportanswer");
         addChild(_contactAnswerTF);
         _contactButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _contactButton.width = 242;
         var _temp_16:* = _contactButton;
         var _loc4_:String = "ui.windows.generalinformation.contactsupport";
         _temp_16.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(_contactButton);
         drawLayout();
      }
      
      private function createTextField(param1:String) : MPTextField
      {
         var _loc2_:MPTextField = new MobileWomTextField();
         _loc2_.textRendererProperties.textFormat = getWomTextFormat(25);
         _loc2_.textRendererProperties.wordWrap = true;
         _loc2_.width = 420;
         var _temp_1:* = _loc2_;
         var _loc3_:String = "ui.windows.generalinformation." + param1;
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         return _loc2_;
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_topBackground,_background,40);
         _faqQuestionTF.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_faqQuestionTF,_topBackground,39,20);
         MobileAlignmentUtil.alignBelowOf(_faqAnswerTF,_faqQuestionTF,11);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_faqButton,_topBackground,_topBackground.height - (_faqButton.height >> 1) - 5);
         MobileAlignmentUtil.alignBelowOf(_midBackground,_topBackground,28);
         _guidesQuestionTF.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_guidesQuestionTF,_midBackground,39,20);
         MobileAlignmentUtil.alignBelowOf(_guidesAnswerTF,_guidesQuestionTF,11);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_guidesButton,_midBackground,_midBackground.height - (_guidesButton.height >> 1) - 5);
         MobileAlignmentUtil.alignBelowOf(_bottomBackground,_midBackground,30);
         _contactQuestionTF.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_contactQuestionTF,_bottomBackground,39,20);
         MobileAlignmentUtil.alignBelowOf(_contactAnswerTF,_contactQuestionTF,11);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_contactButton,_bottomBackground,_bottomBackground.height - (_contactButton.height >> 1) - 5);
      }
      
      public function get faqButton() : MPButton
      {
         return _faqButton;
      }
      
      public function get guidesButton() : MPButton
      {
         return _guidesButton;
      }
      
      public function get contactButton() : MPButton
      {
         return _contactButton;
      }
   }
}

