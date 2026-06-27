package wom.view.screen.windows.upgrade
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   
   public class UpgradeCityCenterWindow extends UpgradeWindow
   {
      
      private static const WINDOW_WIDTH:int = 731;
      
      private static const WINDOW_HEIGHT:int = 481;
      
      private var unlockLabel:TextField;
      
      private var unlockTextField:TextField;
      
      private var buildMoreLabel:TextField;
      
      private var buildMoreTextField:TextField;
      
      private var upgradeMoreLabel:TextField;
      
      private var upgradeMoreTextField:TextField;
      
      public function UpgradeCityCenterWindow(param1:BuildingInfo, param2:BuildingTypeDIO)
      {
         super(param1,param2,731,481);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         unlockLabel = new CaptionTextField();
         unlockLabel.autoSize = "left";
         var _loc1_:TextFormat = unlockLabel.getTextFormat();
         _loc1_.align = "center";
         §§push(_loc1_);
         var _loc3_:int = 20;
         §§pop().size = peak.i18n.lang.Languages.isActiveLanguageEmdedded() ? _loc3_ : _loc3_ - 4;
         unlockLabel.defaultTextFormat = _loc1_;
         var _temp_2:* = unlockLabel;
         var _loc4_:String = "ui.windows.upgrade.youwwilunlock";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc4_) + " :";
         addChild(unlockLabel);
         unlockTextField = new WomTextField();
         unlockTextField.width = 490;
         unlockTextField.height = 40;
         unlockTextField.multiline = true;
         unlockTextField.wordWrap = true;
         var _loc2_:int = _buildingInfo.level + 1;
         var _temp_4:* = unlockTextField;
         var _loc5_:String = "domain.building." + _buildingTypeDIO.id + ".perlevel." + _loc2_ + ".youwillunlock";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(unlockTextField);
         buildMoreLabel = new CaptionTextField();
         buildMoreLabel.autoSize = "left";
         buildMoreLabel.defaultTextFormat = _loc1_;
         var _temp_6:* = buildMoreLabel;
         var _loc6_:String = "ui.windows.upgrade.youwillbeabletobuildmoe";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc6_) + " :";
         addChild(buildMoreLabel);
         buildMoreTextField = new WomTextField();
         buildMoreTextField.width = 490;
         buildMoreTextField.height = 53;
         buildMoreTextField.multiline = true;
         buildMoreTextField.wordWrap = true;
         var _temp_8:* = buildMoreTextField;
         var _loc7_:String = "domain.building." + _buildingTypeDIO.id + ".perlevel." + _loc2_ + ".youwillbeabletobuildmore";
         _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(buildMoreTextField);
         upgradeMoreLabel = new CaptionTextField();
         upgradeMoreLabel.autoSize = "left";
         upgradeMoreLabel.defaultTextFormat = _loc1_;
         var _temp_10:* = upgradeMoreLabel;
         var _loc8_:String = "ui.windows.upgrade.youwillbeabletoupgradeyour";
         _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc8_) + " :";
         addChild(upgradeMoreLabel);
         upgradeMoreTextField = new WomTextField();
         upgradeMoreTextField.width = 490;
         upgradeMoreTextField.height = 53;
         upgradeMoreTextField.multiline = true;
         upgradeMoreTextField.wordWrap = true;
         var _temp_12:* = upgradeMoreTextField;
         var _loc9_:String = "domain.building." + _buildingTypeDIO.id + ".perlevel." + _loc2_ + ".youwillbeabletoupgradeyour";
         _temp_12.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         addChild(upgradeMoreTextField);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         unlockLabel.x = 185;
         unlockLabel.y = 43;
         AlignmentUtil.alignBelowOf(unlockTextField,unlockLabel,8);
         AlignmentUtil.alignBelowOf(buildMoreLabel,unlockTextField,15);
         AlignmentUtil.alignBelowOf(buildMoreTextField,buildMoreLabel,8);
         AlignmentUtil.alignBelowOf(upgradeMoreLabel,buildMoreTextField,15);
         AlignmentUtil.alignBelowOf(upgradeMoreTextField,upgradeMoreLabel,8);
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         costsBackground.y = 337;
         AlignmentUtil.alignRightOf(durationBackground,costsBackground,10);
      }
   }
}

