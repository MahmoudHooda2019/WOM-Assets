package wom.view.screen.windows.beast.cave
{
   import flash.utils.Dictionary;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.job.BeastPreTrainingJob;
   import wom.model.game.job.BeastTrainingJob;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.LocalizedDateTimeUtil;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileDailyFeedPanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 774;
      
      private static const HEIGHT:int = 514;
      
      private static const PROGRESSBAR_WIDTH:int = 235;
      
      private static const PROGRESSBAR_HEIGHT:int = 36;
      
      private static const COSTASSET_WIDTH:int = 92;
      
      private static const BONUS_SYMBOL:String = "+ ";
      
      private static const BONUS_BG_WIDTH:int = 79;
      
      private static const BONUS_BG_HEIGHT:int = 38;
      
      private static const BONUS_LABEL_WIDTH:int = 64;
      
      private static const BONUS_INDEX_DAMAGE:int = 0;
      
      private static const BONUS_INDEX_HEALTH:int = 1;
      
      private static const BONUS_INDEX_SPEED:int = 2;
      
      private static const BONUS_INDEX_BUFF:int = 3;
      
      private static const BONUS_X_MARGIN:int = 9;
      
      private var _beastAsset:DisplayObject;
      
      private var nextFeedingProgressBar:MobileWomProgressBar;
      
      private var nextFeedingTextField:MPTextField;
      
      private var damageTextField:MPTextField;
      
      private var healthTextField:MPTextField;
      
      private var speedTextField:MPTextField;
      
      private var buffTextField:MPTextField;
      
      private var dailyFeedInfoTextField:MPTextField;
      
      private var costLabel:MPTextField;
      
      private var costButtons:Vector.<MPButton>;
      
      private var costTextFields:Vector.<MPTextField>;
      
      private var bonus1Label:MPTextField;
      
      private var bonus2Label:MPTextField;
      
      private var bonus3Label:MPTextField;
      
      private var bonusProgressBars:Vector.<Vector.<MobileWomProgressBar>>;
      
      private var bonusTexts:Vector.<Vector.<String>>;
      
      private var _feedUseResourcesButton:MPButton;
      
      private var _instantFeedButton:MobileWomButton;
      
      private var infoBackground:DisplayObject;
      
      private var beastNameTextField:MobileCaptionTextField;
      
      private var _remainingDurationForTraining:Number;
      
      public function MobileDailyFeedPanel()
      {
         super(774,514);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         beastNameTextField = new MobileCaptionTextField();
         beastNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(46);
         beastNameTextField.textRendererProperties.wordWrap = true;
         addChild(beastNameTextField);
         nextFeedingProgressBar = createProgressBar();
         nextFeedingTextField = new MobileCaptionTextField();
         nextFeedingTextField.width = 140;
         nextFeedingTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         nextFeedingTextField.textRendererProperties.wordWrap = true;
         addChild(nextFeedingTextField);
         var _loc1_:String = "ui.windows.beast.cave.beast.progressbar.speedtitle";
         speedTextField = createBonusHeaderTextField(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         var _loc2_:String = "ui.windows.beast.cave.beast.progressbar.healthtitle";
         healthTextField = createBonusHeaderTextField(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         var _loc3_:String = "ui.windows.beast.cave.beast.progressbar.damagetitle";
         damageTextField = createBonusHeaderTextField(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         var _loc4_:String = "ui.windows.beast.cave.beast.progressbar.bufftitle";
         buffTextField = createBonusHeaderTextField(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         dailyFeedInfoTextField = new MobileWomTextField();
         dailyFeedInfoTextField.textRendererProperties.textFormat = getWomTextFormat(21,"center");
         dailyFeedInfoTextField.textRendererProperties.wordWrap = true;
         dailyFeedInfoTextField.width = infoBackground.width - 30;
         addChild(dailyFeedInfoTextField);
         var _temp_13:* = dailyFeedInfoTextField;
         var _loc5_:String = "ui.windows.beast.cave.dailyfeed.desc";
         _temp_13.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         var _loc6_:String = "ui.windows.beast.cave.dailyfeed.tofeed";
         costLabel = createHeaderTextField(peak.i18n.PText.INSTANCE.getText0(_loc6_));
         costTextFields = new Vector.<MPTextField>();
         costButtons = new Vector.<MPButton>();
         var _loc7_:String = "ui.windows.beast.cave.dailyfeed.bonus1";
         bonus1Label = createBonusLabel(peak.i18n.PText.INSTANCE.getText0(_loc7_));
         var _loc8_:String = "ui.windows.beast.cave.dailyfeed.bonus2";
         bonus2Label = createBonusLabel(peak.i18n.PText.INSTANCE.getText0(_loc8_));
         var _loc9_:String = "ui.windows.beast.cave.dailyfeed.bonus3";
         bonus3Label = createBonusLabel(peak.i18n.PText.INSTANCE.getText0(_loc9_));
         bonusProgressBars = new Vector.<Vector.<MobileWomProgressBar>>();
         bonusProgressBars[0] = new Vector.<MobileWomProgressBar>();
         bonusProgressBars[1] = new Vector.<MobileWomProgressBar>();
         bonusProgressBars[2] = new Vector.<MobileWomProgressBar>();
         bonusProgressBars[3] = new Vector.<MobileWomProgressBar>();
         bonusTexts = new Vector.<Vector.<String>>();
         bonusTexts[0] = new Vector.<String>();
         bonusTexts[1] = new Vector.<String>();
         bonusTexts[2] = new Vector.<String>();
         bonusTexts[3] = new Vector.<String>();
         _feedUseResourcesButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         var _temp_27:* = _feedUseResourcesButton;
         var _loc10_:String = "ui.windows.beast.cave.dailyfeed.feeduseresources";
         _temp_27.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         _feedUseResourcesButton.width = 371;
         addChild(_feedUseResourcesButton);
         _instantFeedButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         var _temp_29:* = _instantFeedButton;
         var _loc11_:String = "ui.windows.beast.cave.dailyfeed.instantfeed";
         _temp_29.label = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         _instantFeedButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _instantFeedButton.width = 371;
         addChild(_instantFeedButton);
      }
      
      private function createBonusLabel(param1:String) : MPTextField
      {
         var _loc2_:MPTextField = new MobileWomTextField();
         _loc2_.width = 78;
         _loc2_.textRendererProperties.textFormat = getWomTextFormat(21);
         addChild(_loc2_);
         _loc2_.text = param1;
         return _loc2_;
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         infoBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         infoBackground.width = 445;
         infoBackground.height = 474;
         addChild(infoBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(infoBackground,bg,307,24);
      }
      
      override public function drawLayout() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         super.drawLayout();
         MobileAlignmentUtil.alignAccordingToPositionOf(nextFeedingProgressBar,infoBackground,181,26);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(nextFeedingTextField,nextFeedingProgressBar,-148);
         MobileAlignmentUtil.alignAccordingToPositionOf(bonus1Label,infoBackground,181,77);
         MobileAlignmentUtil.alignAccordingToPositionOf(bonus2Label,infoBackground,267,77);
         MobileAlignmentUtil.alignAccordingToPositionOf(bonus3Label,infoBackground,348,77);
         MobileAlignmentUtil.alignAccordingToPositionOf(dailyFeedInfoTextField,infoBackground,15,290);
         _beastAsset.visible = _beastAsset.width > 1;
         if(_beastAsset.visible)
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_beastAsset,bg,300 - _beastAsset.width);
            MobileAlignmentUtil.alignAccordingToPositionOf(beastNameTextField,bg,300 - beastNameTextField.width >> 1,420);
         }
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_instantFeedButton,_feedUseResourcesButton,308);
         var _loc2_:int = 10;
         _loc2_ = 5;
         MobileAlignmentUtil.alignAccordingToPositionOf(costLabel,infoBackground,34,398);
         _loc5_ = 0;
         while(_loc5_ < costButtons.length)
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(costButtons[_loc5_],costLabel,_loc2_);
            costButtons[_loc5_].y += 4;
            _loc2_ += 92 + 8;
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(costButtons[_loc5_],costLabel,_loc2_);
            _loc2_ += costTextFields[_loc5_].width + 18;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < costButtons.length)
         {
            costButtons[_loc5_].width = 92;
            _loc2_ += 92 + costTextFields[_loc5_].width + 20;
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(costTextFields[_loc5_],costButtons[_loc5_],61);
            _loc5_++;
         }
         var _loc1_:int = 98;
         _loc5_ = 0;
         while(_loc5_ < bonusProgressBars.length)
         {
            _loc3_ = 93;
            _loc4_ = 0;
            while(_loc4_ < bonusProgressBars[_loc5_].length)
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(bonusProgressBars[_loc5_][_loc4_],infoBackground,_loc3_,_loc1_);
               _loc3_ += 83;
               _loc4_++;
            }
            _loc1_ += 46;
            _loc5_++;
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_feedUseResourcesButton,bg,11,bg.height + 30 - (_feedUseResourcesButton.height >> 1));
         MobileAlignmentUtil.alignRightOf(_instantFeedButton,_feedUseResourcesButton,8);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(speedTextField,bonusProgressBars[2][0],-(9 + 55));
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(healthTextField,bonusProgressBars[1][0],-(9 + 55));
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(damageTextField,bonusProgressBars[0][0],-(9 + 55));
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(buffTextField,bonusProgressBars[3][0],-(9 + 55));
      }
      
      private function drawNextFeedingTextFieldLayout() : void
      {
         if(!nextFeedingProgressBar.visible)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(nextFeedingTextField,nextFeedingProgressBar,(nextFeedingProgressBar.width - nextFeedingTextField.width) / 2,0);
         }
      }
      
      private function createProgressBar(param1:int = 235) : MobileWomProgressBar
      {
         var _loc2_:MobileWomProgressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         _loc2_.width = param1;
         _loc2_.minimum = 0;
         _loc2_.height = 36;
         _loc2_.align = "center";
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function createHeaderTextField(param1:String) : MPTextField
      {
         var _loc2_:MPTextField = new MobileCaptionTextField();
         _loc2_.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(_loc2_);
         _loc2_.text = param1;
         return _loc2_;
      }
      
      private function createBonusProgressBar(param1:Boolean) : MobileWomProgressBar
      {
         var _loc2_:MobileWomProgressBar = MobileWomUIComponentFactory.createProgressBar("Blue");
         _loc2_.width = 79;
         _loc2_.height = 38;
         _loc2_.align = "center";
         _loc2_.minimum = 0;
         _loc2_.maximum = 1;
         _loc2_.value = param1 ? 1 : 0;
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function createBonusHeaderTextField(param1:String) : MPTextField
      {
         var _loc2_:MPTextField = new MobileCaptionTextField();
         _loc2_.textRendererProperties.textFormat = getCaptionTextFormat(21);
         _loc2_.width = 30;
         addChild(_loc2_);
         _loc2_.text = param1;
         return _loc2_;
      }
      
      public function updateProgressBar(param1:BeastInfo, param2:Boolean = false) : void
      {
         var _loc4_:Boolean = false;
         var _loc3_:BeastTrainingJob = param1.jobScheduler.preTrainingJob != null ? param1.jobScheduler.preTrainingJob : param1.jobScheduler.waitTrainingJob;
         var _loc5_:Boolean = false;
         if(_loc3_ != null)
         {
            _remainingDurationForTraining = _loc3_ != null ? _loc3_.executionTime - new Date().getTime() : 0;
            nextFeedingProgressBar.maximum = _loc3_ != null ? _loc3_.originalDuration : 0;
            nextFeedingProgressBar.value = _remainingDurationForTraining;
            nextFeedingProgressBar.label = LocalizedDateTimeUtil.getUserFriendlyTime(_remainingDurationForTraining);
            _loc4_ = _loc3_ is BeastPreTrainingJob ? true : param1.bonusStage != 0;
            _loc5_ = nextFeedingProgressBar.visible != _loc4_;
            nextFeedingProgressBar.visible = _loc4_;
            var _loc6_:String;
            var _loc7_:String;
            var _loc8_:String;
            nextFeedingTextField.text = _loc3_ is BeastPreTrainingJob ? (_loc6_ = "ui.windows.beast.cave.evolution.nextfeedingin",peak.i18n.PText.INSTANCE.getText0(_loc6_)) : (param1.bonusStage != 0 ? (_loc7_ = "ui.windows.beast.cave.evolution.willstarvein",peak.i18n.PText.INSTANCE.getText0(_loc7_)) : (_loc8_ = "ui.windows.beast.cave.evolution.ready",peak.i18n.PText.INSTANCE.getText0(_loc8_)));
         }
         else
         {
            _loc5_ = nextFeedingProgressBar.visible;
            var _temp_2:* = nextFeedingTextField;
            var _loc9_:String = "ui.windows.beast.cave.evolution.ready";
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
            nextFeedingProgressBar.visible = false;
         }
         if(param2)
         {
            drawLayout();
         }
         else if(_loc5_)
         {
            drawNextFeedingTextFieldLayout();
         }
      }
      
      public function updateBonusTexts(param1:BeastInfo, param2:BeastTypeDIO) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         bonusTexts[0][0] = numberFormat(param2.damage(param2.maxLevels - 1));
         bonusTexts[1][0] = numberFormat(param2.healthPointsPerLevel[param2.maxLevels - 1]);
         bonusTexts[2][0] = numberFormat(param2.speed(param2.maxLevels - 1));
         bonusTexts[3][0] = numberFormat(param2.buffsPerLevel[param2.maxLevels - 1]);
         bonusTexts[0][1] = "+ " + numberFormat(param2.damagePointsPerStage[0] - param2.damage(param2.maxLevels - 1));
         bonusTexts[1][1] = "+ " + numberFormat(param2.healthPointsPerStage[0] - param2.healthPointsPerLevel[param2.maxLevels - 1]);
         bonusTexts[2][1] = "+ " + numberFormat((param2.speedsPerStage[0] - param2.speed(param2.maxLevels - 1)).toFixed(1));
         bonusTexts[3][1] = "+ " + numberFormat(param2.buffsPerStage[0] - param2.buffsPerLevel[param2.maxLevels - 1]);
         _loc4_ = 2;
         while(_loc4_ <= param2.maxBonusStages)
         {
            bonusTexts[0][_loc4_] = "+ " + numberFormat(param2.damagePointsPerStage[_loc4_ - 1] - param2.damagePointsPerStage[_loc4_ - 2]);
            bonusTexts[1][_loc4_] = "+ " + numberFormat(param2.healthPointsPerStage[_loc4_ - 1] - param2.healthPointsPerStage[_loc4_ - 2]);
            bonusTexts[2][_loc4_] = "+ " + numberFormat((param2.speedsPerStage[_loc4_ - 1] - param2.speedsPerStage[_loc4_ - 2]).toFixed(1));
            bonusTexts[3][_loc4_] = "+ " + numberFormat(param2.buffsPerStage[_loc4_ - 1] - param2.buffsPerStage[_loc4_ - 2]);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc3_ = 0;
            while(_loc3_ <= param2.maxBonusStages)
            {
               bonusProgressBars[_loc4_][_loc3_] = createBonusProgressBar(false);
               bonusProgressBars[_loc4_][_loc3_].label = bonusTexts[_loc4_][_loc3_];
               _loc3_++;
            }
            _loc4_++;
         }
      }
      
      private function numberFormat(param1:*) : String
      {
         return NumberUtil.numberFormat(param1,2,false,false);
      }
      
      public function updateBonus(param1:BeastInfo, param2:BeastTypeDIO) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ <= param2.maxBonusStages)
         {
            if(param1.bonusStage < _loc4_)
            {
               _loc3_ = 0;
               while(_loc3_ < 4)
               {
                  bonusProgressBars[_loc3_][_loc4_].value = 0;
                  _loc3_++;
               }
            }
            else
            {
               _loc3_ = 0;
               while(_loc3_ < 4)
               {
                  bonusProgressBars[_loc3_][_loc4_].value = 1;
                  _loc3_++;
               }
            }
            _loc4_++;
         }
         bonus1Label.alpha = param1.bonusStage >= 0 ? 1 : 0.5;
         bonus2Label.alpha = param1.bonusStage >= 1 ? 1 : 0.5;
         bonus3Label.alpha = param1.bonusStage >= 2 ? 1 : 0.5;
      }
      
      public function updateBeast(param1:BeastInfo, param2:BeastTypeDIO, param3:Dictionary) : void
      {
         var _loc8_:int = 0;
         var _loc5_:UnitTypeAmountDTO = null;
         var _loc4_:UnitTypeDIO = null;
         var _loc7_:MobileWomButton = null;
         clearBeast();
         _beastAsset = assetRepository.getDisplayObject(param2.assetName + param1.level);
         addChildAt(_beastAsset,1);
         var _temp_2:* = beastNameTextField;
         var _loc9_:String = "domain.beasts." + param1.typeId + ".name";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         updateProgressBar(param1,false);
         updateBonusTexts(param1,param2);
         updateBonus(param1,param2);
         var _loc6_:Vector.<UnitTypeAmountDTO> = param2.trainingCostsPerStage[param1.bonusStage >= param2.maxBonusStages ? param2.maxBonusStages - 1 : param1.bonusStage];
         _loc8_ = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc8_];
            _loc4_ = param3[_loc5_.id];
            _loc7_ = MobileWomUIComponentFactory.createMobileColoredButton("Beige","Large");
            _loc7_.isSelected = true;
            _loc7_.defaultIcon = assetRepository.getDisplayObject(_loc4_.assetName + "Portrait");
            _loc7_.width = 92;
            costButtons.push(_loc7_);
            addChild(_loc7_);
            var _temp_6:* = costTextFields;
            var _temp_4:* = "ui.windows.beast.cave.dailyfeed.costtextfield";
            var _loc10_:String = _loc5_.amount.toString();
            var _loc11_:String = _temp_4;
            _temp_6.push(createHeaderTextField(peak.i18n.PText.INSTANCE.getText1(_loc11_,_loc10_)));
            _loc8_++;
         }
         _instantFeedButton.rightLabel = "" + (param1.bonusStage >= param2.maxBonusStages ? "" + param2.levelUpGoldCostsPerStage[param2.maxBonusStages - 1] : "" + param2.levelUpGoldCostsPerStage[param1.bonusStage]);
         nextFeedingTextField.textRendererProperties.wordWrap = nextFeedingProgressBar.visible;
         drawLayout();
      }
      
      private function clearBeast() : void
      {
         if(_beastAsset != null && contains(_beastAsset))
         {
            removeChild(_beastAsset);
         }
         for each(var _loc2_ in costButtons)
         {
            if(contains(_loc2_))
            {
               removeChild(_loc2_);
            }
         }
         costButtons.length = 0;
         for each(var _loc1_ in costTextFields)
         {
            if(contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
         costTextFields.length = 0;
      }
      
      public function get feedUseResourcesButton() : MPButton
      {
         return _feedUseResourcesButton;
      }
      
      public function get instantFeedButton() : MPButton
      {
         return _instantFeedButton;
      }
      
      public function get beastAsset() : DisplayObject
      {
         return _beastAsset;
      }
      
      public function get remainingDurationForTraining() : Number
      {
         return _remainingDurationForTraining;
      }
   }
}

