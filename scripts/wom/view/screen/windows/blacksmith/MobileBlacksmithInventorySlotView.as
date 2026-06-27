package wom.view.screen.windows.blacksmith
{
   import peak.component.mobile.MPRigidButton;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.controller.event.GameTickEvent;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.game.store.EventInventoryItemInfo;
   import wom.model.game.store.StoreUtil;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileBlacksmithInventorySlotView extends Sprite implements View
   {
      
      private static const WIDTH:int = 92;
      
      private static const HEIGHT:int = 93;
      
      public static const STATE_EMPTY:int = 0;
      
      public static const STATE_WAITING:int = 1;
      
      public static const STATE_IN_PROGRESS:int = 2;
      
      public static const STATE_READY:int = 3;
      
      public static const STATE_LOCKED:int = 4;
      
      private var _state:int;
      
      private var _eventInventoryItemInfo:EventInventoryItemInfo;
      
      private var _finishNowButton:MobileWomButton;
      
      private var _eventItemDIO:EventItemDIO;
      
      private var _slotIndex:int;
      
      private var _timeProgressBar:MobileWomProgressBar;
      
      private var finishNowLabel:MobileCaptionTextField;
      
      private var finishNowCostLabel:MobileCaptionTextField;
      
      private var finishNowGoldIcon:DisplayObject;
      
      private var slotHeader:MobileCaptionTextField;
      
      private var _minusButton:DisplayObject;
      
      private var _eventItemId:int;
      
      private var slotBackground:DisplayObject;
      
      private var threeDotsAsset:DisplayObject;
      
      private var _eventItemButton:MobileWomButton;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var lockIcon:DisplayObject;
      
      private var _requiredGoldForFinish:int;
      
      private var blacksmithCurrentLevel:int;
      
      private var blacksmithRequirementLabel:MobileWomTextField;
      
      public function MobileBlacksmithInventorySlotView(param1:MobileWomAssetRepository, param2:int)
      {
         super();
         this.assetRepository = param1;
         this.blacksmithCurrentLevel = param2;
         init();
      }
      
      private static function getSlotHeaderAccordingToState(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               var _loc3_:String = "ui.windows.blacksmith.states.waiting";
               return peak.i18n.PText.INSTANCE.getText0(_loc3_);
            case 1:
               return "";
            case 2:
               var _loc2_:String = "ui.windows.blacksmith.states.ready";
               return peak.i18n.PText.INSTANCE.getText0(_loc2_);
            case 3:
               var _loc4_:String = "ui.windows.blacksmith.states.locked";
               return peak.i18n.PText.INSTANCE.getText0(_loc4_);
            default:
               return "";
         }
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         slotBackground = assetRepository.getDisplayObject("MercSlotBackground");
         addChild(slotBackground);
         slotBackground.width = 92;
         threeDotsAsset = assetRepository.getDisplayObject("SymbolThreeDot");
         addChild(threeDotsAsset);
         _eventItemButton = MobileWomUIComponentFactory.createMobileColoredButton("Beige","Large");
         _eventItemButton.width = 92;
         _eventItemButton.isSelected = true;
         addChild(_eventItemButton);
         slotHeader = createCaptionTextField(this,23);
         _minusButton = new MPRigidButton("IconRedDecrease","IconRedDecreaseHover");
         addChild(_minusButton);
         _finishNowButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         _finishNowButton.width = 83;
         addChild(_finishNowButton);
         finishNowLabel = createCaptionTextField(_finishNowButton,21);
         finishNowGoldIcon = assetRepository.getDisplayObject("IconGoldS");
         _finishNowButton.addChild(finishNowGoldIcon);
         finishNowCostLabel = createCaptionTextField(_finishNowButton,25);
         var _temp_10:* = finishNowLabel;
         var _loc1_:String = "ui.windows.blacksmith.finishnow";
         _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         finishNowCostLabel.text = "70";
         _timeProgressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         _timeProgressBar.align = "center";
         _timeProgressBar.width = 83;
         _timeProgressBar.minimum = 0;
         addChild(_timeProgressBar);
         lockIcon = assetRepository.getDisplayObject("IconLockMBordered");
         lockIcon.scaleX = lockIcon.scaleY = 0.55;
         lockIcon.visible = false;
         addChild(lockIcon);
         blacksmithRequirementLabel = new MobileWomTextField();
         var _temp_15:* = blacksmithRequirementLabel;
         var _temp_14:* = "ui.windows.blacksmith.levelrequired";
         var _loc2_:int = requiredBlacksmithLevel;
         var _loc3_:String = _temp_14;
         _temp_15.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         blacksmithRequirementLabel.textRendererProperties.textFormat = getWomTextFormat(18,"center");
         blacksmithRequirementLabel.textRendererProperties.wordWrap = true;
         blacksmithRequirementLabel.width = 92 - 5;
         blacksmithRequirementLabel.visible = false;
         addChild(blacksmithRequirementLabel);
         drawLayout();
      }
      
      private function createCaptionTextField(param1:Sprite, param2:int) : MobileCaptionTextField
      {
         var _loc3_:MobileCaptionTextField = new MobileCaptionTextField();
         _loc3_.textRendererProperties.textFormat = getCaptionTextFormat(param2);
         param1.addChild(_loc3_);
         return _loc3_;
      }
      
      public function drawLayout() : void
      {
         slotHeader.x = 92 - slotHeader.width >> 1;
         slotHeader.y = 8;
         _timeProgressBar.x = 92 - _timeProgressBar.width >> 1;
         slotBackground.x = 92 - slotBackground.width >> 1;
         slotBackground.y = 44;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(blacksmithRequirementLabel,slotBackground,7);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(lockIcon,slotBackground,50);
         MobileAlignmentUtil.alignMiddleOf(threeDotsAsset,slotBackground);
         MobileAlignmentUtil.alignMiddleOf(_eventItemButton,slotBackground);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_finishNowButton,_eventItemButton,93 + 3);
         finishNowLabel.x = 20;
         finishNowLabel.y = 6;
         finishNowGoldIcon.x = 14;
         finishNowGoldIcon.y = 20;
         finishNowCostLabel.x = 37;
         finishNowCostLabel.y = 26;
         MobileAlignmentUtil.alignAccordingToPositionOf(_minusButton,_eventItemButton,68,-4);
      }
      
      public function updateInfo(param1:EventInventoryItemInfo, param2:EventItemDIO, param3:int) : void
      {
         _slotIndex = param3;
         _eventInventoryItemInfo = param1;
         _state = calculateState(_eventInventoryItemInfo);
         if(_state == 0)
         {
            clearSlot();
            return;
         }
         if(_state == 4)
         {
            lockSlot();
            return;
         }
         if(_state == 2)
         {
            _minusButton.visible = true;
            slotHeader.visible = false;
            _timeProgressBar.visible = true;
         }
         else
         {
            _minusButton.visible = false;
            slotHeader.visible = true;
            _timeProgressBar.visible = false;
            slotHeader.text = getSlotHeaderAccordingToState(_state);
         }
         lockIcon.visible = blacksmithRequirementLabel.visible = false;
         _finishNowButton.visible = _state != 3;
         _eventItemButton.visible = _minusButton.visible = true;
         _eventItemDIO = param2;
         _eventItemButton.defaultIcon = assetRepository.getDisplayObject(_eventItemDIO.assetName.substring(0,_eventItemDIO.assetName.length - 4) + "Portrait");
         var _loc4_:Number = _state == 2 ? param1.getRemainingDuration() : param1.originalDuration;
         _requiredGoldForFinish = StoreUtil.mercenaryHiringPrice(_loc4_ / 1000) << 0;
         finishNowCostLabel.text = "" + (_requiredGoldForFinish < 1 ? 1 : _requiredGoldForFinish);
         _timeProgressBar.maximum = param1.originalDuration;
         _timeProgressBar.value = param1.getRemainingDuration();
         drawLayout();
      }
      
      public function clearSlot() : void
      {
         _eventItemButton.visible = slotHeader.visible = _minusButton.visible = _finishNowButton.visible = _timeProgressBar.visible = lockIcon.visible = blacksmithRequirementLabel.visible = false;
         slotBackground.visible = threeDotsAsset.visible = true;
         _state = 0;
         _eventItemId = -1;
         _eventItemDIO = null;
         _eventInventoryItemInfo = null;
         _eventItemButton.defaultIcon = null;
      }
      
      public function lockSlot() : void
      {
         _eventItemButton.visible = slotHeader.visible = _minusButton.visible = _finishNowButton.visible = _timeProgressBar.visible = threeDotsAsset.visible = false;
         slotBackground.visible = lockIcon.visible = blacksmithRequirementLabel.visible = true;
         _state = 4;
         _eventItemId = -1;
         _eventItemDIO = null;
         _eventInventoryItemInfo = null;
         _eventItemButton.defaultIcon = null;
         var _temp_11:* = blacksmithRequirementLabel;
         var _temp_10:* = "ui.windows.blacksmith.levelrequired";
         var _loc2_:int = requiredBlacksmithLevel;
         var _loc3_:String = _temp_10;
         _temp_11.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
      }
      
      public function updateProgress(param1:GameTickEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_state == 2)
         {
            _loc3_ = _state;
            _state = calculateState(eventInventoryItemInfo);
            if(_loc3_ != _state)
            {
               updateInfo(_eventInventoryItemInfo,_eventItemDIO,_slotIndex);
            }
            if(_state == 2)
            {
               _loc2_ = _eventInventoryItemInfo.getRemainingDuration();
               _timeProgressBar.label = DateTimeUtil.getFormattedTime(_loc2_);
               _requiredGoldForFinish = StoreUtil.mercenaryHiringPrice(_loc2_ / 1000) << 0;
               finishNowCostLabel.text = "" + (_requiredGoldForFinish < 1 ? 1 : _requiredGoldForFinish);
               _timeProgressBar.value = _eventInventoryItemInfo.getRemainingDuration();
            }
         }
      }
      
      private function calculateState(param1:EventInventoryItemInfo) : int
      {
         var _loc2_:int = 0;
         if(param1 != null)
         {
            _loc2_ = param1.getRemainingDuration();
            if(_loc2_ == 0)
            {
               return 3;
            }
            if(_loc2_ > param1.originalDuration)
            {
               return 1;
            }
            if(_loc2_ > 0)
            {
               return 2;
            }
         }
         if(requiredBlacksmithLevel > blacksmithCurrentLevel)
         {
            return 4;
         }
         return 0;
      }
      
      private function get requiredBlacksmithLevel() : int
      {
         return _slotIndex - 4;
      }
      
      public function set eventItemDIO(param1:EventItemDIO) : void
      {
         _eventItemDIO = param1;
      }
      
      public function get eventInventoryItemInfo() : EventInventoryItemInfo
      {
         return _eventInventoryItemInfo;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get slotIndex() : int
      {
         return _slotIndex;
      }
      
      public function get eventItemDIO() : EventItemDIO
      {
         return _eventItemDIO;
      }
      
      public function get finishNowButton() : MobileWomButton
      {
         return _finishNowButton;
      }
      
      public function get minusButton() : DisplayObject
      {
         return _minusButton;
      }
      
      public function get requiredGoldForFinish() : int
      {
         return _requiredGoldForFinish;
      }
   }
}

