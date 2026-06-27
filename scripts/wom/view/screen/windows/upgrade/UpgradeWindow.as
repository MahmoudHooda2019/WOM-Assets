package wom.view.screen.windows.upgrade
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.ui.common.IconLabelView;
   import wom.view.ui.common.OrView;
   import wom.view.ui.common.ResourceGroupView;
   import wom.view.ui.common.ResourceView;
   import wom.view.util.GenericWindow;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class UpgradeWindow extends GenericWindow
   {
      
      protected var _buildingInfo:BuildingInfo;
      
      protected var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _buildingSilhouette:DisplayObject;
      
      protected var costsBackground:DisplayObject;
      
      protected var durationBackground:DisplayObject;
      
      protected var nextLevelIcon:DisplayObject;
      
      private var nextLevelTF:TextField;
      
      private var costLabel:TextField;
      
      private var _costView:ResourceGroupView;
      
      private var durationView:IconLabelView;
      
      private var _upgradeWithResourcesButton:WomButton;
      
      private var orIcon:DisplayObject;
      
      private var _upgradeWithGoldButton:WomButton;
      
      protected var _targetLevel:int;
      
      protected var _serverSpeed:int;
      
      private var _resourcesSatisfied:Boolean = false;
      
      public function UpgradeWindow(param1:BuildingInfo, param2:BuildingTypeDIO, param3:int, param4:int, param5:Vector.<WindowEnumeration> = null)
      {
         super(param3,param4,param5);
         _buildingInfo = param1;
         _buildingTypeDIO = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _windowHeader.autoSize = "left";
         _targetLevel = _buildingInfo.level >= _buildingTypeDIO.maxLevels - 1 ? _buildingTypeDIO.maxLevels - 1 : _buildingInfo.level;
         _buildingSilhouette = assetRepository.getDisplayObject(_buildingTypeDIO.silhouetteVisuals[_targetLevel]);
         addChild(_buildingSilhouette);
         var _temp_3:* = "ui.windows.upgrade.header";
         var _loc3_:String = "domain.building." + _buildingInfo.buildingTypeId + ".name";
         var _loc4_:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         var _loc5_:String = _temp_3;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_));
         nextLevelIcon = assetRepository.getDisplayObject("Upgrade");
         addChild(nextLevelIcon);
         nextLevelTF = new CaptionTextField();
         var _loc2_:TextFormat = nextLevelTF.getTextFormat();
         _loc2_.align = "center";
         §§push(_loc2_);
         var _loc6_:int = 20;
         §§pop().size = peak.i18n.lang.Languages.isActiveLanguageEmdedded() ? _loc6_ : _loc6_ - 4;
         nextLevelTF.defaultTextFormat = _loc2_;
         nextLevelTF.width = 42;
         nextLevelTF.height = 25;
         nextLevelTF.text = (_targetLevel + 1).toString();
         addChild(nextLevelTF);
         costLabel = new CaptionTextField();
         costLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         var _temp_8:* = costLabel;
         var _loc7_:String = "ui.windows.upgrade.cost";
         _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(costLabel);
         _costView = new ResourceGroupView(true);
         addChild(_costView);
         _costView.updateWithResources(_buildingTypeDIO.resourceCosts[_targetLevel]);
         var _loc1_:Number = _buildingTypeDIO.upgradeDurationsPerLevel[_targetLevel] / _serverSpeed;
         var _loc8_:String;
         durationView = new IconLabelView("Clock45",_loc1_ ? LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc1_) : (_loc8_ = "ui.common.instant",peak.i18n.PText.INSTANCE.getText0(_loc8_)));
         addChild(durationView);
         _upgradeWithResourcesButton = new WomBlueLargeButton();
         var _temp_12:* = _upgradeWithResourcesButton;
         var _loc9_:String = "ui.windows.upgrade.useresources";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         _upgradeWithResourcesButton.width = 210;
         addChild(_upgradeWithResourcesButton);
         _upgradeWithGoldButton = new WomGreenLargeButton();
         var _temp_14:* = _upgradeWithGoldButton;
         var _loc10_:String = "ui.windows.upgrade.upgradenow";
         _temp_14.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         _upgradeWithGoldButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         _upgradeWithGoldButton.rightLabel = StoreUtil.buildingPriceWithRequirementsVector(_buildingTypeDIO.resourceCosts[_targetLevel],_loc1_) + "";
         _upgradeWithGoldButton.width = 300;
         addChild(_upgradeWithGoldButton);
         orIcon = new OrView();
         addChild(orIcon);
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         costsBackground = assetRepository.getDisplayObject("BackgroundLight");
         costsBackground.width = 500;
         costsBackground.height = 108;
         costsBackground.x = 66;
         costsBackground.y = 295;
         addChild(costsBackground);
         durationBackground = assetRepository.getDisplayObject("BackgroundLight");
         durationBackground.width = 102;
         durationBackground.height = costsBackground.height;
         AlignmentUtil.alignRightOf(durationBackground,costsBackground,10);
         addChild(durationBackground);
      }
      
      public function drawLayout() : void
      {
         _buildingSilhouette.x = 170 - _buildingSilhouette.width;
         _buildingSilhouette.y = 250 - _buildingSilhouette.height;
         _windowHeader.x = _windowWidth / 2 - (_windowHeader.width + nextLevelIcon.width + 10) / 2;
         AlignmentUtil.alignRightWithYMarginOf(nextLevelIcon,_windowHeader,-10,10);
         AlignmentUtil.alignAccordingToPositionOf(nextLevelTF,nextLevelIcon,0,22);
         AlignmentUtil.alignAccordingToPositionOf(costLabel,costsBackground,20,-10);
         AlignmentUtil.alignAccordingToPositionOf(_costView,costsBackground,(costsBackground.width - _costView.width) / 2 << 0,17);
         AlignmentUtil.alignAccordingToPositionOf(durationView,durationBackground,(durationBackground.width - durationView.componentWidth) / 2 << 0,17);
         _upgradeWithResourcesButton.x = 96;
         _upgradeWithResourcesButton.y = height - _upgradeWithResourcesButton.height / 2;
         AlignmentUtil.alignRightWithYMarginOf(orIcon,_upgradeWithResourcesButton,11,-11);
         AlignmentUtil.alignRightOf(_upgradeWithGoldButton,_upgradeWithResourcesButton,18);
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
      
      public function get upgradeWithResourcesButton() : Button
      {
         return _upgradeWithResourcesButton;
      }
      
      public function get upgradeWithGoldButton() : Button
      {
         return _upgradeWithGoldButton;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      public function get buildingSilhouette() : DisplayObject
      {
         return _buildingSilhouette;
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
   }
}

