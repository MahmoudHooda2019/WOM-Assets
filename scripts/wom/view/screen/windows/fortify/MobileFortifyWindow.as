package wom.view.screen.windows.fortify
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.FortificationInfoDIO;
   import wom.model.domain.domaininfoobject.PrerequisiteDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.upgrade.MobileLevelEffectComparisonView;
   import wom.view.ui.common.MobileIconLabelView;
   import wom.view.ui.common.MobileResourceGroupView;
   import wom.view.ui.common.MobileResourceView;
   import wom.view.util.LocalizedDateTimeUtil;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileFortifyWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 870;
      
      private static const WINDOW_HEIGHT:int = 540;
      
      private var _buildingInfo:BuildingInfo;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _fortificationInfoDIO:FortificationInfoDIO;
      
      private var _fortificationSilhouetteBack:DisplayObject;
      
      private var requirementBackground:DisplayObject;
      
      private var levelComparisonBackground:DisplayObject;
      
      private var costsBackground:DisplayObject;
      
      private var durationBackground:DisplayObject;
      
      private var nextLevelIcon:DisplayObject;
      
      private var nextLevelTF:MPTextField;
      
      private var requirementsLabel:MPTextField;
      
      private var passedRequirementsTextField:MPTextField;
      
      private var failedRequirementsTextField:MPTextField;
      
      private var damageProtectionLevelComparisonView:MobileLevelEffectComparisonView;
      
      private var costLabel:MPTextField;
      
      private var _costView:MobileResourceGroupView;
      
      private var duration:MobileIconLabelView;
      
      private var _upgradeWithResourcesButton:MPButton;
      
      private var _upgradeWithGoldButton:MobileWomButton;
      
      private var _targetLevelIndex:int;
      
      private var _serverSpeed:int;
      
      private var _requirementsSatisfied:Boolean = false;
      
      private var _resourcesSatisfied:Boolean = false;
      
      private var _fortificationSilhouetteFront:DisplayObject;
      
      public function MobileFortifyWindow(param1:BuildingInfo, param2:BuildingTypeDIO, param3:Vector.<WindowEnumeration> = null)
      {
         super(870,540,param3);
         _buildingInfo = param1;
         _buildingTypeDIO = param2;
         _fortificationInfoDIO = _buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.FORTIFICATION_INFO.id] as FortificationInfoDIO;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:int = _buildingInfo.fortificationLevel + 1;
         _targetLevelIndex = _loc1_ - 1;
         var _loc3_:int = _fortificationInfoDIO.maxLevels - 1;
         var _loc2_:int = _targetLevelIndex - 1;
         _fortificationSilhouetteBack = assetRepository.getDisplayObject("FortificationMediumS" + _loc1_ + "Back");
         addChild(_fortificationSilhouetteBack);
         _fortificationSilhouetteFront = assetRepository.getDisplayObject("FortificationMediumS" + _loc1_ + "Front");
         addChild(_fortificationSilhouetteFront);
         var _temp_4:* = "ui.windows.fortify.header";
         var _loc4_:String = "domain.building." + _buildingInfo.buildingTypeId + ".name";
         var _loc5_:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc6_:String = _temp_4;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_));
         nextLevelIcon = assetRepository.getDisplayObject("IconFortifyMBordered");
         addChild(nextLevelIcon);
         nextLevelTF = new MobileCaptionTextField();
         nextLevelTF.textRendererProperties.textFormat = getCaptionTextFormat(38);
         addChild(nextLevelTF);
         nextLevelTF.text = (_targetLevelIndex + 1).toString();
         requirementsLabel = new MobileCaptionTextField();
         requirementsLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(requirementsLabel);
         var _temp_9:* = requirementsLabel;
         var _loc7_:String = "ui.windows.fortify.requirements";
         _temp_9.text = peak.i18n.PText.INSTANCE.getText0(_loc7_) + " :";
         passedRequirementsTextField = new MobileWomTextField();
         passedRequirementsTextField.textRendererProperties.textFormat = getWomTextFormat(21,"left",2849024);
         addChild(passedRequirementsTextField);
         failedRequirementsTextField = new MobileWomTextField();
         failedRequirementsTextField.textRendererProperties.textFormat = getWomTextFormat(21,"left",15682332);
         addChild(failedRequirementsTextField);
         §§push(§§findproperty(MobileLevelEffectComparisonView));
         var _loc8_:String = "ui.windows.fortify.damageprotection";
         damageProtectionLevelComparisonView = new §§pop().MobileLevelEffectComparisonView(peak.i18n.PText.INSTANCE.getText0(_loc8_),_loc2_ != -1 ? _fortificationInfoDIO.protectionBonusesPerLevelAsPercent[_loc2_] : 0,_fortificationInfoDIO.protectionBonusesPerLevelAsPercent[_targetLevelIndex],_fortificationInfoDIO.protectionBonusesPerLevelAsPercent[_loc3_],"ui.common.percentage",153,350);
         addChild(damageProtectionLevelComparisonView);
         costLabel = new MobileCaptionTextField();
         costLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(costLabel);
         var _temp_14:* = costLabel;
         var _loc9_:String = "ui.windows.fortify.cost";
         _temp_14.text = peak.i18n.PText.INSTANCE.getText0(_loc9_) + ":";
         _costView = new MobileResourceGroupView(true);
         addChild(_costView);
         _costView.updateWithResources(_fortificationInfoDIO.resourceCosts[_targetLevelIndex]);
         duration = new MobileIconLabelView("IconTimerM",LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_fortificationInfoDIO.fortifyDurationsPerLevelInSecs[_targetLevelIndex] / _serverSpeed));
         addChild(duration);
         _upgradeWithResourcesButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _upgradeWithResourcesButton.width = 344;
         var _temp_18:* = _upgradeWithResourcesButton;
         var _loc10_:String = "ui.windows.fortify.useresources";
         _temp_18.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         addChild(_upgradeWithResourcesButton);
         _upgradeWithGoldButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _upgradeWithGoldButton.width = 440;
         var _temp_20:* = _upgradeWithGoldButton;
         var _loc11_:String = "ui.windows.fortify.upgradewithgold";
         _temp_20.label = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         _upgradeWithGoldButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _upgradeWithGoldButton.rightLabel = StoreUtil.buildingPriceWithRequirementsVector(_fortificationInfoDIO.resourceCosts[_targetLevelIndex],_fortificationInfoDIO.fortifyDurationsPerLevelInSecs[_targetLevelIndex] / _serverSpeed) + "";
         addChild(_upgradeWithGoldButton);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         requirementBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         requirementBackground.width = 781;
         requirementBackground.height = 69;
         addChild(requirementBackground);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(requirementBackground,_background,42);
         levelComparisonBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         levelComparisonBackground.width = 781;
         levelComparisonBackground.height = 213;
         addChild(levelComparisonBackground);
         MobileAlignmentUtil.alignBelowOf(levelComparisonBackground,requirementBackground,13);
         costsBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         costsBackground.width = 459;
         costsBackground.height = 115;
         addChild(costsBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(costsBackground,_background,141,355);
         durationBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         durationBackground.width = 120;
         durationBackground.height = costsBackground.height;
         addChild(durationBackground);
         MobileAlignmentUtil.alignRightOf(durationBackground,costsBackground,8);
         _staticLayer.flatten();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_fortificationSilhouetteBack,levelComparisonBackground,240 - _fortificationSilhouetteBack.width >> 1,levelComparisonBackground.height - 140 >> 1);
         alignFortificationSilhoutteFront(_buildingInfo.fortificationLevel + 1);
         _windowHeader.x = _windowWidth - (_windowHeader.width + nextLevelIcon.width + 10) >> 1;
         MobileAlignmentUtil.alignRightOf(nextLevelIcon,_windowHeader,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(nextLevelTF,nextLevelIcon,(nextLevelIcon.width - nextLevelTF.width >> 1) - 2,12);
         MobileAlignmentUtil.alignAccordingToPositionOf(costLabel,costsBackground,20,-7);
         MobileAlignmentUtil.alignAccordingToPositionOf(_costView,costsBackground,costsBackground.width - _costView.width >> 1,24);
         MobileAlignmentUtil.alignAccordingToPositionOf(duration,durationBackground,durationBackground.width - duration.componentWidth >> 1,24);
         MobileAlignmentUtil.alignAccordingToPositionOf(requirementsLabel,requirementBackground,21,-7);
         MobileAlignmentUtil.alignAccordingToPositionOf(failedRequirementsTextField,requirementBackground,27,22);
         MobileAlignmentUtil.alignRightOf(passedRequirementsTextField,failedRequirementsTextField);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(damageProtectionLevelComparisonView,levelComparisonBackground,240);
         _upgradeWithResourcesButton.x = 35;
         _upgradeWithResourcesButton.y = height - _upgradeWithResourcesButton.height / 2;
         MobileAlignmentUtil.alignRightOf(_upgradeWithGoldButton,_upgradeWithResourcesButton,15);
      }
      
      private function alignFortificationSilhoutteFront(param1:int) : void
      {
         if(param1 == 1)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_fortificationSilhouetteFront,_fortificationSilhouetteBack,-15,_fortificationSilhouetteBack.height - 23);
         }
         else
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_fortificationSilhouetteFront,_fortificationSilhouetteBack,0,_fortificationSilhouetteBack.height - 40);
         }
      }
      
      public function get upgradeWithResourcesButton() : MPButton
      {
         return _upgradeWithResourcesButton;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      public function get fortificationInfoDIO() : FortificationInfoDIO
      {
         return _fortificationInfoDIO;
      }
      
      public function get upgradeWithGoldButton() : MPButton
      {
         return _upgradeWithGoldButton;
      }
      
      public function updateWithResources(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc5_:ResourceAmountDTO = null;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = true;
         _loc6_ = 0;
         while(_loc6_ < _fortificationInfoDIO.resourceCosts[_targetLevelIndex].length)
         {
            _loc5_ = _fortificationInfoDIO.resourceCosts[_targetLevelIndex][_loc6_];
            _loc4_ = param1[_loc5_.resourceType] >= _loc5_.resourceAmount;
            if(_loc3_)
            {
               _loc3_ = _loc4_;
            }
            for each(var _loc2_ in _costView.resourceViews)
            {
               if(_loc2_.resourceId == _loc5_.resourceType)
               {
                  _loc2_.updateTextFormat(!_loc4_);
               }
            }
            _loc6_++;
         }
         _resourcesSatisfied = _loc3_;
      }
      
      public function get targetLevelIndex() : int
      {
         return _targetLevelIndex;
      }
      
      public function set serverSpeed(param1:int) : void
      {
         _serverSpeed = param1;
      }
      
      public function updatePrerequisitesData(param1:Vector.<BuildingInfo>) : void
      {
         var _loc7_:int = 0;
         var _loc6_:PrerequisiteDIO = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         passedRequirementsTextField.text = "";
         failedRequirementsTextField.text = "";
         if(_fortificationInfoDIO.maxLevels <= _buildingInfo.fortificationLevel)
         {
            return;
         }
         var _loc2_:Vector.<PrerequisiteDIO> = _fortificationInfoDIO.buildingPrerequisitesPerLevel[_buildingInfo.fortificationLevel];
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
                     failedRequirementsTextField.text += ", ";
                  }
                  failedRequirementsTextField.text += _loc4_;
               }
               else
               {
                  if(passedRequirementsTextField.text.length > 0)
                  {
                     passedRequirementsTextField.text += ", ";
                  }
                  passedRequirementsTextField.text += _loc4_;
               }
            }
            _loc7_++;
         }
         _requirementsSatisfied = failedRequirementsTextField.text == "";
         if(passedRequirementsTextField.text == "")
         {
            var _loc12_:String;
            passedRequirementsTextField.text = _requirementsSatisfied ? (_loc12_ = "ui.windows.upgrade.allrequirementsmet",peak.i18n.PText.INSTANCE.getText0(_loc12_)) : "";
         }
         drawLayout();
      }
      
      public function get resourcesSatisfied() : Boolean
      {
         return _resourcesSatisfied;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get requirementsSatisfied() : Boolean
      {
         return _requirementsSatisfied;
      }
   }
}

