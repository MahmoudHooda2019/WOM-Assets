package wom.view.screen.windows.staff
{
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.util.GenericWindow;
   
   public class ActivateBuildingByStaffsWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 649;
      
      private static const WINDOW_HEIGHT:int = 532;
      
      private var _headerTextField:TextField;
      
      private var _requiredStaffsPanel:RequiredStaffsPanel;
      
      public function ActivateBuildingByStaffsWindow(param1:int = 649, param2:int = 532)
      {
         super(param1,param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.activatebuildingbystaffs.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _headerTextField = new WomTextField();
         _headerTextField.defaultTextFormat = WomTextFormats.CENTER_20;
         _headerTextField.wordWrap = true;
         _headerTextField.multiline = true;
         _headerTextField.width = 607;
         _headerTextField.autoSize = "center";
         var _temp_3:* = _headerTextField;
         var _loc2_:String = "ui.windows.activatebuildingbystaffs.message";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_headerTextField);
         _requiredStaffsPanel = new RequiredStaffsPanel();
         addChild(_requiredStaffsPanel);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_headerTextField,_background,31);
         _requiredStaffsPanel.x = 21;
         _requiredStaffsPanel.y = 80;
      }
      
      public function updateWindowDimensions(param1:int) : void
      {
         windowHeight = param1 > 3 ? 532 : 354;
         _background.height = windowHeight;
         drawLayout();
      }
      
      public function get requiredStaffsPanel() : RequiredStaffsPanel
      {
         return _requiredStaffsPanel;
      }
   }
}

