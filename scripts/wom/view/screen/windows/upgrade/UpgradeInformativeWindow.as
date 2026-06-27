package wom.view.screen.windows.upgrade
{
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   
   public class UpgradeInformativeWindow extends UpgradeBuildingWithRequirementWindow
   {
      
      private static const WINDOW_WIDTH:int = 731;
      
      private static const WINDOW_HEIGHT:int = 433;
      
      private var functionLabel:TextField;
      
      private var functionTextField:TextField;
      
      public function UpgradeInformativeWindow(param1:BuildingInfo, param2:BuildingTypeDIO)
      {
         super(param1,param2,731,433);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         functionLabel = new CaptionTextField();
         functionLabel.autoSize = "left";
         functionLabel.defaultTextFormat = requirementsLabel.defaultTextFormat;
         var _temp_2:* = functionLabel;
         var _loc1_:String = "ui.windows.upgrade.function";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_) + " :";
         addChild(functionLabel);
         functionTextField = new WomTextField();
         functionTextField.autoSize = "left";
         var _temp_4:* = functionTextField;
         var _loc2_:String = "domain.building." + _buildingTypeDIO.id + ".function";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(functionTextField);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         costsBackground.y = 288;
         AlignmentUtil.alignRightOf(durationBackground,costsBackground,10);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         AlignmentUtil.alignBelowOf(functionLabel,requirementBackground,35);
         AlignmentUtil.alignBelowOf(functionTextField,functionLabel,8);
      }
   }
}

