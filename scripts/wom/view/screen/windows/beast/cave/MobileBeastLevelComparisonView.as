package wom.view.screen.windows.beast.cave
{
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.view.screen.windows.upgrade.MobileLevelEffectComparisonView;
   
   public class MobileBeastLevelComparisonView extends Sprite implements View
   {
      
      private static const PROGRESSBAR_WIDTH:int = 220;
      
      private static const PROGRESSBAR_HEIGHT:int = 30;
      
      private static const LABEL_MARGIN:int = 7;
      
      private static const LABEL_WIDTH:int = 65;
      
      private var damageProgressBar:MobileLevelEffectComparisonView;
      
      private var healthProgressBar:MobileLevelEffectComparisonView;
      
      private var speedProgressBar:MobileLevelEffectComparisonView;
      
      private var buffProgressBar:MobileLevelEffectComparisonView;
      
      private var _nextLevel:int;
      
      private var _beastDIO:BeastTypeDIO;
      
      private var _currentLevel:int;
      
      public function MobileBeastLevelComparisonView(param1:BeastTypeDIO, param2:int, param3:int)
      {
         super();
         _beastDIO = param1;
         _currentLevel = param2;
         _nextLevel = param3;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _temp_1:* = §§findproperty(MobileLevelEffectComparisonView);
         var _loc1_:String = "ui.windows.beast.cave.beast.progressbar.speedtitle";
         speedProgressBar = new MobileLevelEffectComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc1_),_beastDIO.speed(_currentLevel - 1),_beastDIO.speed(_nextLevel - 1),_beastDIO.speedsPerStage[_beastDIO.maxBonusStages - 1],null,65,220,7);
         addChild(speedProgressBar);
         var _temp_3:* = §§findproperty(MobileLevelEffectComparisonView);
         var _loc2_:String = "ui.windows.beast.cave.beast.progressbar.healthtitle";
         healthProgressBar = new MobileLevelEffectComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc2_),_beastDIO.healthPointsPerLevel[_currentLevel - 1],_beastDIO.healthPointsPerLevel[_nextLevel - 1],_beastDIO.healthPointsPerStage[_beastDIO.maxBonusStages - 1],null,65,220,7);
         addChild(healthProgressBar);
         var _temp_5:* = §§findproperty(MobileLevelEffectComparisonView);
         var _loc3_:String = "ui.windows.beast.cave.beast.progressbar.damagetitle";
         damageProgressBar = new MobileLevelEffectComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc3_),_beastDIO.damage(_currentLevel - 1),_beastDIO.damage(_nextLevel - 1),_beastDIO.damagePointsPerStage[_beastDIO.maxBonusStages - 1],null,65,220,7);
         addChild(damageProgressBar);
         var _temp_7:* = §§findproperty(MobileLevelEffectComparisonView);
         var _loc4_:String = "ui.windows.beast.cave.beast.progressbar.bufftitle";
         buffProgressBar = new MobileLevelEffectComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc4_),_beastDIO.buffsPerLevel[_currentLevel - 1],_beastDIO.buffsPerLevel[_nextLevel - 1],_beastDIO.buffsPerStage[_beastDIO.maxBonusStages - 1],null,65,220,7);
         addChild(buffProgressBar);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(healthProgressBar,speedProgressBar,0,46);
         MobileAlignmentUtil.alignAccordingToPositionOf(damageProgressBar,healthProgressBar,0,46);
         MobileAlignmentUtil.alignAccordingToPositionOf(buffProgressBar,damageProgressBar,0,46);
      }
      
      public function updateComperation() : void
      {
         if(speedProgressBar)
         {
            if(contains(speedProgressBar))
            {
               removeChild(speedProgressBar);
            }
         }
         var _temp_1:* = §§findproperty(MobileLevelEffectComparisonView);
         var _loc5_:String = "ui.windows.beast.cave.beast.progressbar.speedtitle";
         speedProgressBar = new MobileLevelEffectComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc5_),_beastDIO.speed(_currentLevel - 1),_beastDIO.speed(_nextLevel - 1),_beastDIO.speedsPerStage[_beastDIO.maxBonusStages - 1],null,65,220,7);
         addChild(speedProgressBar);
         if(healthProgressBar)
         {
            if(contains(healthProgressBar))
            {
               removeChild(healthProgressBar);
            }
         }
         var _temp_3:* = §§findproperty(MobileLevelEffectComparisonView);
         var _loc6_:String = "ui.windows.beast.cave.beast.progressbar.healthtitle";
         healthProgressBar = new MobileLevelEffectComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc6_),_beastDIO.healthPointsPerLevel[_currentLevel - 1],_beastDIO.healthPointsPerLevel[_nextLevel - 1],_beastDIO.healthPointsPerStage[_beastDIO.maxBonusStages - 1],null,65,220,7);
         addChild(healthProgressBar);
         if(damageProgressBar)
         {
            if(contains(damageProgressBar))
            {
               removeChild(damageProgressBar);
            }
         }
         var _temp_5:* = §§findproperty(MobileLevelEffectComparisonView);
         var _loc7_:String = "ui.windows.beast.cave.beast.progressbar.damagetitle";
         damageProgressBar = new MobileLevelEffectComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc7_),_beastDIO.damage(_currentLevel - 1),_beastDIO.damage(_nextLevel - 1),_beastDIO.damagePointsPerStage[_beastDIO.maxBonusStages - 1],null,65,220,7);
         addChild(damageProgressBar);
         if(buffProgressBar)
         {
            if(contains(buffProgressBar))
            {
               removeChild(buffProgressBar);
            }
         }
         var _loc8_:String = _beastDIO.id == 33 ? "ui.windows.beast.cave.beast.progressbar.rangetitle" : "ui.windows.beast.cave.beast.progressbar.bufftitle";
         var _loc4_:String = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         var _loc3_:int = int(_beastDIO.id == 33 ? _beastDIO.range(_currentLevel - 1) * 5 : _beastDIO.buffsPerLevel[_currentLevel - 1]);
         var _loc2_:int = int(_beastDIO.id == 33 ? _beastDIO.range(_nextLevel - 1) * 5 : _beastDIO.buffsPerLevel[_nextLevel - 1]);
         var _loc1_:int = int(_beastDIO.id == 33 ? _beastDIO.rangesPerStage[_beastDIO.maxBonusStages - 1] * 5 : _beastDIO.buffsPerStage[_beastDIO.maxBonusStages - 1]);
         buffProgressBar = new MobileLevelEffectComparisonView(_loc4_,_loc3_,_loc2_,_loc1_,null,65,220,7);
         addChild(buffProgressBar);
         drawLayout();
      }
      
      private function numberFormat(param1:Number) : String
      {
         return NumberUtil.numberFormat(param1,2,false,false);
      }
   }
}

