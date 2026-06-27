package wom.view.screen.windows.constructionsite
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.StaffDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.staff.StaffInfo;
   import wom.model.game.store.StoreUtil;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.staff.MobileRequiredStaffsPanel;
   import wom.view.util.LocalizedDateTimeUtil;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileCityCenterConstructionSiteWindow extends MobileGenericWindow
   {
      
      private var infoTF:MPTextField;
      
      private var info2TF:MPTextField;
      
      private var staffPanel:MobileRequiredStaffsPanel;
      
      private var progressBarBackground:DisplayObject;
      
      private var timerIcon:DisplayObject;
      
      private var progressBar:MobileWomProgressBar;
      
      private var _abandonButton:MobileWomButton;
      
      private var _askFriendsButton:MobileWomButton;
      
      private var _finishNowButton:MobileWomButton;
      
      private var remainingDurationTF:MPTextField;
      
      private var _buildingInfo:BuildingInfo;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _job:BuildingUpgradeJob;
      
      public function MobileCityCenterConstructionSiteWindow(param1:BuildingInfo, param2:BuildingTypeDIO, param3:BuildingUpgradeJob)
      {
         super(840,520);
         _buildingInfo = param1;
         _buildingTypeDIO = param2;
         _job = param3;
      }
      
      [PostConstruct]
      override public function init() : void
      {
         super.init();
         initLayout();
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         setHeader("Upgrade Started!");
         infoTF = new MobileWomTextField();
         infoTF.width = 640;
         infoTF.textRendererProperties.textFormat = getWomTextFormat(21,"left",16777215);
         var _temp_2:* = infoTF;
         var _loc1_:String = "ui.windows.constructionsite.citycenterinformationtext";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(infoTF);
         info2TF = new MobileWomTextField();
         info2TF.width = 640;
         info2TF.textRendererProperties.textFormat = getWomTextFormat(21,"left",16777215);
         var _temp_4:* = info2TF;
         var _loc2_:String = "ui.windows.constructionsite.citycenterinformationtext2";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(info2TF);
         staffPanel = new MobileRequiredStaffsPanel();
         addChild(staffPanel);
         progressBarBackground = assetRepository.getDisplayObject("MobileBrownBackground");
         progressBarBackground.width = 753;
         progressBarBackground.height = 92;
         addChild(progressBarBackground);
         progressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         progressBar.width = 540;
         progressBar.height = 33;
         progressBar.minimum = 0;
         progressBar.align = "left";
         addChild(progressBar);
         timerIcon = assetRepository.getDisplayObject("IconTimerM");
         addChild(timerIcon);
         remainingDurationTF = new MobileWomTextField();
         remainingDurationTF.width = 400;
         remainingDurationTF.textRendererProperties.textFormat = getCaptionTextFormat(21,"left",16777215);
         addChild(remainingDurationTF);
         _abandonButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Small");
         var _temp_11:* = _abandonButton;
         var _loc3_:String = "ui.windows.constructionsite.cancelbutton";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _abandonButton.width = 128;
         addChild(_abandonButton);
         _askFriendsButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         var _temp_13:* = _askFriendsButton;
         var _loc4_:String = "ui.windows.constructionsite.askfriends";
         _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _askFriendsButton.width = 285;
         addChild(_askFriendsButton);
         _finishNowButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         var _temp_15:* = _finishNowButton;
         var _loc5_:String = "ui.windows.constructionsite.finishnowbutton";
         _temp_15.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _finishNowButton.width = 400;
         _finishNowButton.defaultIcon = assetRepository.getDisplayObject("IconGoldM");
         addChild(_finishNowButton);
         updateView();
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         infoTF.x = 50;
         infoTF.y = 54;
         info2TF.x = 50;
         info2TF.y = 75;
         progressBarBackground.x = 45;
         progressBarBackground.y = 364;
         MobileAlignmentUtil.alignAccordingToPositionOf(timerIcon,progressBarBackground,28,21);
         MobileAlignmentUtil.alignAccordingToPositionOf(progressBar,progressBarBackground,52,29);
         MobileAlignmentUtil.alignAccordingToPositionOf(_abandonButton,progressBarBackground,600,24);
         MobileAlignmentUtil.alignAccordingToPositionOf(remainingDurationTF,timerIcon,60,16);
         staffPanel.x = 45;
         staffPanel.y = 120;
         _askFriendsButton.x = 71;
         _askFriendsButton.y = 465;
         MobileAlignmentUtil.alignRightOf(_finishNowButton,_askFriendsButton,12);
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get job() : BuildingUpgradeJob
      {
         return _job;
      }
      
      public function updateWithStaffList(param1:BuildingInfo, param2:Vector.<StaffDIO>, param3:Vector.<StaffInfo>, param4:Vector.<Vector.<int>>) : void
      {
         staffPanel.updateWithStaffList(param1,param2,param3,param4);
         _askFriendsButton.isEnabled = !param3 || param2.length > param3.length;
      }
      
      public function get askFriendsButton() : MobileWomButton
      {
         return _askFriendsButton;
      }
      
      public function get abandonButton() : MobileWomButton
      {
         return _abandonButton;
      }
      
      public function get finishNowButton() : MobileWomButton
      {
         return _finishNowButton;
      }
      
      public function get remainingTime() : int
      {
         var _loc1_:Number = new Date().getTime() - _job.jobCreationTime;
         return _job.originalDuration - _loc1_;
      }
      
      public function updateView() : void
      {
         var _loc1_:Number = remainingTime;
         progressBar.maximum = _job.originalDuration;
         progressBar.value = _loc1_;
         remainingDurationTF.text = LocalizedDateTimeUtil.getUserFriendlyTime(_loc1_);
         var _loc2_:String;
         _finishNowButton.rightLabel = _job.durationRemaining < 300000 ? (_loc2_ = "ui.windows.constructionsite.free",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : StoreUtil.buildingPrice(0,_job.durationRemaining / 1000) + "";
      }
      
      public function updateUpgradeJob(param1:BuildingUpgradeJob) : void
      {
         _job = param1;
         updateView();
      }
   }
}

