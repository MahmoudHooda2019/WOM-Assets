package wom.view.screen.windows.recycle
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.game.building.DecorationInfo;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.ui.common.MobileIconLabelView;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileRecycleDecorationWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 620;
      
      private static const WINDOW_HEIGHT:int = 320;
      
      private var descriptionTextField:MobileWomTextField;
      
      private var _recycleButton:MobileWomButton;
      
      private var gainsBackground:DisplayObject;
      
      private var gainLabel:MobileCaptionTextField;
      
      private var gainView:MobileIconLabelView;
      
      private var _instanceId:int;
      
      public var decorationInfo:DecorationInfo;
      
      public var decorationDIO:DecorationTypeDIO;
      
      private var descriptionBackground:DisplayObject;
      
      public function MobileRecycleDecorationWindow(param1:int)
      {
         super(620,320);
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
         _recycleButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         _recycleButton.width = 180;
         addChild(_recycleButton);
         var _temp_4:* = _recycleButton;
         var _loc4_:String = "ui.windows.recycle.recycle";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         descriptionTextField = new MobileWomTextField();
         descriptionTextField.width = descriptionBackground.width;
         descriptionTextField.textRendererProperties.textFormat = getWomTextFormat(23,"center");
         descriptionTextField.textRendererProperties.wordWrap = true;
         addChild(descriptionTextField);
         var _temp_6:* = descriptionTextField;
         var _loc5_:String = "ui.windows.recycle.decoration.desc";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         gainLabel = new MobileCaptionTextField();
         gainLabel.textRendererProperties.textFormat = getCaptionTextFormat(23);
         addChild(gainLabel);
         var _temp_8:* = gainLabel;
         var _loc6_:String = "ui.windows.cancelconstruction.gain";
         _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         gainView = new MobileIconLabelView("IconRPM",decorationDIO.sellPrice + "");
         addChild(gainView);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         descriptionBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         descriptionBackground.width = 620 - 60;
         descriptionBackground.height = 105;
         MobileAlignmentUtil.alignMiddleXAxisOf(descriptionBackground,this);
         descriptionBackground.y = 30;
         addChild(descriptionBackground);
         gainsBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         gainsBackground.width = 200;
         gainsBackground.height = 105;
         MobileAlignmentUtil.alignMiddleXAxisOf(gainsBackground,this);
         gainsBackground.y = 320 - gainsBackground.height - 60;
         addChild(gainsBackground);
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleOf(descriptionTextField,descriptionBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(gainLabel,gainsBackground,20,-10);
         MobileAlignmentUtil.alignMiddleOf(gainView,gainsBackground);
         MobileAlignmentUtil.alignMiddleXAxisOf(_recycleButton,_background);
         _recycleButton.y = 320 - (_recycleButton.height >> 1);
      }
      
      public function get recycleButton() : MPButton
      {
         return _recycleButton;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
   }
}

