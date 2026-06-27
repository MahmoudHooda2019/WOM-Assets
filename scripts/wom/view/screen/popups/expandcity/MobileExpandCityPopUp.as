package wom.view.screen.popups.expandcity
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileExpandCityPopUp extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 489;
      
      private static const WINDOW_HEIGHT:int = 311;
      
      private var bg:DisplayObject;
      
      private var expandAsset:DisplayObject;
      
      private var _requiredGold:int;
      
      private var _availabilityText:String;
      
      private var availabilityTextField:MPTextField;
      
      private var messageTextField:MobileWomTextField;
      
      private var _confirmButton:MobileWomButton;
      
      public function MobileExpandCityPopUp(param1:Vector.<WindowEnumeration> = null)
      {
         super(489,311,param1);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.expandcity.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         bg = assetRepository.getDisplayObject("MobileBeigeBackground");
         bg.width = 416;
         bg.height = 160;
         addChild(bg);
         expandAsset = assetRepository.getDisplayObject("ExpandCity");
         addChild(expandAsset);
         messageTextField = new MobileWomTextField();
         messageTextField.textRendererProperties.textFormat = getWomTextFormat(23);
         messageTextField.textRendererProperties.wordWrap = true;
         messageTextField.width = 285;
         addChild(messageTextField);
         var _temp_7:* = messageTextField;
         var _temp_6:* = messageTextField;
         var _loc2_:String = "ui.windows.store.items.1003.desc";
         _temp_7.text = _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         availabilityTextField = new MobileWomTextField();
         availabilityTextField.textRendererProperties.textFormat = getWomTextFormat(23,"center",16777215);
         availabilityTextField.width = 300;
         addChild(availabilityTextField);
         availabilityTextField.text = _availabilityText;
         _confirmButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _confirmButton.width = 310;
         _confirmButton.defaultIcon = assetRepository.getDisplayObject("IconGoldM");
         _confirmButton.rightLabel = _requiredGold + "";
         var _temp_10:* = _confirmButton;
         var _loc3_:String = "ui.windows.gold.buy";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_confirmButton);
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(bg,_background,35);
         MobileAlignmentUtil.alignAccordingToPositionOf(messageTextField,bg,116,37);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(expandAsset,bg,-15);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(availabilityTextField,_background,205);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_confirmButton,_background,245);
      }
      
      public function get confirmButton() : MobileWomButton
      {
         return _confirmButton;
      }
      
      public function get requiredGold() : int
      {
         return _requiredGold;
      }
      
      public function set requiredGold(param1:int) : void
      {
         _requiredGold = param1;
      }
      
      public function set availabilityText(param1:String) : void
      {
         _availabilityText = param1;
      }
   }
}

