package wom.view.screen.windows.trainingchamber
{
   import com.greensock.TweenLite;
   import fl.controls.Button;
   import fl.controls.ProgressBar;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.component.button.colored.WomRedLargeButton;
   import wom.view.component.button.rigid.TrainingChamberNextButton;
   import wom.view.component.button.rigid.TrainingChamberPreviousButton;
   import wom.view.component.progressbar.ProgressBar30;
   import wom.view.ui.common.IconLabelView;
   import wom.view.ui.common.OrView;
   import wom.view.ui.common.ResourceGroupView;
   import wom.view.util.GenericWindow;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class TrainingChamberWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 729;
      
      private static const WINDOW_HEIGHT:int = 522;
      
      private var trainDetailsBackground:DisplayObject;
      
      private var trainCostsBackground:DisplayObject;
      
      private var _mercenaryPicture:DisplayObject;
      
      private var lockIcon:DisplayObject;
      
      private var _previousMercenaryButton:Button;
      
      private var _nextMercenaryButton:Button;
      
      private var shieldIcon:DisplayObject;
      
      private var currentLevelTextField:TextField;
      
      private var mercenaryNameTextField:TextField;
      
      private var favoriteTargetLabel:TextField;
      
      private var favoriteTargetsTextField:TextField;
      
      private var trainDetailsCaption:TextField;
      
      private var beforeLabel:TextField;
      
      private var afterLabel:TextField;
      
      private var speedLabel:TextField;
      
      private var speedBeforeTextField:TextField;
      
      private var speedBeforeProgressBar:ProgressBar;
      
      private var speedAfterTextField:TextField;
      
      private var speedAfterProgressBar:ProgressBar;
      
      private var healthLabel:TextField;
      
      private var healthBeforeTextField:TextField;
      
      private var healthBeforeProgressBar:ProgressBar;
      
      private var healthAfterTextField:TextField;
      
      private var healthAfterProgressBar:ProgressBar;
      
      private var damageLabel:TextField;
      
      private var damageBeforeTextField:TextField;
      
      private var damageBeforeProgressBar:ProgressBar;
      
      private var damageAfterTextField:TextField;
      
      private var damageAfterProgressBar:ProgressBar;
      
      private var resourceLabel:TextField;
      
      private var resourceBeforeTextField:TextField;
      
      private var resourceBeforeProgressBar:ProgressBar;
      
      private var resourceAfterTextField:TextField;
      
      private var resourceAfterProgressBar:ProgressBar;
      
      private var housingLabel:TextField;
      
      private var housingBeforeTextField:TextField;
      
      private var housingBeforeProgressBar:ProgressBar;
      
      private var housingAfterTextField:TextField;
      
      private var housingAfterProgressBar:ProgressBar;
      
      private var timeLabel:TextField;
      
      private var timeBeforeTextField:TextField;
      
      private var timeBeforeProgressBar:ProgressBar;
      
      private var timeAfterTextField:TextField;
      
      private var timeAfterProgressBar:ProgressBar;
      
      private var requirementsLabel:TextField;
      
      private var _costView:ResourceGroupView;
      
      private var durationView:IconLabelView;
      
      private var chamberLevelView:IconLabelView;
      
      private var chamberLevelTextField:TextField;
      
      private var _startTrainingButton:WomButton;
      
      private var _instantTrainButton:WomButton;
      
      private var _trainedButton:WomButton;
      
      private var _finishNowButton:WomButton;
      
      private var _stopButton:WomButton;
      
      private var _shortenWithRPButton:WomButton;
      
      private var orIcon:DisplayObject;
      
      private var _unitTypeInfo:UnitTypeInfo;
      
      private var unitTypeDIO:UnitTypeDIO;
      
      private var _instanceId:int;
      
      private var remainingTimeLabel:TextField;
      
      private var _remainingTimeTextField:TextField;
      
      private var remainingTimeIcon:DisplayObject;
      
      private var _remainingProgressBar:ProgressBar;
      
      private var _currentIndex:int;
      
      private var _activeTrainingForThisBuilding:int;
      
      private var processIsFromAnotherChamberTextField:TextField;
      
      public function TrainingChamberWindow(param1:int)
      {
         super(729,522);
         _instanceId = param1;
         _activeTrainingForThisBuilding = -1;
         _currentIndex = -1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc2_:String = "ui.windows.trainingchamber.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         _mercenaryPicture = assetRepository.getDisplayObject("BedoinBruteTrch");
         addChild(_mercenaryPicture);
         lockIcon = assetRepository.getDisplayObject("RecruitmentChamberLockIconBig");
         lockIcon.visible = false;
         addChild(lockIcon);
         _previousMercenaryButton = new TrainingChamberPreviousButton();
         addChild(_previousMercenaryButton);
         _nextMercenaryButton = new TrainingChamberNextButton();
         addChild(_nextMercenaryButton);
         shieldIcon = assetRepository.getDisplayObject("MercenaryLevel41Px");
         addChild(shieldIcon);
         currentLevelTextField = new CaptionTextField();
         currentLevelTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_30;
         currentLevelTextField.autoSize = "left";
         addChild(currentLevelTextField);
         mercenaryNameTextField = new CaptionTextField();
         mercenaryNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_24;
         mercenaryNameTextField.autoSize = "left";
         addChild(mercenaryNameTextField);
         favoriteTargetLabel = new CaptionTextField();
         favoriteTargetLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         favoriteTargetLabel.autoSize = "left";
         var _temp_10:* = favoriteTargetLabel;
         var _loc3_:String = "ui.windows.trainingchamber.favoritetargets";
         _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc3_) + " :";
         addChild(favoriteTargetLabel);
         favoriteTargetsTextField = new WomTextField();
         favoriteTargetsTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         favoriteTargetsTextField.width = 220;
         favoriteTargetsTextField.autoSize = "left";
         addChild(favoriteTargetsTextField);
         trainDetailsCaption = new CaptionTextField();
         trainDetailsCaption.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         trainDetailsCaption.autoSize = "left";
         trainDetailsCaption.height = 19;
         var _temp_13:* = trainDetailsCaption;
         var _loc4_:String = "ui.windows.trainingchamber.traindetails";
         _temp_13.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(trainDetailsCaption);
         beforeLabel = new WomTextField();
         beforeLabel.defaultTextFormat = WomTextFormats.CENTER_16;
         beforeLabel.width = 130;
         var _temp_15:* = beforeLabel;
         var _loc5_:String = "ui.windows.trainingchamber.beforetraining";
         _temp_15.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(beforeLabel);
         afterLabel = new WomTextField();
         afterLabel.defaultTextFormat = WomTextFormats.CENTER_16;
         afterLabel.width = 130;
         var _temp_17:* = afterLabel;
         var _loc6_:String = "ui.windows.trainingchamber.aftertraining";
         _temp_17.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(afterLabel);
         speedLabel = createLabel("movementspeed");
         healthLabel = createLabel("health");
         damageLabel = createLabel("damage");
         resourceLabel = createLabel("resourcecost");
         housingLabel = createLabel("housing");
         timeLabel = createLabel("time");
         speedBeforeProgressBar = createProgressBar();
         healthBeforeProgressBar = createProgressBar();
         damageBeforeProgressBar = createProgressBar();
         resourceBeforeProgressBar = createProgressBar();
         housingBeforeProgressBar = createProgressBar();
         timeBeforeProgressBar = createProgressBar();
         speedBeforeTextField = createProgressBarTextField();
         healthBeforeTextField = createProgressBarTextField();
         damageBeforeTextField = createProgressBarTextField();
         resourceBeforeTextField = createProgressBarTextField();
         housingBeforeTextField = createProgressBarTextField();
         timeBeforeTextField = createProgressBarTextField();
         speedAfterProgressBar = createProgressBar();
         healthAfterProgressBar = createProgressBar();
         damageAfterProgressBar = createProgressBar();
         resourceAfterProgressBar = createProgressBar();
         housingAfterProgressBar = createProgressBar();
         timeAfterProgressBar = createProgressBar();
         speedAfterTextField = createProgressBarTextField();
         healthAfterTextField = createProgressBarTextField();
         damageAfterTextField = createProgressBarTextField();
         resourceAfterTextField = createProgressBarTextField();
         housingAfterTextField = createProgressBarTextField();
         timeAfterTextField = createProgressBarTextField();
         requirementsLabel = new CaptionTextField();
         requirementsLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         requirementsLabel.autoSize = "left";
         var _temp_49:* = requirementsLabel;
         var _loc7_:String = "ui.windows.build.requirements";
         _temp_49.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(requirementsLabel);
         _costView = new ResourceGroupView();
         addChild(_costView);
         durationView = new IconLabelView("Clock45","");
         addChild(durationView);
         var _temp_53:* = §§findproperty(IconLabelView);
         var _temp_52:* = "Upgrade";
         var _loc8_:String = "ui.windows.recruitmentchamber.chamberlevel";
         chamberLevelView = new IconLabelView(_temp_52,peak.i18n.PText.INSTANCE.getText0(_loc8_));
         addChild(chamberLevelView);
         chamberLevelTextField = new CaptionTextField();
         chamberLevelTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         chamberLevelTextField.autoSize = "left";
         addChild(chamberLevelTextField);
         _startTrainingButton = new WomBlueLargeButton();
         var _temp_57:* = _startTrainingButton;
         var _loc9_:String = "ui.windows.trainingchamber.starttraining";
         _temp_57.label = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         _startTrainingButton.width = 208;
         addChild(_startTrainingButton);
         _instantTrainButton = new WomGreenLargeButton();
         var _temp_59:* = _instantTrainButton;
         var _loc10_:String = "ui.windows.trainingchamber.instanttraining";
         _temp_59.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         _instantTrainButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         _instantTrainButton.width = 288;
         addChild(_instantTrainButton);
         _trainedButton = new WomBlueLargeButton();
         var _temp_61:* = _trainedButton;
         var _loc11_:String = "ui.windows.trainingchamber.trainedmax";
         _temp_61.label = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         _trainedButton.width = 230;
         _trainedButton.mouseEnabled = false;
         _trainedButton.enabled = false;
         addChild(_trainedButton);
         _stopButton = new WomRedLargeButton();
         var _temp_63:* = _stopButton;
         var _loc12_:String = "ui.windows.trainingchamber.stop";
         _temp_63.label = peak.i18n.PText.INSTANCE.getText0(_loc12_);
         _stopButton.width = 120;
         addChild(_stopButton);
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("Rp");
         _loc1_.height = _loc1_.height * (21 / _loc1_.width) >> 0;
         _loc1_.width = 21;
         _shortenWithRPButton = new WomBlueSmallButton();
         _shortenWithRPButton.width = 133;
         var _temp_65:* = _shortenWithRPButton;
         var _loc13_:String = "ui.windows.constructionsite.cutdurationwithrp";
         _temp_65.label = peak.i18n.PText.INSTANCE.getText0(_loc13_);
         _shortenWithRPButton.setStyle("icon",_loc1_);
         _shortenWithRPButton.rightLabel = "30";
         addChild(_shortenWithRPButton);
         _finishNowButton = new WomGreenLargeButton();
         _finishNowButton.width = 265;
         var _temp_67:* = _finishNowButton;
         var _loc14_:String = "ui.windows.constructionsite.finishnowbutton";
         _temp_67.label = peak.i18n.PText.INSTANCE.getText0(_loc14_);
         _finishNowButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         addChild(_finishNowButton);
         orIcon = new OrView();
         addChild(orIcon);
         remainingTimeLabel = new CaptionTextField();
         remainingTimeLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         remainingTimeLabel.autoSize = "left";
         var _temp_70:* = remainingTimeLabel;
         var _loc15_:String = "ui.windows.trainingchamber.remainingtime";
         _temp_70.text = peak.i18n.PText.INSTANCE.getText0(_loc15_);
         addChild(remainingTimeLabel);
         processIsFromAnotherChamberTextField = new WomTextField();
         processIsFromAnotherChamberTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         processIsFromAnotherChamberTextField.autoSize = "left";
         var _temp_72:* = processIsFromAnotherChamberTextField;
         var _loc16_:String = "ui.windows.trainingchamber.processfromother";
         _temp_72.text = peak.i18n.PText.INSTANCE.getText0(_loc16_);
         processIsFromAnotherChamberTextField.visible = false;
         addChild(processIsFromAnotherChamberTextField);
         _remainingProgressBar = createProgressBar();
         _remainingProgressBar.width = 348;
         _remainingTimeTextField = new CaptionTextField();
         _remainingTimeTextField.autoSize = "left";
         _remainingTimeTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         addChild(_remainingTimeTextField);
         remainingTimeIcon = assetRepository.getDisplayObject("Clock45");
         addChild(remainingTimeIcon);
      }
      
      private function createLabel(param1:String) : TextField
      {
         var _loc2_:TextField = new CaptionTextField();
         _loc2_.defaultTextFormat = WomTextFormats.RIGHT_16;
         _loc2_.width = 114;
         _loc2_.height = 17;
         var _temp_1:* = _loc2_;
         var _loc3_:String = "ui.windows.trainingchamber." + param1;
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function createProgressBar() : ProgressBar
      {
         var _loc1_:ProgressBar = new ProgressBar30();
         _loc1_.width = 130;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function createProgressBarTextField() : TextField
      {
         var _loc1_:TextField = new CaptionTextField();
         _loc1_.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _loc1_.width = 87;
         _loc1_.height = 17;
         addChild(_loc1_);
         return _loc1_;
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         trainDetailsBackground = assetRepository.getDisplayObject("BackgroundLight");
         trainDetailsBackground.width = 396;
         trainDetailsBackground.height = 220;
         trainDetailsBackground.x = 304;
         trainDetailsBackground.y = 101;
         addChild(trainDetailsBackground);
         trainCostsBackground = assetRepository.getDisplayObject("BackgroundLight");
         trainCostsBackground.width = 396;
         trainCostsBackground.height = 121;
         AlignmentUtil.alignBelowOf(trainCostsBackground,trainDetailsBackground,20);
         addChild(trainCostsBackground);
      }
      
      public function drawLayout() : void
      {
         if(unitTypeDIO)
         {
            _mercenaryPicture.x = unitTypeDIO.trainingChamberOffset.x;
            _mercenaryPicture.y = unitTypeDIO.trainingChamberOffset.y;
         }
         else
         {
            _mercenaryPicture.x = -116;
            _mercenaryPicture.y = 0;
         }
         lockIcon.x = 100;
         lockIcon.y = 155;
         _previousMercenaryButton.x = 77;
         _previousMercenaryButton.y = 425;
         AlignmentUtil.alignRightOf(_nextMercenaryButton,_previousMercenaryButton,4);
         shieldIcon.x = 305;
         shieldIcon.y = 38;
         AlignmentUtil.alignAccordingToPositionOf(currentLevelTextField,shieldIcon,17,1);
         AlignmentUtil.alignRightWithYMarginOf(mercenaryNameTextField,shieldIcon,-3,6);
         AlignmentUtil.alignBelowOf(favoriteTargetLabel,mercenaryNameTextField,-3);
         AlignmentUtil.alignRightWithYMarginOf(favoriteTargetsTextField,favoriteTargetLabel,2,2);
         AlignmentUtil.alignAccordingToPositionOf(trainDetailsCaption,trainDetailsBackground,20,-10);
         var _loc1_:Boolean = unitTypeDIO && unitTypeDIO.event;
         housingLabel.visible = housingBeforeProgressBar.visible = housingAfterProgressBar.visible = housingBeforeTextField.visible = housingAfterTextField.visible = !_loc1_;
         AlignmentUtil.alignAccordingToPositionOf(speedLabel,trainDetailsBackground,0,35);
         AlignmentUtil.alignBelowOf(healthLabel,speedLabel,13);
         AlignmentUtil.alignBelowOf(damageLabel,healthLabel,13);
         AlignmentUtil.alignBelowOf(resourceLabel,damageLabel,13);
         AlignmentUtil.alignBelowOf(housingLabel,resourceLabel,13);
         AlignmentUtil.alignBelowOf(timeLabel,_loc1_ ? resourceLabel : housingLabel,13);
         AlignmentUtil.alignRightWithYMarginOf(speedBeforeProgressBar,speedLabel,-4,10);
         AlignmentUtil.alignRightWithYMarginOf(healthBeforeProgressBar,healthLabel,-4,10);
         AlignmentUtil.alignRightWithYMarginOf(damageBeforeProgressBar,damageLabel,-4,10);
         AlignmentUtil.alignRightWithYMarginOf(resourceBeforeProgressBar,resourceLabel,-4,10);
         AlignmentUtil.alignRightWithYMarginOf(housingBeforeProgressBar,_loc1_ ? resourceLabel : housingLabel,-4,10);
         AlignmentUtil.alignRightWithYMarginOf(timeBeforeProgressBar,timeLabel,-4,10);
         AlignmentUtil.alignRightOf(speedBeforeTextField,speedLabel,17);
         AlignmentUtil.alignRightOf(healthBeforeTextField,healthLabel,17);
         AlignmentUtil.alignRightOf(damageBeforeTextField,damageLabel,17);
         AlignmentUtil.alignRightOf(resourceBeforeTextField,resourceLabel,17);
         AlignmentUtil.alignRightOf(housingBeforeTextField,_loc1_ ? resourceLabel : housingLabel,17);
         AlignmentUtil.alignRightOf(timeBeforeTextField,timeLabel,17);
         AlignmentUtil.alignRightOf(speedAfterProgressBar,speedBeforeProgressBar,4);
         AlignmentUtil.alignRightOf(healthAfterProgressBar,healthBeforeProgressBar,4);
         AlignmentUtil.alignRightOf(damageAfterProgressBar,damageBeforeProgressBar,4);
         AlignmentUtil.alignRightOf(resourceAfterProgressBar,resourceBeforeProgressBar,4);
         AlignmentUtil.alignRightOf(housingAfterProgressBar,housingBeforeProgressBar,4);
         AlignmentUtil.alignRightOf(timeAfterProgressBar,timeBeforeProgressBar,4);
         AlignmentUtil.alignRightOf(speedAfterTextField,speedBeforeTextField,47);
         AlignmentUtil.alignRightOf(healthAfterTextField,healthBeforeTextField,47);
         AlignmentUtil.alignRightOf(damageAfterTextField,damageBeforeTextField,47);
         AlignmentUtil.alignRightOf(resourceAfterTextField,resourceBeforeTextField,47);
         AlignmentUtil.alignRightOf(housingAfterTextField,housingBeforeTextField,47);
         AlignmentUtil.alignRightOf(timeAfterTextField,timeBeforeTextField,47);
         AlignmentUtil.alignAccordingToPositionOf(beforeLabel,speedBeforeProgressBar,0,-25);
         AlignmentUtil.alignAccordingToPositionOf(afterLabel,speedAfterProgressBar,0,-25);
         AlignmentUtil.alignAccordingToPositionOf(requirementsLabel,trainCostsBackground,20,-10);
         AlignmentUtil.alignMiddleOf(durationView,trainCostsBackground);
         AlignmentUtil.alignLeftOf(_costView,durationView);
         AlignmentUtil.alignRightOf(chamberLevelView,durationView);
         AlignmentUtil.alignMiddleOf(chamberLevelTextField,chamberLevelView);
         _startTrainingButton.x = 89;
         _trainedButton.y = _stopButton.y = _startTrainingButton.y = 522 - (_startTrainingButton.height / 2 << 0) - 13;
         _stopButton.x = 212;
         _trainedButton.x = (729 - _trainedButton.width) / 2 << 0;
         AlignmentUtil.alignRightOf(_instantTrainButton,_startTrainingButton,18);
         AlignmentUtil.alignRightOf(_finishNowButton,_stopButton,18);
         if(_startTrainingButton.visible)
         {
            orIcon.visible = true;
            AlignmentUtil.alignRightWithYMarginOf(orIcon,_startTrainingButton,11,-11);
         }
         else if(_stopButton.visible)
         {
            orIcon.visible = true;
            AlignmentUtil.alignRightWithYMarginOf(orIcon,_stopButton,11,-11);
         }
         else
         {
            orIcon.visible = false;
         }
         AlignmentUtil.alignAccordingToPositionOf(remainingTimeLabel,trainCostsBackground,20,-10);
         AlignmentUtil.alignBelowOf(processIsFromAnotherChamberTextField,remainingTimeLabel);
         AlignmentUtil.alignBelowWithXMarginOf(_shortenWithRPButton,trainDetailsBackground,trainDetailsBackground.width - shortenWithRPButton.width - 12,47);
         AlignmentUtil.alignBelowWithXMarginOf(remainingTimeIcon,trainDetailsBackground,10,80);
         AlignmentUtil.alignAccordingToPositionOf(_remainingProgressBar,remainingTimeIcon,28,8);
         AlignmentUtil.alignAccordingToPositionOf(_remainingTimeTextField,remainingTimeIcon,55,13);
      }
      
      public function update(param1:UnitTypeDIO, param2:UnitTypeInfo, param3:Boolean) : void
      {
         var _loc14_:int = 0;
         this.unitTypeDIO = param1;
         this._unitTypeInfo = param2;
         removeChild(_mercenaryPicture);
         _mercenaryPicture = assetRepository.getDisplayObject(param1.assetName + (param1.event ? "Large" : "Trch"));
         addChildAt(_mercenaryPicture,getChildIndex(lockIcon));
         lockIcon.visible = !param3;
         _mercenaryPicture.alpha = param3 ? 1 : 0.5;
         var _temp_2:* = damageLabel;
         var _loc25_:String = "ui.windows.trainingchamber." + (param1.healer ? "heal" : "damage");
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc25_);
         var _temp_3:* = resourceLabel;
         var _loc26_:String = param1.event ? "ui.windows.upgrade.cost" : "ui.windows.trainingchamber.resourcecost";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc26_);
         currentLevelTextField.text = param2.currentLevel + "";
         var _temp_4:* = mercenaryNameTextField;
         var _loc27_:String = "domain.units." + param1.id + ".name";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc27_);
         favoriteTargetsTextField.text = "";
         if(param1.healer)
         {
            var _temp_5:* = favoriteTargetsTextField;
            var _loc28_:String = "ui.windows.trainingchamber.healer";
            _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc28_);
         }
         else if(param1.targetsAnything)
         {
            var _temp_6:* = favoriteTargetsTextField;
            var _loc29_:String = "ui.windows.trainingchamber.anything";
            _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc29_);
         }
         else
         {
            _loc14_ = 0;
            while(_loc14_ < param1.favouriteTargets.length)
            {
               if(favoriteTargetsTextField.text != "")
               {
                  favoriteTargetsTextField.appendText(", ");
               }
               var _temp_7:* = favoriteTargetsTextField;
               var _loc30_:String = "domain.buildingkinds." + param1.favouriteTargets[_loc14_] + ".name";
               _temp_7.appendText(peak.i18n.PText.INSTANCE.getText0(_loc30_));
               _loc14_++;
            }
         }
         favoriteTargetLabel.visible = favoriteTargetsTextField.visible = param1.id != 34;
         var _loc13_:int = param2.currentLevel - 1;
         var _loc18_:int = param2.currentLevel;
         if(_loc18_ == param1.maxLevels)
         {
            _loc18_--;
         }
         chamberLevelTextField.text = "" + param1.trainingPrerequisitesPerLevel[_loc18_].level;
         var _loc10_:Number = param1.speed(_loc13_);
         var _loc12_:int = param1.healthPointsPerLevel[_loc13_];
         var _loc19_:int = param1.damage(_loc13_);
         var _loc5_:Number = param1.hiringCostsPerLevel[_loc13_][0].resourceAmount;
         var _loc6_:int = param1.spacesPerLevel[_loc13_];
         var _loc7_:Number = param1.hiringDurationPerLevelInSecs[_loc13_];
         var _loc24_:Number = param1.speed(_loc18_);
         var _loc17_:int = param1.healthPointsPerLevel[_loc18_];
         var _loc4_:int = param1.damage(_loc18_);
         var _loc16_:Number = param1.hiringCostsPerLevel[_loc18_][0].resourceAmount;
         var _loc11_:int = param1.spacesPerLevel[_loc18_];
         var _loc9_:Number = param1.hiringDurationPerLevelInSecs[_loc18_];
         var _loc15_:Number = param1.speed(param1.maxLevels - 1);
         var _loc22_:int = param1.healthPointsPerLevel[param1.maxLevels - 1];
         var _loc23_:int = param1.damage(param1.maxLevels - 1);
         var _loc20_:Number = param1.hiringCostsPerLevel[param1.maxLevels - 1][0].resourceAmount;
         var _loc21_:int = param1.spacesPerLevel[param1.maxLevels - 1];
         var _loc8_:Number = param1.hiringDurationPerLevelInSecs[0];
         _loc14_ = 1;
         while(_loc14_ < param1.maxLevels)
         {
            if(_loc8_ < param1.hiringDurationPerLevelInSecs[_loc14_])
            {
               _loc8_ = param1.hiringDurationPerLevelInSecs[_loc14_];
            }
            _loc14_++;
         }
         TweenLite.to(speedBeforeProgressBar,0.2,{
            "value":_loc10_,
            "maximum":_loc15_
         });
         TweenLite.to(healthBeforeProgressBar,0.2,{
            "value":_loc12_,
            "maximum":_loc22_
         });
         TweenLite.to(damageBeforeProgressBar,0.2,{
            "value":_loc19_,
            "maximum":_loc23_
         });
         TweenLite.to(resourceBeforeProgressBar,0.2,{
            "value":_loc5_,
            "maximum":_loc20_
         });
         TweenLite.to(housingBeforeProgressBar,0.2,{
            "value":_loc6_,
            "maximum":_loc21_
         });
         TweenLite.to(timeBeforeProgressBar,0.2,{
            "value":_loc7_,
            "maximum":_loc8_
         });
         TweenLite.to(speedAfterProgressBar,0.2,{
            "value":_loc24_,
            "maximum":_loc15_
         });
         TweenLite.to(healthAfterProgressBar,0.2,{
            "value":_loc17_,
            "maximum":_loc22_
         });
         TweenLite.to(damageAfterProgressBar,0.2,{
            "value":_loc4_,
            "maximum":_loc23_
         });
         TweenLite.to(resourceAfterProgressBar,0.2,{
            "value":_loc16_,
            "maximum":_loc20_
         });
         TweenLite.to(housingAfterProgressBar,0.2,{
            "value":_loc11_,
            "maximum":_loc21_
         });
         TweenLite.to(timeAfterProgressBar,0.2,{
            "value":_loc9_,
            "maximum":_loc8_
         });
         var _temp_11:* = speedBeforeTextField;
         var _temp_10:* = _loc10_ + " ";
         var _loc31_:String = "ui.windows.trainingchamber.kph";
         _temp_11.text = _temp_10 + peak.i18n.PText.INSTANCE.getText0(_loc31_);
         healthBeforeTextField.text = _loc12_ + "";
         damageBeforeTextField.text = _loc19_ + "";
         resourceBeforeTextField.text = _loc5_ + "";
         var _temp_13:* = housingBeforeTextField;
         var _temp_12:* = _loc6_ + " ";
         var _loc32_:String = "ui.windows.trainingchamber.spaces";
         _temp_13.text = _temp_12 + peak.i18n.PText.INSTANCE.getText0(_loc32_);
         timeBeforeTextField.text = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc7_);
         var _temp_15:* = speedAfterTextField;
         var _temp_14:* = _loc24_ + " ";
         var _loc33_:String = "ui.windows.trainingchamber.kph";
         _temp_15.text = _temp_14 + peak.i18n.PText.INSTANCE.getText0(_loc33_);
         healthAfterTextField.text = _loc17_ + "";
         damageAfterTextField.text = _loc4_ + "";
         resourceAfterTextField.text = _loc16_ + "";
         var _temp_17:* = housingAfterTextField;
         var _temp_16:* = _loc11_ + " ";
         var _loc34_:String = "ui.windows.trainingchamber.spaces";
         _temp_17.text = _temp_16 + peak.i18n.PText.INSTANCE.getText0(_loc34_);
         timeAfterTextField.text = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc9_);
         _remainingProgressBar.visible = remainingTimeIcon.visible = remainingTimeLabel.visible = _remainingTimeTextField.visible = _finishNowButton.visible = _stopButton.visible = _shortenWithRPButton.visible = param2.currentlyTraining;
         _trainedButton.visible = param2.currentLevel == param1.maxLevels;
         chamberLevelTextField.visible = requirementsLabel.visible = chamberLevelView.visible = durationView.visible = _costView.visible = _startTrainingButton.visible = _instantTrainButton.visible = !param2.currentlyTraining && param2.currentLevel != param1.maxLevels;
         processIsFromAnotherChamberTextField.visible = _remainingTimeTextField.visible && param2.unitTypeId != activeTrainingForThisBuilding;
         _stopButton.enabled = _finishNowButton.enabled = _shortenWithRPButton.enabled = param2.unitTypeId == activeTrainingForThisBuilding;
         _costView.updateWithResources(param1.trainingCostsPerLevel[_loc18_]);
         durationView.label = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(param1.trainingDurationPerLevelInSecs[_loc18_]);
         _instantTrainButton.rightLabel = StoreUtil.mercenaryTrainAndRecruitPrice(param1.trainingCostsPerLevel[_loc18_][0].resourceAmount,param1.trainingDurationPerLevelInSecs[_loc18_]) + "";
         drawLayout();
      }
      
      public function get nextMercenaryButton() : Button
      {
         return _nextMercenaryButton;
      }
      
      public function get previousMercenaryButton() : Button
      {
         return _previousMercenaryButton;
      }
      
      public function get startTrainingButton() : WomButton
      {
         return _startTrainingButton;
      }
      
      public function get instantTrainButton() : WomButton
      {
         return _instantTrainButton;
      }
      
      public function get trainedButton() : WomButton
      {
         return _trainedButton;
      }
      
      public function get finishNowButton() : WomButton
      {
         return _finishNowButton;
      }
      
      public function get stopButton() : WomButton
      {
         return _stopButton;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get unitTypeInfo() : UnitTypeInfo
      {
         return _unitTypeInfo;
      }
      
      public function get remainingTimeTextField() : TextField
      {
         return _remainingTimeTextField;
      }
      
      public function get remainingProgressBar() : ProgressBar
      {
         return _remainingProgressBar;
      }
      
      public function get currentIndex() : int
      {
         return _currentIndex;
      }
      
      public function set currentIndex(param1:int) : void
      {
         _currentIndex = param1;
      }
      
      public function get activeTrainingForThisBuilding() : int
      {
         return _activeTrainingForThisBuilding;
      }
      
      public function set activeTrainingForThisBuilding(param1:int) : void
      {
         _activeTrainingForThisBuilding = param1;
      }
      
      public function get shortenWithRPButton() : WomButton
      {
         return _shortenWithRPButton;
      }
   }
}

