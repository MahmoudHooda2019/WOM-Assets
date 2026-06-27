package wom.view.screen.windows.hiringquarters
{
   import com.greensock.TweenLite;
   import fl.controls.ProgressBar;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.progressbar.ProgressBar26;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class HiringQuartersSelectMercenaryPanel extends Sprite implements View
   {
      
      private var assetRepository:WomAssetRepository;
      
      private var mercenariesListBackground:DisplayObject;
      
      private var _mercenaryViews:Vector.<HiringQuartersMercenaryView>;
      
      private var mercenaryInformationPanel:Sprite;
      
      private var mercenaryNameLabel:TextField;
      
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
      
      private var hireCostLabel:TextField;
      
      private var hireCostTextField:TextField;
      
      private var hireCostProgressBar:ProgressBar;
      
      private var housingLabel:TextField;
      
      private var housingTextField:TextField;
      
      private var housingProgressBar:ProgressBar;
      
      private var hireTimeLabel:TextField;
      
      private var hireTimeTextField:TextField;
      
      private var hireTimeProgressBar:ProgressBar;
      
      private var _selectedMercenaryId:int;
      
      private var previouslySelectedMercenary:HiringQuartersMercenaryView;
      
      private var _selectedMercenaryBackground:DisplayObject;
      
      private var _clickForeground:DisplayObject;
      
      public function HiringQuartersSelectMercenaryPanel(param1:WomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         init();
      }
      
      public function get mercenaryViews() : Vector.<HiringQuartersMercenaryView>
      {
         return _mercenaryViews;
      }
      
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         mercenariesListBackground = assetRepository.getDisplayObject("BackgroundLight");
         mercenariesListBackground.width = 319;
         mercenariesListBackground.height = 184;
         addChild(mercenariesListBackground);
         mercenaryInformationPanel = new Sprite();
         mercenaryInformationPanel.visible = false;
         addChild(mercenaryInformationPanel);
         mercenaryNameLabel = new CaptionTextField();
         mercenaryNameLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         mercenaryNameLabel.autoSize = "left";
         mercenaryInformationPanel.addChild(mercenaryNameLabel);
         mercenaryDescriptionTextField = new WomTextField();
         mercenaryDescriptionTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         mercenaryDescriptionTextField.multiline = true;
         mercenaryDescriptionTextField.wordWrap = true;
         mercenaryDescriptionTextField.width = 160;
         mercenaryDescriptionTextField.height = 130;
         mercenaryInformationPanel.addChild(mercenaryDescriptionTextField);
         favoriteTargetLabel = new CaptionTextField();
         favoriteTargetLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         favoriteTargetLabel.autoSize = "left";
         var _temp_6:* = favoriteTargetLabel;
         var _loc1_:String = "ui.windows.hiringquarters.favoritetargets";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc1_) + ":";
         mercenaryInformationPanel.addChild(favoriteTargetLabel);
         favoriteTargetsTextField = new WomTextField();
         favoriteTargetsTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         favoriteTargetsTextField.multiline = true;
         favoriteTargetsTextField.wordWrap = true;
         favoriteTargetsTextField.width = 160;
         favoriteTargetsTextField.height = 40;
         mercenaryInformationPanel.addChild(favoriteTargetsTextField);
         speedLabel = createLabel("speed");
         healthLabel = createLabel("health");
         damageLabel = createLabel("damage");
         housingLabel = createLabel("housing");
         hireCostLabel = createLabel("hirecost");
         hireTimeLabel = createLabel("time");
         speedProgressBar = createProgressBar();
         healthProgressBar = createProgressBar();
         damageProgressBar = createProgressBar();
         housingProgressBar = createProgressBar();
         hireCostProgressBar = createProgressBar();
         hireTimeProgressBar = createProgressBar();
         speedTextField = createProgressBarTextField();
         healthTextField = createProgressBarTextField();
         damageTextField = createProgressBarTextField();
         housingTextField = createProgressBarTextField();
         hireCostTextField = createProgressBarTextField();
         hireTimeTextField = createProgressBarTextField();
         _selectedMercenaryBackground = assetRepository.getDisplayObject("HiringQuartersHover");
         _selectedMercenaryBackground.visible = false;
         addChild(_selectedMercenaryBackground);
         _clickForeground = assetRepository.getDisplayObject("HiringQuartersClick");
         _clickForeground.visible = false;
         addChild(_clickForeground);
      }
      
      private function createLabel(param1:String) : TextField
      {
         var _loc2_:TextField = new CaptionTextField();
         _loc2_.defaultTextFormat = WomTextFormats.RIGHT_16;
         _loc2_.width = 73;
         _loc2_.height = 17;
         var _temp_1:* = _loc2_;
         var _loc3_:String = "ui.windows.hiringquarters." + param1;
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         mercenaryInformationPanel.addChild(_loc2_);
         return _loc2_;
      }
      
      private function createProgressBar() : ProgressBar
      {
         var _loc1_:ProgressBar = new ProgressBar26();
         _loc1_.width = 133;
         mercenaryInformationPanel.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createProgressBarTextField() : TextField
      {
         var _loc1_:TextField = new CaptionTextField();
         _loc1_.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _loc1_.width = 87;
         _loc1_.height = 17;
         mercenaryInformationPanel.addChild(_loc1_);
         return _loc1_;
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignRightWithYMarginOf(mercenaryInformationPanel,mercenariesListBackground,5,0);
         AlignmentUtil.alignBelowOf(healthLabel,speedLabel,11);
         AlignmentUtil.alignBelowOf(damageLabel,healthLabel,11);
         AlignmentUtil.alignBelowOf(hireCostLabel,damageLabel,11);
         AlignmentUtil.alignBelowOf(housingLabel,hireCostLabel,11);
         AlignmentUtil.alignBelowOf(hireTimeLabel,housingLabel,11);
         AlignmentUtil.alignRightWithYMarginOf(speedProgressBar,speedLabel,-3,10);
         AlignmentUtil.alignRightWithYMarginOf(healthProgressBar,healthLabel,-3,10);
         AlignmentUtil.alignRightWithYMarginOf(damageProgressBar,damageLabel,-3,10);
         AlignmentUtil.alignRightWithYMarginOf(housingProgressBar,housingLabel,-3,10);
         AlignmentUtil.alignRightWithYMarginOf(hireCostProgressBar,hireCostLabel,-3,10);
         AlignmentUtil.alignRightWithYMarginOf(hireTimeProgressBar,hireTimeLabel,-3,10);
         AlignmentUtil.alignRightOf(speedTextField,speedLabel,15);
         AlignmentUtil.alignRightOf(healthTextField,healthLabel,15);
         AlignmentUtil.alignRightOf(damageTextField,damageLabel,15);
         AlignmentUtil.alignRightOf(housingTextField,housingLabel,15);
         AlignmentUtil.alignRightOf(hireCostTextField,hireCostLabel,15);
         AlignmentUtil.alignRightOf(hireTimeTextField,hireTimeLabel,15);
         AlignmentUtil.alignRightWithYMarginOf(mercenaryNameLabel,speedProgressBar,-5,5);
         AlignmentUtil.alignBelowOf(mercenaryDescriptionTextField,mercenaryNameLabel,13);
         AlignmentUtil.alignBelowOf(favoriteTargetLabel,mercenaryDescriptionTextField,5);
         AlignmentUtil.alignBelowOf(favoriteTargetsTextField,favoriteTargetLabel,1);
         for each(var _loc1_ in _mercenaryViews)
         {
            if(_loc1_.unitTypeDIO.id == _selectedMercenaryId)
            {
               if(_selectedMercenaryBackground.width != 0 && _loc1_.mercenaryAsset.width != 0)
               {
                  AlignmentUtil.alignMiddleOf(_selectedMercenaryBackground,_loc1_);
                  _selectedMercenaryBackground.visible = true;
               }
               break;
            }
         }
      }
      
      public function fillUnits(param1:Vector.<UnitTypeDIO>) : void
      {
         var _loc4_:HiringQuartersMercenaryView = null;
         var _loc2_:int = 0;
         _mercenaryViews = new Vector.<HiringQuartersMercenaryView>();
         for each(var _loc3_ in param1)
         {
            _loc4_ = new HiringQuartersMercenaryView(_loc3_,_loc2_);
            _mercenaryViews.push(_loc4_);
            if(_loc2_ == 0)
            {
               AlignmentUtil.alignAccordingToPositionOf(_loc4_,mercenariesListBackground,10,11);
            }
            else if(_loc2_ % 5 == 0)
            {
               _loc4_.x = _mercenaryViews[_loc2_ - 5].x;
               _loc4_.y = _mercenaryViews[_loc2_ - 5].y + 55;
            }
            else
            {
               _loc4_.x = _mercenaryViews[_loc2_ - 1].x + 61;
               _loc4_.y = _mercenaryViews[_loc2_ - 1].y;
            }
            addChild(_loc4_);
            _loc2_++;
         }
      }
      
      public function updateUnits(param1:Dictionary) : void
      {
         var _loc2_:int = 0;
         var _loc5_:UnitTypeInfo = null;
         var _loc3_:UnitTypeDIO = null;
         var _loc4_:int = 0;
         var _loc7_:Number = 0;
         var _loc11_:int = 0;
         var _loc13_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:int = 0;
         var _loc8_:Number = 0;
         for(var _loc10_ in param1)
         {
            _loc2_ = -1;
            _loc5_ = param1[_loc10_];
            for each(var _loc6_ in _mercenaryViews)
            {
               if(_loc6_.unitTypeDIO.id == _loc5_.unitTypeId)
               {
                  _loc3_ = _loc6_.unitTypeDIO;
                  _loc2_ = _loc6_.index;
                  break;
               }
            }
            if(_loc2_ != -1)
            {
               _mercenaryViews[_loc2_].updateUnit(_loc5_);
               _loc4_ = _loc5_.currentLevel;
               if(_loc4_ != 0)
               {
                  _loc4_--;
               }
               if(_loc7_ < _loc3_.speed(_loc4_))
               {
                  _loc7_ = _loc3_.speed(_loc4_);
               }
               if(_loc11_ < _loc3_.healthPointsPerLevel[_loc4_])
               {
                  _loc11_ = _loc3_.healthPointsPerLevel[_loc4_];
               }
               if(_loc13_ < _loc3_.damage(_loc4_))
               {
                  _loc13_ = _loc3_.damage(_loc4_);
               }
               if(_loc9_ < _loc3_.hiringCostsPerLevel[_loc4_][0].resourceAmount)
               {
                  _loc9_ = _loc3_.hiringCostsPerLevel[_loc4_][0].resourceAmount;
               }
               if(_loc12_ < _loc3_.spacesPerLevel[_loc4_])
               {
                  _loc12_ = _loc3_.spacesPerLevel[_loc4_];
               }
               if(_loc8_ < _loc3_.hiringDurationPerLevelInSecs[_loc4_])
               {
                  _loc8_ = _loc3_.hiringDurationPerLevelInSecs[_loc4_];
               }
            }
         }
         speedProgressBar.maximum = _loc7_;
         healthProgressBar.maximum = _loc11_;
         damageProgressBar.maximum = _loc13_;
         housingProgressBar.maximum = _loc12_;
         hireCostProgressBar.maximum = _loc9_;
         hireTimeProgressBar.maximum = _loc8_;
      }
      
      public function loadMercenaryData(param1:UnitTypeDIO, param2:UnitTypeInfo) : void
      {
         var _loc11_:int = 0;
         _selectedMercenaryId = param1.id;
         for each(var _loc10_ in _mercenaryViews)
         {
            if(_loc10_.unitTypeDIO.id == _selectedMercenaryId)
            {
               if(_selectedMercenaryBackground.width != 0 && _loc10_.mercenaryAsset.width != 0)
               {
                  if(previouslySelectedMercenary)
                  {
                     previouslySelectedMercenary.updateSelected(false);
                  }
                  _loc10_.updateSelected(true);
                  AlignmentUtil.alignAccordingToPositionOf(_selectedMercenaryBackground,_loc10_,-3,-3);
                  previouslySelectedMercenary = _loc10_;
               }
               break;
            }
         }
         var _temp_5:* = damageLabel;
         var _loc14_:String = "ui.windows.hiringquarters." + (param1.healer ? "heal" : "damage");
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc14_);
         mercenaryInformationPanel.visible = true;
         var _loc7_:int = param2.currentLevel - 1;
         var _loc5_:Number = param1.speed(_loc7_);
         var _loc9_:int = param1.healthPointsPerLevel[_loc7_];
         var _loc8_:int = param1.damage(_loc7_);
         var _loc4_:Number = param1.hiringCostsPerLevel[_loc7_][0].resourceAmount;
         var _loc3_:int = param1.spacesPerLevel[_loc7_];
         var _loc6_:Number = param1.hiringDurationPerLevelInSecs[_loc7_];
         TweenLite.to(speedProgressBar,0.2,{"value":_loc5_});
         TweenLite.to(healthProgressBar,0.2,{"value":_loc9_});
         TweenLite.to(damageProgressBar,0.2,{"value":_loc8_});
         TweenLite.to(housingProgressBar,0.2,{"value":_loc3_});
         TweenLite.to(hireCostProgressBar,0.2,{"value":_loc4_});
         TweenLite.to(hireTimeProgressBar,0.2,{"value":_loc6_});
         var _temp_6:* = mercenaryNameLabel;
         var _loc15_:String = "domain.units." + param1.id + ".name";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc15_) + ":";
         var _temp_8:* = speedTextField;
         var _temp_7:* = _loc5_ + " ";
         var _loc16_:String = "ui.windows.recruitmentchamber.kph";
         _temp_8.text = _temp_7 + peak.i18n.PText.INSTANCE.getText0(_loc16_);
         healthTextField.text = _loc9_ + "";
         damageTextField.text = _loc8_ + "";
         hireCostTextField.text = NumberUtil.format(_loc4_);
         var _temp_10:* = housingTextField;
         var _temp_9:* = _loc3_ + " ";
         var _loc17_:String = "ui.windows.recruitmentchamber.spaces";
         _temp_10.text = _temp_9 + peak.i18n.PText.INSTANCE.getText0(_loc17_);
         hireTimeTextField.text = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc6_);
         var _temp_11:* = mercenaryDescriptionTextField;
         var _loc18_:String = "domain.units." + param1.id + ".descshortened";
         _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc18_);
         favoriteTargetsTextField.text = "";
         if(param1.healer)
         {
            var _temp_12:* = favoriteTargetsTextField;
            var _loc19_:String = "ui.windows.trainingchamber.healer";
            _temp_12.text = peak.i18n.PText.INSTANCE.getText0(_loc19_);
         }
         else if(param1.targetsAnything)
         {
            var _temp_13:* = favoriteTargetsTextField;
            var _loc20_:String = "ui.windows.trainingchamber.anything";
            _temp_13.text = peak.i18n.PText.INSTANCE.getText0(_loc20_);
         }
         else
         {
            _loc11_ = 0;
            while(_loc11_ < param1.favouriteTargets.length)
            {
               if(favoriteTargetsTextField.text != "")
               {
                  favoriteTargetsTextField.appendText(", ");
               }
               var _temp_14:* = favoriteTargetsTextField;
               var _loc21_:String = "domain.buildingkinds." + param1.favouriteTargets[_loc11_] + ".name";
               _temp_14.appendText(peak.i18n.PText.INSTANCE.getText0(_loc21_));
               _loc11_++;
            }
         }
      }
      
      public function get selectedMercenaryId() : int
      {
         return _selectedMercenaryId;
      }
      
      public function get clickForeground() : DisplayObject
      {
         return _clickForeground;
      }
      
      public function get selectedMercenaryBackground() : DisplayObject
      {
         return _selectedMercenaryBackground;
      }
   }
}

