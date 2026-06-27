package wom.view.ui.mainframe.city
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.Environment;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.mainframe.MobileUILayer;
   
   public class MobileCityPlannerUILayer extends MobileUILayer
   {
      
      private var _closeButton:MPRigidButton;
      
      private var _constructableMenuContainer:Sprite;
      
      private var constructableMenuBg:DisplayObject;
      
      private var _constructableNameTF:MPTextField;
      
      private var _sellButton:MobileWomButton;
      
      private var bottomBg:DisplayObject;
      
      private var _archerButton:MobileWomButton;
      
      private var _cannonButton:MobileWomButton;
      
      private var _gatlingButton:MobileWomButton;
      
      private var _flamerButton:MobileWomButton;
      
      private var _skyButton:MobileWomButton;
      
      private var _mirrorButton:MobileWomButton;
      
      private var _watchPostButton:MobileWomButton;
      
      private var _beastButton:MobileWomButton;
      
      private var _beastCannonButton:MobileWomButton;
      
      private var _saveButton:MobileWomButton;
      
      private var _loadButton:MobileWomButton;
      
      private var _applyButton:MobileWomButton;
      
      private var _toggleGridsButton:MobileWomButton;
      
      private var _clearLayoutButton:MobileWomButton;
      
      public function MobileCityPlannerUILayer()
      {
         super();
         _visibleWidth = Environment.starling.stage.stageWidth;
         _visibleHeight = Environment.starling.stage.stageHeight;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _closeButton = new MPRigidButton("ButtonClose","ButtonCloseHover");
         addChild(_closeButton);
         _closeButton.validate();
         _toggleGridsButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Small");
         _toggleGridsButton.yMargin = -3;
         _toggleGridsButton.iconPosition = "top";
         _toggleGridsButton.defaultIcon = assetRepository.getDisplayObject("SymbolWhiteGrid");
         _toggleGridsButton.width = 48;
         addChild(_toggleGridsButton);
         _clearLayoutButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Small");
         _clearLayoutButton.yMargin = -3;
         _clearLayoutButton.iconPosition = "top";
         _clearLayoutButton.defaultIcon = assetRepository.getDisplayObject("SymbolWhiteClear");
         _clearLayoutButton.width = 48;
         addChild(_clearLayoutButton);
         _constructableMenuContainer = new Sprite();
         _constructableMenuContainer.visible = false;
         addChild(_constructableMenuContainer);
         constructableMenuBg = assetRepository.getDisplayObject("MobileBeigeBackground");
         constructableMenuBg.width = 406;
         constructableMenuBg.height = 100;
         _constructableMenuContainer.addChild(constructableMenuBg);
         _constructableNameTF = new MobileCaptionTextField();
         _constructableNameTF.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
         _constructableNameTF.width = 295;
         _constructableMenuContainer.addChild(_constructableNameTF);
         _sellButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Small");
         _sellButton.width = 92;
         var _temp_8:* = _sellButton;
         var _loc1_:String = "m.ui.mainframe.city.menupanel.sell";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _constructableMenuContainer.addChild(_sellButton);
         bottomBg = assetRepository.getDisplayObject("MapListBackground");
         bottomBg.width = _visibleWidth;
         addChild(bottomBg);
         _archerButton = createAndAddRangeToggleButton("ArchersTowerAvatar",getBuildingName(31));
         _cannonButton = createAndAddRangeToggleButton("BombardTowerAvatar",getBuildingName(32));
         _gatlingButton = createAndAddRangeToggleButton("FireArrowTowerAvatar",getBuildingName(34));
         _flamerButton = createAndAddRangeToggleButton("FlamerTowerAvatar",getBuildingName(33));
         _skyButton = createAndAddRangeToggleButton("SkyTowerAvatar",getBuildingName(35));
         _mirrorButton = createAndAddRangeToggleButton("BurningMirrorsAvatar",getBuildingName(36));
         _watchPostButton = createAndAddRangeToggleButton("WatchPostAvatar",getBuildingName(37));
         _beastButton = createAndAddRangeToggleButton("BeastCaveAvatar",getBuildingName(29));
         _beastCannonButton = createAndAddRangeToggleButton("BeastCannonTowerAvatar",getBuildingName(29));
         _saveButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _saveButton.width = 114;
         var _temp_20:* = _saveButton;
         var _loc2_:String = "ui.windows.cityplanner.save";
         _temp_20.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_saveButton);
         _loadButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _loadButton.width = 114;
         var _temp_22:* = _loadButton;
         var _loc3_:String = "ui.windows.cityplanner.load";
         _temp_22.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_loadButton);
         _applyButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _applyButton.width = 114;
         var _temp_24:* = _applyButton;
         var _loc4_:String = "ui.windows.cityplanner.apply";
         _temp_24.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(_applyButton);
      }
      
      private function getBuildingName(param1:int) : String
      {
         var _loc2_:String = "domain.building." + param1 + ".name";
         return peak.i18n.PText.INSTANCE.getText0(_loc2_);
      }
      
      private function createAndAddRangeToggleButton(param1:String, param2:String) : MobileWomButton
      {
         var _loc4_:MobileWomButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _loc4_.isToggle = true;
         _loc4_.width = 63;
         var _temp_3:* = _loc4_;
         var _temp_2:* = "ui.windows.cityplanner.ranges";
         var _loc5_:String = param2;
         var _loc6_:String = _temp_2;
         _temp_3.data = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
         var _loc3_:DisplayObject = assetRepository.getDisplayObject(param1);
         _loc3_.scaleX = _loc3_.scaleY = 0.5;
         _loc4_.defaultIcon = _loc3_;
         addChild(_loc4_);
         return _loc4_;
      }
      
      override protected function createAndAddLandlordPanel() : void
      {
      }
      
      override protected function createAndAddChatPanel() : void
      {
      }
      
      override public function drawLayout() : void
      {
         _closeButton.x = _visibleWidth - _closeButton.width - 14;
         _closeButton.y = 11;
         _toggleGridsButton.x = 13;
         _toggleGridsButton.y = 11;
         MobileAlignmentUtil.alignBelowOf(_clearLayoutButton,_toggleGridsButton,3);
         bottomBg.y = _visibleHeight - bottomBg.height;
         _constructableMenuContainer.x = _visibleWidth - constructableMenuBg.width >> 1;
         _constructableMenuContainer.y = _visibleHeight - 157;
         MobileAlignmentUtil.alignAccordingToPositionOf(_constructableNameTF,constructableMenuBg,0,25);
         MobileAlignmentUtil.alignAccordingToPositionOf(_sellButton,constructableMenuBg,295,15);
         _archerButton.x = 7;
         MobileAlignmentUtil.alignAccordingToPositionOf(_archerButton,bottomBg,18,11);
         MobileAlignmentUtil.alignRightOf(_cannonButton,_archerButton,3);
         MobileAlignmentUtil.alignRightOf(_gatlingButton,_cannonButton,3);
         MobileAlignmentUtil.alignRightOf(_flamerButton,_gatlingButton,3);
         MobileAlignmentUtil.alignRightOf(_skyButton,_flamerButton,3);
         MobileAlignmentUtil.alignRightOf(_mirrorButton,_skyButton,3);
         MobileAlignmentUtil.alignRightOf(_beastCannonButton,_mirrorButton,3);
         MobileAlignmentUtil.alignRightOf(_watchPostButton,_beastCannonButton,3);
         MobileAlignmentUtil.alignRightOf(_beastButton,_watchPostButton,3);
         MobileAlignmentUtil.alignAccordingToPositionOf(_saveButton,bottomBg,_visibleWidth - 378,11);
         MobileAlignmentUtil.alignRightOf(_loadButton,_saveButton,7);
         MobileAlignmentUtil.alignRightOf(_applyButton,_loadButton,7);
      }
      
      public function resetSelections() : void
      {
         _archerButton.isSelected = _cannonButton.isSelected = _gatlingButton.isSelected = _flamerButton.isSelected = _skyButton.isSelected = _mirrorButton.isSelected = _watchPostButton.isSelected = _beastButton.isSelected = _beastCannonButton.isSelected = false;
      }
      
      public function get closeButton() : MPRigidButton
      {
         return _closeButton;
      }
      
      public function get archerButton() : MobileWomButton
      {
         return _archerButton;
      }
      
      public function get beastCannonButton() : MobileWomButton
      {
         return _beastCannonButton;
      }
      
      public function get cannonButton() : MobileWomButton
      {
         return _cannonButton;
      }
      
      public function get gatlingButton() : MobileWomButton
      {
         return _gatlingButton;
      }
      
      public function get flamerButton() : MobileWomButton
      {
         return _flamerButton;
      }
      
      public function get skyButton() : MobileWomButton
      {
         return _skyButton;
      }
      
      public function get mirrorButton() : MobileWomButton
      {
         return _mirrorButton;
      }
      
      public function get watchPostButton() : MobileWomButton
      {
         return _watchPostButton;
      }
      
      public function get beastButton() : MobileWomButton
      {
         return _beastButton;
      }
      
      public function get saveButton() : MobileWomButton
      {
         return _saveButton;
      }
      
      public function get loadButton() : MobileWomButton
      {
         return _loadButton;
      }
      
      public function get applyButton() : MobileWomButton
      {
         return _applyButton;
      }
      
      public function get toggleGridsButton() : MobileWomButton
      {
         return _toggleGridsButton;
      }
      
      public function get clearLayoutButton() : MobileWomButton
      {
         return _clearLayoutButton;
      }
      
      public function get constructableNameTF() : MPTextField
      {
         return _constructableNameTF;
      }
      
      public function get sellButton() : MobileWomButton
      {
         return _sellButton;
      }
      
      public function get constructableMenuContainer() : Sprite
      {
         return _constructableMenuContainer;
      }
   }
}

