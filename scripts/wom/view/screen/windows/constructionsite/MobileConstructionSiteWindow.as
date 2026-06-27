package wom.view.screen.windows.constructionsite
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileConstructionSiteWindow extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 560;
      
      private static const WINDOW_HEIGHT:int = 377;
      
      private var _abandonButton:MobileWomButton;
      
      private var _shortenWithRPButton:MobileWomButton;
      
      protected var progressBackground:DisplayObject;
      
      private var _buildingInfo:BuildingInfo;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _job:BuildingUpgradeJob;
      
      protected var _remainingDurationProgressBar:MobileWomProgressBar;
      
      protected var clockIcon:DisplayObject;
      
      public function MobileConstructionSiteWindow(param1:BuildingInfo, param2:BuildingTypeDIO, param3:BuildingUpgradeJob, param4:Vector.<WindowEnumeration> = null, param5:int = 560, param6:int = 377)
      {
         super(param5,param6,param4);
         this._buildingInfo = param1;
         this._buildingTypeDIO = param2;
         this._job = param3;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc2_:String = "ui.windows.constructionsite.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         _imageAsset = assetRepository.getDisplayObject("PoseWorker4");
         addChild(_imageAsset);
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = 450;
         var _loc3_:String = "ui.windows.constructionsite.informationtext";
         _speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc3_),null,false,35,39);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _actionButton.width = 395;
         var _temp_7:* = _actionButton;
         var _loc4_:String = "ui.windows.constructionsite.finishnowbutton";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _actionButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _actionButton.iconOffsetY = 3;
         _actionButton.iconOffsetX = -5;
         _actionButton.invalidate("styles");
         addChild(_actionButton);
         progressBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         progressBackground.width = 425;
         progressBackground.height = 120;
         addChild(progressBackground);
         _abandonButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Small");
         _abandonButton.width = 165;
         var _temp_10:* = _abandonButton;
         var _loc5_:String = "ui.windows.constructionsite.cancelbutton";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_abandonButton);
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("IconRPS");
         _shortenWithRPButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Small");
         _shortenWithRPButton.width = 165;
         var _temp_12:* = _shortenWithRPButton;
         var _loc6_:String = "ui.windows.constructionsite.cutdurationwithrp";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _shortenWithRPButton.defaultIcon = _loc1_;
         _shortenWithRPButton.rightLabel = "30";
         addChild(_shortenWithRPButton);
         _remainingDurationProgressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         _remainingDurationProgressBar.minimum = 0;
         _remainingDurationProgressBar.width = 228;
         _remainingDurationProgressBar.height = 33;
         _remainingDurationProgressBar.align = "center";
         addChild(_remainingDurationProgressBar);
         updateView();
         clockIcon = assetRepository.getDisplayObject("IconTimerM");
         addChild(clockIcon);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_imageAsset,_background,-_imageAsset.width / 5 * 2);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,70,50);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,windowHeight - _actionButton.height / 2);
         MobileAlignmentUtil.alignAccordingToPositionOf(progressBackground,_background,72,181);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(clockIcon,progressBackground,-clockIcon.width / 2);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_remainingDurationProgressBar,progressBackground,0);
         MobileAlignmentUtil.alignRightWithYMarginOf(_abandonButton,progressBackground,12,-_abandonButton.width - 14);
         MobileAlignmentUtil.alignBelowOf(_shortenWithRPButton,_abandonButton,5);
      }
      
      public function updateView() : void
      {
         var _loc2_:Number = new Date().getTime() - _job.jobCreationTime;
         var _loc1_:Number = _job.durationRemaining - _loc2_;
         _remainingDurationProgressBar.maximum = _job.originalDuration;
         _remainingDurationProgressBar.value = _job.originalDuration - _loc1_;
         _remainingDurationProgressBar.label = LocalizedDateTimeUtil.getUserFriendlyTime(_loc1_);
         var _loc3_:String;
         _actionButton.rightLabel = _job.durationRemaining < 300000 ? (_loc3_ = "ui.windows.constructionsite.free",peak.i18n.PText.INSTANCE.getText0(_loc3_)) : StoreUtil.buildingPrice(0,_job.durationRemaining / 1000) + "";
         _shortenWithRPButton.isEnabled = _job.durationRemaining > 300000;
      }
      
      public function updateUpgradeJob(param1:BuildingUpgradeJob) : void
      {
         _job = param1;
         updateView();
      }
      
      public function get abandonButton() : MobileWomButton
      {
         return _abandonButton;
      }
      
      public function get shortenWithRPButton() : MobileWomButton
      {
         return _shortenWithRPButton;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get job() : BuildingUpgradeJob
      {
         return _job;
      }
      
      public function get remainingTime() : int
      {
         return _job.durationRemaining;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
   }
}

