package wom.view.screen.windows.trainingchamber
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.screen.windows.upgrade.MobileLevelEffectComparisonView;
   
   public class MobileTrainingChamberItemInfoView extends Sprite implements View
   {
      
      private static const WIDTH:int = 344;
      
      private static const HEIGHT:int = 502;
      
      private var background:DisplayObject;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var mercenarData:Object;
      
      private var unitTypeDIO:UnitTypeDIO;
      
      private var damageComparisonView:MobileLevelEffectComparisonView;
      
      private var healthComparisonView:MobileLevelEffectComparisonView;
      
      private var speedComparisonView:MobileLevelEffectComparisonView;
      
      private var ironCostComparisonView:MobileLevelEffectComparisonView;
      
      private var housingComparisonView:MobileLevelEffectComparisonView;
      
      private var timeComparisonView:MobileLevelEffectComparisonView;
      
      private var mercenaryNameTextField:MPTextField;
      
      private var unitTypeInfo:UnitTypeInfo;
      
      private var _hintButton:MPRigidButton;
      
      private var mercenaryLevelTextField:MobileCaptionTextField;
      
      public function MobileTrainingChamberItemInfoView(param1:MobileWomAssetRepository)
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
         background.x = 7;
         background.y = 11;
         addChild(background);
         mercenaryNameTextField = new MobileCaptionTextField();
         mercenaryNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(33,"center");
         mercenaryNameTextField.width = 344 - 80;
         addChild(mercenaryNameTextField);
         mercenaryLevelTextField = new MobileCaptionTextField();
         mercenaryLevelTextField.textRendererProperties.textFormat = getCaptionTextFormat(30,"center");
         mercenaryLevelTextField.width = 344 - 80;
         addChild(mercenaryLevelTextField);
         speedComparisonView = createComparisonView("speed");
         var _loc1_:String = "ui.windows.trainingchamber.health";
         healthComparisonView = createComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         damageComparisonView = createComparisonView(" ");
         var _loc2_:String = "ui.windows.trainingchamber.resourcecost";
         ironCostComparisonView = createComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         var _loc3_:String = "ui.windows.trainingchamber.housing";
         housingComparisonView = createComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         var _loc4_:String = "ui.windows.trainingchamber.time";
         timeComparisonView = createComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _hintButton.addEventListener("triggered",onHintButtonClicked);
         addChild(_hintButton);
         drawLayout();
      }
      
      private function createComparisonView(param1:String) : MobileLevelEffectComparisonView
      {
         var _loc2_:MobileLevelEffectComparisonView = new MobileLevelEffectComparisonView(param1,0,0,0,null,90,185);
         addChild(_loc2_);
         return _loc2_;
      }
      
      public function updateMercenaryData(param1:Object) : void
      {
         this.data = param1;
         var _temp_1:* = damageComparisonView;
         var _loc22_:String = "ui.windows.trainingchamber." + (unitTypeDIO.healer ? "heal" : "damage");
         _temp_1.effectName = peak.i18n.PText.INSTANCE.getText0(_loc22_);
         var _temp_2:* = mercenaryNameTextField;
         var _loc23_:String = "domain.units." + unitTypeDIO.id + ".name";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc23_);
         var _temp_4:* = mercenaryLevelTextField;
         var _temp_3:* = "ui.windows.beast.keeper.level";
         var _loc24_:int = unitTypeInfo.currentLevel;
         var _loc25_:String = _temp_3;
         _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc25_,_loc24_);
         var _loc11_:int = unitTypeInfo.currentLevel - 1;
         var _loc15_:int = int(unitTypeInfo.currentLevel == unitTypeDIO.maxLevels ? unitTypeInfo.currentLevel - 1 : unitTypeInfo.currentLevel);
         var _loc8_:Number = unitTypeDIO.speed(_loc11_);
         var _loc10_:int = unitTypeDIO.healthPointsPerLevel[_loc11_];
         var _loc16_:int = unitTypeDIO.damage(_loc11_);
         var _loc3_:Number = unitTypeDIO.hiringCostsPerLevel[_loc11_][0].resourceAmount;
         var _loc4_:int = unitTypeDIO.spacesPerLevel[_loc11_];
         var _loc5_:Number = unitTypeDIO.hiringDurationPerLevelInSecs[_loc11_];
         var _loc21_:Number = unitTypeDIO.speed(_loc15_);
         var _loc14_:int = unitTypeDIO.healthPointsPerLevel[_loc15_];
         var _loc2_:int = unitTypeDIO.damage(_loc15_);
         var _loc13_:Number = unitTypeDIO.hiringCostsPerLevel[_loc15_][0].resourceAmount;
         var _loc9_:int = unitTypeDIO.spacesPerLevel[_loc15_];
         var _loc7_:Number = unitTypeDIO.hiringDurationPerLevelInSecs[_loc15_];
         var _loc12_:Number = unitTypeDIO.speed(unitTypeDIO.maxLevels - 1);
         var _loc19_:int = unitTypeDIO.healthPointsPerLevel[unitTypeDIO.maxLevels - 1];
         var _loc20_:int = unitTypeDIO.damage(unitTypeDIO.maxLevels - 1);
         var _loc17_:Number = Math.max(unitTypeDIO.hiringCostsPerLevel[0][0].resourceAmount,unitTypeDIO.hiringCostsPerLevel[unitTypeDIO.maxLevels - 1][0].resourceAmount);
         var _loc18_:int = unitTypeDIO.spacesPerLevel[unitTypeDIO.maxLevels - 1];
         var _loc6_:Number = Math.max(unitTypeDIO.hiringDurationPerLevelInSecs[0],unitTypeDIO.hiringDurationPerLevelInSecs[unitTypeDIO.maxLevels - 1]);
         speedComparisonView.updateWithComparisonInfo(_loc8_,_loc21_,_loc12_);
         healthComparisonView.updateWithComparisonInfo(_loc10_,_loc14_,_loc19_);
         damageComparisonView.updateWithComparisonInfo(_loc16_,_loc2_,_loc20_);
         ironCostComparisonView.updateWithComparisonInfo(_loc3_,_loc13_,_loc17_);
         housingComparisonView.updateWithComparisonInfo(_loc4_,_loc9_,_loc18_);
         timeComparisonView.updateWithComparisonInfo(_loc5_,_loc7_,_loc6_);
         var _temp_5:* = ironCostComparisonView;
         var _loc26_:String = unitTypeDIO.event ? "ui.windows.upgrade.cost" : "ui.windows.trainingchamber.resourcecost";
         _temp_5.effectName = peak.i18n.PText.INSTANCE.getText0(_loc26_);
         housingComparisonView.visible = !unitTypeDIO.event;
         drawLayout();
      }
      
      private function onHintButtonClicked(param1:Event) : void
      {
         (this.parent as MobileTrainingChamberItemViewRenderer).onHintButtonClicked();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(mercenaryNameTextField,background,-10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(mercenaryLevelTextField,background,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,background,295,10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(speedComparisonView,background,120);
         MobileAlignmentUtil.alignBelowOf(healthComparisonView,speedComparisonView,4);
         MobileAlignmentUtil.alignBelowOf(damageComparisonView,healthComparisonView,4);
         MobileAlignmentUtil.alignBelowOf(ironCostComparisonView,damageComparisonView,4);
         MobileAlignmentUtil.alignBelowOf(housingComparisonView,ironCostComparisonView,4);
         MobileAlignmentUtil.alignBelowOf(timeComparisonView,housingComparisonView.visible ? housingComparisonView : ironCostComparisonView,4);
      }
      
      public function get data() : Object
      {
         return mercenarData;
      }
      
      public function set data(param1:Object) : void
      {
         if(param1)
         {
            mercenarData = param1;
            unitTypeDIO = param1.unitTypeDIO;
            unitTypeInfo = param1.unitTypeInfo;
         }
      }
   }
}

