package wom.view.screen.windows.hiringquarters
{
   import flash.utils.Dictionary;
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileHiringQuartersMercenaryPanel extends Sprite implements View
   {
      
      public static const CENTRAL_HIRING_PANEL:int = 0;
      
      public static const HIRING_PANEL:int = 1;
      
      private static const PANEL_WIDTH:int = 998;
      
      private static const PANEL_HEIGHT:int = 495;
      
      private static const CENTRAL_PANEL_HEIGHT:int = 318;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var _mercenaryViews:Vector.<MobileHiringQuartersMercenaryView>;
      
      private var _mercenaryViewUnitIdMap:Dictionary;
      
      protected var _mercenaryViewHolder:Sprite;
      
      protected var _mercenaryInformationPanel:Sprite;
      
      private var _buildingInstanceId:int;
      
      private var _type:int;
      
      private var mercenaryHugeAsset:DisplayObject;
      
      private var _infoButton:MPRigidButton;
      
      private var mercenaryNameLabel:MPTextField;
      
      private var mercenaryDescriptionTextField:MPTextField;
      
      private var shieldAsset:DisplayObject;
      
      private var levelTextField:MPTextField;
      
      private var speedLabel:MPTextField;
      
      private var speedProgressBar:MobileWomProgressBar;
      
      private var healthLabel:MPTextField;
      
      private var healthProgressBar:MobileWomProgressBar;
      
      private var damageLabel:MPTextField;
      
      private var damageProgressBar:MobileWomProgressBar;
      
      private var favoriteTargetLabel:MPTextField;
      
      private var favoriteTargetsTextField:MPTextField;
      
      private var hireCostAsset:DisplayObject;
      
      private var hireCostTextField:MPTextField;
      
      private var hireTimeAsset:DisplayObject;
      
      private var hireTimeTextField:MPTextField;
      
      private var hireHousingAsset:DisplayObject;
      
      private var housingTextField:MPTextField;
      
      public function MobileHiringQuartersMercenaryPanel(param1:int, param2:MobileWomAssetRepository, param3:int)
      {
         super();
         this.assetRepository = param2;
         _buildingInstanceId = param3;
         _type = param1;
         init();
      }
      
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileBeigeBackground");
         background.width = 998;
         background.height = _type == 1 ? 495 : 318;
         addChild(background);
         _mercenaryViewHolder = new Sprite();
         addChild(_mercenaryViewHolder);
         initMercenaryInformationPanel();
      }
      
      private function initMercenaryInformationPanel() : void
      {
         _mercenaryInformationPanel = new Sprite();
         _mercenaryInformationPanel.visible = false;
         addChild(_mercenaryInformationPanel);
         mercenaryNameLabel = new MobileCaptionTextField();
         mercenaryNameLabel.textRendererProperties.textFormat = getCaptionTextFormat(38);
         _mercenaryInformationPanel.addChild(mercenaryNameLabel);
         mercenaryDescriptionTextField = new MobileWomTextField();
         mercenaryDescriptionTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         mercenaryDescriptionTextField.textRendererProperties.wordWrap = true;
         mercenaryDescriptionTextField.width = 265;
         _mercenaryInformationPanel.addChild(mercenaryDescriptionTextField);
         shieldAsset = assetRepository.getDisplayObject("IconLevelBeastMBordered");
         _mercenaryInformationPanel.addChild(shieldAsset);
         levelTextField = new MobileCaptionTextField();
         levelTextField.textRendererProperties.textFormat = getCaptionTextFormat(25);
         _mercenaryInformationPanel.addChild(levelTextField);
         speedLabel = createLabel("speed");
         healthLabel = createLabel("health");
         damageLabel = createLabel("damage");
         speedProgressBar = createProgressBar();
         healthProgressBar = createProgressBar();
         damageProgressBar = createProgressBar();
         favoriteTargetLabel = new MobileCaptionTextField();
         favoriteTargetLabel.textRendererProperties.textFormat = getCaptionTextFormat(23);
         var _temp_13:* = favoriteTargetLabel;
         var _loc1_:String = "ui.windows.hiringquarters.favoritetargets";
         _temp_13.text = peak.i18n.PText.INSTANCE.getText0(_loc1_) + ":";
         _mercenaryInformationPanel.addChild(favoriteTargetLabel);
         favoriteTargetsTextField = new MobileWomTextField();
         favoriteTargetsTextField.textRendererProperties.textFormat = getWomTextFormat(19);
         favoriteTargetsTextField.textRendererProperties.wordWrap = true;
         favoriteTargetsTextField.width = 160;
         _mercenaryInformationPanel.addChild(favoriteTargetsTextField);
         hireCostAsset = assetRepository.getDisplayObject("IconIronMBordered");
         _mercenaryInformationPanel.addChild(hireCostAsset);
         hireCostTextField = new MobileCaptionTextField();
         hireCostTextField.textRendererProperties.textFormat = getCaptionTextFormat(23);
         _mercenaryInformationPanel.addChild(hireCostTextField);
         hireTimeAsset = assetRepository.getDisplayObject("IconTimerM");
         _mercenaryInformationPanel.addChild(hireTimeAsset);
         hireTimeTextField = new MobileCaptionTextField();
         hireTimeTextField.textRendererProperties.textFormat = getCaptionTextFormat(23);
         _mercenaryInformationPanel.addChild(hireTimeTextField);
         hireHousingAsset = assetRepository.getDisplayObject("IconSpace");
         _mercenaryInformationPanel.addChild(hireHousingAsset);
         housingTextField = new MobileCaptionTextField();
         housingTextField.textRendererProperties.textFormat = getCaptionTextFormat(23);
         _mercenaryInformationPanel.addChild(housingTextField);
         _infoButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _mercenaryInformationPanel.addChild(_infoButton);
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 340;
         if(mercenaryHugeAsset)
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(mercenaryHugeAsset,background,_loc1_ - mercenaryHugeAsset.width >> 1);
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(shieldAsset,background,_loc1_,66);
         MobileAlignmentUtil.alignMiddleOf(levelTextField,shieldAsset);
         MobileAlignmentUtil.alignRightWithYMarginOf(mercenaryNameLabel,shieldAsset,5,5);
         MobileAlignmentUtil.alignBelowWithXMarginOf(mercenaryDescriptionTextField,shieldAsset,5,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(speedLabel,background,672,128);
         MobileAlignmentUtil.alignRightOf(speedProgressBar,speedLabel,100 - speedLabel.width);
         MobileAlignmentUtil.alignBelowOf(healthLabel,speedLabel,30);
         MobileAlignmentUtil.alignRightOf(healthProgressBar,healthLabel,100 - healthLabel.width);
         MobileAlignmentUtil.alignBelowOf(damageLabel,healthLabel,30);
         MobileAlignmentUtil.alignRightOf(damageProgressBar,damageLabel,100 - damageLabel.width);
         MobileAlignmentUtil.alignBelowOf(favoriteTargetLabel,damageLabel,30);
         MobileAlignmentUtil.alignRightOf(favoriteTargetsTextField,favoriteTargetLabel,20);
         MobileAlignmentUtil.alignAccordingToPositionOf(hireCostAsset,background,685,350);
         MobileAlignmentUtil.alignBelowWithXMarginOf(hireCostTextField,hireCostAsset,hireCostAsset.width - hireCostTextField.width >> 1);
         MobileAlignmentUtil.alignRightOf(hireTimeAsset,hireCostAsset,40);
         MobileAlignmentUtil.alignBelowWithXMarginOf(hireTimeTextField,hireTimeAsset,hireTimeAsset.width - hireTimeTextField.width >> 1);
         MobileAlignmentUtil.alignRightOf(hireHousingAsset,hireTimeAsset,45);
         MobileAlignmentUtil.alignBelowWithXMarginOf(housingTextField,hireHousingAsset,hireHousingAsset.width - housingTextField.width >> 1);
         MobileAlignmentUtil.alignRightWithYMarginOf(_infoButton,background,15,-_infoButton.width * 2);
      }
      
      private function createLabel(param1:String) : MPTextField
      {
         var _loc2_:MPTextField = new MobileCaptionTextField();
         _loc2_.textRendererProperties.textFormat = getCaptionTextFormat(23);
         var _temp_1:* = _loc2_;
         var _loc3_:String = "ui.windows.hiringquarters." + param1;
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _mercenaryInformationPanel.addChild(_loc2_);
         return _loc2_;
      }
      
      private function createProgressBar() : MobileWomProgressBar
      {
         var _loc1_:MobileWomProgressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         _loc1_.width = 185;
         _loc1_.height = 34;
         _loc1_.minimum = 0;
         _loc1_.align = "center";
         _mercenaryInformationPanel.addChild(_loc1_);
         return _loc1_;
      }
      
      public function fillUnits(param1:Vector.<UnitTypeDIO>) : void
      {
         var _loc3_:MobileHiringQuartersMercenaryView = null;
         _mercenaryViews = new Vector.<MobileHiringQuartersMercenaryView>();
         _mercenaryViewUnitIdMap = new Dictionary();
         for each(var _loc2_ in param1)
         {
            _loc3_ = new MobileHiringQuartersMercenaryView(_loc2_.id,_buildingInstanceId,2);
            _mercenaryViews.push(_loc3_);
            _mercenaryViewUnitIdMap[_loc2_.id] = _loc3_;
            _mercenaryViewHolder.addChild(_loc3_);
         }
         if(_type == 1)
         {
            drawUnitsHiringPanel();
         }
         else if(_type == 0)
         {
            drawUnitsCentralHiringPanel();
         }
      }
      
      private function drawUnitsHiringPanel() : void
      {
         var _loc1_:int = 0;
         if(_mercenaryViews == null)
         {
            return;
         }
         if(_mercenaryViews.length > 0)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_mercenaryViews[0],background,175,55);
         }
         _loc1_ = 1;
         while(_loc1_ < _mercenaryViews.length)
         {
            if(_loc1_ % 5 == 0)
            {
               MobileAlignmentUtil.alignHeightSpecifiedBelowOf(_mercenaryViews[_loc1_],_mercenaryViews[_loc1_ - 5],25,_mercenaryViews[_loc1_ - 5].visibleHeight);
            }
            else
            {
               MobileAlignmentUtil.alignWidthSpecifiedRightOf(_mercenaryViews[_loc1_],_mercenaryViews[_loc1_ - 1],46,_mercenaryViews[_loc1_ - 1].visibleWidth);
            }
            _loc1_++;
         }
      }
      
      private function drawUnitsCentralHiringPanel() : void
      {
         var _loc1_:int = 0;
         if(_mercenaryViews == null)
         {
            return;
         }
         if(_mercenaryViews.length > 0)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_mercenaryViews[0],background,33,38);
            MobileAlignmentUtil.alignAccordingToPositionOf(_mercenaryViews[8],background,96,167);
         }
         _loc1_ = 1;
         while(_loc1_ < _mercenaryViews.length)
         {
            if(_loc1_ < 8)
            {
               MobileAlignmentUtil.alignWidthSpecifiedRightOf(_mercenaryViews[_loc1_],_mercenaryViews[_loc1_ - 1],26,_mercenaryViews[_loc1_ - 1].visibleWidth);
            }
            else if(_loc1_ > 8)
            {
               MobileAlignmentUtil.alignWidthSpecifiedRightOf(_mercenaryViews[_loc1_],_mercenaryViews[_loc1_ - 1],26,_mercenaryViews[_loc1_ - 1].visibleWidth);
            }
            _loc1_++;
         }
      }
      
      public function get mercenaryViews() : Vector.<MobileHiringQuartersMercenaryView>
      {
         return _mercenaryViews;
      }
      
      public function updateUnits(param1:Dictionary) : void
      {
         var _loc6_:UnitTypeInfo = null;
         var _loc4_:int = 0;
         var _loc3_:UnitTypeDIO = null;
         var _loc5_:int = 0;
         var _loc2_:Number = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         for(var _loc7_ in param1)
         {
            _loc6_ = param1[_loc7_];
            _loc4_ = getMercenaryIndexById(_loc6_.unitTypeId);
            if(_loc4_ != -1)
            {
               _loc3_ = _mercenaryViews[_loc4_].unitTypeDIO;
               _mercenaryViews[_loc4_].updateUnit(_loc6_);
               _loc5_ = _loc6_.currentLevel;
               if(_loc5_ != 0)
               {
                  _loc5_--;
               }
               if(_loc2_ < _loc3_.speed(_loc5_))
               {
                  _loc2_ = _loc3_.speed(_loc5_);
               }
               if(_loc8_ < _loc3_.healthPointsPerLevel[_loc5_])
               {
                  _loc8_ = _loc3_.healthPointsPerLevel[_loc5_];
               }
               if(_loc9_ < _loc3_.damage(_loc5_))
               {
                  _loc9_ = _loc3_.damage(_loc5_);
               }
            }
         }
         speedProgressBar.maximum = _loc2_;
         healthProgressBar.maximum = _loc8_;
         damageProgressBar.maximum = _loc9_;
      }
      
      public function loadMercenaryData(param1:UnitTypeDIO, param2:UnitTypeInfo) : void
      {
         var _loc10_:int = 0;
         showMercenaryInfoPanel();
         if(mercenaryHugeAsset)
         {
            _mercenaryInformationPanel.removeChild(mercenaryHugeAsset);
            mercenaryHugeAsset = null;
         }
         mercenaryHugeAsset = assetRepository.getDisplayObject(param1.assetName);
         _mercenaryInformationPanel.addChildAt(mercenaryHugeAsset,getChildIndex(background) + 1);
         var _temp_3:* = damageLabel;
         var _loc11_:String = "ui.windows.hiringquarters." + (param1.healer ? "heal" : "damage");
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         levelTextField.text = param2.currentLevel + "";
         var _loc7_:int = param2.currentLevel - 1;
         var _loc5_:Number = param1.speed(_loc7_);
         var _loc9_:int = param1.healthPointsPerLevel[_loc7_];
         var _loc8_:int = param1.damage(_loc7_);
         var _loc4_:Number = param1.hiringCostsPerLevel[_loc7_][0].resourceAmount;
         var _loc3_:int = param1.spacesPerLevel[_loc7_];
         var _loc6_:Number = param1.hiringDurationPerLevelInSecs[_loc7_];
         tweenProgressBarValue(speedProgressBar,0.2,_loc5_);
         tweenProgressBarValue(healthProgressBar,0.2,_loc9_);
         tweenProgressBarValue(damageProgressBar,0.2,_loc8_);
         var _temp_4:* = mercenaryNameLabel;
         var _loc12_:String = "domain.units." + param1.id + ".name";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc12_) + ":";
         var _temp_6:* = speedProgressBar;
         var _temp_5:* = _loc5_ + " ";
         var _loc13_:String = "ui.windows.recruitmentchamber.kph";
         _temp_6.label = _temp_5 + peak.i18n.PText.INSTANCE.getText0(_loc13_);
         healthProgressBar.label = _loc9_ + "";
         damageProgressBar.label = _loc8_ + "";
         hireCostTextField.text = NumberUtil.format(_loc4_);
         var _temp_8:* = housingTextField;
         var _temp_7:* = _loc3_ + " ";
         var _loc14_:String = "ui.windows.recruitmentchamber.spaces";
         _temp_8.text = _temp_7 + peak.i18n.PText.INSTANCE.getText0(_loc14_);
         hireTimeTextField.text = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc6_);
         var _temp_9:* = mercenaryDescriptionTextField;
         var _loc15_:String = "domain.units." + param1.id + ".descshortened";
         _temp_9.text = peak.i18n.PText.INSTANCE.getText0(_loc15_);
         favoriteTargetsTextField.text = "";
         if(param1.healer)
         {
            var _temp_10:* = favoriteTargetsTextField;
            var _loc16_:String = "ui.windows.trainingchamber.healer";
            _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc16_);
         }
         else if(param1.targetsAnything)
         {
            var _temp_11:* = favoriteTargetsTextField;
            var _loc17_:String = "ui.windows.trainingchamber.anything";
            _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc17_);
         }
         else
         {
            _loc10_ = 0;
            while(_loc10_ < param1.favouriteTargets.length)
            {
               if(favoriteTargetsTextField.text != "")
               {
                  favoriteTargetsTextField.text += ", ";
               }
               var _temp_13:* = favoriteTargetsTextField.text;
               var _loc18_:String = "domain.buildingkinds." + param1.favouriteTargets[_loc10_] + ".name";
               favoriteTargetsTextField.text = _temp_13 + peak.i18n.PText.INSTANCE.getText0(_loc18_);
               _loc10_++;
            }
         }
         drawLayout();
      }
      
      public function get infoButton() : MPRigidButton
      {
         return _infoButton;
      }
      
      public function showMercenaryInfoPanel() : void
      {
         _mercenaryViewHolder.visible = false;
         _mercenaryInformationPanel.visible = true;
         extendPanelHeight();
      }
      
      public function hideMercenaryInfoPanel() : void
      {
         _mercenaryViewHolder.visible = true;
         _mercenaryInformationPanel.visible = false;
         if(_type == 0)
         {
            condensePanelHeight();
         }
         else
         {
            extendPanelHeight();
         }
      }
      
      public function showHireAnimationOf(param1:int) : void
      {
         (_mercenaryViewUnitIdMap[param1] as MobileHiringQuartersMercenaryView).showHireAnimation();
      }
      
      private function tweenProgressBarValue(param1:MobileWomProgressBar, param2:Number, param3:Number) : void
      {
         var _loc4_:Tween = new Tween(param1,param2);
         _loc4_.animate("value",param3);
         Starling.juggler.add(_loc4_);
      }
      
      private function getMercenaryIndexById(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:MobileHiringQuartersMercenaryView = null;
         _loc3_ = 0;
         while(_loc3_ < _mercenaryViews.length)
         {
            _loc2_ = _mercenaryViews[_loc3_];
            if(_loc2_.unitTypeId == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function condensePanelHeight() : void
      {
         background.height = 318;
      }
      
      private function extendPanelHeight() : void
      {
         background.height = 495;
      }
   }
}

