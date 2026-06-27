package wom.view.screen.windows.beastcage
{
   import flash.geom.Point;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.build.MobileBuildingSilhouette;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileBeastCageWindow extends MobileGenericWindow
   {
      
      public static const WINDOW_WIDTH:Number = 830;
      
      public static const WINDOW_HEIGHT:Number = 614;
      
      private var _cityCenterView:DisplayObject;
      
      private var _beastCaveView:DisplayObject;
      
      private var _levelIcon:DisplayObject;
      
      private var requirementsLabel:MPTextField;
      
      private var explanationTextField:MPTextField;
      
      private var levelTextField:MPTextField;
      
      private var cityCenterTextField:MPTextField;
      
      private var beastCaveTextField:MPTextField;
      
      private var infoBackground:DisplayObject;
      
      private var beast1:DisplayObject;
      
      private var beast2:DisplayObject;
      
      private var beast3:DisplayObject;
      
      public function MobileBeastCageWindow()
      {
         super(830,614);
      }
      
      override protected function initLayout() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc3_:int = 0;
         super.initLayout();
         var _loc4_:String = "ui.windows.cagedbeast.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         beast1 = assetRepository.getDisplayObject("Bearwolf6");
         beast1.scaleX = -1;
         beast2 = assetRepository.getDisplayObject("Dragonfly6");
         beast3 = assetRepository.getDisplayObject("Mightosour6");
         addChild(beast3);
         addChild(beast1);
         addChild(beast2);
         var _loc2_:int = 71;
         _loc3_ = 0;
         while(_loc3_ < 15)
         {
            _loc1_ = assetRepository.getDisplayObject("Grate");
            addChild(_loc1_);
            MobileAlignmentUtil.alignAccordingToPositionOf(_loc1_,_background,_loc2_,16);
            _loc2_ += 48;
            _loc3_++;
         }
         infoBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         infoBackground.width = 722;
         infoBackground.height = 198;
         addChild(infoBackground);
         infoBackground.width = 722;
         infoBackground.height = 198;
         addChild(infoBackground);
         _cityCenterView = new MobileBuildingSilhouette(10,4,null,new Point(210,210));
         addChild(_cityCenterView);
         _beastCaveView = new MobileBuildingSilhouette(29,1,null,new Point(180,180));
         addChild(_beastCaveView);
         _levelIcon = assetRepository.getDisplayObject("IconUpgradeM");
         addChild(_levelIcon);
         requirementsLabel = createCaptionTextField(27);
         var _temp_10:* = requirementsLabel;
         var _loc5_:String = "ui.windows.cagedbeast.requirements";
         _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc5_) + ":";
         addChild(requirementsLabel);
         explanationTextField = createWomTextField(23);
         explanationTextField.width = 370;
         addChild(explanationTextField);
         var _temp_12:* = explanationTextField;
         var _loc6_:String = "ui.windows.cagedbeast.explanation";
         _temp_12.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         levelTextField = createCaptionTextField(27);
         addChild(levelTextField);
         levelTextField.text = "4";
         cityCenterTextField = createCaptionTextField(23);
         addChild(cityCenterTextField);
         var _temp_15:* = cityCenterTextField;
         var _loc7_:String = "domain.building.10.name";
         _temp_15.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         beastCaveTextField = createCaptionTextField(23);
         addChild(beastCaveTextField);
         var _temp_17:* = beastCaveTextField;
         var _loc8_:String = "domain.building.29.name";
         _temp_17.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         drawLayout();
      }
      
      private function createCaptionTextField(param1:int) : MobileCaptionTextField
      {
         var _loc2_:MobileCaptionTextField = new MobileCaptionTextField();
         _loc2_.textRendererProperties.textFormat = getCaptionTextFormat(param1);
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function createWomTextField(param1:int) : MobileWomTextField
      {
         var _loc2_:MobileWomTextField = new MobileWomTextField();
         _loc2_.width = 400;
         _loc2_.textRendererProperties.textFormat = getWomTextFormat(param1,"center");
         _loc2_.textRendererProperties.wordWrap = true;
         addChild(_loc2_);
         return _loc2_;
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(infoBackground,_background,370);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(explanationTextField,infoBackground,26);
         MobileAlignmentUtil.alignAccordingToPositionOf(requirementsLabel,infoBackground,495,-10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_cityCenterView,infoBackground,403,-20);
         MobileAlignmentUtil.alignAccordingToPositionOf(_beastCaveView,infoBackground,555,16);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_levelIcon,_cityCenterView,120);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(cityCenterTextField,_cityCenterView,177);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(beastCaveTextField,_beastCaveView,140);
         MobileAlignmentUtil.alignAccordingToPositionOf(levelTextField,_levelIcon,(_levelIcon.width - levelTextField.width >> 1) - 2,24);
         MobileAlignmentUtil.alignAccordingToPositionOf(beast1,_background,80 + beast1.width,25);
         MobileAlignmentUtil.alignAccordingToPositionOf(beast2,_background,198,1);
         MobileAlignmentUtil.alignAccordingToPositionOf(beast3,_background,420,58);
      }
   }
}

