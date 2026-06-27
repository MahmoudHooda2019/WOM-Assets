package wom.view.screen.windows.event
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   import wom.model.domain.domaininfoobject.CatapultTypeDIO;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.event.EventItemType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileEventStoreItemInfoView extends Sprite implements View
   {
      
      private static const WIDTH:int = 344;
      
      private static const HEIGHT:int = 502;
      
      private static const PROGRESSBAR_WIDTH_NORMAL:int = 195;
      
      private static const PROGRESSBAR_HEIGHT:int = 36;
      
      private static const PROGRESSBAR_X_MARGIN:int = 8;
      
      private var background:DisplayObject;
      
      private var itemSpecificDIO:Object;
      
      private var itemNameHeader:MPTextField;
      
      private var itemDescriptionTextField:MPTextField;
      
      private var _itemData:Object;
      
      private var detailsProgressBar1:MobileWomProgressBar;
      
      private var detailsProgressBar2:MobileWomProgressBar;
      
      private var detailsProgressBar3:MobileWomProgressBar;
      
      private var detailsProgressBar4:MobileWomProgressBar;
      
      private var detailsProgressBar5:MobileWomProgressBar;
      
      private var detailsLabel1:MPTextField;
      
      private var detailsLabel2:MPTextField;
      
      private var detailsLabel3:MPTextField;
      
      private var detailsLabel4:MPTextField;
      
      private var detailsLabel5:MPTextField;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _hintButton:MPRigidButton;
      
      private var eventItemDIO:EventItemDIO;
      
      private var isLocked:Boolean;
      
      private var favoriteTargetLabel:MobileCaptionTextField;
      
      private var favoriteTargetTextField:MobileWomTextField;
      
      public function MobileEventStoreItemInfoView(param1:MobileWomAssetRepository)
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
         addChild(background);
         itemNameHeader = new MobileCaptionTextField();
         itemNameHeader.textRendererProperties.textFormat = getCaptionTextFormat(33,"center");
         itemNameHeader.width = 344 - 80;
         addChild(itemNameHeader);
         itemDescriptionTextField = new MobileWomTextField();
         itemDescriptionTextField.width = 344 - 80;
         itemDescriptionTextField.textRendererProperties.textFormat = getWomTextFormat(21,"center");
         itemDescriptionTextField.textRendererProperties.wordWrap = true;
         addChild(itemDescriptionTextField);
         detailsLabel1 = createCaptionTextField();
         detailsLabel2 = createCaptionTextField();
         detailsLabel3 = createCaptionTextField();
         detailsLabel4 = createCaptionTextField();
         detailsLabel5 = createCaptionTextField();
         detailsProgressBar1 = createProgressBar();
         detailsProgressBar2 = createProgressBar();
         detailsProgressBar3 = createProgressBar();
         detailsProgressBar4 = createProgressBar();
         detailsProgressBar5 = createProgressBar();
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _hintButton.addEventListener("triggered",onHintButtonClicked);
         addChild(_hintButton);
         favoriteTargetLabel = new MobileCaptionTextField();
         favoriteTargetLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(favoriteTargetLabel);
         favoriteTargetTextField = new MobileWomTextField();
         favoriteTargetTextField.width = 160;
         favoriteTargetTextField.textRendererProperties.wordWrap = true;
         favoriteTargetTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         addChild(favoriteTargetTextField);
         drawLayout();
      }
      
      private function createCaptionTextField() : MobileCaptionTextField
      {
         var _loc1_:MobileCaptionTextField = new MobileCaptionTextField();
         _loc1_.textRendererProperties.textFormat = getCaptionTextFormat(23);
         _loc1_.visible = false;
         addChild(_loc1_);
         return _loc1_;
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(itemNameHeader,background,-10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,background,295,10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(itemDescriptionTextField,background,47);
         MobileAlignmentUtil.alignAccordingToPositionOf(detailsProgressBar1,background,120,200);
         MobileAlignmentUtil.alignBelowOf(detailsProgressBar2,detailsProgressBar1,10);
         MobileAlignmentUtil.alignBelowOf(detailsProgressBar3,detailsProgressBar2,10);
         MobileAlignmentUtil.alignBelowOf(detailsProgressBar4,detailsProgressBar3,10);
         MobileAlignmentUtil.alignBelowOf(detailsProgressBar5,detailsProgressBar4,10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(detailsLabel1,detailsProgressBar1,-(8 + 85));
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(detailsLabel2,detailsProgressBar2,-(8 + 85));
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(detailsLabel3,detailsProgressBar3,-(8 + 85));
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(detailsLabel4,detailsProgressBar4,-(8 + 85));
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(detailsLabel5,detailsProgressBar5,-(8 + 85));
         MobileAlignmentUtil.alignBelowOf(favoriteTargetLabel,detailsLabel5,32);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(favoriteTargetTextField,favoriteTargetLabel,favoriteTargetLabel.width + 10);
      }
      
      public function updateItemData(param1:Object) : void
      {
         this.data = param1;
         itemNameHeader.text = eventItemDIO.name;
         var _temp_1:* = itemDescriptionTextField;
         var _loc2_:String = "m.ui.windows.blacksmith.items." + eventItemDIO.id + ".desc";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         switch(eventItemDIO.itemType)
         {
            case EventItemType.MERCENARY.id:
               updateUnitDetails(itemSpecificDIO as UnitTypeDIO);
               break;
            case EventItemType.CATAPULT.id:
               updateCatapultDetails(itemSpecificDIO as CatapultTypeDIO);
         }
         drawLayout();
      }
      
      private function updateCatapultDetails(param1:CatapultTypeDIO) : void
      {
         var _loc2_:Number = NaN;
         if(param1.id == 4)
         {
            var _temp_1:* = detailsLabel1;
            var _loc3_:String = "ui.windows.eventstore.damage";
            _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            var _temp_2:* = detailsLabel2;
            var _loc4_:String = "ui.windows.eventstore.duration";
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
            var _temp_3:* = detailsLabel3;
            var _loc5_:String = "ui.windows.blacksmith.radius";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            _loc2_ = param1.activationTimesPerStage[0] / 60;
            detailsProgressBar1.label = "" + param1.effectValues[0].effectValuesPerStage[0] / _loc2_;
            detailsProgressBar2.label = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc2_);
            detailsProgressBar3.label = "" + param1.rangesPerStaqe[0];
            detailsLabel1.visible = detailsLabel2.visible = detailsLabel3.visible = true;
            detailsProgressBar1.visible = detailsProgressBar2.visible = detailsProgressBar3.visible = true;
         }
         else if(param1.id == 5)
         {
            var _temp_6:* = detailsLabel1;
            var _loc6_:String = "ui.windows.eventstore.duration";
            _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            var _temp_7:* = detailsLabel2;
            var _loc7_:String = "ui.windows.blacksmith.radius";
            _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            _loc2_ = param1.activationTimesPerStage[0] / 60;
            detailsProgressBar1.label = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc2_);
            detailsProgressBar2.label = "" + param1.rangesPerStaqe[0];
            detailsLabel1.visible = detailsLabel2.visible = true;
            detailsProgressBar1.visible = detailsProgressBar2.visible = true;
         }
         else if(param1.id == 6)
         {
            var _temp_8:* = detailsLabel1;
            var _loc8_:String = "ui.windows.eventstore.heal";
            _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
            var _temp_9:* = detailsLabel2;
            var _loc9_:String = "ui.windows.eventstore.duration";
            _temp_9.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
            var _temp_10:* = detailsLabel3;
            var _loc10_:String = "ui.windows.blacksmith.radius";
            _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc10_);
            _loc2_ = param1.activationTimesPerStage[0] / 60;
            detailsProgressBar1.label = "" + param1.effectValues[0].effectValuesPerStage[0];
            detailsProgressBar2.label = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc2_);
            detailsProgressBar3.label = "" + param1.rangesPerStaqe[0];
            detailsLabel1.visible = detailsLabel2.visible = detailsLabel3.visible = true;
            detailsProgressBar1.visible = detailsProgressBar2.visible = detailsProgressBar3.visible = true;
         }
         favoriteTargetLabel.visible = favoriteTargetTextField.visible = false;
      }
      
      public function updateUnitDetails(param1:UnitTypeDIO) : void
      {
         var _loc2_:int = 0;
         var _temp_1:* = favoriteTargetLabel;
         var _loc3_:String = "ui.windows.recruitmentchamber.favoritetargets";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc3_) + ":";
         favoriteTargetTextField.text = "";
         if(param1.healer)
         {
            var _temp_2:* = favoriteTargetTextField;
            var _loc4_:String = "ui.windows.recruitmentchamber.healer";
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         }
         else if(param1.targetsAnything)
         {
            var _temp_3:* = favoriteTargetTextField;
            var _loc5_:String = "ui.windows.recruitmentchamber.anything";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < param1.favouriteTargets.length)
            {
               if(favoriteTargetTextField.text != "")
               {
                  favoriteTargetTextField.text += ", ";
               }
               var _temp_5:* = favoriteTargetTextField;
               var _temp_4:* = favoriteTargetTextField.text;
               var _loc6_:String = "domain.buildingkinds." + param1.favouriteTargets[_loc2_] + ".name";
               _temp_5.text = _temp_4 + peak.i18n.PText.INSTANCE.getText0(_loc6_);
               _loc2_++;
            }
         }
         if(param1.id == 29 || param1.id == 34 || param1.id == 31)
         {
            var _temp_8:* = detailsLabel1;
            var _loc7_:String = "ui.windows.eventstore.speed";
            _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            var _temp_9:* = detailsLabel2;
            var _loc8_:String = "ui.windows.eventstore.health";
            _temp_9.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
            var _temp_10:* = detailsLabel3;
            var _loc9_:String = "ui.windows.eventstore.damage";
            _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
            var _temp_11:* = detailsLabel4;
            var _loc10_:String = "ui.windows.eventstore.teamsize";
            _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc10_);
            var _temp_12:* = detailsLabel5;
            var _loc11_:String = "ui.windows.eventstore.range";
            _temp_12.text = peak.i18n.PText.INSTANCE.getText0(_loc11_);
            var _temp_16:* = detailsProgressBar1;
            var _temp_15:* = "";
            var _temp_14:* = "ui.windows.blacksmith.speedandkph";
            var _temp_13:* = param1.speed(0);
            var _loc12_:String = "ui.windows.trainingchamber.kph";
            var _loc13_:* = peak.i18n.PText.INSTANCE.getText0(_loc12_);
            var _loc14_:Number = _temp_13;
            var _loc15_:String = _temp_14;
            _temp_16.label = _temp_15 + peak.i18n.PText.INSTANCE.getText2(_loc15_,_loc14_,_loc13_);
            detailsProgressBar2.label = "" + param1.healthPointsPerLevel[0];
            detailsProgressBar3.label = "" + param1.damage(0);
            detailsProgressBar4.label = "" + param1.teamSize;
            detailsProgressBar5.label = "" + param1.range(0);
            detailsLabel5.visible = detailsLabel4.visible = detailsLabel3.visible = detailsLabel2.visible = detailsLabel1.visible = true;
            detailsProgressBar5.visible = detailsProgressBar4.visible = detailsProgressBar3.visible = detailsProgressBar2.visible = detailsProgressBar1.visible = true;
         }
         else
         {
            var _temp_23:* = detailsLabel1;
            var _loc16_:String = "ui.windows.eventstore.speed";
            _temp_23.text = peak.i18n.PText.INSTANCE.getText0(_loc16_);
            var _temp_24:* = detailsLabel2;
            var _loc17_:String = "ui.windows.eventstore.health";
            _temp_24.text = peak.i18n.PText.INSTANCE.getText0(_loc17_);
            var _temp_25:* = detailsLabel3;
            var _loc18_:String = "ui.windows.eventstore.damage";
            _temp_25.text = peak.i18n.PText.INSTANCE.getText0(_loc18_);
            var _temp_26:* = detailsLabel4;
            var _loc19_:String = "ui.windows.eventstore.teamsize";
            _temp_26.text = peak.i18n.PText.INSTANCE.getText0(_loc19_);
            var _temp_29:* = detailsProgressBar1;
            var _temp_28:* = "ui.windows.blacksmith.speedandkph";
            var _temp_27:* = param1.speed(0);
            var _loc20_:String = "ui.windows.trainingchamber.kph";
            var _loc21_:* = peak.i18n.PText.INSTANCE.getText0(_loc20_);
            var _loc22_:Number = _temp_27;
            var _loc23_:String = _temp_28;
            _temp_29.label = peak.i18n.PText.INSTANCE.getText2(_loc23_,_loc22_,_loc21_);
            detailsProgressBar2.label = "" + param1.healthPointsPerLevel[0];
            detailsProgressBar3.label = "" + param1.damage(0);
            detailsProgressBar4.label = "" + param1.teamSize;
            detailsLabel1.visible = detailsLabel2.visible = detailsLabel3.visible = detailsLabel4.visible = true;
            detailsProgressBar1.visible = detailsProgressBar2.visible = detailsProgressBar3.visible = detailsProgressBar4.visible = true;
         }
         favoriteTargetLabel.visible = favoriteTargetTextField.visible = param1.id != 34;
         drawLayout();
      }
      
      private function onHintButtonClicked(param1:Event) : void
      {
         (this.parent as MobileEventStoreItemViewRenderer).onHintButtonClicked();
      }
      
      private function createProgressBar(param1:int = 195, param2:String = "Yellow") : MobileWomProgressBar
      {
         var _loc3_:MobileWomProgressBar = MobileWomUIComponentFactory.createProgressBar(param2);
         _loc3_.width = param1;
         _loc3_.height = 36;
         _loc3_.minimum = 0;
         _loc3_.maximum = 1;
         _loc3_.value = 1;
         _loc3_.align = "center";
         _loc3_.visible = false;
         addChild(_loc3_);
         return _loc3_;
      }
      
      public function get data() : Object
      {
         return _itemData;
      }
      
      public function set data(param1:Object) : void
      {
         if(param1)
         {
            _itemData = param1;
            itemSpecificDIO = param1.itemSpecificDIO;
            isLocked = param1.isLocked;
            eventItemDIO = param1.eventItemDIO;
         }
      }
   }
}

