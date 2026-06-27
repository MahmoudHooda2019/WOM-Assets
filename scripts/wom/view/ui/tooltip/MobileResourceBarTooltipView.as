package wom.view.ui.tooltip
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.game.resource.ResourceType;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileResourceBarTooltipView extends MobileBaseTooltipView
   {
      
      public static const VIEW_WIDTH:Number = 294;
      
      public static const VIEW_HEIGHT:Number = 161;
      
      private var _addButton:MobileWomButton;
      
      private var capacityLabel:MobileCaptionTextField;
      
      private var currentLabel:MobileCaptionTextField;
      
      private var productionLabel:MobileCaptionTextField;
      
      private var capacityTextField:MobileWomTextField;
      
      private var currentTextField:MobileWomTextField;
      
      private var productionTextField:MobileWomTextField;
      
      private var _resourceType:ResourceType;
      
      public function MobileResourceBarTooltipView(param1:ResourceType)
      {
         super(294,161,true);
         _resourceType = param1;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "domain.resource." + _resourceType.id + ".name";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         var _loc2_:String = "ui.mainframe.city.tooltip.capacity";
         capacityLabel = createLabel(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         var _loc3_:String = "ui.mainframe.city.tooltip.current";
         currentLabel = createLabel(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         productionLabel = createLabel("production");
         capacityTextField = createTextField();
         currentTextField = createTextField();
         productionTextField = createTextField();
         _addButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         _addButton.width = 129;
         addChild(_addButton);
         _addButton.label = "ADD";
      }
      
      private function createLabel(param1:String) : MobileCaptionTextField
      {
         var _loc2_:MobileCaptionTextField = new MobileCaptionTextField();
         _loc2_.textRendererProperties.textFormat = getCaptionTextFormat(25);
         addChild(_loc2_);
         _loc2_.text = param1;
         return _loc2_;
      }
      
      private function createTextField() : MobileWomTextField
      {
         var _loc1_:MobileWomTextField = new MobileWomTextField();
         _loc1_.textRendererProperties.textFormat = getWomTextFormat(25);
         addChild(_loc1_);
         return _loc1_;
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_addButton,_bg,161 - (_addButton.height >> 1));
         MobileAlignmentUtil.alignAccordingToPositionOf(capacityLabel,_bg,35,34);
         MobileAlignmentUtil.alignBelowOf(currentLabel,capacityLabel,8);
         MobileAlignmentUtil.alignBelowOf(productionLabel,currentLabel,8);
         MobileAlignmentUtil.alignAccordingToPositionOf(capacityTextField,capacityLabel,140,-2);
         MobileAlignmentUtil.alignAccordingToPositionOf(currentTextField,currentLabel,140,-2);
         MobileAlignmentUtil.alignAccordingToPositionOf(productionTextField,productionLabel,140,-2);
      }
      
      public function updateWithData(param1:Number, param2:Number, param3:Number) : void
      {
         capacityTextField.text = NumberUtil.format(param1);
         currentTextField.text = NumberUtil.format(param2);
         var _temp_2:* = productionTextField;
         var _temp_1:* = NumberUtil.format(param3) + "/";
         var _loc4_:String = "ui.mainframe.city.tooltip.hour";
         _temp_2.text = _temp_1 + peak.i18n.PText.INSTANCE.getText0(_loc4_);
         drawLayout();
      }
      
      public function get addButton() : MobileWomButton
      {
         return _addButton;
      }
   }
}

