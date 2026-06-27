package wom.view.screen.windows.beast.cave
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import peak.util.DateTimeUtil;
   import peak.util.NumberUtil;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.store.StoreUtil;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.component.progressbar.MaskedProgressBar;
   import wom.view.component.progressbar.ProgressBar26;
   import wom.view.util.BaseWindowPanel;
   
   public class BeastPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 693;
      
      private static const HEIGHT:int = 472;
      
      private static const PROGRESSBAR_WIDTH_NORMAL:int = 273;
      
      private static const PROGRESSBAR_WIDTH_LARGE:int = 327;
      
      private static const PROGRESSBAR_HEIGHT:int = 26;
      
      private static const PROGRESSBAR_X_MARGIN:int = 9;
      
      private var levelInfoBackground:DisplayObject;
      
      private var levelInfoHeaderTextField:TextField;
      
      private var levelInfoTextField:TextField;
      
      private var levelDetailsBackground:DisplayObject;
      
      private var damageProgressBar:MaskedProgressBar;
      
      private var damageTextField:TextField;
      
      private var healthProgressBar:MaskedProgressBar;
      
      private var healthTextField:TextField;
      
      private var speedProgressBar:MaskedProgressBar;
      
      private var speedTextField:TextField;
      
      private var buffProgressBar:MaskedProgressBar;
      
      private var buffTextField:TextField;
      
      private var beastInfoTextField:TextField;
      
      private var currentHealthBackground:DisplayObject;
      
      private var currentHealthProgressBar:MaskedProgressBar;
      
      private var currentHealthTextField:TextField;
      
      private var fullyHealedHeaderTextField:TextField;
      
      private var fullyHealedTextField:TextField;
      
      private var _beastAsset:AssetDisplayObject;
      
      private var beastNameTextField:TextField;
      
      private var _healButton:WomButton;
      
      private var _goldCostForHealing:int = 0;
      
      public function BeastPanel()
      {
         super(693,472);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         levelInfoBackground = assetRepository.getDisplayObject("BackgroundDark");
         levelInfoBackground.width = 359;
         levelInfoBackground.height = 42;
         addChild(levelInfoBackground);
         levelInfoHeaderTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         levelInfoHeaderTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         levelInfoHeaderTextField.autoSize = "left";
         var _temp_3:* = levelInfoHeaderTextField;
         var _loc1_:String = "ui.windows.beast.cave.beast.evolution";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(levelInfoHeaderTextField);
         levelInfoTextField = new WomTextField();
         levelInfoTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         levelInfoTextField.autoSize = "left";
         addChild(levelInfoTextField);
         levelDetailsBackground = assetRepository.getDisplayObject("BackgroundDark");
         levelDetailsBackground.width = 359;
         levelDetailsBackground.height = 297;
         addChild(levelDetailsBackground);
         damageProgressBar = createProgressBar();
         var _loc2_:String = "ui.windows.beast.cave.beast.progressbar.damagetitle";
         damageTextField = createProgressBarTextField(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         healthProgressBar = createProgressBar();
         var _loc3_:String = "ui.windows.beast.cave.beast.progressbar.healthtitle";
         healthTextField = createProgressBarTextField(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         speedProgressBar = createProgressBar();
         var _loc4_:String = "ui.windows.beast.cave.beast.progressbar.speedtitle";
         speedTextField = createProgressBarTextField(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         buffProgressBar = createProgressBar();
         var _loc5_:String = "ui.windows.beast.cave.beast.progressbar.bufftitle";
         buffTextField = createProgressBarTextField(peak.i18n.PText.INSTANCE.getText0(_loc5_));
         beastInfoTextField = new WomTextField();
         beastInfoTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         beastInfoTextField.multiline = true;
         beastInfoTextField.wordWrap = true;
         beastInfoTextField.width = levelDetailsBackground.width - 20;
         beastInfoTextField.autoSize = "left";
         addChild(beastInfoTextField);
         currentHealthBackground = assetRepository.getDisplayObject("BackgroundDark");
         currentHealthBackground.width = 359;
         currentHealthBackground.height = 107;
         addChild(currentHealthBackground);
         currentHealthTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         currentHealthTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         currentHealthTextField.autoSize = "left";
         var _temp_21:* = currentHealthTextField;
         var _loc6_:String = "ui.windows.beast.cave.beast.currenthealth";
         _temp_21.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(currentHealthTextField);
         currentHealthProgressBar = createProgressBar(327);
         fullyHealedHeaderTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         fullyHealedHeaderTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         fullyHealedHeaderTextField.autoSize = "left";
         var _temp_24:* = fullyHealedHeaderTextField;
         var _loc7_:String = "ui.windows.beast.cave.beast.fullyhealedin";
         _temp_24.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(fullyHealedHeaderTextField);
         fullyHealedTextField = new WomTextField();
         fullyHealedTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         fullyHealedTextField.autoSize = "left";
         addChild(fullyHealedTextField);
         fullyHealedTextField.text = "lorem ipsum";
         beastNameTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
         beastNameTextField.defaultTextFormat = WomTextFormats.CENTER_32;
         beastNameTextField.width = 300;
         beastNameTextField.wordWrap = true;
         addChild(beastNameTextField);
         _healButton = new WomGreenLargeButton();
         var _temp_28:* = _healButton;
         var _loc8_:String = "ui.windows.beast.cave.beast.heal";
         _temp_28.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         _healButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         _healButton.width = 299;
         addChild(_healButton);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         AlignmentUtil.alignAccordingToPositionOf(levelInfoBackground,bg,324,13);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(levelInfoHeaderTextField,levelInfoBackground,19);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(levelInfoTextField,levelInfoBackground,102);
         AlignmentUtil.alignBelowOf(levelDetailsBackground,levelInfoBackground,0);
         AlignmentUtil.alignAccordingToPositionOf(damageProgressBar,levelDetailsBackground,75,14);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(damageTextField,damageProgressBar,-(9 + damageTextField.width));
         AlignmentUtil.alignBelowOf(healthProgressBar,damageProgressBar,2);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(healthTextField,healthProgressBar,-(9 + healthTextField.width));
         AlignmentUtil.alignBelowOf(speedProgressBar,healthProgressBar,2);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(speedTextField,speedProgressBar,-(9 + speedTextField.width));
         AlignmentUtil.alignBelowOf(buffProgressBar,speedProgressBar,2);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(buffTextField,buffProgressBar,-(9 + buffTextField.width));
         AlignmentUtil.alignAccordingToPositionOf(beastInfoTextField,levelDetailsBackground,10,137);
         AlignmentUtil.alignBelowOf(currentHealthBackground,levelDetailsBackground,0);
         AlignmentUtil.alignAccordingToPositionOf(currentHealthTextField,currentHealthBackground,21,15);
         AlignmentUtil.alignBelowOf(currentHealthProgressBar,currentHealthTextField,3);
         AlignmentUtil.alignBelowOf(fullyHealedHeaderTextField,currentHealthProgressBar,7);
         AlignmentUtil.alignRightOf(fullyHealedTextField,fullyHealedHeaderTextField,7);
         AlignmentUtil.alignAccordingToPositionOf(beastNameTextField,bg,9,420);
         _beastAsset.visible = _beastAsset.width > 1;
         if(_beastAsset.visible)
         {
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_beastAsset,bg,310 - _beastAsset.width);
         }
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_healButton,bg,459);
      }
      
      private function createProgressBar(param1:int = 273) : MaskedProgressBar
      {
         var _loc2_:MaskedProgressBar = new ProgressBar26();
         _loc2_.width = param1;
         _loc2_.height = 26;
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function createProgressBarTextField(param1:String) : TextField
      {
         var _loc2_:TextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _loc2_.defaultTextFormat = WomTextFormats.RIGHT_16;
         _loc2_.autoSize = "right";
         _loc2_.text = param1;
         addChild(_loc2_);
         return _loc2_;
      }
      
      public function updateCurrentHealth(param1:BeastInfo, param2:BeastTypeDIO, param3:Boolean = false) : void
      {
         var _loc5_:Number = param2.healingCostTimesPerLevel[param1.level - 1];
         var _loc6_:Number = param2.healingTimesPerLevel[param1.level - 1];
         var _loc8_:int = int(param1.bonusStage > 0 ? param2.healthPointsPerStage[param1.bonusStage - 1] : param2.healthPointsPerLevel[param1.level - 1]);
         currentHealthProgressBar.setProgress(param1.healthPoints,_loc8_);
         var _temp_3:* = currentHealthProgressBar;
         var _temp_2:* = "ui.windows.beast.cave.beast.progressbar.health";
         var _temp_1:* = numberFormat(param1.healthPoints);
         var _loc9_:String = numberFormat(_loc8_);
         var _loc10_:String = _temp_1;
         var _loc11_:String = _temp_2;
         _temp_3.progressText = peak.i18n.PText.INSTANCE.getText2(_loc11_,_loc10_,_loc9_);
         var _loc4_:int = Math.ceil((_loc8_ - param1.healthPoints) * _loc5_ / _loc8_);
         var _loc7_:int = Math.ceil((_loc8_ - param1.healthPoints) * _loc6_ / _loc8_);
         _goldCostForHealing = StoreUtil.mercenaryTrainAndRecruitPrice(0,_loc4_);
         _healButton.rightLabel = numberFormat(_goldCostForHealing);
         _healButton.visible = _goldCostForHealing > 0;
         fullyHealedTextField.text = DateTimeUtil.getFormattedTimeWithoutCroppingHours(_loc7_ * 1000);
         fullyHealedHeaderTextField.visible = fullyHealedTextField.visible = param1.healthPoints < _loc8_;
         if(param3)
         {
            drawLayout();
         }
      }
      
      private function numberFormat(param1:Number) : String
      {
         return NumberUtil.numberFormat(param1,2,false,false);
      }
      
      public function updateBeast(param1:BeastInfo, param2:BeastTypeDIO) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         clearBeast();
         var _temp_1:* = buffTextField;
         var _loc9_:String = param2.id == 33 ? "ui.windows.beast.cave.beast.progressbar.rangetitle" : "ui.windows.beast.cave.beast.progressbar.bufftitle";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         var _temp_3:* = levelInfoTextField;
         var _temp_2:* = "ui.windows.beast.cave.beast.stage";
         var _loc10_:String = param1.level.toString();
         var _loc11_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc11_,_loc10_);
         var _temp_4:* = beastInfoTextField;
         var _loc12_:String = "domain.beasts." + param1.typeId + ".desc";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc12_);
         var _temp_5:* = beastNameTextField;
         var _loc13_:String = "domain.beasts." + param1.typeId + ".name";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc13_);
         beastNameTextField.height = beastNameTextField.textHeight + 4 >> 0;
         _beastAsset = assetRepository.getDisplayObject(param2.assetName + param1.level);
         addChild(_beastAsset);
         if(param1.bonusStage > 0)
         {
            _loc6_ = param1.bonusStage - 1;
            _loc4_ = param2.damagePointsPerStage[_loc6_];
            _loc7_ = param2.healthPointsPerStage[_loc6_];
            _loc3_ = param2.speedsPerStage[_loc6_];
            _loc5_ = int(param2.id == 33 ? param2.rangesPerStage[_loc6_] * 5 : param2.buffsPerStage[_loc6_]);
         }
         else
         {
            _loc8_ = param1.level - 1;
            _loc4_ = param2.damage(_loc8_);
            _loc7_ = param2.healthPointsPerLevel[_loc8_];
            _loc3_ = param2.speed(_loc8_);
            _loc5_ = int(param2.id == 33 ? param2.range(_loc8_) * 5 : param2.buffsPerLevel[_loc8_]);
         }
         damageProgressBar.setProgress(_loc4_,param2.damagePointsPerStage[param2.maxBonusStages - 1]);
         damageProgressBar.progressText = numberFormat(_loc4_);
         healthProgressBar.setProgress(_loc7_,param2.healthPointsPerStage[param2.maxBonusStages - 1]);
         healthProgressBar.progressText = numberFormat(_loc7_);
         speedProgressBar.setProgress(_loc3_,param2.speedsPerStage[param2.maxBonusStages - 1]);
         var _temp_8:* = speedProgressBar;
         var _temp_7:* = numberFormat(_loc3_) + " ";
         var _loc14_:String = "ui.windows.recruitmentchamber.kph";
         _temp_8.progressText = _temp_7 + peak.i18n.PText.INSTANCE.getText0(_loc14_);
         buffProgressBar.setProgress(_loc5_,param2.id == 33 ? param2.rangesPerStage[param2.maxBonusStages - 1] * 5 : param2.buffsPerStage[param2.maxBonusStages - 1]);
         var _temp_10:* = buffProgressBar;
         var _temp_9:* = param2.id == 33 ? "ui.windows.beast.cave.beast.progressbar.range" : "ui.windows.beast.cave.beast.progressbar.buff";
         var _loc15_:String = numberFormat(_loc5_);
         var _loc16_:String = _temp_9;
         _temp_10.progressText = peak.i18n.PText.INSTANCE.getText1(_loc16_,_loc15_);
         updateCurrentHealth(param1,param2,false);
         drawLayout();
      }
      
      private function clearBeast() : void
      {
         if(_beastAsset != null && contains(_beastAsset))
         {
            removeChild(_beastAsset);
         }
      }
      
      public function get healButton() : WomButton
      {
         return _healButton;
      }
      
      public function get beastAsset() : AssetDisplayObject
      {
         return _beastAsset;
      }
      
      public function get goldCostForHealing() : int
      {
         return _goldCostForHealing;
      }
   }
}

