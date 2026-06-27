package wom.view.screen.windows.cityplanner
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.component.WomPlannerRootV2;
   import wom.model.game.helper.RowColumnPair;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.CityPlannerRangeToggleButton;
   import wom.view.component.button.colored.WomBlueMiniButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomBrownSmallButton;
   import wom.view.component.button.colored.WomOrangeSmallButton;
   import wom.view.util.GenericWindow;
   
   public class CityPlannerWindow extends GenericWindow
   {
      
      public static const WINDOW_WIDTH:int = 760;
      
      public static const WINDOW_HEIGHT:int = 555;
      
      [Inject]
      public var plannerRoot:WomPlannerRootV2;
      
      private var _darkBackground:DisplayObject;
      
      private var _nameLightBackground:DisplayObject;
      
      private var _nameDarkBackground:DisplayObject;
      
      private var _menuContainer:Sprite;
      
      private var _zoomLevel:int = 0;
      
      private var _isFullScreen:Boolean;
      
      private var _archerButton:Button;
      
      private var _cannonButton:Button;
      
      private var _gatlingButton:Button;
      
      private var _flamerButton:Button;
      
      private var _skyButton:Button;
      
      private var _mirrorButton:Button;
      
      private var _watchPostButton:Button;
      
      private var _beastButton:Button;
      
      private var _beastCannonButton:Button;
      
      private var _saveButton:Button;
      
      private var _loadButton:Button;
      
      private var _applyButton:Button;
      
      private var _expandButton:Button;
      
      private var hintTextField:TextField;
      
      private var _zoomInButton:Button;
      
      private var _zoomOutButton:Button;
      
      private var _fullScreenButton:Button;
      
      private var _toggleGridsButton:Button;
      
      private var _clearLayoutButton:Button;
      
      private var _zoomBar:DisplayObject;
      
      private var _zoomBarCursor:DisplayObject;
      
      private var _nameLabel:WomTextField;
      
      public var keepRootState:Boolean;
      
      public function CityPlannerWindow(param1:Boolean)
      {
         this._isFullScreen = param1;
         super(760,555);
         keepRootState = false;
      }
      
      override protected function initLayout() : void
      {
         _windowWidth = getWindowWidth();
         _windowHeight = getWindowHeight();
         super.initLayout();
         var _loc1_:String = "ui.windows.cityplanner.cityplanner";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _darkBackground = assetRepository.getDisplayObject("BackgroundLight");
         _darkBackground.width = getCanvasWidth();
         _darkBackground.height = getCanvasHeight();
         addChild(_darkBackground);
         _menuContainer = new Sprite();
         addChild(_menuContainer);
         _archerButton = createAndAddRangeToggleButton("ArchersTowerAvatar",getBuildingName(31));
         _cannonButton = createAndAddRangeToggleButton("BombardTowerAvatar",getBuildingName(32));
         _gatlingButton = createAndAddRangeToggleButton("GatlingArrowTowerAvatar",getBuildingName(34));
         _flamerButton = createAndAddRangeToggleButton("FlamerTowerAvatar",getBuildingName(33));
         _skyButton = createAndAddRangeToggleButton("SkyTowerAvatar",getBuildingName(35));
         _mirrorButton = createAndAddRangeToggleButton("BurningMirrorsAvatar",getBuildingName(36));
         _watchPostButton = createAndAddRangeToggleButton("WatchPostAvatar",getBuildingName(37));
         _beastButton = createAndAddRangeToggleButton("BeastCaveAvatar",getBuildingName(29));
         _beastCannonButton = createAndAddRangeToggleButton("BeastCannonTowerAvatar",getBuildingName(45));
         _saveButton = new WomBrownSmallButton();
         _saveButton.width = 68;
         var _temp_16:* = _saveButton;
         var _loc2_:String = "ui.windows.cityplanner.save";
         _temp_16.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _menuContainer.addChild(_saveButton);
         _loadButton = new WomBrownSmallButton();
         _loadButton.width = 68;
         var _temp_18:* = _loadButton;
         var _loc3_:String = "ui.windows.cityplanner.load";
         _temp_18.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _menuContainer.addChild(_loadButton);
         _applyButton = new WomBrownSmallButton();
         _applyButton.width = 79;
         var _temp_20:* = _applyButton;
         var _loc4_:String = "ui.windows.cityplanner.apply";
         _temp_20.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _menuContainer.addChild(_applyButton);
         _expandButton = new WomOrangeSmallButton();
         _expandButton.width = 106;
         _menuContainer.addChild(_expandButton);
         hintTextField = new WomTextField();
         hintTextField.autoSize = "left";
         var _temp_23:* = hintTextField;
         var _loc5_:String = "ui.windows.cityplanner.hint";
         _temp_23.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _menuContainer.addChild(hintTextField);
         _nameLightBackground = assetRepository.getDisplayObject("CityPlannerBuildingNameBackground");
         _nameLightBackground.width = 269;
         _nameDarkBackground = assetRepository.getDisplayObject("BackgroundDark");
         _nameDarkBackground.width = 233;
         _nameDarkBackground.height = 28;
         _nameLabel = new WomTextField();
         _nameLabel.width = _nameDarkBackground.width;
         _nameLabel.height = _nameDarkBackground.height;
         _nameLabel.defaultTextFormat = WomTextFormats.CENTER_18;
         _nameLabel.text = "";
         _zoomInButton = new WomBlueMiniButton();
         _zoomInButton.width = 26;
         _zoomInButton.setStyle("icon",assetRepository.getDisplayObject("BluePlusIcon"));
         _zoomOutButton = new WomBlueMiniButton();
         _zoomOutButton.width = 26;
         _zoomOutButton.setStyle("icon",assetRepository.getDisplayObject("BlueMinusIcon"));
         _zoomBar = assetRepository.getDisplayObject("CityPlannerZoomBar");
         _zoomBarCursor = assetRepository.getDisplayObject("CityPlannerZoomBarCursor");
         _zoomBarCursor.y = _zoomBar.y + _zoomBar.height / 2;
         _fullScreenButton = new WomBlueMiniButton();
         _fullScreenButton.width = 26;
         _fullScreenButton.setStyle("icon",assetRepository.getDisplayObject("FullscreenIcon"));
         _toggleGridsButton = new WomBlueMiniButton();
         _toggleGridsButton.width = 26;
         _toggleGridsButton.setStyle("icon",assetRepository.getDisplayObject("GridIcon"));
         _toggleGridsButton.toggle = true;
         _clearLayoutButton = new WomBlueSmallButton();
         _clearLayoutButton.width = 79;
         var _temp_34:* = _clearLayoutButton;
         var _loc6_:String = "ui.windows.cityplanner.clear";
         _temp_34.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         setComponentPositions();
         addChild(plannerRoot.render.canvas);
         addChild(_zoomBar);
         addChild(_zoomOutButton);
         addChild(_zoomInButton);
         addChild(_zoomBarCursor);
         addChild(_fullScreenButton);
         addChild(_toggleGridsButton);
         addChild(_clearLayoutButton);
         addChild(_nameLightBackground);
         addChild(_nameDarkBackground);
         addChild(_nameLabel);
         drawLayout();
      }
      
      private function getBuildingName(param1:int) : String
      {
         var _loc2_:String = "domain.building." + param1 + ".name";
         return peak.i18n.PText.INSTANCE.getText0(_loc2_);
      }
      
      private function createAndAddRangeToggleButton(param1:String, param2:String) : CityPlannerRangeToggleButton
      {
         var _loc3_:CityPlannerRangeToggleButton = new CityPlannerRangeToggleButton();
         _loc3_.width = 40;
         var _temp_2:* = _loc3_;
         var _temp_1:* = "ui.windows.cityplanner.ranges";
         var _loc4_:String = param2;
         var _loc5_:String = _temp_1;
         _temp_2.label = peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_);
         _loc3_.setStyle("icon",assetRepository.getDisplayObject(param1));
         _menuContainer.addChild(_loc3_);
         return _loc3_;
      }
      
      public function updateWithCityInfo(param1:RowColumnPair) : void
      {
         var _loc2_:int = param1.numberOfColumns;
         if(_loc2_ == 200 || _loc2_ == 220 || _loc2_ == 242 || _loc2_ == 268 || _loc2_ == 295)
         {
            var _temp_5:* = _expandButton;
            var _loc3_:String = "ui.windows.cityplanner.expandbase";
            _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         }
         else
         {
            var _temp_6:* = _expandButton;
            var _loc4_:String = "ui.windows.cityplanner.maxarea";
            _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
            _expandButton.enabled = false;
         }
      }
      
      protected function drawLayout() : void
      {
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_darkBackground,_background,35);
         AlignmentUtil.alignBelowOf(_menuContainer,_darkBackground);
         _menuContainer.x = (_background.width - 710 >> 1) - 5;
         _archerButton.x = 7;
         AlignmentUtil.alignRightOf(_cannonButton,_archerButton,2);
         AlignmentUtil.alignRightOf(_gatlingButton,_cannonButton,2);
         AlignmentUtil.alignRightOf(_flamerButton,_gatlingButton,2);
         AlignmentUtil.alignRightOf(_skyButton,_flamerButton,2);
         AlignmentUtil.alignRightOf(_mirrorButton,_skyButton,2);
         AlignmentUtil.alignRightOf(_beastCannonButton,_mirrorButton,2);
         AlignmentUtil.alignRightOf(_watchPostButton,_beastCannonButton,2);
         AlignmentUtil.alignRightOf(_beastButton,_watchPostButton,2);
         AlignmentUtil.alignBelowOf(hintTextField,_archerButton,9);
         _saveButton.x = 385;
         _saveButton.y = 10;
         AlignmentUtil.alignRightOf(_loadButton,_saveButton,5);
         AlignmentUtil.alignRightOf(_applyButton,_loadButton,5);
         AlignmentUtil.alignRightOf(_expandButton,_applyButton,5);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_nameLightBackground,_darkBackground,_darkBackground.height - _nameLightBackground.height);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_nameDarkBackground,_darkBackground,_darkBackground.height - _nameDarkBackground.height);
         AlignmentUtil.alignMiddleOf(_nameLabel,_nameDarkBackground);
         _nameLabel.y += 4;
         AlignmentUtil.alignAccordingToPositionOf(_zoomInButton,_darkBackground,10,8);
         AlignmentUtil.alignAccordingToPositionOf(_zoomOutButton,_darkBackground,10,95);
         AlignmentUtil.alignAccordingToPositionOf(_zoomBar,_zoomInButton,6,(_zoomOutButton.y + _zoomOutButton.height - _zoomInButton.y - _zoomBar.height) / 2);
         AlignmentUtil.alignMiddleOf(_zoomBarCursor,_zoomBar);
         AlignmentUtil.alignBelowOf(_fullScreenButton,_zoomOutButton,5);
         AlignmentUtil.alignBelowOf(_toggleGridsButton,_fullScreenButton,5);
         AlignmentUtil.alignAccordingToPositionOf(_clearLayoutButton,_darkBackground,_darkBackground.width - _clearLayoutButton.width - 10,10);
      }
      
      public function toggleGrids(param1:Boolean) : void
      {
         plannerRoot.toggleGrids(param1);
      }
      
      public function resizeWindow(param1:Boolean) : void
      {
         this._isFullScreen = param1;
         _windowWidth = getWindowWidth();
         _windowHeight = getWindowHeight();
         if(_darkBackground == null)
         {
            _darkBackground = assetRepository.getDisplayObject("BackgroundLight");
         }
         if(!contains(_darkBackground))
         {
            addChild(_darkBackground);
         }
         _darkBackground.width = getCanvasWidth();
         _darkBackground.height = getCanvasHeight();
         drawBackground();
         setPlannerRootSize();
         drawLayout();
         alignHeader();
      }
      
      public function setPlannerRootSize() : void
      {
         plannerRoot.render.clipCanvas = true;
         plannerRoot.render.canvasRect = new Rectangle(_darkBackground.x + 5,_darkBackground.y + 5,getCanvasWidth() - 10,getCanvasHeight() - 10);
      }
      
      public function resetSelections() : void
      {
         _archerButton.selected = _cannonButton.selected = _gatlingButton.selected = _flamerButton.selected = _skyButton.selected = _mirrorButton.selected = _watchPostButton.selected = _beastButton.selected = _beastCannonButton.selected = false;
      }
      
      public function handleZoomIn() : void
      {
         _zoomLevel = _zoomLevel + 1;
         setComponentPositions();
      }
      
      public function setComponentPositions() : void
      {
         _zoomBarCursor.y = _zoomBar.y + _zoomBar.height * 2 / 3 - 10 - _zoomBarCursor.height / 2 - (_zoomBar.height - 60) / 3 * _zoomLevel;
      }
      
      public function handleZoomOut() : void
      {
         _zoomLevel = _zoomLevel - 1;
         setComponentPositions();
      }
      
      public function getWindowWidth() : int
      {
         return _isFullScreen ? this.stage.stageWidth - 30 : 760;
      }
      
      public function getWindowHeight() : int
      {
         return _isFullScreen ? this.stage.stageHeight - 30 : 555;
      }
      
      public function getCanvasWidth() : int
      {
         return getWindowWidth() - 50;
      }
      
      public function getCanvasHeight() : int
      {
         return getWindowHeight() - 132;
      }
      
      public function get zoomLevel() : int
      {
         return _zoomLevel;
      }
      
      public function get isFullScreen() : Boolean
      {
         return _isFullScreen;
      }
      
      public function get saveButton() : Button
      {
         return _saveButton;
      }
      
      public function get loadButton() : Button
      {
         return _loadButton;
      }
      
      public function get applyButton() : Button
      {
         return _applyButton;
      }
      
      public function get expandButton() : Button
      {
         return _expandButton;
      }
      
      public function get zoomInButton() : Button
      {
         return _zoomInButton;
      }
      
      public function get zoomOutButton() : Button
      {
         return _zoomOutButton;
      }
      
      public function get fullScreenButton() : Button
      {
         return _fullScreenButton;
      }
      
      public function get toggleGridsButton() : Button
      {
         return _toggleGridsButton;
      }
      
      public function set zoomLevel(param1:int) : void
      {
         _zoomLevel = param1;
      }
      
      public function get nameLabel() : WomTextField
      {
         return _nameLabel;
      }
      
      public function set nameLabel(param1:WomTextField) : void
      {
         _nameLabel = param1;
      }
      
      public function get archerButton() : Button
      {
         return _archerButton;
      }
      
      public function get cannonButton() : Button
      {
         return _cannonButton;
      }
      
      public function get gatlingButton() : Button
      {
         return _gatlingButton;
      }
      
      public function get flamerButton() : Button
      {
         return _flamerButton;
      }
      
      public function get skyButton() : Button
      {
         return _skyButton;
      }
      
      public function get mirrorButton() : Button
      {
         return _mirrorButton;
      }
      
      public function get watchPostButton() : Button
      {
         return _watchPostButton;
      }
      
      public function get beastButton() : Button
      {
         return _beastButton;
      }
      
      public function get clearLayoutButton() : Button
      {
         return _clearLayoutButton;
      }
      
      public function get beastCannonButton() : Button
      {
         return _beastCannonButton;
      }
   }
}

