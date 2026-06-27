package wom.view.ui.mainframe.city
{
   import peak.display.View;
   import peak.i18n.PText;
   import peak.starling.FlatteningSprite;
   import peak.starling.InflatedBoundsSprite;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.tooltip.MobileInformativeTooltipView;
   
   public class MobileProtectionPanel extends InflatedBoundsSprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var flag:DisplayObject;
      
      private var protectionLabel:MobileCaptionTextField;
      
      private var remainingDurationTextField:MobileCaptionTextField;
      
      private var _tooltip:MobileInformativeTooltipView;
      
      public function MobileProtectionPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         visible = false;
         setPaddings(10,10,0,10);
         background = assetRepository.getDisplayObject("BackgroundTransparentProtectionPanel");
         background.width = 269;
         background.height = 40;
         addChild(background);
         protectionLabel = new MobileCaptionTextField();
         protectionLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(protectionLabel);
         var _temp_4:* = protectionLabel;
         var _loc1_:String = "ui.mainframe.city.protection";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         flag = assetRepository.getDisplayObject("IconProtectionMBordered");
         addChild(flag);
         remainingDurationTextField = new MobileCaptionTextField();
         remainingDurationTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(remainingDurationTextField);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(flag,background,-2);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(protectionLabel,background,10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(remainingDurationTextField,background,159);
      }
      
      public function updateRemainingDuration(param1:String) : void
      {
         var _loc2_:Boolean = false;
         if(remainingDurationTextField.text != param1 && parent is FlatteningSprite && parent.stage)
         {
            _loc2_ = true;
            (parent as FlatteningSprite).unflatten();
         }
         remainingDurationTextField.text = param1;
         drawLayout();
         if(_loc2_)
         {
            (parent as FlatteningSprite).flatten();
         }
      }
      
      public function get tooltip() : MobileInformativeTooltipView
      {
         return _tooltip;
      }
      
      public function set tooltip(param1:MobileInformativeTooltipView) : void
      {
         _tooltip = param1;
      }
   }
}

