package wom.view.screen.windows.cityplanner
{
   import feathers.controls.Button;
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextInput;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileCityPlannerSaveLayoutRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private static const WIDTH:int = 753;
      
      private static const HEIGHT:int = 118;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var slotNameLabel:MPTextField;
      
      private var slotNameInput:MobileWomTextInput;
      
      private var _saveButton:MobileWomButton;
      
      private var _buyWithGoldButton:MobileWomButton;
      
      private var _buyWithRPButton:MobileWomButton;
      
      public function MobileCityPlannerSaveLayoutRenderer(param1:MobileWomAssetRepository, param2:Boolean)
      {
         super();
         this.assetRepository = param1;
         background = param1.getDisplayObject("MobileBeigeBackground");
         background.width = 753;
         background.height = 118;
         addChild(background);
         slotNameLabel = new MobileCaptionTextField();
         slotNameLabel.textRendererProperties.textFormat = getCaptionTextFormat(23,"right");
         slotNameLabel.width = 76;
         addChild(slotNameLabel);
         slotNameInput = new MobileWomTextInput();
         slotNameInput.addEventListener("change",onChange);
         slotNameInput.isEnabled = false;
         slotNameInput.width = 505;
         addChild(slotNameInput);
         _saveButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         var _temp_5:* = _saveButton;
         var _loc3_:String = "ui.windows.cityplanner.save";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _saveButton.width = 121;
         addChild(_saveButton);
         _buyWithGoldButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         var _temp_7:* = _buyWithGoldButton;
         var _loc4_:String = "ui.windows.cityplanner.buy";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _buyWithGoldButton.defaultIcon = param1.getDisplayObject("IconGoldS");
         _buyWithGoldButton.width = 171;
         addChild(_buyWithGoldButton);
         _buyWithRPButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         var _temp_9:* = _buyWithRPButton;
         var _loc5_:String = "ui.windows.cityplanner.buy";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _buyWithRPButton.defaultIcon = param1.getDisplayObject("IconRPS");
         _buyWithRPButton.width = 171;
         addChild(_buyWithRPButton);
      }
      
      private function onChange(param1:Event) : void
      {
         _data.name = slotNameInput.text;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:Boolean = false;
         if(param1)
         {
            _data = param1;
            _loc3_ = Boolean(param1.slotUnavailable);
            _loc2_ = Boolean(param1.buttonsEnabled);
            _saveButton.data = param1.slotNum;
            _buyWithGoldButton.data = param1.slotNum;
            _buyWithRPButton.data = param1.slotNum;
            _buyWithGoldButton.rightLabel = param1.goldCost;
            _buyWithRPButton.rightLabel = param1.rpCost;
            slotNameInput.text = param1.name;
            slotNameInput.isEnabled = !_loc3_;
            slotNameInput.width = _loc3_ ? 276 : 505;
            _buyWithGoldButton.visible = _loc3_;
            _buyWithGoldButton.isEnabled = _loc2_;
            _buyWithRPButton.visible = _loc3_;
            _buyWithRPButton.isEnabled = _loc2_;
            _saveButton.visible = !_loc3_;
            var _temp_2:* = slotNameLabel;
            var _loc4_:String = "ui.windows.cityplanner.slot";
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc4_) + " " + param1.slotNum;
            drawLayout();
         }
      }
      
      private function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(slotNameLabel,background,0,45);
         MobileAlignmentUtil.alignAccordingToPositionOf(slotNameInput,background,85,24);
         MobileAlignmentUtil.alignAccordingToPositionOf(_saveButton,background,604,24);
         MobileAlignmentUtil.alignAccordingToPositionOf(_buyWithGoldButton,background,376,24);
         MobileAlignmentUtil.alignRightOf(_buyWithRPButton,_buyWithGoldButton,9);
      }
      
      public function get saveButton() : Button
      {
         return _saveButton;
      }
      
      public function get buyWithGoldButton() : MobileWomButton
      {
         return _buyWithGoldButton;
      }
      
      public function get buyWithRPButton() : MobileWomButton
      {
         return _buyWithRPButton;
      }
   }
}

