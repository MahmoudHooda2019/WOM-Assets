package wom.view.screen.windows.build
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.MultipleInstancePrerequisitesDIO;
   import wom.model.domain.domaininfoobject.PrerequisiteDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.ui.common.MobileIconLabelView;
   import wom.view.ui.common.MobileResourceGroupView;
   import wom.view.ui.common.MobileResourceView;
   import wom.view.util.LocalizedDateTimeUtil;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileConstructBuildingWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 870;
      
      private static const WINDOW_HEIGHT:int = 540;
      
      private var _buildingTypeInfo:BuildingTypeInfo;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _buildingSilhouette:DisplayObject;
      
      private var requirementBackground:DisplayObject;
      
      private var costsBackground:DisplayObject;
      
      private var durationBackground:DisplayObject;
      
      private var requirementsLabel:MPTextField;
      
      private var descriptionTextField:MPTextField;
      
      private var passedRequirementsTextField:MPTextField;
      
      private var failedRequirementsTextField:MPTextField;
      
      private var costLabel:MPTextField;
      
      private var _costView:MobileResourceGroupView;
      
      private var durationView:MobileIconLabelView;
      
      private var _buildWithResourcesButton:MPButton;
      
      private var _buildWithGoldButton:MobileWomButton;
      
      private var _serverSpeed:int;
      
      private var _resourcesSatisfied:Boolean = false;
      
      private var _requirementsSatisfied:Boolean = false;
      
      private var descBackground:DisplayObject;
      
      public function MobileConstructBuildingWindow(param1:BuildingTypeInfo, param2:BuildingTypeDIO, param3:Vector.<WindowEnumeration> = null)
      {
         super(870,540,param3);
         _buildingTypeInfo = param1;
         _buildingTypeDIO = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _buildingSilhouette = new MobileBuildingSilhouette(_buildingTypeDIO.id);
         addChild(_buildingSilhouette);
         var _temp_2:* = "ui.windows.build.header";
         var _loc2_:String = "domain.building." + _buildingTypeDIO.id + ".name";
         var _loc3_:* = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         var _loc4_:String = _temp_2;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_));
         _buildWithResourcesButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         var _temp_5:* = _buildWithResourcesButton;
         var _loc5_:String = "ui.windows.build.useresources";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _buildWithResourcesButton.width = 344;
         addChild(_buildWithResourcesButton);
         _buildWithGoldButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         var _temp_7:* = _buildWithGoldButton;
         var _loc6_:String = "ui.windows.build.buildnow";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _buildWithGoldButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _buildWithGoldButton.rightLabel = StoreUtil.buildingPriceWithRequirementsVector(_buildingTypeDIO.resourceCosts[0],_buildingTypeDIO.upgradeDurationsPerLevel[0] / _serverSpeed) + "";
         _buildWithGoldButton.width = 440;
         addChild(_buildWithGoldButton);
         requirementsLabel = new MobileCaptionTextField();
         requirementsLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(requirementsLabel);
         var _temp_9:* = requirementsLabel;
         var _loc7_:String = "ui.windows.build.requirements";
         _temp_9.text = peak.i18n.PText.INSTANCE.getText0(_loc7_) + " :";
         passedRequirementsTextField = new MobileWomTextField();
         passedRequirementsTextField.textRendererProperties.textFormat = getWomTextFormat(21,"left",2849024);
         addChild(passedRequirementsTextField);
         failedRequirementsTextField = new MobileWomTextField();
         failedRequirementsTextField.textRendererProperties.textFormat = getWomTextFormat(21,"left",15682332);
         addChild(failedRequirementsTextField);
         descriptionTextField = new MobileWomTextField();
         descriptionTextField.width = 495;
         descriptionTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         descriptionTextField.textRendererProperties.wordWrap = true;
         addChild(descriptionTextField);
         var _temp_13:* = descriptionTextField;
         var _loc8_:String = "domain.building." + _buildingTypeDIO.id + ".desc";
         _temp_13.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         costLabel = new MobileCaptionTextField();
         costLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(costLabel);
         var _temp_15:* = costLabel;
         var _loc9_:String = "ui.windows.upgrade.cost";
         _temp_15.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         _costView = new MobileResourceGroupView(true);
         _costView = new MobileResourceGroupView(true);
         addChild(_costView);
         _costView.updateWithResources(_buildingTypeDIO.resourceCosts[0]);
         var _loc1_:Number = _buildingTypeDIO.upgradeDurationsPerLevel[0] / _serverSpeed;
         var _loc10_:String;
         durationView = new MobileIconLabelView("IconTimerM",_loc1_ ? LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc1_) : (_loc10_ = "ui.common.instant",peak.i18n.PText.INSTANCE.getText0(_loc10_)));
         addChild(durationView);
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
         descBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         descBackground.width = 781;
         descBackground.height = 213;
         addChild(descBackground);
         MobileAlignmentUtil.alignBelowOf(descBackground,requirementBackground,13);
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
         MobileAlignmentUtil.alignAccordingToPositionOf(costLabel,costsBackground,20,-7);
         MobileAlignmentUtil.alignAccordingToPositionOf(_costView,costsBackground,costsBackground.width - _costView.width >> 1,24);
         MobileAlignmentUtil.alignAccordingToPositionOf(durationView,durationBackground,durationBackground.width - durationView.componentWidth >> 1,24);
         MobileAlignmentUtil.alignAccordingToPositionOf(requirementsLabel,requirementBackground,21,-7);
         MobileAlignmentUtil.alignAccordingToPositionOf(failedRequirementsTextField,requirementBackground,27,22);
         MobileAlignmentUtil.alignRightOf(passedRequirementsTextField,failedRequirementsTextField);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(descriptionTextField,descBackground,240);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_buildingSilhouette,descBackground,240 - _buildingSilhouette.width >> 1);
         _buildWithResourcesButton.x = 35;
         _buildWithResourcesButton.y = height - _buildWithResourcesButton.height / 2;
         MobileAlignmentUtil.alignRightOf(_buildWithGoldButton,_buildWithResourcesButton,15);
      }
      
      public function updateWithResources(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc5_:ResourceAmountDTO = null;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = true;
         _loc6_ = 0;
         while(_loc6_ < _buildingTypeDIO.resourceCosts[0].length)
         {
            _loc5_ = _buildingTypeDIO.resourceCosts[0][_loc6_];
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
         drawLayout();
      }
      
      public function get buildWithResourcesButton() : MPButton
      {
         return _buildWithResourcesButton;
      }
      
      public function get buildingSilhouette() : DisplayObject
      {
         return _buildingSilhouette;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get buildWithGoldButton() : MPButton
      {
         return _buildWithGoldButton;
      }
      
      public function set serverSpeed(param1:int) : void
      {
         _serverSpeed = param1;
      }
      
      public function updatePrerequisitesData(param1:Vector.<BuildingInfo>) : void
      {
         var _loc6_:* = undefined;
         var _loc5_:* = undefined;
         var _loc9_:int = 0;
         var _loc8_:PrerequisiteDIO = null;
         var _loc4_:String = null;
         var _loc7_:int = 0;
         passedRequirementsTextField.text = "";
         failedRequirementsTextField.text = "";
         if(_buildingTypeDIO.buildingPrerequisitesPerInstance.length > 0)
         {
            _loc6_ = _buildingTypeDIO.buildingPrerequisitesPerInstance[_buildingTypeInfo.currentInstanceCount];
            _loc5_ = _buildingTypeDIO.buildingPrerequisitesPerLevel[0];
         }
         else
         {
            for each(var _loc2_ in _buildingTypeDIO.multipleInstancePrerequisites)
            {
               if(_loc2_.maxInstances > _buildingTypeInfo.currentInstanceCount)
               {
                  _loc6_ = _loc2_.prerequisites;
                  break;
               }
            }
         }
         _loc9_ = 0;
         while(_loc6_ && _loc9_ < _loc6_.length)
         {
            _loc8_ = _loc6_[_loc9_];
            if(!(_loc8_.id == 10 && _loc8_.level <= 1))
            {
               var _loc16_:String = "domain.building." + _loc8_.id + ".name";
               var _temp_4:*;
               var _loc17_:String;
               _loc4_ = peak.i18n.PText.INSTANCE.getText0(_loc16_) + (_loc8_.level == 1 ? "" : (_temp_4 = " ",_loc17_ = "ui.windows.upgrade.levelabbreviation",_temp_4 + peak.i18n.PText.INSTANCE.getText0(_loc17_) + _loc8_.level));
               _loc7_ = _loc8_.count;
               for each(var _loc3_ in param1)
               {
                  if(_loc3_.buildingTypeId == _loc8_.id && _loc3_.level >= _loc8_.level)
                  {
                     _loc7_--;
                  }
               }
               if(_loc7_ > 0)
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
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc5_ && _loc9_ < _loc5_.length)
         {
            _loc8_ = _loc5_[_loc9_];
            if(!(_loc8_.id == 10 && _loc8_.level <= 1))
            {
               §§push(_loc8_.count == 1 ? "" : _loc8_.count + "x ");
               var _loc18_:String = "domain.building." + _loc8_.id + ".name";
               _loc4_ = §§pop() + (peak.i18n.PText.INSTANCE.getText0(_loc18_) + (_loc8_.level == 1 ? "" : " L" + _loc8_.level));
               var _temp_9:* = passedRequirementsTextField.text;
               var _loc19_:String = "domain.building." + _loc8_.id + ".name";
               if(_temp_9.indexOf(peak.i18n.PText.INSTANCE.getText0(_loc19_)) == -1 && _temp_11.indexOf(peak.i18n.PText.INSTANCE.getText0(_loc20_)) == -1)
               {
                  _loc7_ = _loc8_.count;
                  for each(_loc3_ in param1)
                  {
                     if(_loc3_.buildingTypeId == _loc8_.id && _loc3_.level >= _loc8_.level)
                     {
                        _loc7_--;
                     }
                  }
                  if(_loc7_ > 0)
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
            }
            _loc9_++;
         }
         _requirementsSatisfied = failedRequirementsTextField.text == "";
         if(passedRequirementsTextField.text == "")
         {
            var _loc21_:String;
            passedRequirementsTextField.text = _requirementsSatisfied ? (_loc21_ = "ui.windows.upgrade.allrequirementsmet",peak.i18n.PText.INSTANCE.getText0(_loc21_)) : "";
         }
         drawLayout();
      }
      
      public function get resourcesSatisfied() : Boolean
      {
         return _resourcesSatisfied;
      }
      
      public function get buildingTypeInfo() : BuildingTypeInfo
      {
         return _buildingTypeInfo;
      }
      
      public function get requirementsSatisfied() : Boolean
      {
         return _requirementsSatisfied;
      }
   }
}

