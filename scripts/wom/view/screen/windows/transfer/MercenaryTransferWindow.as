package wom.view.screen.windows.transfer
{
   import fl.data.DataProvider;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomScrollPane;
   import wom.view.component.WomTabBar;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.progressbar.ProgressBar30;
   import wom.view.component.progressbar.WomProgressBar;
   import wom.view.ui.common.IconLabelView;
   import wom.view.ui.mainframe.city.tooltip.AttachableTooltipView;
   import wom.view.util.GenericWindow;
   
   public class MercenaryTransferWindow extends GenericWindow
   {
      
      public static const WATCH_POST:int = 1;
      
      public static const ALLIANCE_BARRACKS:int = 2;
      
      public static const FRIEND_WATCH_POST:int = 3;
      
      private static const WINDOW_WIDTH:int = 746;
      
      private static const WINDOW_HEIGHT:int = 521;
      
      private var _tabBar:WomTabBar;
      
      private var fromBackground:DisplayObject;
      
      private var _fromHousingScrollPane:WomScrollPane;
      
      private var _fromStoreScrollPane:WomScrollPane;
      
      private var inBunkerScrollPane:WomScrollPane;
      
      private var fromHousingContent:Sprite;
      
      private var fromStoreContent:Sprite;
      
      private var inBunkerContent:Sprite;
      
      private var _fromHousingMercenaryViews:Vector.<MercenaryTransferWindowMercenaryView>;
      
      private var _fromStoreMercenaryViews:Vector.<MercenaryTransferWindowMercenaryView>;
      
      private var inWatchPostMercenaryViews:Vector.<MercenaryTransferWindowMercenaryView>;
      
      private var inBunkerBackground:DisplayObject;
      
      private var bunkerCapacityProgress:WomProgressBar;
      
      private var bunkerCapacityLabel:TextField;
      
      private var bunkerCapacityFractionalTextField:TextField;
      
      private var bunkerCapacityPercentageTextField:TextField;
      
      private var blueSparkle:DisplayObject;
      
      private var _transferResourceCost:IconLabelView;
      
      private var _transferGoldCost:IconLabelView;
      
      private var _transferButton:WomButton;
      
      private var _transferButtonTooltip:AttachableTooltipView;
      
      private var _transferResourceAmount:int;
      
      private var _transferGoldAmount:int;
      
      private var _currentHousing:int;
      
      private var _housingCapacity:int;
      
      private var _housingToBeAdd:int = 0;
      
      private var _tabToBeActivated:int = 0;
      
      private var _type:int;
      
      public function MercenaryTransferWindow(param1:int)
      {
         super(746,521);
         _type = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         fromBackground = assetRepository.getDisplayObject("BackgroundLight");
         fromBackground.width = 294;
         fromBackground.height = 402;
         addChild(fromBackground);
         _tabBar = new WomTabBar(131);
         var _temp_5:* = _tabBar;
         var _temp_4:* = §§findproperty(DataProvider);
         var _loc1_:String = "ui.windows.watchpost.fromhousing";
         var _temp_3:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc2_:String = "ui.windows.watchpost.fromstore";
         _temp_5.dataProvider = new DataProvider([_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_)]);
         addChild(_tabBar);
         _fromHousingScrollPane = new WomScrollPane();
         _fromHousingScrollPane.width = fromBackground.width + 2;
         _fromHousingScrollPane.height = fromBackground.height - 24;
         _fromHousingScrollPane.verticalScrollPolicy = "on";
         addChild(_fromHousingScrollPane);
         fromHousingContent = new Sprite();
         _fromHousingScrollPane.source = fromHousingContent;
         _fromStoreScrollPane = new WomScrollPane();
         _fromStoreScrollPane.width = _fromHousingScrollPane.width;
         _fromStoreScrollPane.height = _fromHousingScrollPane.height;
         addChild(_fromStoreScrollPane);
         fromStoreContent = new Sprite();
         _fromStoreScrollPane.source = fromStoreContent;
         blueSparkle = assetRepository.getDisplayObject("BlueSparkle");
         addChild(blueSparkle);
         _transferResourceCost = new IconLabelView("Might","",95,65);
         addChild(_transferResourceCost);
         _transferGoldCost = new IconLabelView("Gold","",95,65);
         addChild(_transferGoldCost);
         _transferButton = new WomBlueSmallButton();
         _transferButton.width = 102;
         var _temp_14:* = _transferButton;
         var _loc3_:String = "ui.windows.watchpost.transfer";
         _temp_14.label = peak.i18n.PText.INSTANCE.getText0(_loc3_) + " >>";
         addChild(_transferButton);
         inBunkerBackground = assetRepository.getDisplayObject("BackgroundLight");
         inBunkerBackground.width = 294;
         inBunkerBackground.height = 455;
         addChild(inBunkerBackground);
         inBunkerScrollPane = new WomScrollPane();
         inBunkerScrollPane.width = inBunkerBackground.width + 2;
         inBunkerScrollPane.height = inBunkerBackground.height - 74;
         addChild(inBunkerScrollPane);
         inBunkerContent = new Sprite();
         inBunkerScrollPane.source = inBunkerContent;
         bunkerCapacityProgress = new ProgressBar30();
         bunkerCapacityProgress.width = 113;
         addChild(bunkerCapacityProgress);
         bunkerCapacityLabel = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         bunkerCapacityLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         bunkerCapacityLabel.autoSize = "left";
         var _loc4_:String;
         var _loc5_:String;
         bunkerCapacityLabel.text = _type == 1 ? (_loc4_ = "ui.windows.watchpost.bunkercapacity",peak.i18n.PText.INSTANCE.getText0(_loc4_)) : (_loc5_ = "ui.windows.alliancebarracks.capacitytransfer",peak.i18n.PText.INSTANCE.getText0(_loc5_));
         addChild(bunkerCapacityLabel);
         bunkerCapacityFractionalTextField = new CaptionTextField();
         bunkerCapacityFractionalTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         bunkerCapacityFractionalTextField.autoSize = "left";
         addChild(bunkerCapacityFractionalTextField);
         bunkerCapacityPercentageTextField = new CaptionTextField();
         bunkerCapacityPercentageTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         bunkerCapacityPercentageTextField.autoSize = "right";
         addChild(bunkerCapacityPercentageTextField);
         var _temp_24:* = §§findproperty(AttachableTooltipView);
         var _temp_23:* = this;
         var _temp_22:* = _transferButton;
         var _loc6_:String = "ui.windows.watchpost.enabledtransfertooltip";
         _transferButtonTooltip = new AttachableTooltipView(_temp_23,_temp_22,peak.i18n.PText.INSTANCE.getText0(_loc6_));
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _tabBar.x = 31;
         _tabBar.y = 48;
         AlignmentUtil.alignBelowWithXMarginOf(fromBackground,_tabBar,-8,21);
         AlignmentUtil.alignAccordingToPositionOf(_fromHousingScrollPane,fromBackground,0,12);
         AlignmentUtil.alignAccordingToPositionOf(_fromStoreScrollPane,fromBackground,0,12);
         AlignmentUtil.alignAccordingToPositionOf(blueSparkle,_background,320,144);
         AlignmentUtil.alignAccordingToPositionOf(_transferResourceCost,_background,322,183);
         AlignmentUtil.alignAccordingToPositionOf(_transferGoldCost,_background,322,183);
         AlignmentUtil.alignAccordingToPositionOf(_transferButton,_background,322,259);
         _transferButtonTooltip.updateTooltipAlignmentAccordingToObject((_transferButton.width - _transferButtonTooltip.width) / 2,-_transferButtonTooltip.height * 2 / 3);
         inBunkerBackground.x = 429;
         inBunkerBackground.y = 38;
         AlignmentUtil.alignAccordingToPositionOf(inBunkerScrollPane,inBunkerBackground,0,65);
         AlignmentUtil.alignAccordingToPositionOf(bunkerCapacityLabel,inBunkerBackground,17,17);
         AlignmentUtil.alignAccordingToPositionOf(bunkerCapacityProgress,inBunkerBackground,161,12);
         AlignmentUtil.alignAccordingToPositionOf(bunkerCapacityFractionalTextField,bunkerCapacityProgress,4,6);
         bunkerCapacityPercentageTextField.x = bunkerCapacityProgress.x + bunkerCapacityProgress.width - bunkerCapacityPercentageTextField.width - 6;
         bunkerCapacityPercentageTextField.y = bunkerCapacityFractionalTextField.y;
      }
      
      public function addMercenariesToFromHousing(param1:Vector.<UnitTypeAmountDTO>) : void
      {
         var _loc4_:MercenaryTransferWindowMercenaryView = null;
         var _loc3_:Dictionary = new Dictionary();
         for each(_loc4_ in _fromHousingMercenaryViews)
         {
            _loc3_[_loc4_.unitTypeId] = _loc4_.selectedAmount;
         }
         clearFromHousing();
         if(param1 == null || param1 && param1.length == 0)
         {
            _tabToBeActivated = 1;
            _tabBar.selectedIndex = 1;
            activateTabByIndex(_tabToBeActivated);
         }
         var _loc5_:int = 0;
         for each(var _loc2_ in param1)
         {
            _loc4_ = new MercenaryTransferWindowMercenaryView(_loc2_.id,0,_type,_loc2_.amount,_loc3_[_loc2_.id]);
            _loc4_.x = 9;
            _loc4_.y = _loc5_ * 63;
            fromHousingContent.addChild(_loc4_);
            _fromHousingMercenaryViews.push(_loc4_);
            _loc5_++;
         }
         _fromHousingScrollPane.source = fromHousingContent;
      }
      
      private function clearFromHousing() : void
      {
         _fromHousingScrollPane.source = null;
         fromHousingContent = new Sprite();
         _fromHousingMercenaryViews = new Vector.<MercenaryTransferWindowMercenaryView>();
      }
      
      public function addMercenariesToFromStore(param1:Vector.<UnitTypeDIO>) : void
      {
         var _loc3_:MercenaryTransferWindowMercenaryView = null;
         clearFromStore();
         var _loc4_:int = 0;
         for each(var _loc2_ in param1)
         {
            _loc3_ = new MercenaryTransferWindowMercenaryView(_loc2_.id,1,_type);
            _loc3_.x = 9;
            _loc3_.y = _loc4_ * 63;
            fromStoreContent.addChild(_loc3_);
            _fromStoreMercenaryViews.push(_loc3_);
            _loc4_++;
         }
         _fromStoreScrollPane.source = fromStoreContent;
      }
      
      private function clearFromStore() : void
      {
         _fromStoreScrollPane.source = null;
         fromStoreContent = new Sprite();
         _fromStoreMercenaryViews = new Vector.<MercenaryTransferWindowMercenaryView>();
      }
      
      public function addMercenariesToInBunker(param1:Vector.<UnitTypeAmountDTO>, param2:int) : void
      {
         var _loc4_:MercenaryTransferWindowMercenaryView = null;
         clearInBunker();
         _currentHousing = param2;
         var _loc5_:int = 0;
         for each(var _loc3_ in param1)
         {
            _loc4_ = new MercenaryTransferWindowMercenaryView(_loc3_.id,2,_type,_loc3_.amount);
            _loc4_.x = 9;
            _loc4_.y = _loc5_ * 63;
            inBunkerContent.addChild(_loc4_);
            inWatchPostMercenaryViews.push(_loc4_);
            _loc5_++;
         }
         inBunkerScrollPane.source = inBunkerContent;
         housingToBeAdd = _housingToBeAdd;
      }
      
      private function clearInBunker() : void
      {
         _currentHousing = 0;
         inBunkerScrollPane.source = null;
         inBunkerContent = new Sprite();
         inWatchPostMercenaryViews = new Vector.<MercenaryTransferWindowMercenaryView>();
      }
      
      public function get tabBar() : WomTabBar
      {
         return _tabBar;
      }
      
      public function activateTabByIndex(param1:int) : void
      {
         var _loc2_:* = null;
         housingToBeAdd = 0;
         transferGoldAmount = 0;
         transferResourceAmount = 0;
         for each(_loc2_ in _fromHousingMercenaryViews)
         {
            _loc2_.selectedAmount = 0;
         }
         for each(_loc2_ in _fromStoreMercenaryViews)
         {
            _loc2_.selectedAmount = 0;
         }
         if(param1 == 0)
         {
            _fromHousingScrollPane.visible = true;
            _fromStoreScrollPane.visible = false;
            _transferGoldCost.visible = false;
            _transferResourceCost.visible = _type == 1;
            blueSparkle.visible = _type == 1;
         }
         else
         {
            _fromHousingScrollPane.visible = false;
            _fromStoreScrollPane.visible = true;
            _transferGoldCost.visible = true;
            _transferResourceCost.visible = false;
            blueSparkle.visible = true;
         }
      }
      
      public function get housingToBeAdd() : int
      {
         return _housingToBeAdd;
      }
      
      public function set housingToBeAdd(param1:int) : void
      {
         _housingToBeAdd = param1;
         if(bunkerCapacityFractionalTextField && bunkerCapacityPercentageTextField && bunkerCapacityProgress)
         {
            bunkerCapacityFractionalTextField.text = _currentHousing + _housingToBeAdd + "/" + _housingCapacity;
            var _temp_6:* = bunkerCapacityPercentageTextField;
            var _temp_5:* = "(";
            var _temp_4:* = "ui.common.percentage";
            var _loc2_:int = (_currentHousing + _housingToBeAdd) / _housingCapacity * 100 << 0;
            var _loc3_:String = _temp_4;
            _temp_6.text = _temp_5 + peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_) + ")";
            bunkerCapacityProgress.maximum = _housingCapacity;
            bunkerCapacityProgress.value = _currentHousing + _housingToBeAdd;
         }
      }
      
      public function get currentHousing() : int
      {
         return _currentHousing;
      }
      
      public function set housingCapacity(param1:int) : void
      {
         _housingCapacity = param1;
         housingToBeAdd = _housingToBeAdd;
      }
      
      public function get housingCapacity() : int
      {
         return _housingCapacity;
      }
      
      public function get transferResourceAmount() : int
      {
         return _transferResourceAmount;
      }
      
      public function set transferResourceAmount(param1:int) : void
      {
         _transferResourceAmount = param1;
         _transferResourceCost.label = NumberUtil.format(param1);
         toggleTransferAlpha(param1 <= 0);
      }
      
      public function toggleTransferAlpha(param1:Boolean) : void
      {
         var _loc2_:Number = param1 ? 0.5 : 1;
         _transferGoldCost.alpha = _transferResourceCost.alpha = _transferButton.alpha = _loc2_;
         _transferButton.enabled = !param1;
         _transferButton.mouseEnabled = true;
         var _loc4_:String;
         var _loc5_:String;
         _transferButtonTooltip.tooltipText = param1 ? (_loc4_ = "ui.windows.watchpost.disabledtransfertooltip",peak.i18n.PText.INSTANCE.getText0(_loc4_)) : (_loc5_ = "ui.windows.watchpost.enabledtransfertooltip",peak.i18n.PText.INSTANCE.getText0(_loc5_));
         _transferButtonTooltip.updateTooltipAlignmentAccordingToObject((_transferButton.width - _transferButtonTooltip.width) / 2,-_transferButtonTooltip.height);
      }
      
      public function get transferGoldAmount() : int
      {
         return _transferGoldAmount;
      }
      
      public function set transferGoldAmount(param1:int) : void
      {
         _transferGoldAmount = param1;
         _transferGoldCost.label = NumberUtil.format(param1);
         toggleTransferAlpha(param1 <= 0);
      }
      
      public function get transferButton() : WomButton
      {
         return _transferButton;
      }
      
      public function get fromHousingMercenaryViews() : Vector.<MercenaryTransferWindowMercenaryView>
      {
         return _fromHousingMercenaryViews;
      }
      
      public function get fromStoreMercenaryViews() : Vector.<MercenaryTransferWindowMercenaryView>
      {
         return _fromStoreMercenaryViews;
      }
      
      public function get tabToBeActivated() : int
      {
         return _tabToBeActivated;
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}

