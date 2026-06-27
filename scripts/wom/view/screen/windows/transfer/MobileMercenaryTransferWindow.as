package wom.view.screen.windows.transfer
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPList;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTabBar;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileMercenaryTransferWindow extends MobileGenericWindow
   {
      
      public static const WATCH_POST:int = 1;
      
      public static const ALLIANCE_BARRACKS:int = 2;
      
      public static const FRIEND_WATCH_POST:int = 3;
      
      private static const WINDOW_WIDTH:int = 831;
      
      private static const WINDOW_HEIGHT:int = 685;
      
      private var _tabBar:MobileWomTabBar;
      
      private var fromBackground:DisplayObject;
      
      private var inBunkerBackground:DisplayObject;
      
      private var arrowAsset:DisplayObject;
      
      private var _fromHousingList:MPList;
      
      private var _fromStoreList:MPList;
      
      private var _inBunkerList:MPList;
      
      private var bunkerCapacityProgress:MobileWomProgressBar;
      
      private var bunkerCapacityLabel:MPTextField;
      
      private var _transferResourceAmount:int;
      
      private var _transferGoldAmount:int;
      
      private var _transferWithResourceButton:MobileWomButton;
      
      private var _transferWithGoldButton:MobileWomButton;
      
      private var _currentHousing:int;
      
      private var _housingCapacity:int;
      
      private var _housingToBeAdd:int = 0;
      
      private var _tabToBeActivated:int = 0;
      
      private var _type:int;
      
      public function MobileMercenaryTransferWindow(param1:int, param2:Vector.<WindowEnumeration> = null)
      {
         super(831,685,param2);
         _type = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.watchpost.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         fromBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         fromBackground.width = 353;
         fromBackground.height = 539;
         addChild(fromBackground);
         _tabBar = new MobileWomTabBar();
         var _temp_6:* = _tabBar;
         var _temp_5:* = §§findproperty(ListCollection);
         var _loc2_:String = "ui.windows.watchpost.fromhousing";
         var _temp_4:* = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         var _loc3_:String = "ui.windows.watchpost.fromstore";
         _temp_6.dataProvider = new ListCollection([_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc3_)]);
         _tabBar.selectedIndex = 0;
         _fromHousingList = new MPList();
         _fromHousingList.itemRendererFactory = getRendererFunctionForMode(0);
         _fromHousingList.width = fromBackground.width;
         _fromHousingList.height = fromBackground.height - 20;
         _fromHousingList.verticalScrollPolicy = "on";
         addChild(_fromHousingList);
         _fromStoreList = new MPList();
         _fromStoreList.itemRendererFactory = getRendererFunctionForMode(1);
         _fromStoreList.width = fromBackground.width;
         _fromStoreList.height = fromBackground.height - 20;
         _fromStoreList.verticalScrollPolicy = "on";
         addChild(_fromStoreList);
         MobileAlignmentUtil.alignAccordingToPositionOf(_fromStoreList,fromBackground,16,12);
         inBunkerBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         inBunkerBackground.width = 353;
         inBunkerBackground.height = 584;
         addChild(inBunkerBackground);
         _inBunkerList = new MPList();
         _inBunkerList.itemRendererFactory = getRendererFunctionForMode(2);
         _inBunkerList.width = inBunkerBackground.width;
         _inBunkerList.height = fromBackground.height - 20;
         _inBunkerList.verticalScrollPolicy = "on";
         addChild(_inBunkerList);
         bunkerCapacityProgress = MobileWomUIComponentFactory.createProgressBar("Yellow");
         bunkerCapacityProgress.width = 240;
         bunkerCapacityProgress.height = 33;
         bunkerCapacityProgress.minimum = 0;
         bunkerCapacityProgress.align = "center";
         addChild(bunkerCapacityProgress);
         bunkerCapacityLabel = new MobileCaptionTextField();
         bunkerCapacityLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         bunkerCapacityLabel.width = 66;
         addChild(bunkerCapacityLabel);
         var _loc4_:String;
         var _loc5_:String;
         bunkerCapacityLabel.text = _type == 1 ? (_loc4_ = "ui.mainframe.city.tooltip.capacity",peak.i18n.PText.INSTANCE.getText0(_loc4_)) : (_loc5_ = "ui.mainframe.city.tooltip.capacity",peak.i18n.PText.INSTANCE.getText0(_loc5_));
         _transferWithResourceButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _transferWithResourceButton.width = 340;
         var _temp_14:* = _transferWithResourceButton;
         var _loc6_:String = "ui.windows.watchpost.transfer";
         _temp_14.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _transferWithResourceButton.defaultIcon = assetRepository.getDisplayObject("IconMightL");
         _transferWithResourceButton.rightLabel = "0";
         _transferWithResourceButton.visible = _tabBar.selectedIndex == 0;
         addChild(_transferWithResourceButton);
         _transferWithGoldButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _transferWithGoldButton.width = 340;
         var _temp_16:* = _transferWithGoldButton;
         var _loc7_:String = "ui.windows.watchpost.transfer";
         _temp_16.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _transferWithGoldButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _transferWithGoldButton.rightLabel = "0";
         _transferWithGoldButton.visible = !_transferWithResourceButton.visible;
         addChild(_transferWithGoldButton);
         arrowAsset = assetRepository.getDisplayObject("ArrowBrownInner");
         addChild(arrowAsset);
         addChild(_tabBar);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_tabBar,_background,45,42);
         MobileAlignmentUtil.alignBelowWithXMarginOf(fromBackground,_tabBar,-8,-8);
         MobileAlignmentUtil.alignAccordingToPositionOf(_fromHousingList,fromBackground,16,12);
         MobileAlignmentUtil.alignAccordingToPositionOf(_fromStoreList,fromBackground,16,12);
         MobileAlignmentUtil.alignMiddleOf(arrowAsset,_background);
         MobileAlignmentUtil.alignAccordingToPositionOf(inBunkerBackground,_background,439,42);
         MobileAlignmentUtil.alignAccordingToPositionOf(bunkerCapacityLabel,inBunkerBackground,13,24);
         MobileAlignmentUtil.alignAccordingToPositionOf(bunkerCapacityProgress,inBunkerBackground,93,18);
         MobileAlignmentUtil.alignAccordingToPositionOf(inBunkerList,inBunkerBackground,16,12 + (fromBackground.y - inBunkerBackground.y));
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_transferWithResourceButton,_background,_background.height - 50);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_transferWithGoldButton,_background,_background.height - 50);
      }
      
      public function activateTabByIndex(param1:int) : Boolean
      {
         housingToBeAdd = 0;
         transferGoldAmount = 0;
         transferResourceAmount = 0;
         var _loc2_:Boolean = false;
         if(param1 == 0)
         {
            _fromHousingList.visible = true;
            _transferWithResourceButton.visible = true;
            if(_fromStoreList.numChildren > 0)
            {
               _fromStoreList.visible = false;
               _transferWithGoldButton.visible = false;
            }
         }
         else
         {
            if(_fromStoreList.numChildren == 0)
            {
               _loc2_ = true;
            }
            _fromHousingList.visible = false;
            _transferWithResourceButton.visible = false;
            _fromStoreList.visible = true;
            _transferWithGoldButton.visible = true;
            if(fromStoreList != null)
            {
               clearAllSelectedAmountsOfList(fromStoreList);
            }
         }
         return _loc2_;
      }
      
      public function addMercenariesToFromHousing(param1:Vector.<UnitTypeAmountDTO>, param2:Dictionary) : void
      {
         var _loc4_:Object = null;
         var _loc5_:Vector.<Object> = new Vector.<Object>();
         if(param1 == null || param1 && param1.length == 0)
         {
            _tabToBeActivated = 1;
            _tabBar.selectedIndex = 1;
            activateTabByIndex(_tabToBeActivated);
         }
         for each(var _loc3_ in param1)
         {
            _loc4_ = {};
            _loc4_.unitTypeDIO = param2[_loc3_.id];
            _loc4_.amount = _loc3_.amount;
            _loc4_.selectedAmount = 0;
            _loc5_.push(_loc4_);
         }
         _fromHousingList.dataProvider = new ListCollection(_loc5_);
         _fromHousingList.validate();
      }
      
      public function clearAllSelectedAmountsOfList(param1:MPList) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Object = null;
         var _loc2_:ListCollection = param1.dataProvider;
         if(_loc2_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc3_ = _loc2_.getItemAt(_loc4_);
               setSelectedAmount(_loc3_.unitTypeDIO.id,0,param1);
               _loc4_++;
            }
         }
      }
      
      public function addMercenariesToFromStore(param1:Vector.<UnitTypeDIO>) : void
      {
         var _loc4_:Object = null;
         var _loc3_:Vector.<Object> = new Vector.<Object>();
         for each(var _loc2_ in param1)
         {
            _loc4_ = {};
            _loc4_.unitTypeDIO = _loc2_;
            _loc4_.amount = 0;
            _loc4_.selectedAmount = 0;
            _loc3_.push(_loc4_);
         }
         _fromStoreList.dataProvider = new ListCollection(_loc3_);
         _fromStoreList.validate();
      }
      
      public function addMercenariesToInBunker(param1:Vector.<UnitTypeAmountDTO>, param2:Dictionary, param3:int) : void
      {
         var _loc5_:Object = null;
         var _loc6_:Vector.<Object> = new Vector.<Object>();
         _currentHousing = param3;
         var _loc7_:int = 0;
         for each(var _loc4_ in param1)
         {
            _loc5_ = {};
            _loc5_.unitTypeDIO = param2[_loc4_.id];
            _loc5_.amount = _loc4_.amount;
            _loc5_.selectedAmount = 0;
            _loc6_.push(_loc5_);
         }
         inBunkerList.dataProvider = new ListCollection(_loc6_);
         inBunkerList.validate();
         housingToBeAdd = _housingToBeAdd;
      }
      
      public function set housingToBeAdd(param1:int) : void
      {
         _housingToBeAdd = param1;
         if(bunkerCapacityProgress)
         {
            bunkerCapacityProgress.maximum = _housingCapacity;
            bunkerCapacityProgress.value = _currentHousing + _housingToBeAdd;
            bunkerCapacityProgress.label = _currentHousing + _housingToBeAdd + "/" + _housingCapacity;
         }
      }
      
      public function get housingToBeAdd() : int
      {
         return _housingToBeAdd;
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
         _transferWithResourceButton.rightLabel = NumberUtil.format(param1);
      }
      
      public function get transferGoldAmount() : int
      {
         return _transferGoldAmount;
      }
      
      public function set transferGoldAmount(param1:int) : void
      {
         _transferGoldAmount = param1;
         _transferWithGoldButton.rightLabel = NumberUtil.format(param1);
      }
      
      public function get tabToBeActivated() : int
      {
         return _tabToBeActivated;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      private function fromHousingRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileMercenaryTransferViewRenderer = new MobileMercenaryTransferViewRenderer(assetRepository,_type,0);
         _loc1_.width = 321;
         _loc1_.height = 132 + 21;
         return _loc1_;
      }
      
      private function fromStoreRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileMercenaryTransferViewRenderer = new MobileMercenaryTransferViewRenderer(assetRepository,_type,1);
         _loc1_.width = 321;
         _loc1_.height = 132 + 21;
         return _loc1_;
      }
      
      private function inBunkerRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileMercenaryTransferViewRenderer = new MobileMercenaryTransferViewRenderer(assetRepository,_type,2);
         _loc1_.width = 321;
         _loc1_.height = 132 + 21;
         return _loc1_;
      }
      
      private function getRendererFunctionForMode(param1:int) : Function
      {
         var _loc2_:Function = null;
         if(param1 == 0)
         {
            _loc2_ = fromHousingRendererFactory;
         }
         else if(param1 == 1)
         {
            _loc2_ = fromStoreRendererFactory;
         }
         else if(param1 == 2)
         {
            _loc2_ = inBunkerRendererFactory;
         }
         return _loc2_;
      }
      
      public function get tabBar() : MobileWomTabBar
      {
         return _tabBar;
      }
      
      public function get fromHousingList() : MPList
      {
         return _fromHousingList;
      }
      
      public function get fromStoreList() : MPList
      {
         return _fromStoreList;
      }
      
      public function get inBunkerList() : MPList
      {
         return _inBunkerList;
      }
      
      public function get transferWithResourceButton() : MobileWomButton
      {
         return _transferWithResourceButton;
      }
      
      public function get transferWithGoldButton() : MobileWomButton
      {
         return _transferWithGoldButton;
      }
      
      private function getItemWithIdFromList(param1:int, param2:MPList) : Object
      {
         var _loc5_:int = 0;
         var _loc4_:Object = null;
         var _loc3_:ListCollection = param2.dataProvider;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = _loc3_.getItemAt(_loc5_);
            if(_loc4_.unitTypeDIO.id == param1)
            {
               return _loc4_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function decrementSelectedAmount(param1:int, param2:MPList) : void
      {
         var _loc3_:int = getSelectedAmount(param1,param2);
         setSelectedAmount(param1,--_loc3_,param2);
      }
      
      public function incrementSelectedAmount(param1:int, param2:MPList) : void
      {
         var _loc3_:int = getSelectedAmount(param1,param2);
         setSelectedAmount(param1,++_loc3_,param2);
      }
      
      private function setSelectedAmount(param1:int, param2:int, param3:MPList) : void
      {
         var _loc5_:Object = getItemWithIdFromList(param1,param3);
         var _loc4_:int = param3.dataProvider.getItemIndex(_loc5_);
         _loc5_.selectedAmount = param2;
         param3.dataProvider.updateItemAt(_loc4_);
      }
      
      public function getSelectedAmount(param1:int, param2:MPList) : int
      {
         var _loc3_:Object = getItemWithIdFromList(param1,param2);
         return _loc3_.selectedAmount;
      }
      
      public function getTotalAmountInList(param1:MPList) : int
      {
         var _loc5_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc2_:ListCollection = param1.dataProvider;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_.getItemAt(_loc5_);
            _loc4_ += _loc3_.selectedAmount;
            _loc5_++;
         }
         return _loc4_;
      }
   }
}

