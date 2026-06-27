package wom.view.ui.common
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileSharingPermissionsView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _yellowBackground:DisplayObject;
      
      private var _darkBackground:DisplayObject;
      
      private var _sharingLabel:MPTextField;
      
      private var _sharingTextField:MPTextField;
      
      public function MobileSharingPermissionsView()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _yellowBackground = assetRepository.getDisplayObject("BackgroundYellowPanel");
         _yellowBackground.width = visibleWidth;
         _yellowBackground.height = visibleHeight;
         addChild(_yellowBackground);
         _darkBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         _darkBackground.width = 575;
         _darkBackground.height = 48;
         addChild(_darkBackground);
         _sharingLabel = new MobileCaptionTextField();
         _sharingLabel.textRendererProperties.textFormat = getCaptionTextFormat(23);
         addChild(_sharingLabel);
         var _temp_4:* = _sharingLabel;
         var _loc1_:String = "m.ui.mainframe.sharing.disabledlabel";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _sharingTextField = new MobileWomTextField();
         _sharingTextField.textRendererProperties.textFormat = getWomTextFormat(23,null,16777215);
         addChild(_sharingTextField);
         var _temp_6:* = _sharingTextField;
         var _loc2_:String = "m.ui.mainframe.sharing.enabletext";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleOf(_darkBackground,_yellowBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(_sharingLabel,_darkBackground,8,15);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_sharingTextField,_darkBackground,280);
      }
      
      public function get visibleWidth() : int
      {
         return 606;
      }
      
      public function get visibleHeight() : int
      {
         return 89;
      }
   }
}

