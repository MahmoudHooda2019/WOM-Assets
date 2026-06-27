package wom.view.screen.windows.upgrade
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.PrerequisiteDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileUpgradeBuildingWithRequirementPanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 787;
      
      private static const HEIGHT:int = 295;
      
      protected var requirementsLabel:MPTextField;
      
      protected var _requirementBackground:DisplayObject;
      
      protected var passedRequirementsTextField:MPTextField;
      
      protected var failedRequirementsTextField:MPTextField;
      
      protected var type:int;
      
      protected var _buildingInfo:BuildingInfo;
      
      protected var _buildingTypeDIO:BuildingTypeDIO;
      
      protected var detailsPanel:MobileBaseWindowPanel;
      
      protected var _requirementsSatisfied:Boolean = false;
      
      protected var _targetLevel:int;
      
      private var failedRequirementsWarningTextField:MobileCaptionTextField;
      
      public function MobileUpgradeBuildingWithRequirementPanel(param1:int, param2:BuildingInfo, param3:BuildingTypeDIO, param4:int)
      {
         super(787,295);
         this.type = param1;
         _buildingInfo = param2;
         _buildingTypeDIO = param3;
         _targetLevel = param4;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         requirementsLabel = new MobileCaptionTextField();
         requirementsLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         var _temp_2:* = requirementsLabel;
         var _loc1_:String = "ui.windows.upgrade.requirements";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_) + " :";
         addChild(requirementsLabel);
         passedRequirementsTextField = new MobileWomTextField();
         passedRequirementsTextField.textRendererProperties.textFormat = getWomTextFormat(21,"left",2849024);
         addChild(passedRequirementsTextField);
         failedRequirementsTextField = new MobileWomTextField();
         failedRequirementsTextField.textRendererProperties.textFormat = getWomTextFormat(21,"left",15682332);
         addChild(failedRequirementsTextField);
         failedRequirementsWarningTextField = new MobileCaptionTextField();
         failedRequirementsWarningTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(failedRequirementsWarningTextField);
         failedRequirementsWarningTextField.visible = false;
         detailsPanel = createDetailsPanel(type);
         addChild(detailsPanel);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         _requirementBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         _requirementBackground.width = 787;
         _requirementBackground.height = 69;
         addChild(_requirementBackground);
      }
      
      private function createDetailsPanel(param1:int) : MobileBaseWindowPanel
      {
         switch(param1 - 1)
         {
            case 0:
               return new MobileUpgradeInformativePanel(_buildingTypeDIO,_targetLevel);
            default:
               return new MobileUpgradeComperativePanel(_buildingTypeDIO,_targetLevel);
         }
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignAccordingToPositionOf(requirementsLabel,_requirementBackground,22,-9);
         MobileAlignmentUtil.alignAccordingToPositionOf(failedRequirementsTextField,_requirementBackground,27,22);
         MobileAlignmentUtil.alignRightOf(passedRequirementsTextField,failedRequirementsTextField,8);
         MobileAlignmentUtil.alignAccordingToPositionOf(detailsPanel,bg,0,82);
      }
      
      public function updatePrerequisitesData(param1:Vector.<BuildingInfo>) : void
      {
         var _loc8_:int = 0;
         var _loc7_:PrerequisiteDIO = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         passedRequirementsTextField.text = "";
         failedRequirementsTextField.text = "";
         var _loc4_:int = int(_buildingInfo.level >= _buildingTypeDIO.maxLevels - 1 ? _buildingTypeDIO.maxLevels - 1 : _buildingInfo.level);
         var _loc2_:Vector.<PrerequisiteDIO> = _buildingTypeDIO.buildingPrerequisitesPerLevel[_loc4_];
         _loc8_ = 0;
         while(_loc8_ < _loc2_.length)
         {
            _loc7_ = _loc2_[_loc8_];
            if(!(_loc7_.id == 10 && _loc7_.level <= 1))
            {
               §§push(_loc7_.count == 1 ? "" : _loc7_.count + "x ");
               var _loc11_:String = "domain.building." + _loc7_.id + ".name";
               var _temp_3:*;
               var _loc12_:String;
               _loc5_ = §§pop() + (peak.i18n.PText.INSTANCE.getText0(_loc11_) + (_loc7_.level == 1 ? "" : (_temp_3 = " ",_loc12_ = "ui.windows.upgrade.levelabbreviation",_temp_3 + peak.i18n.PText.INSTANCE.getText0(_loc12_) + _loc7_.level)));
               _loc6_ = _loc7_.count;
               for each(var _loc3_ in param1)
               {
                  if(_loc3_.buildingTypeId == _loc7_.id && _loc3_.level >= _loc7_.level)
                  {
                     _loc6_--;
                  }
               }
               if(_loc6_ > 0)
               {
                  if(failedRequirementsTextField.text.length > 0)
                  {
                     failedRequirementsTextField.text += ", ";
                  }
                  failedRequirementsTextField.text += _loc5_;
               }
               else
               {
                  if(passedRequirementsTextField.text.length > 0)
                  {
                     passedRequirementsTextField.text += ", ";
                  }
                  passedRequirementsTextField.text += _loc5_;
               }
            }
            _loc8_++;
         }
         failedRequirementsWarningTextField.text = failedRequirementsTextField.text;
         _requirementsSatisfied = failedRequirementsTextField.text == "";
         if(passedRequirementsTextField.text == "")
         {
            var _loc13_:String;
            passedRequirementsTextField.text = _requirementsSatisfied ? (_loc13_ = "ui.windows.upgrade.allrequirementsmet",peak.i18n.PText.INSTANCE.getText0(_loc13_)) : "";
         }
         drawLayout();
      }
      
      public function get requirementsSatisfied() : Boolean
      {
         return _requirementsSatisfied;
      }
      
      public function get requirementBackground() : DisplayObject
      {
         return _requirementBackground;
      }
   }
}

