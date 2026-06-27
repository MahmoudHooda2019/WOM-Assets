package wom.view.screen.windows.recruitmentchamber
{
   import com.greensock.TweenLite;
   import fl.controls.Button;
   import fl.controls.ProgressBar;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.controller.event.ui.RecruitmentChamberMercenaryEvent;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.component.button.colored.WomGreenSmallButton;
   import wom.view.component.button.colored.WomRedLargeButton;
   import wom.view.component.progressbar.ProgressBar26;
   import wom.view.ui.common.IconLabelView;
   import wom.view.ui.common.OrView;
   import wom.view.util.GenericWindow;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class RecruitmentChamberWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 728;
      
      private static const WINDOW_HEIGHT:int = 525;
      
      private var mercenariesListBackground:DisplayObject;
      
      private var mercenaryDescriptionBackground:DisplayObject;
      
      private var mercenaryProductionStatsBackground:DisplayObject;
      
      private var mercenaryPicture:DisplayObject;
      
      private var unlockingLabel:TextField;
      
      private var speedupExplanationTextField:TextField;
      
      private var _mercenaryListPreviousButton:Button;
      
      private var _mercenaryListNextButton:Button;
      
      private var _recruitmentChamberMercenaryListViews:Dictionary;
      
      private var mercenaryNameTextField:TextField;
      
      private var mercenaryDescriptionTextField:TextField;
      
      private var favoriteTargetLabel:TextField;
      
      private var favoriteTargetsTextField:TextField;
      
      private var speedLabel:TextField;
      
      private var speedTextField:TextField;
      
      private var speedProgressBar:ProgressBar;
      
      private var healthLabel:TextField;
      
      private var healthTextField:TextField;
      
      private var healthProgressBar:ProgressBar;
      
      private var damageLabel:TextField;
      
      private var damageTextField:TextField;
      
      private var damageProgressBar:ProgressBar;
      
      private var productionStatsTextField:TextField;
      
      private var recruitmentCostsTextField:TextField;
      
      private var onceUnlockedTextField:TextField;
      
      private var recruitCostView:IconLabelView;
      
      private var hireCostView:IconLabelView;
      
      private var housingSpaceView:IconLabelView;
      
      private var chamberLevelView:IconLabelView;
      
      private var chamberLevelTextField:TextField;
      
      private var recruitTimeView:IconLabelView;
      
      private var hireTimeView:IconLabelView;
      
      private var _startRecruitingButton:WomButton;
      
      private var _instantRecruitButton:WomButton;
      
      private var _unlockedButton:WomButton;
      
      private var _finishNowButton:WomButton;
      
      private var _stopButton:WomButton;
      
      private var _shortenWithRPButton:WomButton;
      
      private var orIcon:DisplayObject;
      
      private var _currentlyRecruiting:Boolean = false;
      
      private var _currentlyRecruitingUnitTypeId:int = -1;
      
      private var allRecruitsDone:Boolean = false;
      
      private var _selectedUnitTypeId:int;
      
      private var _selectedUnitTypeInfo:UnitTypeInfo;
      
      private var _initialPageIndex:int;
      
      private var _initialUnitTypeId:int;
      
      private var _currentPageIndex:int;
      
      private var _buildingInstanceId:int;
      
      private var _serverSpeed:int;
      
      private var recruitingMask:Sprite;
      
      private var progressMask:Sprite;
      
      private var clockIcon:DisplayObject;
      
      private var progressTextField:TextField;
      
      private var lockIcon:Sprite;
      
      public function RecruitmentChamberWindow(param1:int, param2:int, param3:int = -1, param4:int = -1, param5:Vector.<WindowEnumeration> = null)
      {
         super(728,525,param5);
         _buildingInstanceId = param1;
         _serverSpeed = param2;
         _initialPageIndex = param3;
         _initialUnitTypeId = param4;
      }
      
      public static function lengthOf(param1:Dictionary) : int
      {
         var _loc2_:int = 0;
         for(var _loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc4_:String = "ui.windows.recruitmentchamber.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         _mercenaryListPreviousButton = new WomBlueSmallButton();
         _mercenaryListPreviousButton.width = 110;
         _mercenaryListPreviousButton.enabled = false;
         var _temp_3:* = _mercenaryListPreviousButton;
         var _loc5_:String = "ui.windows.recruitmentchamber.previous";
         _temp_3.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_mercenaryListPreviousButton);
         _mercenaryListNextButton = new WomGreenSmallButton();
         _mercenaryListNextButton.width = 110;
         _mercenaryListNextButton.enabled = false;
         var _temp_5:* = _mercenaryListNextButton;
         var _loc6_:String = "ui.windows.recruitmentchamber.next";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(_mercenaryListNextButton);
         unlockingLabel = new CaptionTextField();
         unlockingLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         unlockingLabel.autoSize = "left";
         unlockingLabel.visible = false;
         var _temp_7:* = unlockingLabel;
         var _loc7_:String = "ui.windows.recruitmentchamber.unlocking";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc7_) + ":";
         addChild(unlockingLabel);
         speedupExplanationTextField = new WomTextField();
         speedupExplanationTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         speedupExplanationTextField.multiline = true;
         speedupExplanationTextField.wordWrap = true;
         speedupExplanationTextField.width = 200;
         speedupExplanationTextField.autoSize = "left";
         var _temp_9:* = speedupExplanationTextField;
         var _loc8_:String = "ui.windows.recruitmentchamber.speedupexplanation";
         _temp_9.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         addChild(speedupExplanationTextField);
         mercenaryPicture = assetRepository.getDisplayObject("BedoinBruteLarge");
         addChild(mercenaryPicture);
         progressMask = new Sprite();
         addChild(progressMask);
         recruitingMask = new Sprite();
         recruitingMask.visible = false;
         recruitingMask.alpha = 0.5;
         recruitingMask.graphics.beginFill(0);
         recruitingMask.graphics.drawRoundRect(0,0,200,443,18,18);
         recruitingMask.graphics.endFill();
         addChild(recruitingMask);
         recruitingMask.mask = progressMask;
         clockIcon = assetRepository.getDisplayObject("RecruitmentChamberTimeIconSmall");
         clockIcon.visible = false;
         addChild(clockIcon);
         progressTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         progressTextField.autoSize = "left";
         progressTextField.visible = false;
         addChild(progressTextField);
         lockIcon = assetRepository.getDisplayObject("RecruitmentChamberLockIconBig");
         lockIcon.visible = false;
         addChild(lockIcon);
         mercenaryNameTextField = new CaptionTextField();
         mercenaryNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         mercenaryNameTextField.autoSize = "left";
         addChild(mercenaryNameTextField);
         mercenaryDescriptionTextField = new WomTextField();
         mercenaryDescriptionTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         mercenaryDescriptionTextField.multiline = true;
         mercenaryDescriptionTextField.wordWrap = true;
         mercenaryDescriptionTextField.width = 220;
         mercenaryDescriptionTextField.autoSize = "left";
         addChild(mercenaryDescriptionTextField);
         favoriteTargetLabel = new CaptionTextField();
         favoriteTargetLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         favoriteTargetLabel.autoSize = "left";
         var _temp_19:* = favoriteTargetLabel;
         var _loc9_:String = "ui.windows.recruitmentchamber.favoritetargets";
         _temp_19.text = peak.i18n.PText.INSTANCE.getText0(_loc9_) + ":";
         addChild(favoriteTargetLabel);
         favoriteTargetsTextField = new WomTextField();
         favoriteTargetsTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         favoriteTargetsTextField.width = 225;
         favoriteTargetsTextField.wordWrap = true;
         favoriteTargetsTextField.multiline = true;
         addChild(favoriteTargetsTextField);
         productionStatsTextField = new CaptionTextField();
         productionStatsTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         productionStatsTextField.autoSize = "left";
         var _temp_22:* = productionStatsTextField;
         var _loc10_:String = "ui.windows.recruitmentchamber.productionstats";
         _temp_22.text = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         addChild(productionStatsTextField);
         recruitmentCostsTextField = new CaptionTextField();
         recruitmentCostsTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         recruitmentCostsTextField.autoSize = "left";
         var _temp_24:* = recruitmentCostsTextField;
         var _loc11_:String = "ui.windows.recruitmentchamber.recruitmentcosts";
         _temp_24.text = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         addChild(recruitmentCostsTextField);
         onceUnlockedTextField = new WomTextField();
         onceUnlockedTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         onceUnlockedTextField.width = mercenaryProductionStatsBackground.width;
         onceUnlockedTextField.autoSize = "left";
         var _temp_26:* = onceUnlockedTextField;
         var _loc12_:String = "ui.windows.recruitmentchamber.onceunlocked";
         _temp_26.text = peak.i18n.PText.INSTANCE.getText0(_loc12_);
         addChild(onceUnlockedTextField);
         speedLabel = createLabel("speed");
         healthLabel = createLabel("health");
         damageLabel = createLabel("damage");
         var _loc2_:TextFormat = WomTextFormats.CENTER_14_DARK_RED;
         var _loc3_:TextFormat = WomTextFormats.CENTER_14;
         recruitCostView = new IconLabelView("Might45","",70,70,_loc3_,_loc2_);
         hireCostView = new IconLabelView("Iron45","",70,70,_loc3_,_loc2_);
         housingSpaceView = new IconLabelView("RecruitmentChamberBarracksIcon","",70,70,_loc3_,_loc2_);
         var _temp_34:* = §§findproperty(IconLabelView);
         var _temp_33:* = "Upgrade";
         var _loc13_:String = "ui.windows.recruitmentchamber.chamberlevel";
         chamberLevelView = new IconLabelView(_temp_33,peak.i18n.PText.INSTANCE.getText0(_loc13_),70,70,_loc3_,_loc2_);
         recruitTimeView = new IconLabelView("Clock45","",70,70,_loc3_,_loc2_);
         hireTimeView = new IconLabelView("Clock45","",70,70,_loc3_,_loc2_);
         addChild(recruitCostView);
         addChild(hireCostView);
         addChild(housingSpaceView);
         addChild(chamberLevelView);
         addChild(recruitTimeView);
         addChild(hireTimeView);
         speedProgressBar = createProgressBar();
         healthProgressBar = createProgressBar();
         damageProgressBar = createProgressBar();
         speedTextField = createProgressBarTextField();
         healthTextField = createProgressBarTextField();
         damageTextField = createProgressBarTextField();
         chamberLevelTextField = new CaptionTextField();
         chamberLevelTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         chamberLevelTextField.autoSize = "left";
         addChild(chamberLevelTextField);
         _startRecruitingButton = new WomBlueLargeButton();
         var _temp_46:* = _startRecruitingButton;
         var _loc14_:String = "ui.windows.recruitmentchamber.startunlocking";
         _temp_46.label = peak.i18n.PText.INSTANCE.getText0(_loc14_);
         _startRecruitingButton.width = 240;
         addChild(_startRecruitingButton);
         _instantRecruitButton = new WomGreenLargeButton();
         _instantRecruitButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         var _temp_48:* = _instantRecruitButton;
         var _loc15_:String = "ui.windows.recruitmentchamber.instantunlock";
         _temp_48.label = peak.i18n.PText.INSTANCE.getText0(_loc15_);
         _instantRecruitButton.width = 340;
         addChild(_instantRecruitButton);
         _unlockedButton = new WomBlueLargeButton();
         var _temp_50:* = _unlockedButton;
         var _loc16_:String = "ui.windows.recruitmentchamber.unlocked";
         _temp_50.label = peak.i18n.PText.INSTANCE.getText0(_loc16_);
         _unlockedButton.width = 230;
         _unlockedButton.enabled = false;
         addChild(_unlockedButton);
         _stopButton = new WomRedLargeButton();
         var _temp_52:* = _stopButton;
         var _loc17_:String = "ui.windows.recruitmentchamber.stop";
         _temp_52.label = peak.i18n.PText.INSTANCE.getText0(_loc17_);
         _stopButton.width = 120;
         addChild(_stopButton);
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("Rp");
         _loc1_.height = _loc1_.height * (21 / _loc1_.width) >> 0;
         _loc1_.width = 21;
         _shortenWithRPButton = new WomBlueSmallButton();
         _shortenWithRPButton.width = 133;
         var _temp_54:* = _shortenWithRPButton;
         var _loc18_:String = "ui.windows.constructionsite.cutdurationwithrp";
         _temp_54.label = peak.i18n.PText.INSTANCE.getText0(_loc18_);
         _shortenWithRPButton.setStyle("icon",_loc1_);
         _shortenWithRPButton.rightLabel = "30";
         addChild(_shortenWithRPButton);
         _finishNowButton = new WomGreenLargeButton();
         _finishNowButton.width = 265;
         var _temp_56:* = _finishNowButton;
         var _loc19_:String = "ui.windows.constructionsite.finishnowbutton";
         _temp_56.label = peak.i18n.PText.INSTANCE.getText0(_loc19_);
         _finishNowButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         addChild(_finishNowButton);
         orIcon = new OrView();
         addChild(orIcon);
      }
      
      private function createLabel(param1:String) : TextField
      {
         var _loc2_:TextField = new CaptionTextField();
         _loc2_.defaultTextFormat = WomTextFormats.RIGHT_14;
         _loc2_.width = 40;
         _loc2_.height = 17;
         var _temp_1:* = _loc2_;
         var _loc3_:String = "ui.windows.recruitmentchamber." + param1;
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function createProgressBar() : ProgressBar
      {
         var _loc1_:ProgressBar = new ProgressBar26();
         _loc1_.width = 160;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function createProgressBarTextField() : TextField
      {
         var _loc1_:TextField = new CaptionTextField();
         _loc1_.defaultTextFormat = WomTextFormats.FONT_SIZE_14;
         _loc1_.width = 87;
         _loc1_.height = 17;
         addChild(_loc1_);
         return _loc1_;
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         mercenariesListBackground = assetRepository.getDisplayObject("BackgroundLight");
         mercenariesListBackground.width = 238;
         mercenariesListBackground.height = 220;
         mercenariesListBackground.x = 20;
         mercenariesListBackground.y = 23;
         addChild(mercenariesListBackground);
         mercenaryDescriptionBackground = assetRepository.getDisplayObject("BackgroundLight");
         mercenaryDescriptionBackground.width = 239;
         mercenaryDescriptionBackground.height = 336;
         mercenaryDescriptionBackground.x = 466;
         mercenaryDescriptionBackground.y = mercenariesListBackground.y;
         addChild(mercenaryDescriptionBackground);
         mercenaryProductionStatsBackground = assetRepository.getDisplayObject("BackgroundLight");
         mercenaryProductionStatsBackground.width = mercenaryDescriptionBackground.width;
         mercenaryProductionStatsBackground.height = 107;
         addChild(mercenaryProductionStatsBackground);
         AlignmentUtil.alignBelowOf(mercenaryProductionStatsBackground,mercenaryDescriptionBackground,2);
      }
      
      public function drawLayout() : void
      {
         for each(var _loc1_ in _recruitmentChamberMercenaryListViews)
         {
            _loc1_.x = 30;
            _loc1_.y = 32 + _loc1_.index % 4 * 52;
         }
         AlignmentUtil.alignBelowWithXMarginOf(_mercenaryListPreviousButton,mercenariesListBackground,6,10);
         AlignmentUtil.alignRightOf(_mercenaryListNextButton,_mercenaryListPreviousButton);
         AlignmentUtil.alignBelowWithXMarginOf(unlockingLabel,_mercenaryListPreviousButton,3);
         AlignmentUtil.alignBelowOf(speedupExplanationTextField,unlockingLabel);
         AlignmentUtil.alignRightOf(mercenaryPicture,mercenariesListBackground,3);
         AlignmentUtil.alignRightWithYMarginOf(recruitingMask,mercenariesListBackground,1,4);
         AlignmentUtil.alignAccordingToPositionOf(clockIcon,recruitingMask,33,recruitingMask.height - 25);
         AlignmentUtil.alignAccordingToPositionOf(progressTextField,clockIcon,26,-3);
         AlignmentUtil.alignAccordingToPositionOf(_shortenWithRPButton,recruitingMask,30,recruitingMask.height - 63);
         AlignmentUtil.alignAccordingToPositionOf(lockIcon,mercenaryPicture,58,118);
         AlignmentUtil.alignAccordingToPositionOf(mercenaryNameTextField,mercenaryDescriptionBackground,9,9);
         AlignmentUtil.alignBelowOf(mercenaryDescriptionTextField,mercenaryNameTextField,1);
         AlignmentUtil.alignBelowOf(speedLabel,mercenaryNameTextField,163);
         AlignmentUtil.alignBelowOf(healthLabel,speedLabel,10);
         AlignmentUtil.alignBelowOf(damageLabel,healthLabel,10);
         AlignmentUtil.alignBelowOf(favoriteTargetLabel,damageLabel,10);
         AlignmentUtil.alignBelowOf(favoriteTargetsTextField,favoriteTargetLabel,1);
         AlignmentUtil.alignAccordingToPositionOf(productionStatsTextField,mercenaryProductionStatsBackground,10,5);
         AlignmentUtil.alignAccordingToPositionOf(recruitmentCostsTextField,productionStatsTextField,0,0);
         AlignmentUtil.alignRightOf(onceUnlockedTextField,productionStatsTextField);
         AlignmentUtil.alignAccordingToPositionOf(recruitCostView,mercenaryProductionStatsBackground,0,30);
         AlignmentUtil.alignRightOf(recruitTimeView,recruitCostView);
         AlignmentUtil.alignRightOf(chamberLevelView,recruitTimeView);
         AlignmentUtil.alignMiddleOf(chamberLevelTextField,chamberLevelView);
         AlignmentUtil.alignAccordingToPositionOf(hireCostView,recruitCostView,0,0);
         AlignmentUtil.alignAccordingToPositionOf(hireTimeView,recruitTimeView,0,0);
         AlignmentUtil.alignAccordingToPositionOf(housingSpaceView,chamberLevelView,0,0);
         AlignmentUtil.alignRightWithYMarginOf(speedProgressBar,speedLabel,-3,10);
         AlignmentUtil.alignRightWithYMarginOf(healthProgressBar,healthLabel,-3,10);
         AlignmentUtil.alignRightWithYMarginOf(damageProgressBar,damageLabel,-3,10);
         AlignmentUtil.alignRightOf(speedTextField,speedLabel,15);
         AlignmentUtil.alignRightOf(healthTextField,healthLabel,15);
         AlignmentUtil.alignRightOf(damageTextField,damageLabel,15);
         _startRecruitingButton.x = 65;
         _unlockedButton.y = _stopButton.y = _startRecruitingButton.y = 479;
         _stopButton.x = 219;
         _unlockedButton.x = (728 - _unlockedButton.width) / 2 << 0;
         AlignmentUtil.alignRightWithYMarginOf(orIcon,_stopButton.visible ? _stopButton : _startRecruitingButton,11,-11);
         AlignmentUtil.alignRightOf(_instantRecruitButton,_startRecruitingButton,18);
         AlignmentUtil.alignRightOf(_finishNowButton,_stopButton,18);
      }
      
      public function fillUnits(param1:Vector.<UnitTypeDIO>) : void
      {
         var _loc3_:RecruitmentChamberMercenaryListView = null;
         var _loc2_:int = 0;
         _recruitmentChamberMercenaryListViews = new Dictionary();
         for each(var _loc4_ in param1)
         {
            _loc3_ = new RecruitmentChamberMercenaryListView(_loc4_,_loc2_);
            _recruitmentChamberMercenaryListViews[_loc2_] = _loc3_;
            _loc3_.visible = false;
            addChild(_loc3_);
            _loc2_++;
         }
      }
      
      public function updateUnits(param1:Dictionary) : void
      {
         var _loc2_:UnitTypeInfo = null;
         var _loc5_:int = 0;
         allRecruitsDone = true;
         _currentlyRecruiting = false;
         _currentlyRecruitingUnitTypeId = -1;
         for(var _loc3_ in param1)
         {
            _loc2_ = param1[_loc3_];
            updateUnitView(_loc2_);
            if(allRecruitsDone)
            {
               allRecruitsDone = _loc2_.recruited;
            }
            if(!_currentlyRecruiting)
            {
               _currentlyRecruiting = _loc2_.currentlyRecruiting;
            }
            if(_loc2_.currentlyRecruiting)
            {
               _currentlyRecruitingUnitTypeId = _loc2_.unitTypeId;
            }
         }
         if(_initialPageIndex == -1)
         {
            if(_currentlyRecruiting)
            {
               _loc5_ = 0;
               for each(var _loc4_ in _recruitmentChamberMercenaryListViews)
               {
                  if(_loc4_.unitTypeDIO.id == _currentlyRecruitingUnitTypeId)
                  {
                     _initialPageIndex = _loc5_ / 4;
                     _initialUnitTypeId = _currentlyRecruitingUnitTypeId;
                     break;
                  }
                  _loc5_++;
               }
            }
            else
            {
               _loc5_ = 0;
               for each(_loc4_ in _recruitmentChamberMercenaryListViews)
               {
                  if(!_loc4_.unitTypeInfo.recruited)
                  {
                     _initialPageIndex = _loc5_ / 4;
                     _initialUnitTypeId = _loc4_.unitTypeInfo.unitTypeId;
                     break;
                  }
                  _loc5_++;
               }
            }
         }
         if(_initialPageIndex == -1)
         {
            _initialPageIndex = 0;
            _initialUnitTypeId = (_recruitmentChamberMercenaryListViews[0] as RecruitmentChamberMercenaryListView).unitTypeDIO.id;
         }
      }
      
      private function updateUnitView(param1:UnitTypeInfo) : void
      {
         var _loc2_:UnitTypeDIO = null;
         for each(var _loc3_ in _recruitmentChamberMercenaryListViews)
         {
            if(_loc3_.unitTypeDIO.id == param1.unitTypeId)
            {
               _loc2_ = _loc3_.unitTypeDIO;
               _recruitmentChamberMercenaryListViews[_loc3_.index].updateUnit(param1);
               speedProgressBar.maximum = _loc2_.speed(param1.currentLevel - 1);
               healthProgressBar.maximum = _loc2_.healthPointsPerLevel[param1.currentLevel - 1];
               damageProgressBar.maximum = _loc2_.damage(param1.currentLevel - 1);
               break;
            }
         }
      }
      
      public function openPage(param1:int) : void
      {
         if(param1 == -1)
         {
            param1 = 0;
         }
         var _loc3_:int = 0;
         for each(var _loc2_ in _recruitmentChamberMercenaryListViews)
         {
            _loc2_.visible = _loc3_ >= param1 * 4 && _loc3_ < (param1 + 1) * 4;
            _loc3_++;
         }
         _mercenaryListPreviousButton.enabled = param1 != 0;
         _mercenaryListNextButton.enabled = param1 < int(lengthOf(_recruitmentChamberMercenaryListViews) / 4);
         _currentPageIndex = param1;
         selectMercenary(_recruitmentChamberMercenaryListViews[param1 * 4].unitTypeDIO,_recruitmentChamberMercenaryListViews[param1 * 4].unitTypeInfo);
      }
      
      public function reselectCurrentMercenary() : void
      {
         for each(var _loc1_ in _recruitmentChamberMercenaryListViews)
         {
            if(_loc1_.unitTypeInfo.unitTypeId == _selectedUnitTypeId)
            {
               selectMercenary(_loc1_.unitTypeDIO,_loc1_.unitTypeInfo);
               break;
            }
         }
      }
      
      public function get mercenaryListNextButton() : Button
      {
         return _mercenaryListNextButton;
      }
      
      public function get mercenaryListPreviousButton() : Button
      {
         return _mercenaryListPreviousButton;
      }
      
      public function get currentPageIndex() : int
      {
         return _currentPageIndex;
      }
      
      public function get recruitmentChamberMercenaryListViews() : Dictionary
      {
         return _recruitmentChamberMercenaryListViews;
      }
      
      public function selectMercenary(param1:UnitTypeDIO, param2:UnitTypeInfo) : void
      {
         var _loc13_:int = 0;
         removeChild(mercenaryPicture);
         mercenaryPicture = assetRepository.getDisplayObject(param1.assetName + "Large");
         addChildAt(mercenaryPicture,getChildIndex(recruitingMask) - 1);
         var _temp_2:* = damageLabel;
         var _loc14_:String = "ui.windows.recruitmentchamber." + (param1.healer ? "heal" : "damage");
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc14_);
         _selectedUnitTypeId = param1.id;
         _selectedUnitTypeInfo = param2;
         var _temp_5:* = mercenaryNameTextField;
         var _loc15_:String = "domain.units." + param1.id + ".name";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc15_) + ":";
         var _temp_6:* = mercenaryDescriptionTextField;
         var _loc16_:String = "domain.units." + param1.id + ".desc";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc16_);
         favoriteTargetsTextField.text = "";
         if(param1.healer)
         {
            var _temp_7:* = favoriteTargetsTextField;
            var _loc17_:String = "ui.windows.recruitmentchamber.healer";
            _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc17_);
         }
         else if(param1.targetsAnything)
         {
            var _temp_8:* = favoriteTargetsTextField;
            var _loc18_:String = "ui.windows.recruitmentchamber.anything";
            _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc18_);
         }
         else
         {
            _loc13_ = 0;
            while(_loc13_ < param1.favouriteTargets.length)
            {
               if(favoriteTargetsTextField.text != "")
               {
                  favoriteTargetsTextField.appendText(", ");
               }
               var _temp_9:* = favoriteTargetsTextField;
               var _loc19_:String = "domain.buildingkinds." + param1.favouriteTargets[_loc13_] + ".name";
               _temp_9.appendText(peak.i18n.PText.INSTANCE.getText0(_loc19_));
               _loc13_++;
            }
         }
         var _loc9_:int = param2.currentLevel - 1;
         var _loc7_:Number = param1.speed(_loc9_);
         var _loc12_:int = param1.healthPointsPerLevel[_loc9_];
         var _loc11_:int = param1.damage(_loc9_);
         var _loc6_:Number = param1.hiringCostsPerLevel[_loc9_][0].resourceAmount;
         var _loc10_:Number = param1.unlockCost.resourceAmount;
         var _loc5_:int = param1.spacesPerLevel[_loc9_];
         var _loc8_:Number = param1.hiringDurationPerLevelInSecs[_loc9_] / _serverSpeed;
         var _loc3_:Number = param1.unlockDurationInSecs / _serverSpeed;
         var _loc4_:int = param1.unlockPrerequisite.level;
         TweenLite.to(speedProgressBar,0.2,{"value":_loc7_});
         TweenLite.to(healthProgressBar,0.2,{"value":_loc12_});
         TweenLite.to(damageProgressBar,0.2,{"value":_loc11_});
         var _temp_11:* = speedTextField;
         var _temp_10:* = _loc7_ + " ";
         var _loc20_:String = "ui.windows.recruitmentchamber.kph";
         _temp_11.text = _temp_10 + peak.i18n.PText.INSTANCE.getText0(_loc20_);
         healthTextField.text = _loc12_ + "";
         damageTextField.text = _loc11_ + "";
         recruitCostView.label = NumberUtil.format(_loc10_);
         hireCostView.label = NumberUtil.format(_loc6_);
         var _temp_13:* = housingSpaceView;
         var _temp_12:* = _loc5_ + " ";
         var _loc21_:String = "ui.windows.recruitmentchamber.spaces";
         _temp_13.label = _temp_12 + peak.i18n.PText.INSTANCE.getText0(_loc21_);
         chamberLevelTextField.text = _loc4_ + "";
         recruitTimeView.label = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc3_);
         hireTimeView.label = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc8_);
         progressTextField.visible = clockIcon.visible = recruitingMask.visible = param2.currentlyRecruiting;
         onceUnlockedTextField.visible = param2.currentlyRecruiting;
         _finishNowButton.visible = param2.currentlyRecruiting;
         _stopButton.visible = param2.currentlyRecruiting;
         unlockingLabel.visible = param2.currentlyRecruiting;
         speedupExplanationTextField.visible = param2.currentlyRecruiting;
         _shortenWithRPButton.visible = param2.currentlyRecruiting;
         _unlockedButton.visible = param2.recruited;
         productionStatsTextField.visible = hireTimeView.visible = housingSpaceView.visible = hireCostView.visible = param2.recruited || param2.currentlyRecruiting;
         recruitmentCostsTextField.visible = !param2.recruited && !param2.currentlyRecruiting;
         lockIcon.visible = chamberLevelTextField.visible = chamberLevelView.visible = recruitCostView.visible = recruitTimeView.visible = !param2.recruited && !param2.currentlyRecruiting;
         _instantRecruitButton.visible = _startRecruitingButton.visible = orIcon.visible = !param2.recruited && !param2.currentlyRecruiting;
         orIcon.visible ||= _stopButton.visible;
         mercenaryPicture.alpha = !param2.recruited && !param2.currentlyRecruiting ? 0.5 : 1;
         if(!param2.recruited && !param2.currentlyRecruiting)
         {
            _instantRecruitButton.rightLabel = StoreUtil.mercenaryTrainAndRecruitPrice(_loc10_,_loc3_) + "";
         }
         dispatchEvent(new RecruitmentChamberMercenaryEvent("recruitmentChamberMercenarySelected",param2.unitTypeId));
         drawLayout();
      }
      
      public function get startRecruitingButton() : WomButton
      {
         return _startRecruitingButton;
      }
      
      public function get instantRecruitButton() : WomButton
      {
         return _instantRecruitButton;
      }
      
      public function get finishNowButton() : WomButton
      {
         return _finishNowButton;
      }
      
      public function get stopButton() : WomButton
      {
         return _stopButton;
      }
      
      public function get currentlyRecruiting() : Boolean
      {
         return _currentlyRecruiting;
      }
      
      public function get selectedUnitTypeId() : int
      {
         return _selectedUnitTypeId;
      }
      
      public function set currentPageIndex(param1:int) : void
      {
         _currentPageIndex = param1;
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
      
      public function get initialPageIndex() : int
      {
         return _initialPageIndex;
      }
      
      public function get initialUnitTypeId() : int
      {
         return _initialUnitTypeId;
      }
      
      public function get selectedUnitTypeInfo() : UnitTypeInfo
      {
         return _selectedUnitTypeInfo;
      }
      
      public function set initialUnitTypeId(param1:int) : void
      {
         _initialUnitTypeId = param1;
      }
      
      public function get shortenWithRPButton() : WomButton
      {
         return _shortenWithRPButton;
      }
      
      public function updateProgress(param1:Number, param2:Number) : void
      {
         progressTextField.text = param1 > 86400000 ? LocalizedDateTimeUtil.getUserFriendlyTimeWithoutSeconds(param1) : LocalizedDateTimeUtil.getUserFriendlyTime(param1);
         progressMask.graphics.clear();
         progressMask.graphics.beginFill(0);
         progressMask.graphics.drawRect(0,0,recruitingMask.width,int(recruitingMask.height * param1 / param2));
         AlignmentUtil.alignAccordingToPositionOf(progressMask,recruitingMask,0,recruitingMask.height - progressMask.height);
      }
   }
}

