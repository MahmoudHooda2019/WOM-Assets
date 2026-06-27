package wom.view.screen.windows.blacksmith
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.CatapultTypeDIO;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.ui.common.MobileIconLabelViewExtra;
   import wom.view.util.LocalizedDateTimeUtil;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileBlacksmithEventItemInfoPanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 761;
      
      private static const HEIGHT:int = 242;
      
      private var eventItemAsset:DisplayObject;
      
      private var _eventItemDIO:EventItemDIO;
      
      private var eventItemNameLabel:MobileCaptionTextField;
      
      private var eventItemDescriptionTextField:MobileWomTextField;
      
      private var _eventItemButton:MobileWomButton;
      
      private var favoriteTargetLabel:MobileCaptionTextField;
      
      private var favoriteTargetTextField:MobileWomTextField;
      
      private var timeView:MobileIconLabelViewExtra;
      
      private var costLabel:MobileCaptionTextField;
      
      private var detailsLabel1:MPTextField;
      
      private var detailsLabel2:MPTextField;
      
      private var detailsLabel3:MPTextField;
      
      private var detailsProgressBar1:MobileWomProgressBar;
      
      private var detailsProgressBar2:MobileWomProgressBar;
      
      private var detailsProgressBar3:MobileWomProgressBar;
      
      private var _prepareButton:MPButton;
      
      private var _resourceViews:Array;
      
      private var _levelShield:DisplayObject;
      
      private var _levelInfoTextField:MobileCaptionTextField;
      
      public function MobileBlacksmithEventItemInfoPanel()
      {
         super(761,242);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _eventItemButton = MobileWomUIComponentFactory.createMobileColoredButton("Beige","Large");
         _eventItemButton.width = 92;
         _eventItemButton.isSelected = true;
         _eventItemButton.touchable = false;
         addChild(_eventItemButton);
         eventItemNameLabel = new MobileCaptionTextField();
         eventItemNameLabel.textRendererProperties.textFormat = getCaptionTextFormat(33);
         addChild(eventItemNameLabel);
         eventItemDescriptionTextField = new MobileWomTextField();
         eventItemDescriptionTextField.width = 294;
         eventItemDescriptionTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         eventItemDescriptionTextField.textRendererProperties.wordWrap = true;
         addChild(eventItemDescriptionTextField);
         favoriteTargetLabel = createCaptionTextField();
         favoriteTargetTextField = new MobileWomTextField();
         favoriteTargetTextField.width = 180;
         favoriteTargetTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         favoriteTargetTextField.textRendererProperties.wordWrap = true;
         addChild(favoriteTargetTextField);
         timeView = new MobileIconLabelViewExtra("IconTimerM"," ");
         timeView.scaleIcon(0.6);
         timeView.iconAlign = "left";
         timeView.textAlign = "left";
         timeView.textMarginFromIconX = 16;
         addChild(timeView);
         costLabel = createCaptionTextField();
         _resourceViews = [];
         detailsLabel1 = createCaptionTextField("right");
         detailsLabel2 = createCaptionTextField("right");
         detailsLabel3 = createCaptionTextField("right");
         detailsProgressBar1 = createProgressBar();
         detailsProgressBar2 = createProgressBar();
         detailsProgressBar3 = createProgressBar();
         _prepareButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _prepareButton.width = 257;
         addChild(_prepareButton);
         _levelShield = assetRepository.getDisplayObject("IconLevelBeastMBordered");
         _levelShield.touchable = false;
         _levelShield.visible = false;
         addChild(_levelShield);
         _levelInfoTextField = new MobileCaptionTextField();
         _levelInfoTextField.textRendererProperties.textFormat = getCaptionTextFormat(27);
         _levelInfoTextField.touchable = false;
         _levelInfoTextField.visible = false;
         addChild(_levelInfoTextField);
         drawLayout();
      }
      
      private function createResourceCostView(param1:Vector.<ResourceAmountDTO>, param2:Array) : void
      {
         var _loc5_:String = null;
         var _loc7_:int = 0;
         var _loc4_:ResourceAmountDTO = null;
         var _loc3_:MobileIconLabelViewExtra = null;
         for each(var _loc6_ in _resourceViews)
         {
            removeChild(_loc6_);
         }
         _resourceViews = [];
         for each(var _loc8_ in ResourceType.resourceTypes)
         {
            _loc5_ = _loc8_.iconAssetName;
            _loc7_ = 0;
            while(_loc7_ < param1.length)
            {
               _loc4_ = param1[_loc7_];
               if(_loc4_.resourceType == _loc8_.id && _loc4_.resourceAmount > 0)
               {
                  _loc3_ = new MobileIconLabelViewExtra(_loc5_,NumberUtil.format(_loc4_.resourceAmount));
                  _loc3_.scaleIcon(0.8);
                  _loc3_.iconAlign = "left";
                  _loc3_.textAlign = "left";
                  _loc3_.textMarginFromIconX = 28;
                  addChild(_loc3_);
                  _loc3_.updateTextFormatRed(param2[_loc8_.id] < _loc4_.resourceAmount);
                  _resourceViews.push(_loc3_);
                  break;
               }
               _loc7_++;
            }
         }
      }
      
      private function createProgressBar() : MobileWomProgressBar
      {
         var _loc1_:MobileWomProgressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         _loc1_.width = 178;
         _loc1_.height = 33;
         _loc1_.minimum = 0;
         _loc1_.maximum = 1;
         _loc1_.value = 1;
         _loc1_.align = "center";
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function createCaptionTextField(param1:String = "left") : MobileCaptionTextField
      {
         var _loc2_:MobileCaptionTextField = new MobileCaptionTextField();
         _loc2_.textRendererProperties.textFormat = getCaptionTextFormat(23,param1);
         if(param1 == "right")
         {
            _loc2_.width = 150;
         }
         addChild(_loc2_);
         return _loc2_;
      }
      
      override public function drawLayout() : void
      {
         var _loc1_:int = 0;
         super.drawLayout();
         MobileAlignmentUtil.alignAccordingToPositionOf(eventItemNameLabel,bg,30,18);
         MobileAlignmentUtil.alignAccordingToPositionOf(_eventItemButton,bg,27,59);
         MobileAlignmentUtil.alignAccordingToPositionOf(eventItemDescriptionTextField,bg,145,58);
         MobileAlignmentUtil.alignAccordingToPositionOf(favoriteTargetLabel,eventItemDescriptionTextField,0,82);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(favoriteTargetTextField,favoriteTargetLabel,favoriteTargetLabel.width + 10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(timeView,_eventItemButton,92);
         MobileAlignmentUtil.alignAccordingToPositionOf(costLabel,favoriteTargetLabel,0,47);
         if(_resourceViews.length > 0)
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_resourceViews[0],costLabel,costLabel.width + 4);
         }
         _loc1_ = 1;
         while(_loc1_ < _resourceViews.length)
         {
            MobileAlignmentUtil.alignRightOf(_resourceViews[_loc1_],_resourceViews[_loc1_ - 1],8);
            _loc1_++;
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(detailsLabel1,bg,400,24);
         MobileAlignmentUtil.alignBelowOf(detailsLabel2,detailsLabel1,22);
         MobileAlignmentUtil.alignBelowOf(detailsLabel3,detailsLabel2,22);
         MobileAlignmentUtil.alignAccordingToPositionOf(detailsProgressBar1,detailsLabel1,160,-8);
         MobileAlignmentUtil.alignAccordingToPositionOf(detailsProgressBar2,detailsLabel2,160,-8);
         MobileAlignmentUtil.alignAccordingToPositionOf(detailsProgressBar3,detailsLabel3,160,-8);
         MobileAlignmentUtil.alignAccordingToPositionOf(_prepareButton,bg,485,157);
         MobileAlignmentUtil.alignAccordingToPositionOf(_levelShield,_eventItemButton,-16,-13);
         MobileAlignmentUtil.alignAccordingToPositionOf(_levelInfoTextField,_levelShield,20,10);
      }
      
      public function updateInfo(param1:EventItemDIO) : void
      {
         _eventItemDIO = param1;
         if(eventItemAsset != null)
         {
            if(contains(eventItemAsset))
            {
               removeChild(eventItemAsset);
            }
         }
         _eventItemButton.defaultIcon = assetRepository.getDisplayObject(_eventItemDIO.assetName.substring(0,_eventItemDIO.assetName.length - 4) + "Portrait");
         var _temp_2:* = eventItemNameLabel;
         var _loc2_:String = "ui.windows.store.items." + _eventItemDIO.id + ".name";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         var _temp_3:* = eventItemDescriptionTextField;
         var _loc3_:String = "m.ui.windows.blacksmith.items." + _eventItemDIO.id + ".desc";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         var _temp_4:* = favoriteTargetLabel;
         var _loc4_:String = "ui.windows.hiringquarters.favoritetargets";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _temp_5:* = costLabel;
         var _loc5_:String = "ui.windows.build.cost";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         var _temp_6:* = _prepareButton;
         var _loc6_:String = "m.ui.windows.blacksmith.prepare";
         _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         detailsLabel3.visible = true;
         detailsProgressBar3.visible = true;
         drawLayout();
      }
      
      public function updateCatapultDetails(param1:CatapultTypeDIO, param2:Array) : void
      {
         var _loc3_:Number = NaN;
         createResourceCostView(param1.resourceCosts[0],param2);
         if(param1.id == 4 || param1.id == 5 || param1.id == 6)
         {
            var _temp_3:* = detailsLabel1;
            var _loc4_:String = "ui.windows.blacksmith.radius";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
            var _temp_4:* = detailsLabel2;
            var _loc5_:String = "ui.windows.eventstore.duration";
            _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            var _loc6_:String;
            var _loc7_:String;
            detailsLabel3.text = param1.id == 6 ? (_loc6_ = "ui.windows.eventstore.heal",peak.i18n.PText.INSTANCE.getText0(_loc6_)) : (_loc7_ = "ui.windows.eventstore.damage",peak.i18n.PText.INSTANCE.getText0(_loc7_));
            detailsProgressBar1.label = "" + param1.rangesPerStaqe[0];
            _loc3_ = param1.activationTimesPerStage[0] / 60;
            detailsProgressBar2.label = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc3_);
            detailsProgressBar3.label = param1.id == 6 ? "" + param1.effectValues[0].effectValuesPerStage[0] : "" + param1.effectValues[0].effectValuesPerStage[0] / _loc3_;
            timeView.label = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(param1.upgradeTimesInSecs.length > 0 ? param1.upgradeTimesInSecs[0] : 0);
            detailsLabel3.visible = param1.id != 5;
            detailsProgressBar3.visible = param1.id != 5;
         }
         favoriteTargetLabel.visible = favoriteTargetTextField.visible = false;
         _levelShield.visible = _levelInfoTextField.visible = false;
         drawLayout();
      }
      
      public function updateUnitDetails(param1:UnitTypeDIO, param2:UnitTypeInfo, param3:Array) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = param2 ? param2.currentLevel - 1 : 0;
         favoriteTargetTextField.text = "";
         if(param1.healer)
         {
            var _temp_1:* = favoriteTargetTextField;
            var _loc6_:String = "ui.windows.recruitmentchamber.healer";
            _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         }
         else if(param1.targetsAnything)
         {
            var _temp_2:* = favoriteTargetTextField;
            var _loc7_:String = "ui.windows.recruitmentchamber.anything";
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < param1.favouriteTargets.length)
            {
               if(favoriteTargetTextField.text != "")
               {
                  favoriteTargetTextField.text += ", ";
               }
               var _temp_4:* = favoriteTargetTextField;
               var _temp_3:* = favoriteTargetTextField.text;
               var _loc8_:String = "domain.buildingkinds." + param1.favouriteTargets[_loc5_] + ".name";
               _temp_4.text = _temp_3 + peak.i18n.PText.INSTANCE.getText0(_loc8_);
               _loc5_++;
            }
         }
         if(param1.id == 29 || param1.id == 34)
         {
            var _temp_6:* = detailsLabel1;
            var _loc9_:String = "ui.windows.eventstore.range";
            _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
            detailsProgressBar1.label = "" + param1.range(_loc4_);
         }
         else
         {
            var _temp_7:* = detailsLabel1;
            var _loc10_:String = "ui.windows.eventstore.speed";
            _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc10_);
            var _temp_9:* = detailsProgressBar1;
            var _temp_8:* = param1.speed(_loc4_) + " ";
            var _loc11_:String = "ui.windows.trainingchamber.kph";
            _temp_9.label = _temp_8 + peak.i18n.PText.INSTANCE.getText0(_loc11_);
         }
         var _temp_10:* = detailsLabel2;
         var _loc12_:String = "ui.windows.eventstore.health";
         _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc12_);
         var _temp_11:* = detailsLabel3;
         var _loc13_:String = "ui.windows.eventstore.damage";
         _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc13_);
         detailsProgressBar2.label = "" + param1.healthPointsPerLevel[_loc4_];
         detailsProgressBar3.label = "" + param1.damage(_loc4_);
         timeView.label = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(param1.hiringDurationPerLevelInSecs[_loc4_]);
         createResourceCostView(param1.hiringCostsPerLevel[_loc4_],param3);
         favoriteTargetLabel.visible = favoriteTargetTextField.visible = true;
         if(param2)
         {
            _levelInfoTextField.text = "" + param2.currentLevel;
         }
         _levelShield.visible = _levelInfoTextField.visible = param2;
         drawLayout();
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "BackgroundBeige";
      }
      
      public function get prepareButton() : MPButton
      {
         return _prepareButton;
      }
      
      public function get eventItemDIO() : EventItemDIO
      {
         return _eventItemDIO;
      }
   }
}

