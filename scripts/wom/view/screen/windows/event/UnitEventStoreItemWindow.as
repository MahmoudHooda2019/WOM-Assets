package wom.view.screen.windows.event
{
   import fl.controls.ProgressBar;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.event.EventItemType;
   import wom.model.game.event.EventStoreItemInfo;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class UnitEventStoreItemWindow extends BaseEventStoreItemWindow
   {
      
      private var favoriteTargetLabel:TextField;
      
      private var favoriteTargetsTextField:TextField;
      
      private var speedLabel:TextField;
      
      private var speedTextField:TextField;
      
      private var speedProgressBar:ProgressBar;
      
      private var healthLabel:TextField;
      
      private var healthTextField:TextField;
      
      private var healthProgressBar:ProgressBar;
      
      private var damageLabel:TextField;
      
      private var damageTextField:TextField;
      
      private var damageProgressBar:ProgressBar;
      
      private var teamSizeLabel:TextField;
      
      private var teamSizeTextField:TextField;
      
      private var teamSizeProgressBar:ProgressBar;
      
      private var rangeLabel:TextField;
      
      private var rangeTextField:TextField;
      
      private var rangeProgressBar:ProgressBar;
      
      public function UnitEventStoreItemWindow(param1:EventStoreItemInfo, param2:Vector.<WindowEnumeration> = null)
      {
         super(param1,param2);
      }
      
      override protected function initWindowLayout() : void
      {
         super.initWindowLayout();
         favoriteTargetLabel = new CaptionTextField();
         favoriteTargetLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         favoriteTargetLabel.autoSize = "left";
         var _temp_2:* = favoriteTargetLabel;
         var _loc1_:String = "ui.windows.trainingchamber.favoritetargets";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_) + " :";
         favoriteTargetLabel.visible = _storeItemInfo.eventItemType == EventItemType.BEAST || _storeItemInfo.eventItemType == EventItemType.MERCENARY && _storeItemInfo.instanceId != 34;
         addChild(favoriteTargetLabel);
         favoriteTargetsTextField = new WomTextField();
         favoriteTargetsTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         favoriteTargetsTextField.width = 220;
         favoriteTargetsTextField.autoSize = "left";
         favoriteTargetsTextField.visible = favoriteTargetLabel.visible;
         addChild(favoriteTargetsTextField);
         speedLabel = createLabel("speed");
         healthLabel = createLabel("health");
         damageLabel = createLabel("damage");
         teamSizeLabel = createLabel("teamsize");
         rangeLabel = createLabel("range");
         speedProgressBar = createProgressBar();
         healthProgressBar = createProgressBar();
         damageProgressBar = createProgressBar();
         teamSizeProgressBar = createProgressBar();
         rangeProgressBar = createProgressBar();
         speedTextField = createProgressBarTextField();
         healthTextField = createProgressBarTextField();
         damageTextField = createProgressBarTextField();
         teamSizeTextField = createProgressBarTextField();
         rangeTextField = createProgressBarTextField();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         AlignmentUtil.alignBelowOf(favoriteTargetLabel,itemNameTextField,-3);
         AlignmentUtil.alignRightWithYMarginOf(favoriteTargetsTextField,favoriteTargetLabel,2,2);
         AlignmentUtil.alignAccordingToPositionOf(speedLabel,itemDetailsBackground,0,135);
         AlignmentUtil.alignBelowOf(healthLabel,speedLabel,13);
         AlignmentUtil.alignBelowOf(damageLabel,healthLabel,13);
         AlignmentUtil.alignBelowOf(teamSizeLabel,damageLabel,13);
         AlignmentUtil.alignBelowOf(rangeLabel,teamSizeLabel,13);
         AlignmentUtil.alignRightWithYMarginOf(speedProgressBar,speedLabel,-4,10);
         AlignmentUtil.alignRightWithYMarginOf(healthProgressBar,healthLabel,-4,10);
         AlignmentUtil.alignRightWithYMarginOf(damageProgressBar,damageLabel,-4,10);
         AlignmentUtil.alignRightWithYMarginOf(teamSizeProgressBar,teamSizeLabel,-4,10);
         AlignmentUtil.alignRightWithYMarginOf(rangeProgressBar,rangeLabel,-4,10);
         AlignmentUtil.alignRightOf(speedTextField,speedLabel,17);
         AlignmentUtil.alignRightOf(healthTextField,healthLabel,17);
         AlignmentUtil.alignRightOf(damageTextField,damageLabel,17);
         AlignmentUtil.alignRightOf(teamSizeTextField,teamSizeLabel,17);
         AlignmentUtil.alignRightOf(rangeTextField,rangeLabel,17);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_unlockButton,_background,_windowHeight - (_unlockButton.height >> 1));
      }
      
      public function updateWithUnitInfo(param1:UnitTypeDIO, param2:UnitTypeInfo, param3:EventItemDIO) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = int(param2 ? param2.currentLevel : 0);
         favoriteTargetsTextField.text = "";
         if(param1.healer)
         {
            var _temp_1:* = favoriteTargetsTextField;
            var _loc6_:String = "ui.windows.trainingchamber.healer";
            _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         }
         else if(param1.targetsAnything)
         {
            var _temp_2:* = favoriteTargetsTextField;
            var _loc7_:String = "ui.windows.trainingchamber.anything";
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < param1.favouriteTargets.length)
            {
               if(favoriteTargetsTextField.text != "")
               {
                  favoriteTargetsTextField.appendText(", ");
               }
               var _temp_3:* = favoriteTargetsTextField;
               var _loc8_:String = "domain.buildingkinds." + param1.favouriteTargets[_loc5_] + ".name";
               _temp_3.appendText(peak.i18n.PText.INSTANCE.getText0(_loc8_));
               _loc5_++;
            }
         }
         speedProgressBar.setProgress(100,100);
         healthProgressBar.setProgress(100,100);
         damageProgressBar.setProgress(100,100);
         teamSizeProgressBar.setProgress(100,100);
         rangeProgressBar.setProgress(100,100);
         var _temp_5:* = speedTextField;
         var _temp_4:* = param1.speed(_loc4_) + " ";
         var _loc9_:String = "ui.windows.trainingchamber.kph";
         _temp_5.text = _temp_4 + peak.i18n.PText.INSTANCE.getText0(_loc9_);
         healthTextField.text = param1.healthPointsPerLevel[_loc4_] + "";
         damageTextField.text = param1.damage(_loc4_) + "";
         teamSizeTextField.text = param1.teamSize + "";
         rangeTextField.text = param1.range(_loc4_) * (param3 && param3.warBuilding ? 5 : 1) + "";
         drawLayout();
      }
   }
}

