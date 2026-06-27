package wom.view.screen.windows.recruitmentchamber
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
   
   public class MobileRecruitmentChamberItemView extends Sprite implements View
   {
      
      private static const WIDTH:int = 344;
      
      private static const HEIGHT:int = 502;
      
      private var background:DisplayObject;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _mercenarData:Object;
      
      private var unitTypeDIO:UnitTypeDIO;
      
      private var mercenaryNameTextField:MPTextField;
      
      private var mercenaryAsset:DisplayObject;
      
      private var lockIcon:DisplayObject;
      
      private var recruitCostView:MobileIconLabelViewExtra;
      
      private var chamberLevelView:MobileIconLabelViewExtra;
      
      private var chamberLevelTextField:MPTextField;
      
      private var recruitTimeView:MobileIconLabelViewExtra;
      
      private var unitTypeInfo:UnitTypeInfo;
      
      private var serverSpeed:int;
      
      private var hireCostView:MobileIconLabelViewExtra;
      
      private var housingSpaceView:MobileIconLabelViewExtra;
      
      private var hireTimeView:MobileIconLabelViewExtra;
      
      private var recruitingMask:Shape;
      
      private var recruitingProgressBar:MobileWomProgressBar;
      
      private var recruitingTimeIcon:DisplayObject;
      
      private var _hintButton:MPRigidButton;
      
      private var chamberLevel:int;
      
      private var cityMightAmount:Number;
      
      public function MobileRecruitmentChamberItemView(param1:MobileWomAssetRepository)
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
         background.y = 11;
         background.x = 7;
         addChild(background);
         recruitingMask = new Shape();
         recruitingMask.visible = false;
         recruitingMask.alpha = 0.5;
         recruitingMask.graphics.beginFill(0);
         recruitingMask.graphics.drawRoundRect(0,11,344,502,18);
         recruitingMask.graphics.endFill();
         addChild(recruitingMask);
         recruitingProgressBar = MobileWomUIComponentFactory.createProgressBar("Green");
         recruitingProgressBar.width = 233;
         recruitingProgressBar.height = 33;
         recruitingProgressBar.minimum = 0;
         recruitingProgressBar.align = "center";
         addChild(recruitingProgressBar);
         recruitingTimeIcon = assetRepository.getDisplayObject("IconTimerM");
         addChild(recruitingTimeIcon);
         mercenaryNameTextField = new MobileCaptionTextField();
         mercenaryNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(33,"center");
         mercenaryNameTextField.width = 344 - 80;
         addChild(mercenaryNameTextField);
         lockIcon = assetRepository.getDisplayObject("IconLockMBordered");
         lockIcon.visible = false;
         addChild(lockIcon);
         hireCostView = new MobileIconLabelViewExtra("IconIronMBordered"," ");
         hireCostView.textMarginFromIconY = 61;
         addChild(hireCostView);
         housingSpaceView = new MobileIconLabelViewExtra("IconSpace"," ");
         housingSpaceView.textMarginFromIconY = 61;
         addChild(housingSpaceView);
         hireTimeView = new MobileIconLabelViewExtra("IconTimerM"," ");
         hireTimeView.textMarginFromIconY = 61;
         addChild(hireTimeView);
         recruitCostView = new MobileIconLabelViewExtra("IconMightMBordered"," ");
         recruitCostView.textMarginFromIconY = 61;
         addChild(recruitCostView);
         var _temp_12:* = §§findproperty(MobileIconLabelViewExtra);
         var _temp_11:* = "IconUpgradeM";
         var _loc1_:String = "ui.windows.recruitmentchamber.chamberlevel";
         chamberLevelView = new MobileIconLabelViewExtra(_temp_11,peak.i18n.PText.INSTANCE.getText0(_loc1_));
         chamberLevelView.textMarginFromIconY = 61;
         addChild(chamberLevelView);
         recruitTimeView = new MobileIconLabelViewExtra("IconTimerM"," ");
         recruitTimeView.textMarginFromIconY = 61;
         addChild(recruitTimeView);
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
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,background,295,10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(mercenaryNameTextField,background,-10);
         MobileAlignmentUtil.alignMiddleOf(mercenaryAsset,background);
         MobileAlignmentUtil.alignAccordingToPositionOf(recruitCostView,background,54,388);
         MobileAlignmentUtil.alignAccordingToPositionOf(hireCostView,background,54,388);
         MobileAlignmentUtil.alignAccordingToPositionOf(recruitTimeView,background,150,388);
         MobileAlignmentUtil.alignAccordingToPositionOf(hireTimeView,background,150,388);
         MobileAlignmentUtil.alignAccordingToPositionOf(chamberLevelView,background,240,388);
         MobileAlignmentUtil.alignAccordingToPositionOf(housingSpaceView,background,240,388);
         MobileAlignmentUtil.alignMiddleOf(lockIcon,background);
         MobileAlignmentUtil.alignAccordingToPositionOf(chamberLevelTextField,chamberLevelView,(chamberLevelView.width - chamberLevelTextField.width >> 1) - 1,27);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(recruitingProgressBar,background,322);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(recruitingTimeIcon,recruitingProgressBar,-(recruitingTimeIcon.width >> 1));
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
            serverSpeed = param1.serverSpeed;
            unitTypeInfo = param1.unitTypeInfo;
            chamberLevel = param1.chamberLevel;
            cityMightAmount = param1.cityMightAmount;
         }
      }
      
      public function updateMercenaryData(param1:Object) : void
      {
         var _loc8_:Number = NaN;
         this.data = param1;
         clearUnit();
         mercenaryAsset = assetRepository.getDisplayObject(unitTypeDIO.assetName);
         addChildAt(mercenaryAsset,1);
         var _temp_2:* = mercenaryNameTextField;
         var _loc10_:String = "domain.units." + unitTypeDIO.id + ".name";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         mercenaryAsset.alpha = !unitTypeInfo.recruited && !unitTypeInfo.currentlyRecruiting ? 0.5 : 1;
         recruitingMask.alpha = !unitTypeInfo.recruited && !unitTypeInfo.currentlyRecruiting ? 0.5 : 0;
         var _loc6_:int = unitTypeInfo.currentLevel - 1;
         var _loc7_:Number = unitTypeDIO.unlockCost.resourceAmount;
         var _loc2_:Number = unitTypeDIO.unlockDurationInSecs / serverSpeed;
         var _loc9_:int = unitTypeDIO.unlockPrerequisite.level;
         var _loc4_:int = unitTypeDIO.spacesPerLevel[_loc6_];
         var _loc5_:Number = unitTypeDIO.hiringDurationPerLevelInSecs[_loc6_] / serverSpeed;
         var _loc3_:Number = unitTypeDIO.hiringCostsPerLevel[_loc6_][0].resourceAmount;
         recruitCostView.label = NumberUtil.format(_loc7_);
         recruitCostView.updateTextFormatRed(cityMightAmount < _loc7_);
         chamberLevelTextField.text = _loc9_ + "";
         chamberLevelView.updateTextFormatRed(chamberLevel < _loc9_);
         recruitTimeView.label = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc2_);
         recruitingProgressBar.maximum = unitTypeDIO.unlockDurationInSecs;
         hireCostView.label = NumberUtil.format(_loc3_);
         var _temp_6:* = housingSpaceView;
         var _temp_5:* = _loc4_ + " ";
         var _loc11_:String = "ui.windows.recruitmentchamber.spaces";
         _temp_6.label = _temp_5 + peak.i18n.PText.INSTANCE.getText0(_loc11_);
         hireTimeView.label = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc5_);
         lockIcon.visible = chamberLevelTextField.visible = chamberLevelView.visible = recruitCostView.visible = recruitTimeView.visible = !unitTypeInfo.recruited && !unitTypeInfo.currentlyRecruiting;
         hireTimeView.visible = housingSpaceView.visible = hireCostView.visible = unitTypeInfo.recruited || unitTypeInfo.currentlyRecruiting;
         recruitingProgressBar.visible = recruitingTimeIcon.visible = unitTypeInfo.currentlyRecruiting;
         if(unitTypeInfo.currentlyRecruiting)
         {
            _loc8_ = unitTypeInfo.jobCreationTime + unitTypeInfo.durationRemaining - new Date().getTime();
            updateProgress(_loc8_,unitTypeInfo.originalDuration);
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
         (this.parent as MobileRecruitmentChamberItemViewRenderer).onHintButtonClicked();
      }
      
      public function updateProgress(param1:Number, param2:Number) : void
      {
         recruitingProgressBar.label = param1 > 86400000 ? LocalizedDateTimeUtil.getUserFriendlyTimeWithoutSeconds(param1) : LocalizedDateTimeUtil.getUserFriendlyTime(param1);
         recruitingProgressBar.value = unitTypeDIO.unlockDurationInSecs - param1 / 1000;
      }
   }
}

