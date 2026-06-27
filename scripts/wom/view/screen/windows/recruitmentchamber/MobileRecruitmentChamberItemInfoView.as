package wom.view.screen.windows.recruitmentchamber
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileRecruitmentChamberItemInfoView extends Sprite implements View
   {
      
      private static const WIDTH:int = 344;
      
      private static const HEIGHT:int = 502;
      
      private static const PROGRESSBAR_WIDTH_NORMAL:int = 220;
      
      private static const PROGRESSBAR_HEIGHT:int = 36;
      
      private static const PROGRESSBAR_X_MARGIN:int = 8;
      
      private var background:DisplayObject;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var mercenarData:Object;
      
      private var unitTypeDIO:UnitTypeDIO;
      
      private var damageProgressBar:MobileWomProgressBar;
      
      private var damageTextField:MPTextField;
      
      private var healthProgressBar:MobileWomProgressBar;
      
      private var healthTextField:MPTextField;
      
      private var speedProgressBar:MobileWomProgressBar;
      
      private var speedTextField:MPTextField;
      
      private var mercenaryNameTextField:MPTextField;
      
      private var mercenaryDescriptionTextField:MPTextField;
      
      private var favoriteTargetLabel:MPTextField;
      
      private var favoriteTargetTextField:MPTextField;
      
      private var unitTypeInfo:UnitTypeInfo;
      
      private var _hintButton:MPRigidButton;
      
      public function MobileRecruitmentChamberItemInfoView(param1:MobileWomAssetRepository)
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
         mercenaryNameTextField = new MobileCaptionTextField();
         mercenaryNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(33,"center");
         mercenaryNameTextField.width = 344 - 80;
         addChild(mercenaryNameTextField);
         mercenaryDescriptionTextField = new MobileWomTextField();
         mercenaryDescriptionTextField.width = 344 - 80;
         mercenaryDescriptionTextField.textRendererProperties.textFormat = getWomTextFormat(21,"center");
         mercenaryDescriptionTextField.textRendererProperties.wordWrap = true;
         addChild(mercenaryDescriptionTextField);
         speedProgressBar = createProgressBar();
         var _loc1_:String = "ui.windows.recruitmentchamber.speed";
         speedTextField = createProgressBarTextField(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         healthProgressBar = createProgressBar();
         var _loc2_:String = "ui.windows.recruitmentchamber.health";
         healthTextField = createProgressBarTextField(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         damageProgressBar = createProgressBar();
         damageTextField = createProgressBarTextField(" ");
         favoriteTargetLabel = new MobileCaptionTextField();
         favoriteTargetLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(favoriteTargetLabel);
         favoriteTargetTextField = new MobileWomTextField();
         favoriteTargetTextField.width = 170;
         favoriteTargetTextField.textRendererProperties.wordWrap = true;
         favoriteTargetTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         addChild(favoriteTargetTextField);
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _hintButton.setPaddings(10,10,10,10);
         _hintButton.addEventListener("triggered",onHintButtonClicked);
         addChild(_hintButton);
         drawLayout();
      }
      
      public function updateMercenaryData(param1:Object) : void
      {
         var _loc6_:int = 0;
         this.data = param1;
         var _temp_1:* = mercenaryNameTextField;
         var _loc7_:String = "domain.units." + unitTypeDIO.id + ".name";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         var _temp_2:* = mercenaryDescriptionTextField;
         var _loc8_:String = "domain.units." + unitTypeDIO.id + ".desc";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         var _temp_3:* = favoriteTargetLabel;
         var _loc9_:String = "ui.windows.recruitmentchamber.favoritetargets";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc9_) + ":";
         var _loc3_:int = unitTypeInfo.currentLevel - 1;
         var _loc2_:Number = unitTypeDIO.speed(_loc3_);
         var _loc5_:int = unitTypeDIO.healthPointsPerLevel[_loc3_];
         var _loc4_:int = unitTypeDIO.damage(_loc3_);
         damageProgressBar.maximum = unitTypeDIO.damage(unitTypeInfo.currentLevel - 1);
         damageProgressBar.value = _loc4_;
         damageProgressBar.label = numberFormat(_loc4_);
         healthProgressBar.maximum = unitTypeDIO.healthPointsPerLevel[unitTypeInfo.currentLevel - 1];
         healthProgressBar.value = _loc5_;
         healthProgressBar.label = numberFormat(_loc5_);
         speedProgressBar.maximum = unitTypeDIO.speed(unitTypeInfo.currentLevel - 1);
         speedProgressBar.value = _loc2_;
         var _temp_5:* = speedProgressBar;
         var _temp_4:* = numberFormat(_loc2_) + " ";
         var _loc10_:String = "ui.windows.recruitmentchamber.kph";
         _temp_5.label = _temp_4 + peak.i18n.PText.INSTANCE.getText0(_loc10_);
         var _temp_6:* = damageTextField;
         var _loc11_:String = "ui.windows.recruitmentchamber." + (unitTypeDIO.healer ? "heal" : "damage");
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         favoriteTargetTextField.text = "";
         if(unitTypeDIO.healer)
         {
            var _temp_7:* = favoriteTargetTextField;
            var _loc12_:String = "ui.windows.recruitmentchamber.healer";
            _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc12_);
         }
         else if(unitTypeDIO.targetsAnything)
         {
            var _temp_8:* = favoriteTargetTextField;
            var _loc13_:String = "ui.windows.recruitmentchamber.anything";
            _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc13_);
         }
         else
         {
            _loc6_ = 0;
            while(_loc6_ < unitTypeDIO.favouriteTargets.length)
            {
               if(favoriteTargetTextField.text != "")
               {
                  favoriteTargetTextField.text += ", ";
               }
               var _temp_10:* = favoriteTargetTextField;
               var _temp_9:* = favoriteTargetTextField.text;
               var _loc14_:String = "domain.buildingkinds." + unitTypeDIO.favouriteTargets[_loc6_] + ".name";
               _temp_10.text = _temp_9 + peak.i18n.PText.INSTANCE.getText0(_loc14_);
               _loc6_++;
            }
         }
         drawLayout();
      }
      
      private function numberFormat(param1:Number) : String
      {
         return NumberUtil.numberFormat(param1,2,false,false);
      }
      
      private function createProgressBarTextField(param1:String) : MPTextField
      {
         var _loc2_:MobileWomTextField = new MobileCaptionTextField();
         _loc2_.textRendererProperties.textFormat = getCaptionTextFormat(21);
         _loc2_.width = 60;
         addChild(_loc2_);
         _loc2_.text = param1;
         return _loc2_;
      }
      
      private function createProgressBar(param1:int = 220, param2:String = "Yellow") : MobileWomProgressBar
      {
         var _loc3_:MobileWomProgressBar = MobileWomUIComponentFactory.createProgressBar(param2);
         _loc3_.width = param1;
         _loc3_.height = 36;
         _loc3_.minimum = 0;
         _loc3_.align = "center";
         addChild(_loc3_);
         return _loc3_;
      }
      
      private function onHintButtonClicked(param1:Event) : void
      {
         (this.parent as MobileRecruitmentChamberItemViewRenderer).onHintButtonClicked();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(mercenaryNameTextField,background,-10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,background,295,10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(mercenaryDescriptionTextField,background,47);
         MobileAlignmentUtil.alignAccordingToPositionOf(speedProgressBar,background,95,303);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(speedTextField,speedProgressBar,-(8 + 60));
         MobileAlignmentUtil.alignBelowOf(healthProgressBar,speedProgressBar,10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(healthTextField,healthProgressBar,-(8 + 60));
         MobileAlignmentUtil.alignBelowOf(damageProgressBar,healthProgressBar,10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(damageTextField,damageProgressBar,-(8 + 60));
         MobileAlignmentUtil.alignBelowOf(favoriteTargetLabel,damageTextField,27);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(favoriteTargetTextField,favoriteTargetLabel,favoriteTargetLabel.width + 10);
      }
      
      public function get data() : Object
      {
         return mercenarData;
      }
      
      public function set data(param1:Object) : void
      {
         if(param1)
         {
            mercenarData = param1;
            unitTypeDIO = param1.unitTypeDIO;
            unitTypeInfo = param1.unitTypeInfo;
         }
      }
   }
}

