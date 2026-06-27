package wom.view.screen.windows.trainingchamber
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Shape;
   import starling.display.Sprite;
   import starling.events.Event;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileIconLabelViewExtra;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileTrainingChamberItemView extends Sprite implements View
   {
      
      private static const WIDTH:int = 344;
      
      private static const HEIGHT:int = 502;
      
      private var background:DisplayObject;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _mercenarData:Object;
      
      private var unitTypeDIO:UnitTypeDIO;
      
      private var mercenaryNameTextField:MPTextField;
      
      private var mercenaryAsset:DisplayObject;
      
      private var _isEventItemUnlocked:Boolean = false;
      
      private var lockIcon:DisplayObject;
      
      private var trainCostView:MobileIconLabelViewExtra;
      
      private var trainTimeView:MobileIconLabelViewExtra;
      
      private var chamberLevelView:MobileIconLabelViewExtra;
      
      private var chamberLevelTextField:MPTextField;
      
      private var unitTypeInfo:UnitTypeInfo;
      
      private var trainingMask:Shape;
      
      private var trainingProgressBar:MobileWomProgressBar;
      
      private var trainingTimeIcon:DisplayObject;
      
      private var _hintButton:MPRigidButton;
      
      private var levelShield:DisplayObject;
      
      private var levelInfoTextField:MobileCaptionTextField;
      
      private var mercenaryLevelTextField:MobileCaptionTextField;
      
      private var chamberLevel:int;
      
      private var cityMightAmount:Number;
      
      public function MobileTrainingChamberItemView(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileBeigeBackground");
         background.width = 344;
         background.height = 502;
         background.x = 7;
         background.y = 11;
         addChild(background);
         levelShield = assetRepository.getDisplayObject("IconLevelBeastMBordered");
         addChild(levelShield);
         levelInfoTextField = new MobileCaptionTextField();
         levelInfoTextField.textRendererProperties.textFormat = getCaptionTextFormat(27);
         addChild(levelInfoTextField);
         trainingMask = new Shape();
         trainingMask.visible = false;
         trainingMask.alpha = 0.5;
         trainingMask.graphics.beginFill(0);
         trainingMask.graphics.drawRoundRect(0,11,344,502,18);
         trainingMask.graphics.endFill();
         addChild(trainingMask);
         trainingProgressBar = MobileWomUIComponentFactory.createProgressBar("Green");
         trainingProgressBar.width = 233;
         trainingProgressBar.height = 33;
         trainingProgressBar.minimum = 0;
         trainingProgressBar.align = "center";
         addChild(trainingProgressBar);
         trainingTimeIcon = assetRepository.getDisplayObject("IconTimerM");
         addChild(trainingTimeIcon);
         mercenaryNameTextField = new MobileCaptionTextField();
         mercenaryNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(33,"center");
         mercenaryNameTextField.width = 344 - 80;
         addChild(mercenaryNameTextField);
         mercenaryLevelTextField = new MobileCaptionTextField();
         mercenaryLevelTextField.textRendererProperties.textFormat = getCaptionTextFormat(30,"center");
         mercenaryLevelTextField.width = 344 - 80;
         addChild(mercenaryLevelTextField);
         lockIcon = assetRepository.getDisplayObject("IconLockMBordered");
         lockIcon.visible = false;
         addChild(lockIcon);
         trainCostView = new MobileIconLabelViewExtra("IconMightMBordered"," ");
         trainCostView.textMarginFromIconY = 61;
         addChild(trainCostView);
         var _temp_12:* = §§findproperty(MobileIconLabelViewExtra);
         var _temp_11:* = "IconUpgradeM";
         var _loc1_:String = "ui.windows.recruitmentchamber.chamberlevel";
         chamberLevelView = new MobileIconLabelViewExtra(_temp_11,peak.i18n.PText.INSTANCE.getText0(_loc1_));
         chamberLevelView.textMarginFromIconY = 61;
         addChild(chamberLevelView);
         trainTimeView = new MobileIconLabelViewExtra("IconTimerM"," ");
         trainTimeView.textMarginFromIconY = 61;
         addChild(trainTimeView);
         chamberLevelTextField = new MobileCaptionTextField();
         chamberLevelTextField.width = 92;
         chamberLevelTextField.textRendererProperties.textFormat = getCaptionTextFormat(21,"center");
         addChild(chamberLevelTextField);
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _hintButton.addEventListener("triggered",onHintButtonClicked);
         addChild(_hintButton);
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(levelShield,background,10,11);
         MobileAlignmentUtil.alignAccordingToPositionOf(levelInfoTextField,levelShield,20,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,background,295,10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(mercenaryNameTextField,background,-10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(mercenaryLevelTextField,background,10);
         MobileAlignmentUtil.alignMiddleOf(mercenaryAsset,background);
         MobileAlignmentUtil.alignAccordingToPositionOf(trainCostView,background,54,388);
         MobileAlignmentUtil.alignAccordingToPositionOf(trainTimeView,background,150,388);
         MobileAlignmentUtil.alignAccordingToPositionOf(chamberLevelView,background,240,388);
         MobileAlignmentUtil.alignMiddleOf(lockIcon,background);
         MobileAlignmentUtil.alignAccordingToPositionOf(chamberLevelTextField,chamberLevelView,(chamberLevelView.width - chamberLevelTextField.width >> 1) - 1,27);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(trainingProgressBar,background,322);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(trainingTimeIcon,trainingProgressBar,-(trainingTimeIcon.width >> 1));
      }
      
      public function get data() : Object
      {
         return _mercenarData;
      }
      
      public function set data(param1:Object) : void
      {
         if(param1)
         {
            _mercenarData = param1;
            unitTypeDIO = param1.unitTypeDIO;
            unitTypeInfo = param1.unitTypeInfo;
            chamberLevel = param1.chamberLevel;
            cityMightAmount = param1.cityMightAmount;
            _isEventItemUnlocked = "isEventItemUnlocked" in param1 ? param1.isEventItemUnlocked : false;
         }
      }
      
      public function updateMercenaryData(param1:Object) : void
      {
         var _loc5_:Number = NaN;
         this.data = param1;
         clearUnit();
         mercenaryAsset = assetRepository.getDisplayObject(unitTypeDIO.assetName);
         addChildAt(mercenaryAsset,1);
         var _loc3_:int = int(unitTypeInfo.currentLevel == unitTypeDIO.maxLevels ? unitTypeInfo.currentLevel - 1 : unitTypeInfo.currentLevel);
         var _temp_2:* = mercenaryNameTextField;
         var _loc7_:String = "domain.units." + unitTypeDIO.id + ".name";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         levelInfoTextField.text = unitTypeInfo.currentLevel.toString();
         var _temp_4:* = mercenaryLevelTextField;
         var _temp_3:* = "ui.windows.beast.keeper.level";
         var _loc8_:int = unitTypeInfo.currentLevel;
         var _loc9_:String = _temp_3;
         _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc9_,_loc8_);
         var _loc4_:Boolean = !unitTypeDIO.event && !unitTypeInfo.recruited || unitTypeDIO.event && !_isEventItemUnlocked || unitTypeInfo.currentlyTraining;
         mercenaryAsset.alpha = _loc4_ ? 0.5 : 1;
         trainingMask.alpha = _loc4_ ? 0.5 : 0;
         var _loc2_:Number = unitTypeDIO.trainingCostsPerLevel[_loc3_][0].resourceAmount;
         var _loc6_:int = unitTypeDIO.trainingPrerequisitesPerLevel[_loc3_].level;
         trainCostView.label = NumberUtil.format(_loc2_);
         trainCostView.updateTextFormatRed(cityMightAmount < _loc2_);
         chamberLevelTextField.text = _loc6_ + "";
         chamberLevelView.updateTextFormatRed(chamberLevel < _loc6_);
         trainTimeView.label = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(unitTypeDIO.trainingDurationPerLevelInSecs[_loc3_]);
         trainingProgressBar.maximum = unitTypeDIO.trainingDurationPerLevelInSecs[_loc3_];
         lockIcon.visible = !unitTypeDIO.event && !unitTypeInfo.recruited || unitTypeDIO.event && !_isEventItemUnlocked;
         trainCostView.visible = trainTimeView.visible = chamberLevelView.visible = chamberLevelTextField.visible = unitTypeInfo.currentLevel != unitTypeDIO.maxLevels && !unitTypeInfo.currentlyTraining;
         trainingProgressBar.visible = trainingTimeIcon.visible = unitTypeInfo.currentlyTraining;
         if(unitTypeInfo.currentlyTraining)
         {
            _loc5_ = unitTypeInfo.jobCreationTime + unitTypeInfo.durationRemaining - new Date().getTime();
            updateProgress(_loc5_,unitTypeInfo.originalDuration);
         }
         drawLayout();
      }
      
      private function clearUnit() : void
      {
         if(mercenaryAsset)
         {
            if(contains(mercenaryAsset))
            {
               removeChild(mercenaryAsset);
            }
         }
      }
      
      private function onHintButtonClicked(param1:Event) : void
      {
         (this.parent as MobileTrainingChamberItemViewRenderer).onHintButtonClicked();
      }
      
      public function updateProgress(param1:Number, param2:Number) : void
      {
         trainingProgressBar.label = param1 > 86400000 ? LocalizedDateTimeUtil.getUserFriendlyTimeWithoutSeconds(param1) : LocalizedDateTimeUtil.getUserFriendlyTime(param1);
         trainingProgressBar.value = trainingProgressBar.maximum - param1 / 1000;
      }
   }
}

