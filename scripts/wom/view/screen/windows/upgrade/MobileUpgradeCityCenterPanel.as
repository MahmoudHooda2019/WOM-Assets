package wom.view.screen.windows.upgrade
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.build.MobileBuildingSilhouette;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileUpgradeCityCenterPanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 787;
      
      private static const HEIGHT:int = 370;
      
      public static const X_MARGIN_OF_LABELS:int = 246;
      
      protected var unlockLabel:MPTextField;
      
      protected var unlockTextField:MPTextField;
      
      protected var buildMoreLabel:MPTextField;
      
      protected var buildMoreTextField:MPTextField;
      
      protected var upgradeMoreLabel:MPTextField;
      
      protected var upgradeMoreTextField:MPTextField;
      
      protected var _buildingInfo:BuildingInfo;
      
      protected var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _buildingSilhouette:DisplayObject;
      
      public function MobileUpgradeCityCenterPanel(param1:BuildingInfo, param2:BuildingTypeDIO)
      {
         super(787,370);
         _buildingInfo = param1;
         _buildingTypeDIO = param2;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _buildingSilhouette = new MobileBuildingSilhouette(_buildingTypeDIO.id,_buildingInfo.level + 1);
         addChild(_buildingSilhouette);
         unlockLabel = new MobileCaptionTextField();
         unlockLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         var _temp_3:* = unlockLabel;
         var _loc2_:String = "ui.windows.upgrade.youwwilunlock";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc2_) + " :";
         addChild(unlockLabel);
         unlockTextField = new MobileWomTextField();
         unlockTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         unlockTextField.width = 490;
         unlockTextField.height = 53;
         unlockTextField.textRendererProperties.wordWrap = true;
         var _loc1_:int = _buildingInfo.level + 1;
         var _temp_5:* = unlockTextField;
         var _loc3_:String = "domain.building." + _buildingTypeDIO.id + ".perlevel." + _loc1_ + ".youwillunlock";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(unlockTextField);
         buildMoreLabel = new MobileCaptionTextField();
         buildMoreLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         var _temp_7:* = buildMoreLabel;
         var _loc4_:String = "ui.windows.upgrade.youwillbeabletobuildmoe";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc4_) + " :";
         addChild(buildMoreLabel);
         buildMoreTextField = new MobileWomTextField();
         buildMoreTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         buildMoreTextField.width = 490;
         buildMoreTextField.height = 53;
         buildMoreTextField.textRendererProperties.wordWrap = true;
         var _temp_9:* = buildMoreTextField;
         var _loc5_:String = "domain.building." + _buildingTypeDIO.id + ".perlevel." + _loc1_ + ".youwillbeabletobuildmore";
         _temp_9.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(buildMoreTextField);
         upgradeMoreLabel = new MobileCaptionTextField();
         upgradeMoreLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         var _temp_11:* = upgradeMoreLabel;
         var _loc6_:String = "ui.windows.upgrade.youwillbeabletoupgradeyour";
         _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc6_) + " :";
         addChild(upgradeMoreLabel);
         upgradeMoreTextField = new MobileWomTextField();
         upgradeMoreTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         upgradeMoreTextField.width = 490;
         upgradeMoreTextField.height = 53;
         upgradeMoreTextField.textRendererProperties.wordWrap = true;
         var _temp_13:* = upgradeMoreTextField;
         var _loc7_:String = "domain.building." + _buildingTypeDIO.id + ".perlevel." + _loc1_ + ".youwillbeabletoupgradeyour";
         _temp_13.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(upgradeMoreTextField);
         drawLayout();
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "MobileBeigeBackground";
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         unlockLabel.x = 246;
         unlockLabel.y = 29;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_buildingSilhouette,bg,246 - _buildingSilhouette.width >> 1);
         MobileAlignmentUtil.alignBelowOf(unlockTextField,unlockLabel,22);
         MobileAlignmentUtil.alignBelowOf(buildMoreLabel,unlockLabel,84);
         MobileAlignmentUtil.alignBelowOf(buildMoreTextField,buildMoreLabel,22);
         MobileAlignmentUtil.alignBelowOf(upgradeMoreLabel,buildMoreLabel,123);
         MobileAlignmentUtil.alignBelowOf(upgradeMoreTextField,upgradeMoreLabel,22);
      }
   }
}

