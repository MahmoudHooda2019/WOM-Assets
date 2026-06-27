package wom.view.screen.windows.beast.cave
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.job.BeastPreTrainingJob;
   import wom.model.game.job.BeastTrainingJob;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.component.progressbar.MaskedProgressBar;
   import wom.view.component.progressbar.ProgressBar30;
   import wom.view.ui.common.OrView;
   import wom.view.util.BaseWindowPanel;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class EvolutionPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 693;
      
      private static const HEIGHT:int = 472;
      
      private static const PROGRESSBAR_WIDTH:int = 218;
      
      private static const PROGRESSBAR_HEIGHT:int = 26;
      
      private static const LEVEL_BACKGROUND_WIDTH:int = 206;
      
      private static const LEVEL_BACKGROUND_HEIGHT:int = 218;
      
      private static const COSTASSET_WIDTH:int = 54;
      
      private static const COSTASSET_HEIGHT:int = 51;
      
      private var panelContainer:Sprite;
      
      private var nextFeedingProgressBar:MaskedProgressBar;
      
      private var nextFeedingTextField:TextField;
      
      private var currentLevelBackground:DisplayObject;
      
      private var _currentLevelBeastAsset:DisplayObject;
      
      private var nextLevelBackground:DisplayObject;
      
      private var _nextLevelBeastAsset:DisplayObject;
      
      private var arrows:Vector.<Vector.<DisplayObject>>;
      
      private var numberOfTrainingsToLevelUpPerLevelTextField:TextField;
      
      private var costBackground:DisplayObject;
      
      private var costLabel:TextField;
      
      private var costAssets:Vector.<DisplayObject> = null;
      
      private var costAmountTextFields:Vector.<TextField> = null;
      
      private var costNameTextFields:Vector.<TextField> = null;
      
      private var _startFeedingButton:WomButton;
      
      private var orIcon:DisplayObject;
      
      private var _instantEvolveButton:WomButton;
      
      private var _currentBeastLevelInfoView:BeastLevelInfoView;
      
      private var _nextBeastLevelInfoView:BeastLevelInfoView;
      
      private var _numberOfTrainingsToLevelUp:int;
      
      private var _indexOfTrainingsLeftToNextLevel:int;
      
      public function EvolutionPanel()
      {
         super(693,472);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         panelContainer = new Sprite();
         addChild(panelContainer);
         currentLevelBackground = assetRepository.getDisplayObject("BackgroundDark");
         currentLevelBackground.width = 206;
         currentLevelBackground.height = 218;
         panelContainer.addChild(currentLevelBackground);
         nextLevelBackground = assetRepository.getDisplayObject("BackgroundDark");
         nextLevelBackground.width = 206;
         nextLevelBackground.height = 218;
         panelContainer.addChild(nextLevelBackground);
         arrows = new Vector.<Vector.<DisplayObject>>();
         numberOfTrainingsToLevelUpPerLevelTextField = createDefaultCaptionTextField(panelContainer,"",WomTextFormats.CENTER_16,WomTextFormats.DEFAULT_FILTER);
         costBackground = assetRepository.getDisplayObject("BackgroundDark");
         costBackground.width = 228;
         costBackground.height = 220;
         panelContainer.addChild(costBackground);
         var _temp_7:* = panelContainer;
         var _loc1_:String = "ui.windows.beast.cave.evolution.cost";
         costLabel = createDefaultCaptionTextField(_temp_7,peak.i18n.PText.INSTANCE.getText0(_loc1_),WomTextFormats.FONT_SIZE_24,WomTextFormats.DEFAULT_FILTER);
         costAssets = new Vector.<DisplayObject>();
         costAmountTextFields = new Vector.<TextField>();
         costNameTextFields = new Vector.<TextField>();
         nextFeedingProgressBar = createProgressBar();
         nextFeedingTextField = createDefaultCaptionTextField(panelContainer,"",WomTextFormats.CENTER_20);
         _startFeedingButton = new WomBlueLargeButton();
         var _temp_16:* = _startFeedingButton;
         var _loc2_:String = "ui.windows.beast.cave.evolution.startfeeding";
         _temp_16.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _startFeedingButton.width = 209;
         panelContainer.addChild(_startFeedingButton);
         orIcon = new OrView();
         panelContainer.addChild(orIcon);
         _currentBeastLevelInfoView = new BeastLevelInfoView();
         panelContainer.addChild(_currentBeastLevelInfoView);
         _nextBeastLevelInfoView = new BeastLevelInfoView();
         panelContainer.addChild(_nextBeastLevelInfoView);
         _instantEvolveButton = new WomGreenLargeButton();
         var _temp_21:* = _instantEvolveButton;
         var _loc3_:String = "ui.windows.beast.cave.evolution.instantevolve";
         _temp_21.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _instantEvolveButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         _instantEvolveButton.width = 299;
         panelContainer.addChild(_instantEvolveButton);
      }
      
      override public function drawLayout() : void
      {
         var _loc3_:int = 0;
         super.drawLayout();
         AlignmentUtil.alignAccordingToPositionOf(currentLevelBackground,bg,21,50);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(nextLevelBackground,currentLevelBackground,446);
         _currentLevelBeastAsset.visible = _currentLevelBeastAsset.width > 1;
         _nextLevelBeastAsset.visible = _nextLevelBeastAsset.width > 1;
         AlignmentUtil.alignMiddleOf(_currentLevelBeastAsset,currentLevelBackground);
         AlignmentUtil.alignMiddleOf(_nextLevelBeastAsset,nextLevelBackground);
         var _loc2_:int = _numberOfTrainingsToLevelUp > 9 ? 13 : 22;
         var _loc1_:int = 693 - (_numberOfTrainingsToLevelUp * _loc2_ + 7) >> 1;
         _loc3_ = 0;
         while(_loc3_ < _numberOfTrainingsToLevelUp)
         {
            if(_loc3_ < _indexOfTrainingsLeftToNextLevel)
            {
               arrows[_loc3_][0].visible = false;
               arrows[_loc3_][1].visible = true;
               arrows[_loc3_][1].x = _loc1_;
               arrows[_loc3_][1].y = 76;
            }
            else
            {
               arrows[_loc3_][0].visible = true;
               arrows[_loc3_][1].visible = false;
               arrows[_loc3_][0].x = _loc1_;
               arrows[_loc3_][0].y = 76;
            }
            _loc1_ += _loc2_;
            _loc3_++;
         }
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(numberOfTrainingsToLevelUpPerLevelTextField,bg,112);
         _loc3_ = 0;
         while(_loc3_ < costAssets.length)
         {
            costAssets[_loc3_].width = 54;
            costAssets[_loc3_].height = 51;
            _loc3_++;
         }
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(costBackground,bg,138);
         AlignmentUtil.alignAccordingToPositionOf(costLabel,costBackground,8,-10);
         _loc3_ = 0;
         while(_loc3_ < costAssets.length)
         {
            AlignmentUtil.alignAccordingToPositionOf(costAssets[_loc3_],costBackground,12,16 + _loc3_ * (51 + 7));
            AlignmentUtil.alignAccordingToPositionOf(costAmountTextFields[_loc3_],costBackground,70,14 + _loc3_ * (51 + 7));
            AlignmentUtil.alignBelowOf(costNameTextFields[_loc3_],costAmountTextFields[_loc3_],-2);
            _loc3_++;
         }
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(nextFeedingTextField,costBackground,142);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(nextFeedingProgressBar,costBackground,166);
         AlignmentUtil.alignBelowOf(_currentBeastLevelInfoView,currentLevelBackground,10);
         AlignmentUtil.alignBelowOf(_nextBeastLevelInfoView,nextLevelBackground,10);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_startFeedingButton,bg,341);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(orIcon,bg,410);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_instantEvolveButton,bg,459);
      }
      
      private function createProgressBar(param1:int = 218) : MaskedProgressBar
      {
         var _loc2_:MaskedProgressBar = new ProgressBar30();
         _loc2_.width = param1;
         _loc2_.height = 26;
         panelContainer.addChild(_loc2_);
         return _loc2_;
      }
      
      private function createDefaultCaptionTextField(param1:DisplayObjectContainer, param2:String, param3:TextFormat, param4:GlowFilter = null) : TextField
      {
         var _loc5_:TextField = new CaptionTextField(param4 == null ? WomTextFormats.BLACK_FILTER : param4);
         _loc5_.defaultTextFormat = param3;
         _loc5_.autoSize = "left";
         _loc5_.text = param2;
         param1.addChild(_loc5_);
         return _loc5_;
      }
      
      public function updateProgressBar(param1:BeastInfo, param2:BeastTypeDIO, param3:Boolean = false) : void
      {
         var _loc6_:Number = NaN;
         var _loc5_:BeastTrainingJob = param1.jobScheduler.preTrainingJob != null ? param1.jobScheduler.preTrainingJob : param1.jobScheduler.waitTrainingJob;
         var _loc4_:Boolean = param2.numberOfTrainingsToLevelUpPerLevel[param1.level - 1] == param1.numberOfTrainingsLeftToNextLevel;
         if(_loc5_ != null)
         {
            _loc6_ = _loc5_.executionTime - new Date().getTime();
            nextFeedingProgressBar.setProgress(_loc6_,_loc5_.originalDuration);
            nextFeedingProgressBar.progressText = LocalizedDateTimeUtil.getUserFriendlyTime(_loc6_);
            var _loc7_:String;
            var _loc8_:String;
            var _loc9_:String;
            nextFeedingTextField.text = _loc5_ is BeastPreTrainingJob ? (_loc7_ = "ui.windows.beast.cave.evolution.nextfeedingin",peak.i18n.PText.INSTANCE.getText0(_loc7_)) : (_loc4_ ? (_loc8_ = "ui.windows.beast.cave.evolution.ready",peak.i18n.PText.INSTANCE.getText0(_loc8_)) : (_loc9_ = "ui.windows.beast.cave.evolution.willstarvein",peak.i18n.PText.INSTANCE.getText0(_loc9_)));
            nextFeedingProgressBar.visible = _loc5_ is BeastPreTrainingJob ? true : !_loc4_;
         }
         else
         {
            nextFeedingProgressBar.setProgress(0,0);
            nextFeedingProgressBar.progressText = "";
            var _loc10_:String;
            var _loc11_:String;
            nextFeedingTextField.text = _loc4_ ? (_loc10_ = "ui.windows.beast.cave.evolution.ready",peak.i18n.PText.INSTANCE.getText0(_loc10_)) : (_loc11_ = "ui.windows.beast.cave.evolution.starving",peak.i18n.PText.INSTANCE.getText0(_loc11_));
            nextFeedingProgressBar.visible = false;
         }
         if(param3)
         {
            drawLayout();
         }
      }
      
      public function updateBeast(param1:BeastInfo, param2:BeastTypeDIO, param3:Dictionary) : void
      {
         var _loc10_:int = 0;
         var _loc8_:* = undefined;
         var _loc5_:UnitTypeAmountDTO = null;
         var _loc4_:UnitTypeDIO = null;
         var _loc6_:DisplayObject = null;
         _numberOfTrainingsToLevelUp = param2.numberOfTrainingsToLevelUpPerLevel[param1.level - 1];
         _indexOfTrainingsLeftToNextLevel = _numberOfTrainingsToLevelUp - param1.numberOfTrainingsLeftToNextLevel;
         clearBeast();
         _currentLevelBeastAsset = assetRepository.getDisplayObject(param2.assetName + param1.level);
         _currentLevelBeastAsset.scaleX = _currentLevelBeastAsset.scaleY = 0.5;
         panelContainer.addChild(_currentLevelBeastAsset);
         var _loc7_:int = int(param1.level >= param2.maxLevels ? param1.level : param1.level + 1);
         _nextLevelBeastAsset = assetRepository.getDisplayObject(param2.assetName + _loc7_);
         _nextLevelBeastAsset.scaleX = _nextLevelBeastAsset.scaleY = 0.5;
         panelContainer.addChild(_nextLevelBeastAsset);
         updateProgressBar(param1,param2,false);
         if(arrows.length == 0)
         {
            _loc10_ = 0;
            while(_loc10_ < _numberOfTrainingsToLevelUp)
            {
               _loc8_ = new Vector.<DisplayObject>();
               _loc8_.push(assetRepository.getDisplayObject(determineArrowType() + "Normal"));
               _loc8_.push(assetRepository.getDisplayObject(determineArrowType() + "Selected"));
               panelContainer.addChild(_loc8_[0]);
               panelContainer.addChild(_loc8_[1]);
               arrows.push(_loc8_);
               _loc10_++;
            }
         }
         var _temp_7:* = numberOfTrainingsToLevelUpPerLevelTextField;
         var _temp_6:* = "ui.windows.beast.cave.evolution.numberoftrainingslefttonextlevel";
         var _loc12_:String = param1.numberOfTrainingsLeftToNextLevel.toString();
         var _loc13_:String = _temp_6;
         _temp_7.text = peak.i18n.PText.INSTANCE.getText1(_loc13_,_loc12_);
         var _loc9_:Vector.<UnitTypeAmountDTO> = param2.trainingCostsPerLevel[param1.level - 1];
         _loc10_ = 0;
         while(_loc10_ < _loc9_.length)
         {
            _loc5_ = _loc9_[_loc10_];
            _loc4_ = param3[_loc5_.id];
            _loc6_ = assetRepository.getDisplayObject(_loc4_.assetName + "Small");
            costAssets.push(_loc6_);
            panelContainer.addChild(_loc6_);
            costAmountTextFields.push(createDefaultCaptionTextField(panelContainer,_loc5_.amount.toString(),WomTextFormats.FONT_SIZE_30));
            var _temp_10:* = costNameTextFields;
            var _temp_8:* = panelContainer;
            var _loc14_:String = "domain.units." + _loc4_.id + ".name";
            _temp_10.push(createDefaultCaptionTextField(_temp_8,peak.i18n.PText.INSTANCE.getText0(_loc14_),WomTextFormats.FONT_SIZE_18));
            _loc10_++;
         }
         _currentBeastLevelInfoView.updateWithBeastInfo(param2,param1.level);
         _nextBeastLevelInfoView.updateWithBeastInfo(param2,param1.level >= param2.maxLevels ? param2.maxLevels : param1.level + 1);
         _instantEvolveButton.rightLabel = "" + (param1.level >= param2.maxLevels ? "" + param2.levelUpGoldCostsPerLevel[param2.maxLevels - 2] : "" + param2.levelUpGoldCostsPerLevel[param1.level - 1]);
         drawLayout();
      }
      
      private function determineArrowType() : String
      {
         if(_numberOfTrainingsToLevelUp > 9)
         {
            return "BeastCaveEvolutionSmall";
         }
         return "BeastCaveEvolutionBig";
      }
      
      private function clearBeast() : void
      {
         if(_currentLevelBeastAsset != null && contains(_currentLevelBeastAsset))
         {
            panelContainer.removeChild(_currentLevelBeastAsset);
         }
         if(_nextLevelBeastAsset != null && contains(_nextLevelBeastAsset))
         {
            panelContainer.removeChild(_nextLevelBeastAsset);
         }
         if(_numberOfTrainingsToLevelUp != arrows.length)
         {
            for each(var _loc3_ in arrows)
            {
               if(contains(_loc3_[0]))
               {
                  panelContainer.removeChild(_loc3_[0]);
               }
               if(contains(_loc3_[1]))
               {
                  panelContainer.removeChild(_loc3_[1]);
               }
               _loc3_.length = 0;
            }
            arrows.length = 0;
         }
         for each(var _loc1_ in costAssets)
         {
            if(contains(_loc1_))
            {
               panelContainer.removeChild(_loc1_);
            }
         }
         costAssets.length = 0;
         for each(var _loc2_ in costAmountTextFields)
         {
            if(contains(_loc2_))
            {
               panelContainer.removeChild(_loc2_);
            }
         }
         costAmountTextFields.length = 0;
         for each(_loc2_ in costNameTextFields)
         {
            if(contains(_loc2_))
            {
               panelContainer.removeChild(_loc2_);
            }
         }
         costNameTextFields.length = 0;
      }
      
      public function toggleHint(param1:Boolean) : void
      {
         panelContainer.visible = !param1;
      }
      
      public function get currentLevelBeastAsset() : DisplayObject
      {
         return _currentLevelBeastAsset;
      }
      
      public function get nextLevelBeastAsset() : DisplayObject
      {
         return _nextLevelBeastAsset;
      }
      
      public function get startFeedingButton() : WomButton
      {
         return _startFeedingButton;
      }
      
      public function get instantEvolveButton() : WomButton
      {
         return _instantEvolveButton;
      }
   }
}

