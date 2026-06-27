package wom.view.screen.windows.constructionsite
{
   import flash.display.DisplayObject;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomBrownSmallButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.component.progressbar.ProgressBar30;
   import wom.view.component.progressbar.WomProgressBar;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class ConstructionSiteWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 446;
      
      private static const WINDOW_HEIGHT:int = 324;
      
      protected var _workerAsset:AssetDisplayObject;
      
      protected var speechBubble:SpeechBubbleView;
      
      protected var _abandonButton:WomButton;
      
      protected var _finishNowButton:WomGreenLargeButton;
      
      protected var _shortenWithRPButton:WomButton;
      
      protected var progressBackground:DisplayObject;
      
      private var _buildingInfo:BuildingInfo;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _job:BuildingUpgradeJob;
      
      protected var _remainingDurationProgressBar:WomProgressBar;
      
      protected var clockIcon:DisplayObject;
      
      public function ConstructionSiteWindow(param1:BuildingInfo, param2:BuildingTypeDIO, param3:BuildingUpgradeJob, param4:Vector.<WindowEnumeration> = null, param5:int = 446, param6:int = 324)
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
         _workerAsset = assetRepository.getDisplayObject("WorkerNormal");
         addChild(_workerAsset);
         var _temp_4:* = §§findproperty(SpeechBubbleView);
         var _temp_3:* = windowWidth - 61;
         var _loc3_:String = "ui.windows.constructionsite.informationtext";
         speechBubble = new SpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc3_),null,null,118);
         speechBubble.respectMargins = false;
         addChild(speechBubble);
         progressBackground = assetRepository.getDisplayObject("BackgroundLight");
         progressBackground.width = 362;
         progressBackground.height = 75;
         addChild(progressBackground);
         _abandonButton = createAbondonButton();
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("Rp");
         _loc1_.height = _loc1_.height * (21 / _loc1_.width) >> 0;
         _loc1_.width = 21;
         _shortenWithRPButton = new WomBlueSmallButton();
         _shortenWithRPButton.width = 133;
         var _temp_9:* = _shortenWithRPButton;
         var _loc4_:String = "ui.windows.constructionsite.cutdurationwithrp";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _shortenWithRPButton.setStyle("icon",_loc1_);
         _shortenWithRPButton.rightLabel = "30";
         addChild(_shortenWithRPButton);
         _finishNowButton = new WomGreenLargeButton();
         _finishNowButton.width = 265;
         var _temp_11:* = _finishNowButton;
         var _loc5_:String = "ui.windows.constructionsite.finishnowbutton";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _finishNowButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         addChild(_finishNowButton);
         _remainingDurationProgressBar = createProgressBar();
         updateView();
         clockIcon = assetRepository.getDisplayObject("Clock45");
         addChild(clockIcon);
         drawLayout();
      }
      
      protected function createProgressBar() : ProgressBar30
      {
         var _loc1_:ProgressBar30 = new ProgressBar30();
         _loc1_.width = 167;
         _loc1_.textMarginX = 20;
         addChild(_loc1_);
         return _loc1_;
      }
      
      protected function createAbondonButton() : WomButton
      {
         var _loc1_:WomButton = new WomBrownSmallButton();
         _loc1_.width = 133;
         var _temp_1:* = _loc1_;
         var _loc2_:String = "ui.windows.constructionsite.cancelbutton";
         _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_loc1_);
         return _loc1_;
      }
      
      public function drawLayout() : void
      {
         _workerAsset.x = -164;
         _workerAsset.y = -46;
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,17,56);
         AlignmentUtil.alignAccordingToPositionOf(progressBackground,_background,41,181);
         AlignmentUtil.alignAccordingToPositionOf(clockIcon,progressBackground,14,15);
         AlignmentUtil.alignAccordingToPositionOf(_remainingDurationProgressBar,clockIcon,29,7);
         drawButtonsAlignment();
      }
      
      protected function drawButtonsAlignment() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_abandonButton,progressBackground,223,6);
         AlignmentUtil.alignBelowOf(_shortenWithRPButton,_abandonButton,3);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_finishNowButton,_background,_windowHeight - _finishNowButton.height / 2 << 0);
      }
      
      public function updateView() : void
      {
         var _loc2_:Number = new Date().getTime() - _job.jobCreationTime;
         var _loc1_:Number = _job.durationRemaining - _loc2_;
         _remainingDurationProgressBar.setProgress(_job.originalDuration - _loc1_,_job.originalDuration);
         _remainingDurationProgressBar.progressText = LocalizedDateTimeUtil.getUserFriendlyTime(_loc1_);
         var _loc3_:String;
         _finishNowButton.rightLabel = _loc1_ < 300000 ? (_loc3_ = "ui.windows.constructionsite.free",peak.i18n.PText.INSTANCE.getText0(_loc3_)) : StoreUtil.buildingPrice(0,_loc1_ / 1000) + "";
         _shortenWithRPButton.enabled = _job.durationRemaining > 300000;
      }
      
      public function updateUpgradeJob(param1:BuildingUpgradeJob) : void
      {
         _job = param1;
         updateView();
      }
      
      public function get abandonButton() : WomButton
      {
         return _abandonButton;
      }
      
      public function get finishNowButton() : WomGreenLargeButton
      {
         return _finishNowButton;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      public function get workerAsset() : AssetDisplayObject
      {
         return _workerAsset;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get jobType() : BuildingUpgradeJobType
      {
         return _job.type;
      }
      
      public function get remainingTime() : int
      {
         return _job.durationRemaining;
      }
      
      public function get job() : BuildingUpgradeJob
      {
         return _job;
      }
      
      public function get shortenWithRPButton() : WomButton
      {
         return _shortenWithRPButton;
      }
   }
}

