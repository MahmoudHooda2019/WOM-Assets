package wom.view.screen.windows.recycle
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.game.building.DecorationInfo;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomRedLargeButton;
   import wom.view.ui.common.IconLabelView;
   import wom.view.util.GenericWindow;
   
   public class RecycleDecorationWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 400;
      
      private static const WINDOW_HEIGHT:int = 300;
      
      private var descriptionTextField:TextField;
      
      private var _recycleButton:Button;
      
      private var gainsBackground:DisplayObject;
      
      private var gainLabel:TextField;
      
      private var gainView:IconLabelView;
      
      private var _instanceId:int;
      
      public var decorationInfo:DecorationInfo;
      
      public var decorationDIO:DecorationTypeDIO;
      
      public function RecycleDecorationWindow(param1:int)
      {
         super(400,300);
         _instanceId = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = "ui.windows.recycle.header";
         var _loc1_:String = "domain.decoration." + decorationDIO.id + (decorationInfo.subType ? "." + decorationInfo.subType : "") + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_));
         _recycleButton = new WomRedLargeButton();
         var _temp_4:* = _recycleButton;
         var _loc4_:String = "ui.windows.recycle.recycle";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _recycleButton.width = 210;
         addChild(_recycleButton);
         descriptionTextField = new WomTextField();
         descriptionTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         descriptionTextField.width = 400;
         descriptionTextField.multiline = true;
         descriptionTextField.wordWrap = true;
         var _temp_6:* = descriptionTextField;
         var _loc5_:String = "ui.windows.recycle.decoration.desc";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(descriptionTextField);
         gainLabel = new CaptionTextField();
         gainLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         gainLabel.autoSize = "left";
         var _temp_8:* = gainLabel;
         var _loc6_:String = "ui.windows.cancelconstruction.gain";
         _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(gainLabel);
         gainView = new IconLabelView("RP41",decorationDIO.sellPrice + "");
         addChild(gainView);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         gainsBackground = assetRepository.getDisplayObject("BackgroundLight");
         gainsBackground.width = 200;
         gainsBackground.height = 105;
         AlignmentUtil.alignMiddleXAxisOf(gainsBackground,this);
         gainsBackground.y = 300 - gainsBackground.height - 40;
         addChild(gainsBackground);
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignBelowOf(descriptionTextField,_windowHeader,20);
         AlignmentUtil.alignMiddleXAxisOf(descriptionTextField,_windowHeader);
         AlignmentUtil.alignAccordingToPositionOf(gainLabel,gainsBackground,20,-10);
         AlignmentUtil.alignMiddleOf(gainView,gainsBackground);
         AlignmentUtil.alignMiddleXAxisOf(_recycleButton,_background);
         _recycleButton.y = 300 - (_recycleButton.height >> 1);
      }
      
      public function get recycleButton() : Button
      {
         return _recycleButton;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
   }
}

