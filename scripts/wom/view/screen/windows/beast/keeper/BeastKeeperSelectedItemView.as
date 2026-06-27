package wom.view.screen.windows.beast.keeper
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.progressbar.MaskedProgressBar;
   import wom.view.component.progressbar.ProgressBar30;
   
   public class BeastKeeperSelectedItemView extends Sprite implements View
   {
      
      private static const BACKGROUND_WIDTH:int = 669;
      
      private static const BACKGROUND_HEIGHT:int = 163;
      
      private static const PROGRESSBAR_WIDTH:int = 163;
      
      private static const PROGRESSBAR_HEIGHT:int = 26;
      
      private static const PROGRESSBAR_X_MARGIN:int = 9;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _beast:BeastTypeDIO;
      
      private var _beastLevel:int;
      
      private var _beastBonusStage:int;
      
      private var background:DisplayObject;
      
      private var _beastAsset:AssetDisplayObject;
      
      private var beastNameTextField:TextField;
      
      private var beastLevelTextField:TextField;
      
      private var damageProgressBar:MaskedProgressBar;
      
      private var damageTextField:TextField;
      
      private var healthProgressBar:MaskedProgressBar;
      
      private var healthTextField:TextField;
      
      private var speedProgressBar:MaskedProgressBar;
      
      private var speedTextField:TextField;
      
      private var buffProgressBar:MaskedProgressBar;
      
      private var buffTextField:TextField;
      
      private var beastInfoTextField:TextField;
      
      public function BeastKeeperSelectedItemView(param1:BeastTypeDIO, param2:int, param3:int)
      {
         super();
         _beast = param1;
         _beastLevel = param2;
         _beastBonusStage = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("BackgroundLight");
         background.width = 669;
         background.height = 163;
         addChild(background);
         beastNameTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         beastNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         beastNameTextField.autoSize = "left";
         addChild(beastNameTextField);
         beastLevelTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         beastLevelTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         beastLevelTextField.autoSize = "left";
         addChild(beastLevelTextField);
         var _temp_4:* = beastNameTextField;
         var _loc1_:String = "domain.beasts." + _beast.id + ".name";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
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
         beastInfoTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         beastInfoTextField.multiline = true;
         beastInfoTextField.wordWrap = true;
         beastInfoTextField.width = 460;
         beastInfoTextField.autoSize = "left";
         addChild(beastInfoTextField);
      }
      
      public function drawLayout() : void
      {
         _beastAsset.visible = _beastAsset.width > 1;
         if(_beastAsset.visible)
         {
            _beastAsset.scaleX = _beastAsset.scaleY = 163 / _beastAsset.height;
            AlignmentUtil.alignAccordingToPositionOf(_beastAsset,background,163 - _beastAsset.width,-15);
         }
         AlignmentUtil.alignAccordingToPositionOf(beastNameTextField,background,197,5);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(beastLevelTextField,beastNameTextField,beastNameTextField.width + 10);
         beastLevelTextField.y += 2;
         AlignmentUtil.alignAccordingToPositionOf(damageProgressBar,background,253,30);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(damageTextField,damageProgressBar,-(9 + damageTextField.width));
         damageTextField.y += 2;
         AlignmentUtil.alignBelowOf(healthProgressBar,damageProgressBar,6);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(healthTextField,healthProgressBar,-(9 + healthTextField.width));
         healthTextField.y += 2;
         AlignmentUtil.alignRightOf(speedProgressBar,damageProgressBar,78);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(speedTextField,speedProgressBar,-(9 + speedTextField.width));
         speedTextField.y += 2;
         AlignmentUtil.alignBelowOf(buffProgressBar,speedProgressBar,6);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(buffTextField,buffProgressBar,-(9 + buffTextField.width));
         buffTextField.y += 2;
         AlignmentUtil.alignAccordingToPositionOf(beastInfoTextField,background,198,95);
      }
      
      public function updateBeast(param1:BeastTypeDIO) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _temp_1:* = buffTextField;
         var _loc8_:String = param1.id == 33 ? "ui.windows.beast.cave.beast.progressbar.rangetitle" : "ui.windows.beast.cave.beast.progressbar.bufftitle";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         clearBeast();
         _beastAsset = assetRepository.getDisplayObject(_beast.assetName + _beastLevel);
         addChild(_beastAsset);
         var _temp_4:* = beastLevelTextField;
         var _temp_3:* = "ui.windows.beast.keeper.level";
         var _loc9_:int = _beastLevel;
         var _loc10_:String = _temp_3;
         _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc10_,_loc9_);
         if(_beastBonusStage > 0)
         {
            _loc6_ = _beastBonusStage - 1;
            _loc4_ = param1.damagePointsPerStage[_loc6_];
            _loc7_ = param1.healthPointsPerStage[_loc6_];
            _loc3_ = param1.speedsPerStage[_loc6_];
            _loc5_ = param1.id == 33 ? param1.rangesPerStage[_loc6_] : param1.buffsPerStage[_loc6_];
         }
         else
         {
            _loc2_ = _beastLevel - 1;
            _loc4_ = param1.damage(_loc2_);
            _loc7_ = param1.healthPointsPerLevel[_loc2_];
            _loc3_ = param1.speed(_loc2_);
            _loc5_ = param1.id == 33 ? param1.range(_loc2_) : param1.buffsPerLevel[_loc2_];
         }
         damageProgressBar.setProgress(_loc4_,param1.damagePointsPerStage[param1.maxBonusStages - 1]);
         damageProgressBar.progressText = NumberUtil.numberFormat(_loc4_);
         healthProgressBar.setProgress(_loc7_,param1.healthPointsPerStage[param1.maxBonusStages - 1]);
         healthProgressBar.progressText = NumberUtil.numberFormat(_loc7_);
         speedProgressBar.setProgress(_loc3_,param1.speedsPerStage[param1.maxBonusStages - 1]);
         speedProgressBar.progressText = NumberUtil.numberFormat(_loc3_);
         buffProgressBar.setProgress(_loc5_,param1.id == 33 ? param1.rangesPerStage[param1.maxBonusStages - 1] : param1.buffsPerStage[param1.maxBonusStages - 1]);
         var _temp_6:* = buffProgressBar;
         var _temp_5:* = param1.id == 33 ? "ui.windows.beast.cave.beast.progressbar.range" : "ui.windows.beast.cave.beast.progressbar.buff";
         var _loc11_:String = NumberUtil.numberFormat(_loc5_);
         var _loc12_:String = _temp_5;
         _temp_6.progressText = peak.i18n.PText.INSTANCE.getText1(_loc12_,_loc11_);
         var _temp_7:* = beastInfoTextField;
         var _loc13_:String = "domain.beasts." + beast.id + ".desc";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc13_);
         drawLayout();
      }
      
      private function clearBeast() : void
      {
         if(_beastAsset != null && contains(_beastAsset))
         {
            removeChild(_beastAsset);
         }
      }
      
      private function createProgressBar(param1:int = 163) : MaskedProgressBar
      {
         var _loc2_:MaskedProgressBar = new ProgressBar30();
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
         _loc2_.height = _loc2_.textHeight + 4 >> 0;
         addChild(_loc2_);
         return _loc2_;
      }
      
      public function get beastAsset() : AssetDisplayObject
      {
         return _beastAsset;
      }
      
      public function get beast() : BeastTypeDIO
      {
         return _beast;
      }
      
      public function get beastLevel() : int
      {
         return _beastLevel;
      }
   }
}

