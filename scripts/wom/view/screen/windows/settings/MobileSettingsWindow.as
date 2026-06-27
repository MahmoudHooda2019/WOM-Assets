package wom.view.screen.windows.settings
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileSettingsWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 583;
      
      private static const WINDOW_HEIGHT:int = 547;
      
      public static const WINDOW_EXTRA_HEIGHT_FOR_GOOGLE_PLUS:int = 156;
      
      private var _isGooglePlusAvailable:Boolean;
      
      private var _helpButton:MPButton;
      
      private var _generalView:MobileSettingsGeneralView;
      
      private var _selectLangView:MobileSelectLanguageView = null;
      
      public function MobileSettingsWindow(param1:Boolean, param2:Vector.<WindowEnumeration> = null)
      {
         _isGooglePlusAvailable = param1;
         super(583,547 + (_isGooglePlusAvailable ? 156 : 0),param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "m.ui.windows.settings.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _generalView = new MobileSettingsGeneralView(_isGooglePlusAvailable,assetRepository);
         addChild(_generalView);
         _helpButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Small");
         _helpButton.width = 229;
         var _temp_4:* = _helpButton;
         var _loc2_:String = "m.ui.windows.settings.help";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_helpButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         if(_selectLangView)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_selectLangView,_background,49,46);
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_generalView,_background,49,46);
         MobileAlignmentUtil.alignAccordingToPositionOf(_helpButton,_background,309,470 + (_isGooglePlusAvailable ? 156 : 0));
      }
      
      public function get generalView() : MobileSettingsGeneralView
      {
         return _generalView;
      }
      
      public function get selectLangView() : MobileSelectLanguageView
      {
         return _selectLangView;
      }
      
      public function toggleView() : void
      {
         _generalView.visible = !_generalView.visible;
         if(!_selectLangView)
         {
            _selectLangView = new MobileSelectLanguageView(_isGooglePlusAvailable,assetRepository);
            addChild(_selectLangView);
         }
         else
         {
            _selectLangView.visible = !_selectLangView.visible;
         }
         drawLayout();
      }
      
      public function get helpButton() : MPButton
      {
         return _helpButton;
      }
   }
}

