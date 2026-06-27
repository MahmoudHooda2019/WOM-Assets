package wom.view.screen.windows.beast.keeper
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileBeastKeeperItemInfoView extends Sprite implements View
   {
      
      private static const WIDTH:int = 344;
      
      private static const HEIGHT:int = 502;
      
      private static const PROGRESSBAR_WIDTH_NORMAL:int = 220;
      
      private static const PROGRESSBAR_HEIGHT:int = 36;
      
      private static const PROGRESSBAR_X_MARGIN:int = 8;
      
      private var background:DisplayObject;
      
      private var _beastDIO:BeastTypeDIO;
      
      private var _beastLevel:int;
      
      private var _beastNameTextField:MPTextField;
      
      private var _beastLevelTextField:MPTextField;
      
      private var beastInfoTextField:MPTextField;
      
      private var _beastData:Object;
      
      private var damageProgressBar:MobileWomProgressBar;
      
      private var damageTextField:MPTextField;
      
      private var healthProgressBar:MobileWomProgressBar;
      
      private var healthTextField:MPTextField;
      
      private var speedProgressBar:MobileWomProgressBar;
      
      private var speedTextField:MPTextField;
      
      private var buffProgressBar:MobileWomProgressBar;
      
      private var buffTextField:MPTextField;
      
      private var _bonusStage:int;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _hintButton:MPRigidButton;
      
      public function MobileBeastKeeperItemInfoView(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileBeigeBackground");
         background.width = 344;
         background.height = 502;
         background.y = 11;
         addChild(background);
         _beastNameTextField = new MobileCaptionTextField();
         _beastNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(33,"center");
         _beastNameTextField.width = 344 - 80;
         addChild(_beastNameTextField);
         _beastLevelTextField = new MobileCaptionTextField();
         _beastLevelTextField.textRendererProperties.textFormat = getCaptionTextFormat(30,"center");
         _beastLevelTextField.width = 344 - 80;
         addChild(_beastLevelTextField);
         beastInfoTextField = new MobileWomTextField();
         beastInfoTextField.width = 344 - 80;
         beastInfoTextField.textRendererProperties.textFormat = getWomTextFormat(21,"center");
         beastInfoTextField.textRendererProperties.wordWrap = true;
         addChild(beastInfoTextField);
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
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _hintButton.setPaddings(10,10,10,10);
         _hintButton.addEventListener("triggered",onHintButtonClicked);
         addChild(_hintButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_beastNameTextField,background,-10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_beastLevelTextField,background,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,background,295,10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(beastInfoTextField,background,47);
         MobileAlignmentUtil.alignAccordingToPositionOf(speedProgressBar,background,95,303);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(speedTextField,speedProgressBar,-(8 + 60));
         MobileAlignmentUtil.alignBelowOf(healthProgressBar,speedProgressBar,10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(healthTextField,healthProgressBar,-(8 + 60));
         MobileAlignmentUtil.alignBelowOf(damageProgressBar,healthProgressBar,10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(damageTextField,damageProgressBar,-(8 + 60));
         MobileAlignmentUtil.alignBelowOf(buffProgressBar,damageProgressBar,10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(buffTextField,buffProgressBar,-(8 + 60));
      }
      
      public function updateBeastData(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Number = NaN;
         var _loc4_:int = 0;
         this.data = param1;
         var _temp_1:* = _beastNameTextField;
         var _loc6_:String = "domain.beasts." + _beastDIO.id + ".name";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         var _temp_3:* = _beastLevelTextField;
         var _temp_2:* = "ui.windows.beast.keeper.level";
         var _loc7_:int = _beastLevel;
         var _loc8_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc8_,_loc7_);
         var _temp_4:* = beastInfoTextField;
         var _loc9_:String = "domain.beasts." + _beastDIO.id + ".desc";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         if(_bonusStage > 0)
         {
            _loc3_ = _beastDIO.damagePointsPerStage[_bonusStage - 1];
            _loc5_ = _beastDIO.healthPointsPerStage[_bonusStage - 1];
            _loc2_ = _beastDIO.speedsPerStage[_bonusStage - 1];
            _loc4_ = _beastDIO.buffsPerStage[_bonusStage - 1];
         }
         else
         {
            _loc3_ = _beastDIO.damage(_beastLevel - 1);
            _loc5_ = _beastDIO.healthPointsPerLevel[_beastLevel - 1];
            _loc2_ = _beastDIO.speed(_beastLevel - 1);
            _loc4_ = _beastDIO.buffsPerLevel[_beastLevel - 1];
         }
         damageProgressBar.maximum = _beastDIO.damagePointsPerStage[_beastDIO.maxBonusStages - 1];
         damageProgressBar.value = _loc3_;
         damageProgressBar.label = numberFormat(_loc3_);
         healthProgressBar.maximum = _beastDIO.healthPointsPerStage[_beastDIO.maxBonusStages - 1];
         healthProgressBar.value = _loc5_;
         healthProgressBar.label = numberFormat(_loc5_);
         speedProgressBar.maximum = _beastDIO.speedsPerStage[_beastDIO.maxBonusStages - 1];
         speedProgressBar.value = _loc2_;
         var _temp_6:* = speedProgressBar;
         var _temp_5:* = numberFormat(_loc2_) + " ";
         var _loc10_:String = "ui.windows.recruitmentchamber.kph";
         _temp_6.label = _temp_5 + peak.i18n.PText.INSTANCE.getText0(_loc10_);
         buffProgressBar.maximum = _beastDIO.buffsPerStage[_beastDIO.maxBonusStages - 1];
         buffProgressBar.value = _loc4_;
         var _temp_8:* = buffProgressBar;
         var _temp_7:* = "ui.windows.beast.cave.beast.progressbar.buff";
         var _loc11_:String = numberFormat(_loc4_);
         var _loc12_:String = _temp_7;
         _temp_8.label = peak.i18n.PText.INSTANCE.getText1(_loc12_,_loc11_);
         drawLayout();
      }
      
      private function onHintButtonClicked(param1:Event) : void
      {
         (this.parent as MobileBeastKeeperItemViewRenderer).onHintButtonClicked();
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
      
      private function numberFormat(param1:Number) : String
      {
         return NumberUtil.numberFormat(param1,2,false,false);
      }
      
      public function get data() : Object
      {
         return _beastData;
      }
      
      public function set data(param1:Object) : void
      {
         if(param1)
         {
            _beastData = param1;
            _bonusStage = param1.bonusStage;
            _beastDIO = param1.beastDIO;
            _beastLevel = param1.beastLevel;
         }
      }
   }
}

