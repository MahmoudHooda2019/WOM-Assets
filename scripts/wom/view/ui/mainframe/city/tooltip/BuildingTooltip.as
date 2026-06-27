package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.enum.ActionType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class BuildingTooltip extends Sprite implements View
   {
      
      public static const TOOLTIP_WIDTH:int = 180;
      
      public static const TOOLTIP_HEIGHT_SMALL:int = 60;
      
      public static const TOOLTIP_HEIGHT_MEDIUM:int = 80;
      
      public static const TOOLTIP_HEIGHT_LARGE:int = 115;
      
      public static const TOOLTIP_HEIGHT_HUGE:int = 140;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var background:DisplayObject;
      
      private var _spyModeOn:Boolean;
      
      public var bottomPin:DisplayObject;
      
      public var header:CaptionTextField;
      
      public var building:Building;
      
      public var levelIndicator:DisplayObject;
      
      public var levelTextField:CaptionTextField;
      
      public var progressView:BuildingTooltipProgressView;
      
      public var resourceView:BuildingTooltipResourceView;
      
      public var taxView:BuildingTooltipResourceView;
      
      public var stockpileView:BuildingTooltipStockpileView;
      
      public var defenceView:BuildingTooltipDefenceView;
      
      public var housingView:BuildingTooltipHousingView;
      
      public var trapView:BuildingTooltipTrapView;
      
      public var wallView:BuildingTooltipWallView;
      
      public var helpView:BuildingTooltipHelpView;
      
      public var catapultView:BuildingTooltipCatapultView;
      
      public var beastCannonView:BuildingTooltipBeastCannonView;
      
      private var _beastLevelTextField:WomTextField;
      
      public var actionTextField:WomTextField;
      
      public var globalActionType:ActionType;
      
      public var hasView:Boolean = false;
      
      public var help:Boolean;
      
      public function BuildingTooltip(param1:ActionType, param2:Building, param3:Boolean = false)
      {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.building = param2;
         this.globalActionType = param1;
         this.help = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("TooltipBackgroundSkin");
         addChildAt(background,0);
         bottomPin = assetRepository.getDisplayObject("TooltipsBottomPin");
         addChild(bottomPin);
         if(help)
         {
            if(helpView)
            {
               addChild(helpView);
            }
         }
         else
         {
            levelIndicator = assetRepository.getDisplayObject("UpgradeIcon");
            addChild(levelIndicator);
            levelIndicator.width *= 0.8;
            levelIndicator.height *= 0.8;
            levelTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
            levelTextField.defaultTextFormat = WomTextFormats.CENTER_24;
            levelTextField.width = levelIndicator.width;
            levelTextField.height = 22;
            levelTextField.text = building.data.buildingInfo.level + "";
            addChild(levelTextField);
            header = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
            header.defaultTextFormat = WomTextFormats.CENTER_18;
            header.width = 180;
            header.height = 20;
            var _temp_8:* = header;
            var _loc1_:String = "domain.building." + building.data.buildingInfo.buildingTypeId + ".name";
            _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
            addChild(header);
            actionTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
            actionTextField.defaultTextFormat = WomTextFormats.CENTER_20;
            actionTextField.textColor = 6220099;
            actionTextField.width = 180;
            actionTextField.height = 20;
            addChild(actionTextField);
            determineActionText();
         }
         background.width = 180;
         background.height = help || _beastLevelTextField ? 80 : (hasView ? 115 : 60);
         background.height = beastCannonView ? 140 : background.height;
         if(!help && _spyModeOn)
         {
            background.height -= actionTextField.height + (hasView ? 5 : 0);
         }
         drawLayout();
      }
      
      private function determineActionText() : void
      {
         var _loc1_:String = null;
         var _loc2_:BuildingInfo = building.data.buildingInfo;
         var _loc3_:int = _loc2_.level - 1;
         if(progressView)
         {
            hasView = true;
            addChild(progressView);
            if(progressView.type == 2 || progressView.type == 7 || progressView.type == 1 || progressView.type == 3)
            {
               var _loc4_:String;
               actionTextField.text = _spyModeOn ? "" : (_loc4_ = "ui.mainframe.city.tooltip.enter",peak.i18n.PText.INSTANCE.getText0(_loc4_));
            }
            else
            {
               updateActionTextWithProgressData();
            }
         }
         else if(_loc2_.incomplete)
         {
            var _loc5_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc5_ = "ui.mainframe.city.tooltip.finish",peak.i18n.PText.INSTANCE.getText0(_loc5_));
         }
         else if(_loc3_ >= 0 && building.data.buildingTypeDIO.kind.id == 11)
         {
            switch(_loc2_.buildingTypeId - 11)
            {
               case 0:
                  _loc1_ = "Lumber45";
                  break;
               case 1:
                  _loc1_ = "Stone45";
                  break;
               case 2:
                  _loc1_ = "Might45";
                  break;
               case 3:
                  _loc1_ = "Iron45";
            }
            resourceView = new BuildingTooltipResourceView(assetRepository,_loc1_);
            hasView = true;
            addChild(resourceView);
            var _loc6_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc6_ = "ui.mainframe.city.tooltip.harvest",peak.i18n.PText.INSTANCE.getText0(_loc6_));
         }
         else if(_loc3_ >= 0 && building.data.buildingTypeDIO.kind.id == 12)
         {
            stockpileView = new BuildingTooltipStockpileView(assetRepository,_spyModeOn);
            hasView = true;
            addChild(stockpileView);
            var _loc7_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc7_ = "ui.mainframe.city.tooltip.harvestall",peak.i18n.PText.INSTANCE.getText0(_loc7_));
         }
         else if(_loc3_ >= 0 && building.data.buildingTypeDIO.kind.id == 28 && !_loc2_.isTrap && _loc2_.buildingTypeId != 45)
         {
            defenceView = new BuildingTooltipDefenceView(assetRepository);
            hasView = true;
            addChild(defenceView);
            var _loc8_:String;
            var _loc9_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc2_.level == building.data.buildingTypeDIO.maxLevels ? (_loc8_ = "ui.mainframe.city.tooltip.maxlevel",peak.i18n.PText.INSTANCE.getText0(_loc8_)) : (_loc9_ = "ui.mainframe.city.tooltip.upgrade",peak.i18n.PText.INSTANCE.getText0(_loc9_)));
         }
         else if(_loc3_ >= 0 && _loc2_.buildingTypeId == 19)
         {
            housingView = new BuildingTooltipHousingView(0,assetRepository);
            hasView = true;
            addChild(housingView);
            var _loc10_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc10_ = "ui.mainframe.city.tooltip.enter",peak.i18n.PText.INSTANCE.getText0(_loc10_));
         }
         else if(_loc3_ >= 0 && _loc2_.buildingTypeId == 37)
         {
            housingView = new BuildingTooltipHousingView(1,assetRepository);
            hasView = true;
            addChild(housingView);
            var _loc11_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc11_ = "ui.mainframe.city.tooltip.enter",peak.i18n.PText.INSTANCE.getText0(_loc11_));
         }
         else if(_loc3_ >= 0 && _loc2_.buildingTypeId == 38)
         {
            housingView = new BuildingTooltipHousingView(3,assetRepository);
            hasView = true;
            addChild(housingView);
            var _loc12_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc12_ = "ui.mainframe.city.tooltip.enter",peak.i18n.PText.INSTANCE.getText0(_loc12_));
         }
         else if(_loc3_ >= 0 && _loc2_.buildingTypeId == 43)
         {
            housingView = new BuildingTooltipHousingView(2,assetRepository);
            hasView = true;
            addChild(housingView);
            var _loc13_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc13_ = "ui.mainframe.city.tooltip.enter",peak.i18n.PText.INSTANCE.getText0(_loc13_));
         }
         else if(_loc3_ >= 0 && _loc2_.buildingTypeId == 10)
         {
            taxView = new BuildingTooltipResourceView(assetRepository,"Gold27");
            hasView = true;
            addChild(taxView);
            var _loc14_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc14_ = "ui.mainframe.city.tooltip.collecttaxes",peak.i18n.PText.INSTANCE.getText0(_loc14_));
         }
         else if(_loc3_ >= 0 && _loc2_.isTrap)
         {
            trapView = new BuildingTooltipTrapView(assetRepository);
            hasView = true;
            addChild(trapView);
            var _loc15_:String;
            var _loc16_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc2_.healthPoint == 0 ? (_loc15_ = "ui.mainframe.city.tooltip.rearm",peak.i18n.PText.INSTANCE.getText0(_loc15_)) : (_loc16_ = "ui.mainframe.city.tooltip.move",peak.i18n.PText.INSTANCE.getText0(_loc16_)));
         }
         else if(_loc2_.buildingTypeId == 41)
         {
            wallView = new BuildingTooltipWallView(assetRepository);
            hasView = true;
            addChild(wallView);
            var _loc17_:String;
            var _loc18_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc2_.level == building.data.buildingTypeDIO.maxLevels ? (_loc17_ = "ui.mainframe.city.tooltip.maxlevel",peak.i18n.PText.INSTANCE.getText0(_loc17_)) : (_loc18_ = "ui.mainframe.city.tooltip.upgrade",peak.i18n.PText.INSTANCE.getText0(_loc18_)));
         }
         else if(_loc2_.buildingTypeId == 23)
         {
            catapultView = new BuildingTooltipCatapultView(assetRepository);
            hasView = true;
            addChild(catapultView);
            var _loc19_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc19_ = "ui.mainframe.city.tooltip.openmap",peak.i18n.PText.INSTANCE.getText0(_loc19_));
         }
         else if(_loc2_.buildingTypeId == 29)
         {
            _beastLevelTextField = new WomTextField();
            _beastLevelTextField.width = 180;
            _beastLevelTextField.defaultTextFormat = WomTextFormats.CENTER_18;
            addChild(_beastLevelTextField);
            var _loc20_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc20_ = "ui.mainframe.city.tooltip.enter",peak.i18n.PText.INSTANCE.getText0(_loc20_));
         }
         else if(_loc2_.buildingTypeId == 45)
         {
            beastCannonView = new BuildingTooltipBeastCannonView(assetRepository);
            hasView = true;
            addChild(beastCannonView);
            var _loc21_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc21_ = "ui.mainframe.city.tooltip.openmap",peak.i18n.PText.INSTANCE.getText0(_loc21_));
         }
         else
         {
            var _loc22_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc22_ = "ui.mainframe.city.tooltip.enter",peak.i18n.PText.INSTANCE.getText0(_loc22_));
         }
         if(globalActionType == ActionType.FORTIFY)
         {
            var _loc23_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc23_ = "ui.mainframe.city.tooltip.fortify",peak.i18n.PText.INSTANCE.getText0(_loc23_));
         }
         else if(globalActionType == ActionType.MOVE)
         {
            var _loc24_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc24_ = "ui.mainframe.city.tooltip.move",peak.i18n.PText.INSTANCE.getText0(_loc24_));
         }
         else if(globalActionType == ActionType.RECYCLE)
         {
            var _loc25_:String;
            var _loc26_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc2_.isTrap && _loc2_.healthPoint == 0 ? (_loc25_ = "ui.mainframe.city.tooltip.removetrap",peak.i18n.PText.INSTANCE.getText0(_loc25_)) : (_loc26_ = "ui.mainframe.city.tooltip.recycle",peak.i18n.PText.INSTANCE.getText0(_loc26_)));
         }
         else if(globalActionType == ActionType.UPGRADE)
         {
            var _loc27_:String;
            var _loc28_:String;
            actionTextField.text = _spyModeOn ? "" : (_loc2_.level == building.data.buildingTypeDIO.maxLevels ? (_loc27_ = "ui.mainframe.city.tooltip.maxlevel",peak.i18n.PText.INSTANCE.getText0(_loc27_)) : (_loc28_ = "ui.mainframe.city.tooltip.upgrade",peak.i18n.PText.INSTANCE.getText0(_loc28_)));
         }
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(bottomPin,background,background.height - 6);
         if(help)
         {
            if(helpView)
            {
               helpView.x = 0;
               helpView.y = 0;
            }
         }
         else
         {
            levelIndicator.x = (180 - levelIndicator.width) / 2;
            levelIndicator.y = -levelIndicator.height / 2 - 8;
            AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(levelTextField,levelIndicator,8);
            header.x = 0;
            header.y = 12;
            _loc1_ = 30;
            if(progressView)
            {
               AlignmentUtil.alignAccordingToPositionOf(progressView,background,0,_loc1_);
            }
            else if(resourceView)
            {
               AlignmentUtil.alignAccordingToPositionOf(resourceView,background,0,_loc1_);
            }
            else if(taxView)
            {
               AlignmentUtil.alignAccordingToPositionOf(taxView,background,0,_loc1_);
            }
            else if(catapultView)
            {
               AlignmentUtil.alignAccordingToPositionOf(catapultView,background,0,_loc1_ + 4);
            }
            else if(stockpileView)
            {
               AlignmentUtil.alignAccordingToPositionOf(stockpileView,background,0,_loc1_);
            }
            else if(trapView)
            {
               AlignmentUtil.alignAccordingToPositionOf(trapView,background,0,_loc1_ + 15);
            }
            else if(wallView)
            {
               AlignmentUtil.alignAccordingToPositionOf(wallView,background,0,_loc1_ + 15);
            }
            else if(defenceView)
            {
               AlignmentUtil.alignAccordingToPositionOf(defenceView,background,0,_loc1_ + 15);
            }
            else if(housingView)
            {
               AlignmentUtil.alignAccordingToPositionOf(housingView,background,0,_loc1_ + 12);
            }
            else if(_beastLevelTextField)
            {
               AlignmentUtil.alignAccordingToPositionOf(_beastLevelTextField,background,0,_loc1_);
            }
            else if(beastCannonView)
            {
               AlignmentUtil.alignAccordingToPositionOf(beastCannonView,background,0,_loc1_ + 4);
            }
            actionTextField.x = 0;
            actionTextField.y = background.height - actionTextField.height - 8;
         }
      }
      
      public function get visibleHeight() : int
      {
         return background.height + (bottomPin.visible ? 5 : 0);
      }
      
      public function get visibleWidth() : int
      {
         return background.width;
      }
      
      public function updateActionTextWithProgressData() : void
      {
         if(actionTextField)
         {
            if(progressView.remainingMilliseconds < 300000)
            {
               var _loc1_:String;
               actionTextField.text = _spyModeOn ? "" : (_loc1_ = progressView.type == 0 ? "ui.mainframe.city.tooltip.finishrepair" : (progressView.type == 2 || progressView.type == 7 ? "ui.mainframe.city.tooltip.enter" : "ui.mainframe.city.tooltip.finish"),peak.i18n.PText.INSTANCE.getText0(_loc1_));
            }
            else if(progressView.remainingMilliseconds)
            {
               var _loc2_:String;
               actionTextField.text = _spyModeOn ? "" : (_loc2_ = "ui.mainframe.city.tooltip.speedup",peak.i18n.PText.INSTANCE.getText0(_loc2_));
            }
            else
            {
               actionTextField.text = "";
            }
         }
      }
      
      public function set spyModeOn(param1:Boolean) : void
      {
         _spyModeOn = param1;
      }
      
      public function get beastLevelTextField() : WomTextField
      {
         return _beastLevelTextField;
      }
   }
}

