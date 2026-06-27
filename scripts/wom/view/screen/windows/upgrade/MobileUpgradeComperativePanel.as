package wom.view.screen.windows.upgrade
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.windows.build.MobileBuildingSilhouette;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileUpgradeComperativePanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 787;
      
      private static const HEIGHT:int = 213;
      
      private static const X_MARGIN_OF_LABELS:int = 246;
      
      protected var _upgradeAllWallsButton:MPButton;
      
      protected var _levelComparisonViews:Vector.<MobileLevelEffectComparisonView>;
      
      protected var _buildingTypeDIO:BuildingTypeDIO;
      
      protected var _targetLevel:int;
      
      private var _buildingSilhouette:DisplayObject;
      
      public function MobileUpgradeComperativePanel(param1:BuildingTypeDIO, param2:int)
      {
         super(787,213);
         _buildingTypeDIO = param1;
         _targetLevel = param2;
      }
      
      override public function initLayout() : void
      {
         var _loc5_:BuildingSpecificInfoType = null;
         var _loc1_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc2_:int = 0;
         var _loc7_:Number = NaN;
         super.initLayout();
         _buildingSilhouette = new MobileBuildingSilhouette(_buildingTypeDIO.id,_targetLevel);
         addChild(_buildingSilhouette);
         _upgradeAllWallsButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         var _temp_3:* = _upgradeAllWallsButton;
         var _loc10_:String = "ui.windows.upgrade.upgradeallnow";
         _temp_3.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         _upgradeAllWallsButton.width = 170;
         _upgradeAllWallsButton.visible = _buildingTypeDIO.id == 41;
         addChild(_upgradeAllWallsButton);
         _levelComparisonViews = new Vector.<MobileLevelEffectComparisonView>();
         var _temp_5:* = §§findproperty(MobileLevelEffectComparisonView);
         var _loc11_:String = "domain.buildingupgradeparameters.health";
         var _loc4_:MobileLevelEffectComparisonView = new MobileLevelEffectComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc11_),_buildingTypeDIO.healthPointsPerLevel[_targetLevel - 1],_buildingTypeDIO.healthPointsPerLevel[_targetLevel],_buildingTypeDIO.healthPointsPerLevel[_buildingTypeDIO.maxLevels - 1]);
         _levelComparisonViews.push(_loc4_);
         addChild(_loc4_);
         for(var _loc6_ in _buildingTypeDIO.buildingSpecificInfo)
         {
            _loc5_ = BuildingSpecificInfoType.determineBuildingSpecificInfoType(int(_loc6_));
            if(_loc5_ != null && _loc5_.preview && !(_buildingTypeDIO.id == 35 && _loc5_ == BuildingSpecificInfoType.EXPLOSION_RANGES_PER_LEVEL_IN_PX))
            {
               _loc1_ = Number(_buildingTypeDIO.buildingSpecificInfo[_loc6_][_targetLevel - 1]);
               _loc3_ = Number(_buildingTypeDIO.buildingSpecificInfo[_loc6_][_targetLevel]);
               _loc2_ = Math.min(_targetLevel + 2,_buildingTypeDIO.maxLevels - 1);
               _loc7_ = Number(_buildingTypeDIO.buildingSpecificInfo[_loc6_][_loc2_]);
               var _temp_10:* = §§findproperty(MobileLevelEffectComparisonView);
               var _loc12_:String = "domain.buildingupgradeparameters." + _loc5_.name;
               _loc4_ = new MobileLevelEffectComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc12_),_loc1_,_loc3_,_loc7_);
               _levelComparisonViews.push(_loc4_);
               addChild(_loc4_);
            }
         }
         drawLayout();
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "MobileBeigeBackground";
      }
      
      override public function drawLayout() : void
      {
         var _loc2_:int = 0;
         super.drawLayout();
         var _loc1_:int = int(_levelComparisonViews.length);
         if(_levelComparisonViews.length > 0)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_levelComparisonViews[0],bg,246,21 + (170 - ((_loc1_ - 1) * 45 + 32) >> 1));
         }
         _loc2_ = 1;
         while(_loc2_ < _levelComparisonViews.length)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_levelComparisonViews[_loc2_],_levelComparisonViews[_loc2_ - 1],0,45);
            _loc2_++;
         }
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_buildingSilhouette,bg,246 - _buildingSilhouette.width >> 1);
         MobileAlignmentUtil.alignAccordingToPositionOf(_upgradeAllWallsButton,bg,bg.width - _upgradeAllWallsButton.width - 20,bg.height - 21);
      }
      
      public function get upgradeAllWallsButton() : MPButton
      {
         return _upgradeAllWallsButton;
      }
   }
}

