package wom.view.screen.windows.cityplanner
{
   import feathers.controls.Button;
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextInput;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileCityPlannerLoadLayoutRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private static const WIDTH:int = 753;
      
      private static const HEIGHT:int = 118;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var slotNameLabel:MPTextField;
      
      private var slotNameInput:MobileWomTextInput;
      
      private var _loadButton:MobileWomButton;
      
      public function MobileCityPlannerLoadLayoutRenderer(param1:MobileWomAssetRepository, param2:Boolean)
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
         slotNameInput.isEnabled = false;
         slotNameInput.width = 505;
         addChild(slotNameInput);
         _loadButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         var _temp_5:* = _loadButton;
         var _loc3_:String = "ui.windows.cityplanner.load";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _loadButton.width = 121;
         addChild(_loadButton);
         drawLayout();
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _data = param1;
            _loadButton.data = param1.slotNum;
            slotNameInput.text = param1.name;
            if(param1.name == "")
            {
               slotNameInput.isEnabled = false;
               _loadButton.isEnabled = false;
            }
            var _temp_2:* = slotNameLabel;
            var _loc2_:String = "ui.windows.cityplanner.slot";
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc2_) + " " + param1.slotNum;
         }
      }
      
      private function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(slotNameLabel,background,0,45);
         MobileAlignmentUtil.alignAccordingToPositionOf(slotNameInput,background,85,24);
         MobileAlignmentUtil.alignRightOf(_loadButton,slotNameInput,14);
      }
      
      public function get loadButton() : Button
      {
         return _loadButton;
      }
   }
}

