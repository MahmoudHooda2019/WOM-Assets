package wom.view.screen.windows.beast.cave
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.store.StoreUtil;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileBeastPanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 774;
      
      private static const HEIGHT:int = 514;
      
      private static const PROGRESSBAR_WIDTH_NORMAL:int = 220;
      
      private static const PROGRESSBAR_WIDTH_LARGE:int = 250;
      
      private static const PROGRESSBAR_HEIGHT:int = 36;
      
      private static const PROGRESSBAR_X_MARGIN:int = 8;
      
      private var infoBackground:DisplayObject;
      
      private var levelInfoTextField:MPTextField;
      
      private var damageProgressBar:MobileWomProgressBar;
      
      private var damageTextField:MPTextField;
      
      private var healthProgressBar:MobileWomProgressBar;
      
      private var healthTextField:MPTextField;
      
      private var fullyHealedDurationTF:MPTextField;
      
      private var fullyHealedLabel:MPTextField;
      
      private var speedProgressBar:MobileWomProgressBar;
      
      private var speedTextField:MPTextField;
      
      private var buffProgressBar:MobileWomProgressBar;
      
      private var buffTextField:MPTextField;
      
      private var beastInfoTextField:MPTextField;
      
      private var currentHealthProgressBar:MobileWomProgressBar;
      
      private var currentHealthTextField:MPTextField;
      
      private var _beastAsset:DisplayObject;
      
      private var beastNameTextField:MPTextField;
      
      private var _healButton:MobileWomButton;
      
      private var _goldCostForHealing:int = 0;
      
      private var levelShield:DisplayObject;
      
      public function MobileBeastPanel()
      {
         super(774,514);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         levelShield = assetRepository.getDisplayObject("IconLevelBeastMBordered");
         addChild(levelShield);
         levelInfoTextField = new MobileCaptionTextField();
         levelInfoTextField.textRendererProperties.textFormat = getCaptionTextFormat(25);
         addChild(levelInfoTextField);
         damageProgressBar = createProgressBar();
         var _loc1_:String = "ui.windows.beast.cave.beast.progressbar.damagetitle";
         damageTextField = createProgressBarTextField(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         healthProgressBar = createProgressBar();
         var _loc2_:String = "ui.windows.beast.cave.beast.progressbar.healthtitle";
         healthTextField = createProgressBarTextField(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         speedProgressBar = createProgressBar();
         var _loc3_:String = "ui.windows.beast.cave.beast.progressbar.speedtitle";
         speedTextField = createProgressBarTextField(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         buffProgressBar = createProgressBar();
         var _loc4_:String = "ui.windows.beast.cave.beast.progressbar.bufftitle";
         buffTextField = createProgressBarTextField(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         var _loc5_:String = "ui.windows.beast.cave.beast.fullyhealedin";
         fullyHealedLabel = createProgressBarTextField(peak.i18n.PText.INSTANCE.getText0(_loc5_));
         fullyHealedDurationTF = new MobileWomTextField();
         fullyHealedDurationTF.textRendererProperties.textFormat = getWomTextFormat(21);
         addChild(fullyHealedDurationTF);
         fullyHealedDurationTF.text = "";
         beastInfoTextField = new MobileWomTextField();
         beastInfoTextField.width = infoBackground.width - 50;
         beastInfoTextField.textRendererProperties.textFormat = getWomTextFormat(23,"center");
         beastInfoTextField.textRendererProperties.wordWrap = true;
         addChild(beastInfoTextField);
         currentHealthTextField = new MobileCaptionTextField();
         currentHealthTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(currentHealthTextField);
         var _temp_20:* = currentHealthTextField;
         var _loc6_:String = "ui.windows.beast.cave.beast.currenthealth";
         _temp_20.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         currentHealthProgressBar = createProgressBar(250,"Green");
         beastNameTextField = new MobileCaptionTextField();
         beastNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(46,"center");
         beastNameTextField.textRendererProperties.wordWrap = true;
         addChild(beastNameTextField);
         _healButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _healButton.width = 372;
         var _temp_24:* = _healButton;
         var _loc7_:String = "ui.windows.beast.cave.beast.heal";
         _temp_24.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _healButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         addChild(_healButton);
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         infoBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         infoBackground.width = 445;
         infoBackground.height = 470;
         addChild(infoBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(infoBackground,bg,307,24);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignAccordingToPositionOf(levelShield,infoBackground,-19,16);
         MobileAlignmentUtil.alignAccordingToPositionOf(levelInfoTextField,levelShield,20,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(speedProgressBar,infoBackground,145,24);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(speedTextField,speedProgressBar,-(8 + 60));
         MobileAlignmentUtil.alignBelowOf(healthProgressBar,speedProgressBar,10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(healthTextField,healthProgressBar,-(8 + 60));
         MobileAlignmentUtil.alignBelowOf(damageProgressBar,healthProgressBar,10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(damageTextField,damageProgressBar,-(8 + 60));
         MobileAlignmentUtil.alignBelowOf(buffProgressBar,damageProgressBar,10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(buffTextField,buffProgressBar,-(8 + 60));
         MobileAlignmentUtil.alignAccordingToPositionOf(beastInfoTextField,infoBackground,25,225);
         MobileAlignmentUtil.alignAccordingToPositionOf(currentHealthTextField,infoBackground,16,390);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(currentHealthProgressBar,currentHealthTextField,8 + currentHealthTextField.width);
         MobileAlignmentUtil.alignBelowOf(fullyHealedLabel,currentHealthTextField,10);
         fullyHealedLabel.validate();
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(fullyHealedDurationTF,fullyHealedLabel,250);
         _beastAsset.visible = _beastAsset.width > 1;
         if(_beastAsset.visible)
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_beastAsset,bg,300 - _beastAsset.width);
            MobileAlignmentUtil.alignAccordingToPositionOf(beastNameTextField,bg,300 - beastNameTextField.width >> 1,420);
         }
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_healButton,bg,bg.height + 25 - (_healButton.height >> 1));
      }
      
      private function createProgressBar(param1:int = 220, param2:String = "Yellow") : MobileWomProgressBar
      {
         var _loc3_:MobileWomProgressBar = MobileWomUIComponentFactory.createProgressBar(param2);
         _loc3_.width = param1;
         _loc3_.height = 36;
         _loc3_.minimum = 0;
         _loc3_.align = "center";
         addChild(_loc3_);
         return _loc3_;
      }
      
      private function createProgressBarTextField(param1:String) : MPTextField
      {
         var _loc2_:MobileWomTextField = new MobileCaptionTextField();
         _loc2_.textRendererProperties.textFormat = getCaptionTextFormat(21);
         _loc2_.width = 60;
         addChild(_loc2_);
         _loc2_.text = param1;
         return _loc2_;
      }
      
      public function updateCurrentHealth(param1:BeastInfo, param2:BeastTypeDIO, param3:Boolean = false) : void
      {
         var _loc5_:Number = param2.healingCostTimesPerLevel[param1.level - 1];
         var _loc6_:Number = param2.healingTimesPerLevel[param1.level - 1];
         var _loc8_:int = int(param1.bonusStage > 0 ? param2.healthPointsPerStage[param1.bonusStage - 1] : param2.healthPointsPerLevel[param1.level - 1]);
         currentHealthProgressBar.maximum = _loc8_;
         currentHealthProgressBar.value = param1.healthPoints;
         var _temp_3:* = currentHealthProgressBar;
         var _temp_2:* = "ui.windows.beast.cave.beast.progressbar.health";
         var _temp_1:* = numberFormat(param1.healthPoints);
         var _loc9_:String = numberFormat(_loc8_);
         var _loc10_:String = _temp_1;
         var _loc11_:String = _temp_2;
         _temp_3.label = peak.i18n.PText.INSTANCE.getText2(_loc11_,_loc10_,_loc9_);
         var _loc4_:int = Math.ceil((_loc8_ - param1.healthPoints) * _loc5_ / _loc8_);
         var _loc7_:int = Math.ceil((_loc8_ - param1.healthPoints) * _loc6_ / _loc8_);
         _goldCostForHealing = StoreUtil.mercenaryTrainAndRecruitPrice(0,_loc4_);
         _healButton.rightLabel = numberFormat(_goldCostForHealing);
         _healButton.visible = _goldCostForHealing > 0;
         fullyHealedDurationTF.text = DateTimeUtil.getFormattedTimeWithoutCroppingHours(_loc7_ * 1000);
         fullyHealedDurationTF.visible = fullyHealedLabel.visible = param1.healthPoints < _loc8_;
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
         levelInfoTextField.text = param1.level.toString();
         var _temp_2:* = beastInfoTextField;
         var _loc10_:String = "domain.beasts." + param1.typeId + ".desc";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         var _temp_3:* = beastNameTextField;
         var _loc11_:String = "domain.beasts." + param1.typeId + ".name";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         _beastAsset = assetRepository.getDisplayObject(param2.assetName + param1.level);
         addChildAt(_beastAsset,1);
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
         damageProgressBar.maximum = param2.damagePointsPerStage[param2.maxBonusStages - 1];
         damageProgressBar.value = _loc4_;
         damageProgressBar.label = numberFormat(_loc4_);
         healthProgressBar.maximum = param2.healthPointsPerStage[param2.maxBonusStages - 1];
         healthProgressBar.value = _loc7_;
         healthProgressBar.label = numberFormat(_loc7_);
         speedProgressBar.maximum = param2.speedsPerStage[param2.maxBonusStages - 1];
         speedProgressBar.value = _loc3_;
         var _temp_6:* = speedProgressBar;
         var _temp_5:* = numberFormat(_loc3_) + " ";
         var _loc12_:String = "ui.windows.recruitmentchamber.kph";
         _temp_6.label = _temp_5 + peak.i18n.PText.INSTANCE.getText0(_loc12_);
         buffProgressBar.maximum = param2.id == 33 ? param2.rangesPerStage[param2.maxBonusStages - 1] * 5 : param2.buffsPerStage[param2.maxBonusStages - 1];
         buffProgressBar.value = _loc5_;
         var _temp_8:* = buffProgressBar;
         var _temp_7:* = param2.id == 33 ? "ui.windows.beast.cave.beast.progressbar.range" : "ui.windows.beast.cave.beast.progressbar.buff";
         var _loc13_:String = numberFormat(_loc5_);
         var _loc14_:String = _temp_7;
         _temp_8.label = peak.i18n.PText.INSTANCE.getText1(_loc14_,_loc13_);
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
      
      public function get healButton() : MPButton
      {
         return _healButton;
      }
      
      public function get beastAsset() : DisplayObject
      {
         return _beastAsset;
      }
      
      public function get goldCostForHealing() : int
      {
         return _goldCostForHealing;
      }
   }
}

