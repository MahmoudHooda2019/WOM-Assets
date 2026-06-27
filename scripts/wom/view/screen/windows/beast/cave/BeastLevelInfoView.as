package wom.view.screen.windows.beast.cave
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.progressbar.MaskedProgressBar;
   import wom.view.component.progressbar.ProgressBar26;
   
   public class BeastLevelInfoView extends Sprite implements View
   {
      
      private static const PROGRESSBAR_HEIGHT:int = 26;
      
      private static const PROGRESSBAR_X_MARGIN:int = 9;
      
      private var damageProgressBar:MaskedProgressBar;
      
      private var damageTextField:TextField;
      
      private var healthProgressBar:MaskedProgressBar;
      
      private var healthTextField:TextField;
      
      private var speedProgressBar:MaskedProgressBar;
      
      private var speedTextField:TextField;
      
      private var buffProgressBar:MaskedProgressBar;
      
      private var buffTextField:TextField;
      
      public function BeastLevelInfoView()
      {
         super();
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
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
         drawLayout();
      }
      
      private function createProgressBar(param1:int = 112) : MaskedProgressBar
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
      
      public function drawLayout() : void
      {
         damageProgressBar.x = 54;
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(damageTextField,damageProgressBar,-(9 + damageTextField.width));
         AlignmentUtil.alignBelowOf(healthProgressBar,damageProgressBar,2);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(healthTextField,healthProgressBar,-(9 + healthTextField.width));
         AlignmentUtil.alignBelowOf(speedProgressBar,healthProgressBar,2);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(speedTextField,speedProgressBar,-(9 + speedTextField.width));
         AlignmentUtil.alignBelowOf(buffProgressBar,speedProgressBar,2);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(buffTextField,buffProgressBar,-(9 + buffTextField.width));
      }
      
      public function updateWithBeastInfo(param1:BeastTypeDIO, param2:int) : void
      {
         var _temp_1:* = buffTextField;
         var _loc8_:String = param1.id == 33 ? "ui.windows.beast.cave.beast.progressbar.rangetitle" : "ui.windows.beast.cave.beast.progressbar.bufftitle";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         var _loc7_:int = param2 - 1;
         var _loc4_:int = param1.damage(_loc7_);
         var _loc6_:int = param1.healthPointsPerLevel[_loc7_];
         var _loc3_:Number = param1.speed(_loc7_);
         var _loc5_:int = int(param1.id == 33 ? param1.range(_loc7_) * 5 : param1.buffsPerLevel[_loc7_]);
         damageProgressBar.setProgress(_loc4_,param1.damagePointsPerStage[param1.maxBonusStages - 1]);
         damageProgressBar.progressText = numberFormat(_loc4_);
         healthProgressBar.setProgress(_loc6_,param1.healthPointsPerStage[param1.maxBonusStages - 1]);
         healthProgressBar.progressText = numberFormat(_loc6_);
         speedProgressBar.setProgress(_loc3_,param1.speedsPerStage[param1.maxBonusStages - 1]);
         var _temp_3:* = speedProgressBar;
         var _temp_2:* = numberFormat(_loc3_) + " ";
         var _loc9_:String = "ui.windows.recruitmentchamber.kph";
         _temp_3.progressText = _temp_2 + peak.i18n.PText.INSTANCE.getText0(_loc9_);
         buffProgressBar.setProgress(_loc5_,param1.id == 33 ? param1.rangesPerStage[param1.maxBonusStages - 1] * 5 : param1.buffsPerStage[param1.maxBonusStages - 1]);
         var _temp_5:* = buffProgressBar;
         var _temp_4:* = param1.id == 33 ? "ui.windows.beast.cave.beast.progressbar.range" : "ui.windows.beast.cave.beast.progressbar.buff";
         var _loc10_:String = numberFormat(_loc5_);
         var _loc11_:String = _temp_4;
         _temp_5.progressText = peak.i18n.PText.INSTANCE.getText1(_loc11_,_loc10_);
      }
      
      private function numberFormat(param1:Number) : String
      {
         return NumberUtil.numberFormat(param1,2,false,false);
      }
   }
}

