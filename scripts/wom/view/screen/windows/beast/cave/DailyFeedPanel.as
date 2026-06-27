package wom.view.screen.windows.beast.cave
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.job.BeastPreTrainingJob;
   import wom.model.game.job.BeastTrainingJob;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.component.progressbar.MaskedProgressBar;
   import wom.view.component.progressbar.ProgressBar30;
   import wom.view.ui.common.OrView;
   import wom.view.util.BaseWindowPanel;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class DailyFeedPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 693;
      
      private static const HEIGHT:int = 472;
      
      private static const PROGRESSBAR_WIDTH:int = 322;
      
      private static const PROGRESSBAR_HEIGHT:int = 26;
      
      private static const COSTASSET_WIDTH:int = 54;
      
      private static const COSTASSET_HEIGHT:int = 51;
      
      private static const BONUS_SYMBOL:String = "+ ";
      
      private static const BONUS_BG_WIDTH:int = 79;
      
      private static const BONUS_BG_HEIGHT:int = 38;
      
      private static const BONUS_LABEL_WIDTH:int = 64;
      
      private static const BONUS_INDEX_DAMAGE:int = 0;
      
      private static const BONUS_INDEX_HEALTH:int = 1;
      
      private static const BONUS_INDEX_SPEED:int = 2;
      
      private static const BONUS_INDEX_BUFF:int = 3;
      
      private static const BONUS_X_MARGIN:int = 9;
      
      private var _beastAsset:AssetDisplayObject;
      
      private var nextFeedingProgressBar:MaskedProgressBar;
      
      private var nextFeedingTextField:TextField;
      
      private var damageTextField:TextField;
      
      private var healthTextField:TextField;
      
      private var speedTextField:TextField;
      
      private var buffTextField:TextField;
      
      private var dailyFeedInfoTextField:TextField;
      
      private var costLabel:TextField;
      
      private var costBackground:AssetDisplayObject;
      
      private var costAssets:Vector.<AssetDisplayObject>;
      
      private var costTextFields:Vector.<TextField>;
      
      private var lineSprite:Sprite;
      
      private var bonus1Label:TextField;
      
      private var bonus2Label:TextField;
      
      private var bonus3Label:TextField;
      
      private var bonusBackgrounds:Vector.<Vector.<Vector.<AssetDisplayObject>>>;
      
      private var bonusTextFields:Vector.<Vector.<TextField>>;
      
      private var _feedUseResourcesButton:WomButton;
      
      private var orIcon:DisplayObject;
      
      private var _instantFeedButton:WomButton;
      
      public function DailyFeedPanel()
      {
         super(693,472);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         nextFeedingProgressBar = createProgressBar();
         nextFeedingTextField = createHeaderTextField("");
         var _loc2_:String = "ui.windows.beast.cave.beast.progressbar.damagetitle";
         damageTextField = createBonusHeaderTextField(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         var _loc3_:String = "ui.windows.beast.cave.beast.progressbar.healthtitle";
         healthTextField = createBonusHeaderTextField(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         var _loc4_:String = "ui.windows.beast.cave.beast.progressbar.speedtitle";
         speedTextField = createBonusHeaderTextField(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         var _loc5_:String = "ui.windows.beast.cave.beast.progressbar.bufftitle";
         buffTextField = createBonusHeaderTextField(peak.i18n.PText.INSTANCE.getText0(_loc5_));
         dailyFeedInfoTextField = new WomTextField();
         dailyFeedInfoTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         dailyFeedInfoTextField.multiline = true;
         dailyFeedInfoTextField.wordWrap = true;
         dailyFeedInfoTextField.width = 322;
         dailyFeedInfoTextField.autoSize = "left";
         addChild(dailyFeedInfoTextField);
         var _temp_12:* = dailyFeedInfoTextField;
         var _loc6_:String = "ui.windows.beast.cave.dailyfeed.desc";
         _temp_12.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         costBackground = assetRepository.getDisplayObject("BackgroundDark");
         costBackground.height = 69;
         addChild(costBackground);
         var _loc7_:String = "ui.windows.beast.cave.dailyfeed.tofeed";
         costLabel = createHeaderTextField(peak.i18n.PText.INSTANCE.getText0(_loc7_));
         costAssets = new Vector.<AssetDisplayObject>();
         costTextFields = new Vector.<TextField>();
         lineSprite = new Sprite();
         var _loc1_:Graphics = lineSprite.graphics;
         _loc1_.lineStyle(1,6575928);
         _loc1_.moveTo(0,6);
         _loc1_.lineTo(0,0);
         _loc1_.lineTo(7,0);
         _loc1_.moveTo(71,0);
         _loc1_.lineTo(78,0);
         _loc1_.lineTo(78,6);
         _loc1_.moveTo(81,6);
         _loc1_.lineTo(81,0);
         _loc1_.lineTo(88,0);
         _loc1_.moveTo(152,0);
         _loc1_.lineTo(159,0);
         _loc1_.lineTo(159,6);
         _loc1_.moveTo(162,6);
         _loc1_.lineTo(162,0);
         _loc1_.lineTo(169,0);
         _loc1_.moveTo(233,0);
         _loc1_.lineTo(240,0);
         _loc1_.lineTo(240,6);
         addChild(lineSprite);
         var _loc8_:String = "ui.windows.beast.cave.dailyfeed.bonus1";
         bonus1Label = createBonusLabel(peak.i18n.PText.INSTANCE.getText0(_loc8_));
         var _loc9_:String = "ui.windows.beast.cave.dailyfeed.bonus2";
         bonus2Label = createBonusLabel(peak.i18n.PText.INSTANCE.getText0(_loc9_));
         var _loc10_:String = "ui.windows.beast.cave.dailyfeed.bonus3";
         bonus3Label = createBonusLabel(peak.i18n.PText.INSTANCE.getText0(_loc10_));
         bonusBackgrounds = new Vector.<Vector.<Vector.<AssetDisplayObject>>>();
         bonusBackgrounds[0] = new Vector.<Vector.<AssetDisplayObject>>();
         bonusBackgrounds[1] = new Vector.<Vector.<AssetDisplayObject>>();
         bonusBackgrounds[2] = new Vector.<Vector.<AssetDisplayObject>>();
         bonusBackgrounds[3] = new Vector.<Vector.<AssetDisplayObject>>();
         bonusTextFields = new Vector.<Vector.<TextField>>();
         bonusTextFields[0] = new Vector.<TextField>();
         bonusTextFields[1] = new Vector.<TextField>();
         bonusTextFields[2] = new Vector.<TextField>();
         bonusTextFields[3] = new Vector.<TextField>();
         _feedUseResourcesButton = new WomBlueLargeButton();
         var _temp_28:* = _feedUseResourcesButton;
         var _loc11_:String = "ui.windows.beast.cave.dailyfeed.feeduseresources";
         _temp_28.label = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         _feedUseResourcesButton.width = 289;
         addChild(_feedUseResourcesButton);
         _instantFeedButton = new WomGreenLargeButton();
         var _temp_30:* = _instantFeedButton;
         var _loc12_:String = "ui.windows.beast.cave.dailyfeed.instantfeed";
         _temp_30.label = peak.i18n.PText.INSTANCE.getText0(_loc12_);
         _instantFeedButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         _instantFeedButton.width = 269;
         addChild(_instantFeedButton);
         orIcon = new OrView();
         addChild(orIcon);
      }
      
      private function createBonusLabel(param1:String) : WomTextField
      {
         var _loc2_:WomTextField = new WomTextField();
         _loc2_.width = 64;
         _loc2_.defaultTextFormat = WomTextFormats.CENTER;
         _loc2_.text = param1;
         addChild(_loc2_);
         return _loc2_;
      }
      
      override public function drawLayout() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         super.drawLayout();
         AlignmentUtil.alignAccordingToPositionOf(nextFeedingProgressBar,bg,359,52);
         drawNextFeedingTextFieldLayout();
         AlignmentUtil.alignAccordingToPositionOf(lineSprite,bg,440,98);
         AlignmentUtil.alignAccordingToPositionOf(bonus1Label,bg,447,90);
         AlignmentUtil.alignAccordingToPositionOf(bonus2Label,bg,528,90);
         AlignmentUtil.alignAccordingToPositionOf(bonus3Label,bg,609,90);
         AlignmentUtil.alignBelowOf(dailyFeedInfoTextField,nextFeedingProgressBar,194);
         _beastAsset.visible = _beastAsset.width > 1;
         if(_beastAsset.visible)
         {
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_beastAsset,bg,310 - _beastAsset.width);
         }
         AlignmentUtil.alignAccordingToPositionOf(_feedUseResourcesButton,bg,58,450);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_instantFeedButton,_feedUseResourcesButton,308);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(orIcon,_feedUseResourcesButton,280);
         var _loc2_:int = 10;
         _loc5_ = 0;
         while(_loc5_ < costAssets.length)
         {
            costAssets[_loc5_].width = 54;
            costAssets[_loc5_].height = 51;
            _loc2_ += 54 + costTextFields[_loc5_].width + 25;
            _loc5_++;
         }
         costBackground.width = _loc2_;
         _loc2_ = 5;
         AlignmentUtil.alignAccordingToPositionOf(costBackground,bg,360,364);
         AlignmentUtil.alignAccordingToPositionOf(costLabel,costBackground,8,-10);
         _loc5_ = 0;
         while(_loc5_ < costAssets.length)
         {
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(costAssets[_loc5_],costBackground,_loc2_);
            costAssets[_loc5_].y += 4;
            _loc2_ += 54 + 8;
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(costTextFields[_loc5_],costBackground,_loc2_);
            _loc2_ += costTextFields[_loc5_].width + 17;
            _loc5_++;
         }
         var _loc1_:int = 110;
         _loc5_ = 0;
         while(_loc5_ < bonusBackgrounds.length)
         {
            _loc3_ = 359;
            _loc4_ = 0;
            while(_loc4_ < bonusBackgrounds[_loc5_].length)
            {
               AlignmentUtil.alignAccordingToPositionOf(bonusBackgrounds[_loc5_][_loc4_][0],bg,_loc3_,_loc1_);
               AlignmentUtil.alignAccordingToPositionOf(bonusBackgrounds[_loc5_][_loc4_][1],bg,_loc3_,_loc1_);
               AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(bonusTextFields[_loc5_][_loc4_],bonusBackgrounds[_loc5_][_loc4_][0],11);
               _loc3_ += 81;
               _loc4_++;
            }
            _loc1_ += 40;
            _loc5_++;
         }
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(damageTextField,bonusBackgrounds[0][0][0],-(9 + damageTextField.width));
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(healthTextField,bonusBackgrounds[1][0][0],-(9 + healthTextField.width));
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(speedTextField,bonusBackgrounds[2][0][0],-(9 + speedTextField.width));
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(buffTextField,bonusBackgrounds[3][0][0],-(9 + buffTextField.width));
      }
      
      private function drawNextFeedingTextFieldLayout() : void
      {
         if(nextFeedingProgressBar.visible)
         {
            AlignmentUtil.alignAccordingToPositionOf(nextFeedingTextField,nextFeedingProgressBar,0,-25);
         }
         else
         {
            AlignmentUtil.alignAccordingToPositionOf(nextFeedingTextField,nextFeedingProgressBar,(nextFeedingProgressBar.width - nextFeedingTextField.width) / 2,0);
         }
      }
      
      private function createProgressBar(param1:int = 322) : MaskedProgressBar
      {
         var _loc2_:MaskedProgressBar = new ProgressBar30();
         _loc2_.width = param1;
         _loc2_.height = 26;
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function createHeaderTextField(param1:String) : TextField
      {
         var _loc2_:TextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         _loc2_.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         _loc2_.autoSize = "left";
         _loc2_.text = param1;
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function createCostTextField(param1:String) : TextField
      {
         var _loc2_:TextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         _loc2_.defaultTextFormat = WomTextFormats.FONT_SIZE_30;
         _loc2_.autoSize = "left";
         _loc2_.text = param1;
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function createBonusTextField(param1:String) : TextField
      {
         var _loc2_:TextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _loc2_.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _loc2_.autoSize = "left";
         _loc2_.text = param1;
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function createBonusBackground(param1:Boolean) : AssetDisplayObject
      {
         var _loc2_:AssetDisplayObject = assetRepository.getDisplayObject(param1 ? "BeastCaveEvolution2Green" : "BackgroundDark");
         _loc2_.width = 79;
         _loc2_.height = 38;
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function createBonusHeaderTextField(param1:String) : TextField
      {
         var _loc2_:TextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _loc2_.defaultTextFormat = WomTextFormats.RIGHT_16;
         _loc2_.autoSize = "right";
         _loc2_.text = param1;
         addChild(_loc2_);
         return _loc2_;
      }
      
      public function updateProgressBar(param1:BeastInfo, param2:Boolean = false) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc3_:BeastTrainingJob = param1.jobScheduler.preTrainingJob != null ? param1.jobScheduler.preTrainingJob : param1.jobScheduler.waitTrainingJob;
         var _loc6_:Boolean = false;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_ != null ? _loc3_.executionTime - new Date().getTime() : 0;
            nextFeedingProgressBar.setProgress(_loc4_,_loc3_ != null ? _loc3_.originalDuration : 0);
            nextFeedingProgressBar.progressText = LocalizedDateTimeUtil.getUserFriendlyTime(_loc4_);
            _loc5_ = _loc3_ is BeastPreTrainingJob ? true : param1.bonusStage != 0;
            _loc6_ = nextFeedingProgressBar.visible != _loc5_;
            nextFeedingProgressBar.visible = _loc5_;
            var _loc7_:String;
            var _loc8_:String;
            var _loc9_:String;
            nextFeedingTextField.text = _loc3_ is BeastPreTrainingJob ? (_loc7_ = "ui.windows.beast.cave.evolution.nextfeedingin",peak.i18n.PText.INSTANCE.getText0(_loc7_)) : (param1.bonusStage != 0 ? (_loc8_ = "ui.windows.beast.cave.evolution.willstarvein",peak.i18n.PText.INSTANCE.getText0(_loc8_)) : (_loc9_ = "ui.windows.beast.cave.evolution.ready",peak.i18n.PText.INSTANCE.getText0(_loc9_)));
         }
         else
         {
            _loc6_ = nextFeedingProgressBar.visible;
            var _temp_1:* = nextFeedingTextField;
            var _loc10_:String = "ui.windows.beast.cave.evolution.ready";
            _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc10_);
            nextFeedingProgressBar.visible = false;
         }
         if(param2)
         {
            drawLayout();
         }
         else if(_loc6_)
         {
            drawNextFeedingTextFieldLayout();
         }
      }
      
      public function initBonus(param1:BeastInfo, param2:BeastTypeDIO) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _temp_1:* = buffTextField;
         var _loc5_:String = param2.id == 33 ? "ui.windows.beast.cave.beast.progressbar.rangetitle" : "ui.windows.beast.cave.beast.progressbar.bufftitle";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc3_ = 0;
            while(_loc3_ <= param2.maxBonusStages)
            {
               bonusBackgrounds[_loc4_][_loc3_] = new Vector.<AssetDisplayObject>();
               bonusBackgrounds[_loc4_][_loc3_][0] = createBonusBackground(false);
               bonusBackgrounds[_loc4_][_loc3_][1] = createBonusBackground(true);
               _loc3_++;
            }
            _loc4_++;
         }
         bonusTextFields[0][0] = createBonusTextField(numberFormat(param2.damage(param2.maxLevels - 1)));
         bonusTextFields[1][0] = createBonusTextField(numberFormat(param2.healthPointsPerLevel[param2.maxLevels - 1]));
         bonusTextFields[2][0] = createBonusTextField(numberFormat(param2.speed(param2.maxLevels - 1)));
         bonusTextFields[3][0] = createBonusTextField(numberFormat(param2.id == 33 ? param2.range(param2.maxLevels - 1) : param2.buffsPerLevel[param2.maxLevels - 1]));
         bonusTextFields[0][1] = createBonusTextField("+ " + numberFormat(param2.damagePointsPerStage[0] - param2.damage(param2.maxLevels - 1)));
         bonusTextFields[1][1] = createBonusTextField("+ " + numberFormat(param2.healthPointsPerStage[0] - param2.healthPointsPerLevel[param2.maxLevels - 1]));
         bonusTextFields[2][1] = createBonusTextField("+ " + numberFormat((param2.speedsPerStage[0] - param2.speed(param2.maxLevels - 1)).toFixed(1)));
         bonusTextFields[3][1] = createBonusTextField("+ " + numberFormat((param2.id == 33 ? param2.rangesPerStage[0] : param2.buffsPerStage[0]) - (param2.id == 33 ? param2.range(param2.maxLevels - 1) : param2.buffsPerLevel[param2.maxLevels - 1])));
         _loc4_ = 2;
         while(_loc4_ <= param2.maxBonusStages)
         {
            bonusTextFields[0][_loc4_] = createBonusTextField("+ " + numberFormat(param2.damagePointsPerStage[_loc4_ - 1] - param2.damagePointsPerStage[_loc4_ - 2]));
            bonusTextFields[1][_loc4_] = createBonusTextField("+ " + numberFormat(param2.healthPointsPerStage[_loc4_ - 1] - param2.healthPointsPerStage[_loc4_ - 2]));
            bonusTextFields[2][_loc4_] = createBonusTextField("+ " + numberFormat((param2.speedsPerStage[_loc4_ - 1] - param2.speedsPerStage[_loc4_ - 2]).toFixed(1)));
            bonusTextFields[3][_loc4_] = createBonusTextField("+ " + numberFormat((param2.id == 33 ? param2.rangesPerStage[_loc4_ - 1] : param2.buffsPerStage[_loc4_ - 1]) - (param2.id == 33 ? param2.rangesPerStage[_loc4_ - 2] : param2.buffsPerStage[_loc4_ - 2])));
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
                  bonusBackgrounds[_loc3_][_loc4_][0].visible = true;
                  bonusBackgrounds[_loc3_][_loc4_][1].visible = false;
                  _loc3_++;
               }
            }
            else
            {
               _loc3_ = 0;
               while(_loc3_ < 4)
               {
                  bonusBackgrounds[_loc3_][_loc4_][0].visible = false;
                  bonusBackgrounds[_loc3_][_loc4_][1].visible = true;
                  _loc3_++;
               }
            }
            if(_loc4_ - param1.bonusStage <= 1)
            {
               _loc3_ = 0;
               while(_loc3_ < 4)
               {
                  bonusTextFields[_loc3_][_loc4_].alpha = 1;
                  _loc3_++;
               }
            }
            else
            {
               _loc3_ = 0;
               while(_loc3_ < 4)
               {
                  bonusTextFields[_loc3_][_loc4_].alpha = 0.5;
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
         var _loc7_:AssetDisplayObject = null;
         clearBeast();
         _beastAsset = assetRepository.getDisplayObject(param2.assetName + param1.level);
         addChild(_beastAsset);
         updateProgressBar(param1,false);
         if(bonusBackgrounds[0].length == 0)
         {
            initBonus(param1,param2);
         }
         updateBonus(param1,param2);
         var _loc6_:Vector.<UnitTypeAmountDTO> = param2.trainingCostsPerStage[param1.bonusStage >= param2.maxBonusStages ? param2.maxBonusStages - 1 : param1.bonusStage];
         _loc8_ = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc8_];
            _loc4_ = param3[_loc5_.id];
            _loc7_ = assetRepository.getDisplayObject(_loc4_.assetName + "Small");
            costAssets.push(_loc7_);
            addChild(_loc7_);
            var _temp_4:* = costTextFields;
            var _temp_2:* = "ui.windows.beast.cave.dailyfeed.costtextfield";
            var _loc9_:String = _loc5_.amount.toString();
            var _loc10_:String = _temp_2;
            _temp_4.push(createCostTextField(peak.i18n.PText.INSTANCE.getText1(_loc10_,_loc9_)));
            _loc8_++;
         }
         _instantFeedButton.rightLabel = "" + (param1.bonusStage >= param2.maxBonusStages ? "" + param2.levelUpGoldCostsPerStage[param2.maxBonusStages - 1] : "" + param2.levelUpGoldCostsPerStage[param1.bonusStage]);
         drawLayout();
      }
      
      private function clearBeast() : void
      {
         if(_beastAsset != null && contains(_beastAsset))
         {
            removeChild(_beastAsset);
         }
         for each(var _loc1_ in costAssets)
         {
            if(contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
         costAssets.length = 0;
         for each(var _loc2_ in costTextFields)
         {
            if(contains(_loc2_))
            {
               removeChild(_loc2_);
            }
         }
         costTextFields.length = 0;
      }
      
      public function get feedUseResourcesButton() : WomButton
      {
         return _feedUseResourcesButton;
      }
      
      public function get instantFeedButton() : WomButton
      {
         return _instantFeedButton;
      }
      
      public function get beastAsset() : AssetDisplayObject
      {
         return _beastAsset;
      }
   }
}

