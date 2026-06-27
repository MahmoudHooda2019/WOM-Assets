package wom.view.screen.windows.upgrade
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.PrerequisiteDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   
   public class UpgradeBuildingWithRequirementWindow extends UpgradeWindow
   {
      
      protected var requirementsLabel:TextField;
      
      protected var requirementBackground:DisplayObject;
      
      private var passedRequirementsTextField:TextField;
      
      private var failedRequirementsTextField:TextField;
      
      private var line:Sprite;
      
      private var checkIcon:DisplayObject;
      
      private var crossIcon:DisplayObject;
      
      protected var _requirementsSatisfied:Boolean = false;
      
      public function UpgradeBuildingWithRequirementWindow(param1:BuildingInfo, param2:BuildingTypeDIO, param3:int, param4:int)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         requirementsLabel = new CaptionTextField();
         requirementsLabel.autoSize = "left";
         var _loc1_:TextFormat = requirementsLabel.getTextFormat();
         _loc1_.align = "center";
         §§push(_loc1_);
         var _loc2_:int = 18;
         §§pop().size = peak.i18n.lang.Languages.isActiveLanguageEmdedded() ? _loc2_ : _loc2_ - 4;
         requirementsLabel.defaultTextFormat = _loc1_;
         var _temp_2:* = requirementsLabel;
         var _loc3_:String = "ui.windows.upgrade.requirements";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc3_) + " :";
         addChild(requirementsLabel);
         passedRequirementsTextField = new WomTextField();
         passedRequirementsTextField.width = 410;
         passedRequirementsTextField.height = 20;
         passedRequirementsTextField.multiline = true;
         passedRequirementsTextField.wordWrap = true;
         addChild(passedRequirementsTextField);
         failedRequirementsTextField = new WomTextField();
         failedRequirementsTextField.width = 410;
         failedRequirementsTextField.height = 20;
         failedRequirementsTextField.multiline = true;
         failedRequirementsTextField.wordWrap = true;
         addChild(failedRequirementsTextField);
         line = new Sprite();
         line.graphics.lineStyle(1,0,0.4);
         line.graphics.moveTo(0,0);
         line.graphics.lineTo(482,0);
         line.graphics.lineStyle(1,16777215,0.4);
         line.graphics.moveTo(0,1);
         line.graphics.lineTo(482,1);
         addChild(line);
         checkIcon = assetRepository.getDisplayObject("Check");
         checkIcon.scaleX = checkIcon.scaleY = 0.5;
         addChild(checkIcon);
         crossIcon = assetRepository.getDisplayObject("Cross");
         addChild(crossIcon);
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         requirementBackground = assetRepository.getDisplayObject("BackgroundLight");
         requirementBackground.width = 500;
         requirementBackground.height = 100;
         requirementBackground.x = 178;
         requirementBackground.y = 60;
         addChild(requirementBackground);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         upgradeWithResourcesButton.enabled = _requirementsSatisfied;
         upgradeWithGoldButton.enabled = _requirementsSatisfied;
         AlignmentUtil.alignAccordingToPositionOf(requirementsLabel,requirementBackground,15,-requirementsLabel.height / 2);
         AlignmentUtil.alignAccordingToPositionOf(checkIcon,requirementBackground,20,14);
         if(passedRequirementsTextField.visible)
         {
            AlignmentUtil.alignBelowOf(crossIcon,checkIcon,28);
         }
         else
         {
            AlignmentUtil.alignAccordingToPositionOf(crossIcon,checkIcon,0,0);
         }
         AlignmentUtil.alignMiddleOf(line,requirementBackground);
         AlignmentUtil.alignRightOf(passedRequirementsTextField,checkIcon);
         AlignmentUtil.alignMiddleYAxisOf(passedRequirementsTextField,checkIcon);
         AlignmentUtil.alignRightOf(failedRequirementsTextField,crossIcon);
         AlignmentUtil.alignMiddleYAxisOf(failedRequirementsTextField,crossIcon);
      }
      
      public function updatePrerequisitesData(param1:Vector.<BuildingInfo>) : void
      {
         var _loc7_:int = 0;
         var _loc6_:PrerequisiteDIO = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         passedRequirementsTextField.text = "";
         failedRequirementsTextField.text = "";
         var _loc2_:Vector.<PrerequisiteDIO> = _buildingTypeDIO.buildingPrerequisitesPerLevel[_targetLevel];
         _loc7_ = 0;
         while(_loc7_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc7_];
            if(!(_loc6_.id == 10 && _loc6_.level <= 1))
            {
               §§push(_loc6_.count == 1 ? "" : _loc6_.count + "x ");
               var _loc10_:String = "domain.building." + _loc6_.id + ".name";
               var _temp_3:*;
               var _loc11_:String;
               _loc4_ = §§pop() + (peak.i18n.PText.INSTANCE.getText0(_loc10_) + (_loc6_.level == 1 ? "" : (_temp_3 = " ",_loc11_ = "ui.windows.upgrade.levelabbreviation",_temp_3 + peak.i18n.PText.INSTANCE.getText0(_loc11_) + _loc6_.level)));
               _loc5_ = _loc6_.count;
               for each(var _loc3_ in param1)
               {
                  if(_loc3_.buildingTypeId == _loc6_.id && _loc3_.level >= _loc6_.level)
                  {
                     _loc5_--;
                  }
               }
               if(_loc5_ > 0)
               {
                  if(failedRequirementsTextField.text.length > 0)
                  {
                     failedRequirementsTextField.appendText(", ");
                  }
                  failedRequirementsTextField.appendText(_loc4_);
               }
               else
               {
                  if(passedRequirementsTextField.text.length > 0)
                  {
                     passedRequirementsTextField.appendText(", ");
                  }
                  passedRequirementsTextField.appendText(_loc4_);
               }
            }
            _loc7_++;
         }
         _requirementsSatisfied = failedRequirementsTextField.text == "";
         if(passedRequirementsTextField.text == "")
         {
            passedRequirementsTextField.visible = checkIcon.visible = line.visible = _requirementsSatisfied;
            var _loc12_:String;
            passedRequirementsTextField.text = _requirementsSatisfied ? (_loc12_ = "ui.windows.upgrade.allrequirementsmet",peak.i18n.PText.INSTANCE.getText0(_loc12_)) : "";
            requirementBackground.height = 52;
         }
         if(failedRequirementsTextField.text == "")
         {
            failedRequirementsTextField.visible = crossIcon.visible = line.visible = false;
            requirementBackground.height = 52;
         }
         if(passedRequirementsTextField.text != "" && failedRequirementsTextField.text != "")
         {
            passedRequirementsTextField.visible = failedRequirementsTextField.visible = checkIcon.visible = crossIcon.visible = line.visible = true;
            requirementBackground.height = 100;
         }
         drawLayout();
      }
   }
}

