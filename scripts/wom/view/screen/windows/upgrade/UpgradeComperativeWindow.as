package wom.view.screen.windows.upgrade
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomGreenMediumButton;
   
   public class UpgradeComperativeWindow extends UpgradeBuildingWithRequirementWindow
   {
      
      private static const WINDOW_WIDTH:int = 716;
      
      private static const WINDOW_HEIGHT:int = 479;
      
      private var levelComparisonBackground:DisplayObject;
      
      private var _upgradeAllWallsButton:WomGreenMediumButton;
      
      private var _levelComparisonViews:Vector.<LevelEffectComparisonView>;
      
      private var _levelComparisonNowTextField:TextField;
      
      private var _levelComparisonAfterTextField:TextField;
      
      public function UpgradeComperativeWindow(param1:BuildingInfo, param2:BuildingTypeDIO)
      {
         super(param1,param2,716,479);
      }
      
      override protected function initLayout() : void
      {
         var _loc5_:BuildingSpecificInfoType = null;
         var _loc1_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc2_:int = 0;
         var _loc7_:Number = NaN;
         super.initLayout();
         _levelComparisonNowTextField = new WomTextField();
         _levelComparisonNowTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         _levelComparisonNowTextField.autoSize = "center";
         var _temp_2:* = _levelComparisonNowTextField;
         var _loc10_:String = "ui.windows.upgrade.now";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         addChild(_levelComparisonNowTextField);
         _levelComparisonAfterTextField = new WomTextField();
         _levelComparisonAfterTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         _levelComparisonAfterTextField.autoSize = "center";
         var _temp_4:* = _levelComparisonAfterTextField;
         var _loc11_:String = "ui.windows.upgrade.after";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         addChild(_levelComparisonAfterTextField);
         _levelComparisonViews = new Vector.<LevelEffectComparisonView>();
         var _temp_6:* = §§findproperty(LevelEffectComparisonView);
         var _loc12_:String = "domain.buildingupgradeparameters.health";
         var _loc4_:LevelEffectComparisonView = new LevelEffectComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc12_),_buildingTypeDIO.healthPointsPerLevel[_buildingInfo.level - 1],_buildingTypeDIO.healthPointsPerLevel[_targetLevel],_buildingTypeDIO.healthPointsPerLevel[_buildingTypeDIO.maxLevels - 1]);
         _levelComparisonViews.push(_loc4_);
         addChild(_loc4_);
         for(var _loc6_ in _buildingTypeDIO.buildingSpecificInfo)
         {
            _loc5_ = BuildingSpecificInfoType.determineBuildingSpecificInfoType(int(_loc6_));
            if(_loc5_ != null && _loc5_.preview && !(_buildingInfo.buildingTypeId == 35 && _loc5_ == BuildingSpecificInfoType.EXPLOSION_RANGES_PER_LEVEL_IN_PX))
            {
               _loc1_ = Number(_buildingTypeDIO.buildingSpecificInfo[_loc6_][_buildingInfo.level - 1]);
               _loc3_ = Number(_buildingTypeDIO.buildingSpecificInfo[_loc6_][_targetLevel]);
               _loc2_ = Math.min(_buildingInfo.level + 3,_buildingTypeDIO.maxLevels - 1);
               _loc7_ = Number(_buildingTypeDIO.buildingSpecificInfo[_loc6_][_loc2_]);
               var _temp_11:* = §§findproperty(LevelEffectComparisonView);
               var _loc13_:String = "domain.buildingupgradeparameters." + _loc5_.name;
               _loc4_ = new LevelEffectComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc13_),_loc1_,_loc3_,_loc7_,getUnitKeyForComparisonView(_loc5_));
               _levelComparisonViews.push(_loc4_);
               addChild(_loc4_);
            }
         }
         _upgradeAllWallsButton = new WomGreenMediumButton();
         var _temp_13:* = _upgradeAllWallsButton;
         var _loc14_:String = "ui.windows.upgrade.upgradeallnow";
         _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc14_);
         _upgradeAllWallsButton.width = 170;
         _upgradeAllWallsButton.visible = _buildingTypeDIO.id == 41;
         addChild(_upgradeAllWallsButton);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         costsBackground.y = 335;
         AlignmentUtil.alignRightOf(durationBackground,costsBackground,10);
         levelComparisonBackground = assetRepository.getDisplayObject("BackgroundLight");
         levelComparisonBackground.width = 500;
         levelComparisonBackground.height = 142;
         AlignmentUtil.alignBelowOf(levelComparisonBackground,requirementBackground,9);
         addChild(levelComparisonBackground);
      }
      
      override public function drawLayout() : void
      {
         var _loc1_:int = 0;
         super.drawLayout();
         if(_levelComparisonViews.length > 0)
         {
            AlignmentUtil.alignAccordingToPositionOf(_levelComparisonViews[0],levelComparisonBackground,0,27);
            _levelComparisonNowTextField.visible = true;
            _levelComparisonAfterTextField.visible = true;
            AlignmentUtil.alignAccordingToPositionOf(_levelComparisonNowTextField,levelComparisonBackground,216 - _levelComparisonNowTextField.width / 2,5);
            AlignmentUtil.alignAccordingToPositionOf(_levelComparisonAfterTextField,levelComparisonBackground,382 - _levelComparisonAfterTextField.width / 2,5);
         }
         else
         {
            _levelComparisonNowTextField.visible = false;
            _levelComparisonAfterTextField.visible = false;
         }
         _loc1_ = 1;
         while(_loc1_ < _levelComparisonViews.length)
         {
            AlignmentUtil.alignAccordingToPositionOf(_levelComparisonViews[_loc1_],_levelComparisonViews[_loc1_ - 1],0,28);
            _loc1_++;
         }
         AlignmentUtil.alignAccordingToPositionOf(_upgradeAllWallsButton,levelComparisonBackground,levelComparisonBackground.width - _upgradeAllWallsButton.width - 20,levelComparisonBackground.height - 21);
      }
      
      public function get upgradeAllWallsButton() : WomGreenMediumButton
      {
         return _upgradeAllWallsButton;
      }
      
      private function getUnitKeyForComparisonView(param1:BuildingSpecificInfoType) : String
      {
         var _loc2_:String = null;
         if(_buildingInfo.buildingTypeId == 45 && param1 == BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL)
         {
            _loc2_ = "domain.buildingupgradevalues.percentdamage";
         }
         return _loc2_;
      }
   }
}

