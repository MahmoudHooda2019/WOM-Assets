package wom.view.screen.windows.upgrade
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileIconLabelView;
   import wom.view.ui.common.MobileResourceGroupView;
   import wom.view.ui.common.MobileResourceView;
   import wom.view.util.LocalizedDateTimeUtil;
   import wom.view.util.MobileBaseWindowPanel;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileUpgradeWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 870;
      
      private static const WINDOW_HEIGHT:int = 532;
      
      private static const WINDOW_HEIGHT_CITY_CENTER:int = 606;
      
      public static const TYPE_INFORMATIVE:int = 1;
      
      public static const TYPE_COMPARATIVE:int = 2;
      
      public static const TYPE_CITY_CENTER:int = 3;
      
      private var _type:int = 1;
      
      protected var infoPanel:MobileBaseWindowPanel;
      
      protected var _buildingInfo:BuildingInfo;
      
      protected var _buildingTypeDIO:BuildingTypeDIO;
      
      protected var costsBackground:DisplayObject;
      
      protected var durationBackground:DisplayObject;
      
      protected var nextLevelIcon:DisplayObject;
      
      protected var nextLevelTF:MPTextField;
      
      protected var costLabel:MPTextField;
      
      protected var _costView:MobileResourceGroupView;
      
      protected var durationView:MobileIconLabelView;
      
      protected var _upgradeWithResourcesButton:MPButton;
      
      protected var _upgradeWithGoldButton:MobileWomButton;
      
      protected var _targetLevel:int;
      
      protected var _serverSpeed:int;
      
      protected var _resourcesSatisfied:Boolean = false;
      
      private var _requirementsSatisfied:Boolean = true;
      
      public function MobileUpgradeWindow(param1:int, param2:BuildingInfo, param3:BuildingTypeDIO, param4:Vector.<WindowEnumeration> = null)
      {
         super(870,param1 == 3 ? 606 : 532,param4);
         _type = param1;
         _buildingInfo = param2;
         _buildingTypeDIO = param3;
      }
      
      protected function createInfoPanel(param1:int, param2:int) : MobileBaseWindowPanel
      {
         var _loc4_:MobileUpgradeBuildingWithRequirementPanel = null;
         var _loc3_:MobileUpgradeCityCenterPanel = null;
         switch(param1 - 1)
         {
            case 0:
            case 1:
               _loc4_ = new MobileUpgradeBuildingWithRequirementPanel(param1,_buildingInfo,_buildingTypeDIO,param2);
               addChild(_loc4_);
               _requirementsSatisfied = _loc4_.requirementsSatisfied;
               return _loc4_;
            default:
               _loc3_ = new MobileUpgradeCityCenterPanel(_buildingInfo,_buildingTypeDIO);
               addChild(_loc3_);
               return _loc3_;
         }
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _targetLevel = _buildingInfo.level >= _buildingTypeDIO.maxLevels - 1 ? _buildingTypeDIO.maxLevels - 1 : _buildingInfo.level;
         infoPanel = createInfoPanel(_type,_targetLevel);
         var _temp_3:* = "ui.windows.upgrade.header";
         var _loc2_:String = "domain.building." + _buildingInfo.buildingTypeId + ".name";
         var _loc3_:* = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         var _loc4_:String = _temp_3;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_));
         nextLevelIcon = assetRepository.getDisplayObject("IconUpgradeM");
         addChild(nextLevelIcon);
         nextLevelTF = new MobileCaptionTextField();
         nextLevelTF.textRendererProperties.textFormat = getCaptionTextFormat(38);
         addChild(nextLevelTF);
         nextLevelTF.text = (_targetLevel + 1).toString();
         costLabel = new MobileCaptionTextField();
         costLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         var _temp_8:* = costLabel;
         var _loc5_:String = "ui.windows.upgrade.cost";
         _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(costLabel);
         _costView = new MobileResourceGroupView(true);
         addChild(_costView);
         _costView.updateWithResources(_buildingTypeDIO.resourceCosts[_targetLevel]);
         var _loc1_:Number = _buildingTypeDIO.upgradeDurationsPerLevel[_targetLevel] / _serverSpeed;
         var _loc6_:String;
         durationView = new MobileIconLabelView("IconTimerM",_loc1_ ? LocalizedDateTimeUtil.getUserFriendlyTimeWithoutSeconds(_loc1_ * 1000) : (_loc6_ = "ui.common.instant",peak.i18n.PText.INSTANCE.getText0(_loc6_)));
         addChild(durationView);
         _upgradeWithResourcesButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _upgradeWithResourcesButton.width = 344;
         var _temp_12:* = _upgradeWithResourcesButton;
         var _loc7_:String = "ui.windows.upgrade.useresources";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(_upgradeWithResourcesButton);
         _upgradeWithGoldButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _upgradeWithGoldButton.width = 440;
         var _temp_14:* = _upgradeWithGoldButton;
         var _loc8_:String = "ui.windows.upgrade.upgradenow";
         _temp_14.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         _upgradeWithGoldButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _upgradeWithGoldButton.rightLabel = StoreUtil.buildingPriceWithRequirementsVector(_buildingTypeDIO.resourceCosts[_targetLevel],_loc1_) + "";
         _upgradeWithGoldButton.width = 440;
         addChild(_upgradeWithGoldButton);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         costsBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         costsBackground.width = 459;
         costsBackground.height = 115;
         addChild(costsBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(costsBackground,_background,141,height - costsBackground.height - 60);
         durationBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         durationBackground.width = 120;
         durationBackground.height = costsBackground.height;
         addChild(durationBackground);
         MobileAlignmentUtil.alignRightOf(durationBackground,costsBackground,8);
         _staticLayer.flatten();
      }
      
      public function drawLayout() : void
      {
         _windowHeader.x = _windowWidth - (_windowHeader.width + nextLevelIcon.width + 10) >> 1;
         MobileAlignmentUtil.alignRightOf(nextLevelIcon,_windowHeader,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(nextLevelTF,nextLevelIcon,(nextLevelIcon.width - nextLevelTF.width >> 1) - 2,12);
         MobileAlignmentUtil.alignAccordingToPositionOf(costLabel,costsBackground,20,-7);
         MobileAlignmentUtil.alignAccordingToPositionOf(_costView,costsBackground,(costsBackground.width - _costView.width) / 2,24);
         MobileAlignmentUtil.alignAccordingToPositionOf(durationView,durationBackground,durationBackground.width - durationView.componentWidth >> 1,24);
         _upgradeWithResourcesButton.x = 35;
         _upgradeWithResourcesButton.y = height - _upgradeWithResourcesButton.height / 2;
         MobileAlignmentUtil.alignRightOf(_upgradeWithGoldButton,_upgradeWithResourcesButton,15);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(infoPanel,_background,46);
      }
      
      public function updateWithResources(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc5_:ResourceAmountDTO = null;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = true;
         _loc6_ = 0;
         while(_loc6_ < _buildingTypeDIO.resourceCosts[_targetLevel].length)
         {
            _loc5_ = _buildingTypeDIO.resourceCosts[_targetLevel][_loc6_];
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
      
      public function get upgradeWithResourcesButton() : MPButton
      {
         return _upgradeWithResourcesButton;
      }
      
      public function get upgradeWithGoldButton() : MPButton
      {
         return _upgradeWithGoldButton;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get targetLevel() : int
      {
         return _targetLevel;
      }
      
      public function set serverSpeed(param1:int) : void
      {
         _serverSpeed = param1;
      }
      
      public function get resourcesSatisfied() : Boolean
      {
         return _resourcesSatisfied;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get requirementsSatisfied() : Boolean
      {
         return _requirementsSatisfied;
      }
   }
}

