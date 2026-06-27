package wom.view.screen.windows.beast.cave
{
   import flash.utils.Dictionary;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.job.BeastPreTrainingJob;
   import wom.model.game.job.BeastTrainingJob;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.LocalizedDateTimeUtil;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileEvolutionPanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 774;
      
      private static const HEIGHT:int = 514;
      
      private static const COSTASSET_WIDTH:int = 92;
      
      private var panelContainer:Sprite;
      
      private var nextTrainingContainer:Sprite;
      
      private var beastReadyContainer:Sprite;
      
      private var remainingTimeTextField:MPTextField;
      
      private var nextFeedingTextField:MPTextField;
      
      private var beastReadyTextField:MPTextField;
      
      private var _currentLevelBeastAsset:DisplayObject;
      
      private var _nextLevelBeastAsset:DisplayObject;
      
      private var arrows:Vector.<Vector.<DisplayObject>>;
      
      private var numberOfTrainingsToLevelUpPerLevelTextField:MPTextField;
      
      private var costLabel:MPTextField;
      
      private var costTextFields:Vector.<MPTextField> = null;
      
      private var _startFeedingButton:MPButton;
      
      private var _instantEvolveButton:MobileWomButton;
      
      private var _beastLevelComparisonView:MobileBeastLevelComparisonView;
      
      private var _numberOfTrainingsToLevelUp:int;
      
      private var _indexOfTrainingsLeftToNextLevel:int;
      
      private var comperativeBackground:DisplayObject;
      
      private var nextTrainingBackground:DisplayObject;
      
      private var _clockIcon:DisplayObject;
      
      private var costButtons:Vector.<MPButton>;
      
      private var beastReadyForTrainingBackground:DisplayObject;
      
      private var readyAsset:DisplayObject;
      
      public function MobileEvolutionPanel()
      {
         super(774,514);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         panelContainer = new Sprite();
         addChild(panelContainer);
         nextTrainingContainer = new Sprite();
         addChild(nextTrainingContainer);
         beastReadyContainer = new Sprite();
         addChild(beastReadyContainer);
         nextTrainingBackground = assetRepository.getDisplayObject("MobileBrownBackground");
         nextTrainingBackground.width = 360;
         nextTrainingBackground.height = 53;
         nextTrainingContainer.addChild(nextTrainingBackground);
         beastReadyForTrainingBackground = assetRepository.getDisplayObject("MobileGreenBackground");
         beastReadyForTrainingBackground.width = 360;
         beastReadyForTrainingBackground.height = 53;
         beastReadyContainer.addChild(beastReadyForTrainingBackground);
         beastReadyContainer.visible = false;
         readyAsset = assetRepository.getDisplayObject("SymbolTickSelected");
         beastReadyContainer.addChild(readyAsset);
         arrows = new Vector.<Vector.<DisplayObject>>();
         numberOfTrainingsToLevelUpPerLevelTextField = new MobileWomTextField();
         numberOfTrainingsToLevelUpPerLevelTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         panelContainer.addChild(numberOfTrainingsToLevelUpPerLevelTextField);
         var _temp_9:* = panelContainer;
         var _loc1_:String = "ui.windows.beast.cave.evolution.cost";
         costLabel = createDefaultCaptionTextField(_temp_9,peak.i18n.PText.INSTANCE.getText0(_loc1_));
         costTextFields = new Vector.<MPTextField>();
         costButtons = new Vector.<MPButton>();
         remainingTimeTextField = createDefaultCaptionTextField(nextTrainingContainer,"");
         nextFeedingTextField = createDefaultCaptionTextField(nextTrainingContainer,"");
         beastReadyTextField = createDefaultCaptionTextField(beastReadyContainer,"");
         _clockIcon = assetRepository.getDisplayObject("IconTimerM");
         nextTrainingContainer.addChild(_clockIcon);
         _startFeedingButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _startFeedingButton.width = 324;
         var _temp_19:* = _startFeedingButton;
         var _loc2_:String = "ui.windows.beast.cave.evolution.startfeeding";
         _temp_19.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         panelContainer.addChild(_startFeedingButton);
         _instantEvolveButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _instantEvolveButton.width = 450;
         var _temp_21:* = _instantEvolveButton;
         var _loc3_:String = "ui.windows.beast.cave.evolution.instantevolve";
         _temp_21.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _instantEvolveButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _instantEvolveButton.rightLabel = " ";
         panelContainer.addChild(_instantEvolveButton);
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         comperativeBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         comperativeBackground.width = 445;
         comperativeBackground.height = 459;
         addChild(comperativeBackground);
      }
      
      override public function drawLayout() : void
      {
         var _loc5_:int = 0;
         super.drawLayout();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(comperativeBackground,bg,24);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(nextTrainingBackground,comperativeBackground,-10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(beastReadyForTrainingBackground,comperativeBackground,-10);
         _startFeedingButton.x = -4;
         _startFeedingButton.y = 514 + 28 - (_startFeedingButton.height >> 1);
         MobileAlignmentUtil.alignRightOf(_instantEvolveButton,_startFeedingButton,8);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_clockIcon,nextTrainingBackground,-4);
         _currentLevelBeastAsset.visible = _currentLevelBeastAsset.width > 1;
         _nextLevelBeastAsset.visible = _nextLevelBeastAsset.width > 1;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_nextLevelBeastAsset,comperativeBackground,comperativeBackground.width + 82 - (_nextLevelBeastAsset.width >> 1));
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_currentLevelBeastAsset,comperativeBackground,-82 - (_currentLevelBeastAsset.width >> 1));
         var _loc2_:int = _numberOfTrainingsToLevelUp > 9 ? 13 : 22;
         var _loc1_:int = 774 - (_numberOfTrainingsToLevelUp * _loc2_ + 7) >> 1;
         _loc5_ = 0;
         while(_loc5_ < _numberOfTrainingsToLevelUp)
         {
            if(_loc5_ < _indexOfTrainingsLeftToNextLevel)
            {
               arrows[_loc5_][0].visible = false;
               arrows[_loc5_][1].visible = true;
               arrows[_loc5_][1].x = _loc1_;
               arrows[_loc5_][1].y = 90;
            }
            else
            {
               arrows[_loc5_][0].visible = true;
               arrows[_loc5_][1].visible = false;
               arrows[_loc5_][0].x = _loc1_;
               arrows[_loc5_][0].y = 90;
            }
            _loc1_ += _loc2_;
            _loc5_++;
         }
         var _loc4_:int = (comperativeBackground.width - (costButtons.length * (92 + 18) + costLabel.width)) / 2;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(numberOfTrainingsToLevelUpPerLevelTextField,bg,137);
         var _loc3_:int = costLabel.width + 8;
         MobileAlignmentUtil.alignAccordingToPositionOf(costLabel,comperativeBackground,_loc4_,182);
         _loc5_ = 0;
         while(_loc5_ < costButtons.length)
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(costButtons[_loc5_],costLabel,_loc3_);
            _loc3_ += 92 + 8;
            costButtons[_loc5_].y += 4;
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(costTextFields[_loc5_],costButtons[_loc5_],61);
            _loc5_++;
         }
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(nextFeedingTextField,nextTrainingBackground,7);
         MobileAlignmentUtil.alignMiddleOf(beastReadyTextField,beastReadyForTrainingBackground);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(readyAsset,beastReadyForTrainingBackground,8);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(remainingTimeTextField,nextTrainingBackground);
         remainingTimeTextField.x = _clockIcon.x + _clockIcon.width + 9;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_beastLevelComparisonView,comperativeBackground,255);
      }
      
      private function createDefaultCaptionTextField(param1:DisplayObjectContainer, param2:String) : MPTextField
      {
         var _loc3_:MPTextField = new MobileCaptionTextField();
         _loc3_.textRendererProperties.textFormat = getCaptionTextFormat(21);
         param1.addChild(_loc3_);
         _loc3_.text = param2;
         return _loc3_;
      }
      
      public function updateProgress(param1:BeastInfo, param2:BeastTypeDIO, param3:Boolean = false) : void
      {
         var _loc6_:Number = NaN;
         var _loc5_:BeastTrainingJob = param1.jobScheduler.preTrainingJob != null ? param1.jobScheduler.preTrainingJob : param1.jobScheduler.waitTrainingJob;
         var _loc4_:Boolean = param2.numberOfTrainingsToLevelUpPerLevel[param1.level - 1] == param1.numberOfTrainingsLeftToNextLevel;
         if(_loc5_ != null)
         {
            _loc6_ = _loc5_.executionTime - new Date().getTime();
            remainingTimeTextField.text = LocalizedDateTimeUtil.getUserFriendlyTime(_loc6_);
            remainingTimeTextField.visible = _loc5_ is BeastPreTrainingJob ? true : !_loc4_;
            var _loc7_:String;
            var _loc8_:String;
            var _loc9_:String;
            nextFeedingTextField.text = _loc5_ is BeastPreTrainingJob ? (_loc7_ = "ui.windows.beast.cave.evolution.nextfeedingin",peak.i18n.PText.INSTANCE.getText0(_loc7_)) : (_loc4_ ? (_loc8_ = "ui.windows.beast.cave.evolution.ready",peak.i18n.PText.INSTANCE.getText0(_loc8_)) : (_loc9_ = "ui.windows.beast.cave.evolution.willstarvein",peak.i18n.PText.INSTANCE.getText0(_loc9_)));
            var _loc10_:String;
            var _loc11_:String;
            var _loc12_:String;
            beastReadyTextField.text = _loc5_ is BeastPreTrainingJob ? (_loc10_ = "ui.windows.beast.cave.evolution.nextfeedingin",peak.i18n.PText.INSTANCE.getText0(_loc10_)) : (_loc4_ ? (_loc11_ = "ui.windows.beast.cave.evolution.ready",peak.i18n.PText.INSTANCE.getText0(_loc11_)) : (_loc12_ = "ui.windows.beast.cave.evolution.willstarvein",peak.i18n.PText.INSTANCE.getText0(_loc12_)));
            if(!(_loc5_ is BeastPreTrainingJob) && _loc4_)
            {
               beastReadyContainer.visible = true;
               nextTrainingContainer.visible = false;
            }
            else
            {
               beastReadyContainer.visible = false;
               nextTrainingContainer.visible = true;
            }
         }
         else
         {
            var _loc13_:String;
            var _loc14_:String;
            beastReadyTextField.text = _loc4_ ? (_loc13_ = "ui.windows.beast.cave.evolution.ready",peak.i18n.PText.INSTANCE.getText0(_loc13_)) : (_loc14_ = "ui.windows.beast.cave.evolution.starving",peak.i18n.PText.INSTANCE.getText0(_loc14_));
            beastReadyContainer.visible = true;
            nextTrainingContainer.visible = false;
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
         var _loc7_:MPButton = null;
         _numberOfTrainingsToLevelUp = param2.numberOfTrainingsToLevelUpPerLevel[param1.level - 1];
         _indexOfTrainingsLeftToNextLevel = _numberOfTrainingsToLevelUp - param1.numberOfTrainingsLeftToNextLevel;
         clearBeast();
         _currentLevelBeastAsset = assetRepository.getDisplayObject(param2.assetName + param1.level);
         panelContainer.addChild(_currentLevelBeastAsset);
         var _loc6_:int = int(param1.level >= param2.maxLevels ? param1.level : param1.level + 1);
         _nextLevelBeastAsset = assetRepository.getDisplayObject(param2.assetName + _loc6_);
         panelContainer.addChild(_nextLevelBeastAsset);
         updateProgress(param1,param2,false);
         if(arrows.length == 0)
         {
            _loc10_ = 0;
            while(_loc10_ < _numberOfTrainingsToLevelUp)
            {
               _loc8_ = new Vector.<DisplayObject>();
               _loc8_.push(assetRepository.getDisplayObject(determineArrowType() + "Off"));
               _loc8_.push(assetRepository.getDisplayObject(determineArrowType() + "On"));
               panelContainer.addChild(_loc8_[0]);
               panelContainer.addChild(_loc8_[1]);
               arrows.push(_loc8_);
               _loc10_++;
            }
         }
         var _temp_7:* = numberOfTrainingsToLevelUpPerLevelTextField;
         var _temp_6:* = "ui.windows.beast.cave.evolution.numberoftrainingslefttonextlevel";
         var _loc11_:String = param1.numberOfTrainingsLeftToNextLevel.toString();
         var _loc12_:String = _temp_6;
         _temp_7.text = peak.i18n.PText.INSTANCE.getText1(_loc12_,_loc11_);
         var _loc9_:Vector.<UnitTypeAmountDTO> = param2.trainingCostsPerLevel[param1.level - 1];
         _loc10_ = 0;
         while(_loc10_ < _loc9_.length)
         {
            _loc5_ = _loc9_[_loc10_];
            _loc4_ = param3[_loc5_.id];
            _loc7_ = MobileWomUIComponentFactory.createMobileColoredButton("Beige","Large");
            _loc7_.isSelected = true;
            _loc7_.defaultIcon = assetRepository.getDisplayObject(_loc4_.assetName + "Portrait");
            _loc7_.width = 92;
            costButtons.push(_loc7_);
            panelContainer.addChild(_loc7_);
            costTextFields.push(createDefaultCaptionTextField(panelContainer,_loc5_.amount.toString()));
            _loc10_++;
         }
         if(_beastLevelComparisonView)
         {
            if(panelContainer.contains(_beastLevelComparisonView))
            {
               panelContainer.removeChild(_beastLevelComparisonView);
            }
         }
         _beastLevelComparisonView = new MobileBeastLevelComparisonView(param2,param1.level,param1.level >= param2.maxLevels ? param2.maxLevels : param1.level + 1);
         panelContainer.addChild(_beastLevelComparisonView);
         _beastLevelComparisonView.updateComperation();
         _instantEvolveButton.rightLabel = "" + (param1.level >= param2.maxLevels ? "" + param2.levelUpGoldCostsPerLevel[param2.maxLevels - 2] : "" + param2.levelUpGoldCostsPerLevel[param1.level - 1]);
         drawLayout();
      }
      
      private function determineArrowType() : String
      {
         return "EvolutionProgress";
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
         for each(var _loc1_ in costButtons)
         {
            if(contains(_loc1_))
            {
               panelContainer.removeChild(_loc1_);
            }
         }
         costButtons.length = 0;
         for each(var _loc2_ in costTextFields)
         {
            if(contains(_loc2_))
            {
               panelContainer.removeChild(_loc2_);
            }
         }
         costTextFields.length = 0;
      }
      
      public function toggleHint(param1:Boolean) : void
      {
         panelContainer.visible = !param1;
      }
      
      public function get startFeedingButton() : MPButton
      {
         return _startFeedingButton;
      }
      
      public function get instantEvolveButton() : MPButton
      {
         return _instantEvolveButton;
      }
   }
}

