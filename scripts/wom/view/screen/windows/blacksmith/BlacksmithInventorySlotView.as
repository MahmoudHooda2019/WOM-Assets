package wom.view.screen.windows.blacksmith
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import peak.component.PTextField;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import peak.util.DateTimeUtil;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.game.store.EventInventoryItemInfo;
   import wom.model.game.store.StoreUtil;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomGreenSmallButton;
   import wom.view.util.BaseWindowPanel;
   
   public class BlacksmithInventorySlotView extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 99;
      
      private static const HEIGHT:int = 100;
      
      public static const STATE_EMPTY:int = 0;
      
      public static const STATE_WAITING:int = 1;
      
      public static const STATE_IN_PROGRESS:int = 2;
      
      public static const STATE_READY:int = 3;
      
      public static const STATE_LOCKED:int = 4;
      
      private var _state:int;
      
      private var _eventInventoryItemInfo:EventInventoryItemInfo;
      
      private var _stateLabel:PTextField;
      
      private var _finishNowButton:WomGreenSmallButton;
      
      private var _eventItemAsset:AssetDisplayObject;
      
      private var itemAssetContainer:Sprite;
      
      private var _eventItemDIO:EventItemDIO;
      
      private var _eventItemId:int;
      
      private var progressMask:Sprite;
      
      private var inProgressMask:Sprite;
      
      private var clockIcon:AssetDisplayObject;
      
      private var progressTextField:CaptionTextField;
      
      private var _index:int;
      
      private var _eventItemCancelIcon:AssetDisplayObject;
      
      private var lockIcon:AssetDisplayObject;
      
      private var lockTextField:PTextField;
      
      private var _requiredGoldForFinish:Number;
      
      private var _blacksmithCurrentLevel:int;
      
      public function BlacksmithInventorySlotView(param1:EventInventoryItemInfo, param2:int, param3:int)
      {
         super(99,100);
         _blacksmithCurrentLevel = param3;
         if(param1 != null)
         {
            _eventInventoryItemInfo = param1;
            _eventItemId = _eventInventoryItemInfo.id;
         }
         else
         {
            _state = 0;
            _eventItemId = -1;
         }
         _index = param2;
      }
      
      private static function getLabelTextAccordingToState(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               var _loc4_:String = "ui.windows.blacksmith.states.waiting";
               return peak.i18n.PText.INSTANCE.getText0(_loc4_);
            case 1:
               var _loc2_:String = "ui.windows.blacksmith.states.inprogress";
               return peak.i18n.PText.INSTANCE.getText0(_loc2_);
            case 2:
               var _loc3_:String = "ui.windows.blacksmith.states.ready";
               return peak.i18n.PText.INSTANCE.getText0(_loc3_);
            case 3:
               var _loc5_:String = "ui.windows.blacksmith.states.locked";
               return peak.i18n.PText.INSTANCE.getText0(_loc5_);
            default:
               var _loc6_:String = "ui.windows.blacksmith.states.empty";
               return peak.i18n.PText.INSTANCE.getText0(_loc6_);
         }
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         itemAssetContainer = new Sprite();
         addChild(itemAssetContainer);
         _stateLabel = _state == 2 ? new CaptionTextField(WomTextFormats.BLACK_FILTER) : new WomTextField();
         _stateLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _stateLabel.autoSize = "left";
         itemAssetContainer.addChild(_stateLabel);
         _finishNowButton = new WomGreenSmallButton();
         _finishNowButton.width = 97;
         var _temp_4:* = _finishNowButton;
         var _loc1_:String = "ui.windows.blacksmith.finishnow";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _finishNowButton.setStyle("icon",assetRepository.getDisplayObject("IconGoldMini"));
         addChild(_finishNowButton);
         progressMask = new Sprite();
         addChild(progressMask);
         inProgressMask = new Sprite();
         inProgressMask.visible = false;
         inProgressMask.alpha = 0.5;
         inProgressMask.graphics.beginFill(16310409,0.8);
         inProgressMask.graphics.drawRoundRect(0,0,99,100,18,18);
         inProgressMask.graphics.endFill();
         addChild(inProgressMask);
         inProgressMask.mask = progressMask;
         clockIcon = assetRepository.getDisplayObject("Clock45");
         clockIcon.scaleX = clockIcon.scaleY = 0.66;
         clockIcon.visible = false;
         addChild(clockIcon);
         progressTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         progressTextField.defaultTextFormat = WomTextFormats.CAPTION_16;
         progressTextField.autoSize = "left";
         progressTextField.visible = false;
         addChild(progressTextField);
         _eventItemCancelIcon = assetRepository.getDisplayObject("HiringQuartersCancel");
         _eventItemCancelIcon.alpha = 0;
         addChild(_eventItemCancelIcon);
         lockIcon = assetRepository.getDisplayObject("Lock");
         lockIcon.visible = false;
         lockIcon.scaleX = lockIcon.scaleY = 0.8;
         lockIcon.alpha = 0.5;
         addChild(lockIcon);
         lockTextField = new WomTextField();
         lockTextField.defaultTextFormat = WomTextFormats.CENTER_16;
         lockTextField.multiline = true;
         lockTextField.wordWrap = true;
         lockTextField.width = 99 - 5;
         lockTextField.height = 100 - 5;
         var _temp_13:* = lockTextField;
         var _temp_12:* = "ui.windows.blacksmith.levelrequired";
         var _loc2_:int = requiredBlacksmithLevel;
         var _loc3_:String = _temp_12;
         _temp_13.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         lockTextField.visible = false;
         addChild(lockTextField);
         updateInfo(_eventInventoryItemInfo);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_stateLabel,bg,-18);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_finishNowButton,bg,107);
         AlignmentUtil.alignAccordingToPositionOf(clockIcon,bg,10,69);
         AlignmentUtil.alignAccordingToPositionOf(progressTextField,clockIcon,23,5);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(lockIcon,bg,60);
         AlignmentUtil.alignMiddleOf(lockTextField,bg);
      }
      
      public function updateInfo(param1:EventInventoryItemInfo) : void
      {
         var _loc2_:Number = NaN;
         _eventInventoryItemInfo = param1;
         _eventItemId = param1 ? param1.id : -1;
         _state = calculateState();
         if(itemAssetContainer.contains(_stateLabel))
         {
            itemAssetContainer.removeChild(_stateLabel);
         }
         _stateLabel = _state == 2 ? new CaptionTextField(WomTextFormats.BLACK_FILTER) : new WomTextField();
         _stateLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _stateLabel.autoSize = "left";
         _stateLabel.text = getLabelTextAccordingToState(_state);
         itemAssetContainer.addChild(_stateLabel);
         inProgressMask.visible = progressMask.visible = _finishNowButton.visible = _state == 2 || _state == 1;
         clockIcon.visible = progressTextField.visible = _state == 2;
         lockIcon.visible = lockTextField.visible = _state == 4;
         if(param1)
         {
            _loc2_ = _state == 2 ? param1.getRemainingDuration() : param1.originalDuration;
            _requiredGoldForFinish = StoreUtil.mercenaryHiringPrice(_loc2_ / 1000) << 0;
            _finishNowButton.rightLabel = "" + (_requiredGoldForFinish < 1 ? 1 : _requiredGoldForFinish);
         }
         if(_state == 1)
         {
            progressMask.graphics.clear();
            progressMask.graphics.beginFill(16310409,0.8);
            progressMask.graphics.drawRect(0,0,inProgressMask.width,inProgressMask.height);
            AlignmentUtil.alignAccordingToPositionOf(progressMask,inProgressMask,0,inProgressMask.height - progressMask.height);
         }
         if(_eventItemAsset != null)
         {
            if(itemAssetContainer.contains(_eventItemAsset))
            {
               itemAssetContainer.removeChild(_eventItemAsset);
            }
         }
         if(param1)
         {
            _eventItemAsset = assetRepository.getDisplayObject(_eventItemDIO.assetName + "Medium");
            _eventItemAsset.width = 99;
            _eventItemAsset.height = 100;
            itemAssetContainer.addChild(_eventItemAsset);
         }
         if(_state == 2)
         {
            bg.filters = [new GlowFilter(2135263,1,7,7,5)];
         }
         else
         {
            bg.filters = null;
         }
         drawLayout();
      }
      
      public function updateProgress() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = _state;
         _state = calculateState();
         if(_loc2_ != _state)
         {
            updateInfo(_eventInventoryItemInfo);
         }
         if(_state == 2)
         {
            _loc1_ = _eventInventoryItemInfo.getRemainingDuration();
            progressTextField.text = DateTimeUtil.getFormattedTime(_loc1_);
            progressMask.graphics.clear();
            progressMask.graphics.beginFill(16310409,0.8);
            progressMask.graphics.drawRect(0,0,inProgressMask.width,int(inProgressMask.height * _loc1_ / _eventInventoryItemInfo.originalDuration));
            AlignmentUtil.alignAccordingToPositionOf(progressMask,inProgressMask,0,0);
            _requiredGoldForFinish = StoreUtil.mercenaryHiringPrice(_loc1_ / 1000) << 0;
            _finishNowButton.rightLabel = "" + (_requiredGoldForFinish < 1 ? 1 : _requiredGoldForFinish);
         }
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "BackgroundLight";
      }
      
      private function calculateState() : int
      {
         var _loc1_:int = 0;
         if(eventInventoryItemInfo != null)
         {
            _loc1_ = eventInventoryItemInfo.getRemainingDuration();
            if(_loc1_ == 0)
            {
               return 3;
            }
            if(_loc1_ > eventInventoryItemInfo.originalDuration)
            {
               return 1;
            }
            if(_loc1_ > 0)
            {
               return 2;
            }
         }
         else if(requiredBlacksmithLevel > _blacksmithCurrentLevel)
         {
            return 4;
         }
         return 0;
      }
      
      private function get requiredBlacksmithLevel() : int
      {
         return _index - 4;
      }
      
      public function set eventItemDIO(param1:EventItemDIO) : void
      {
         _eventItemDIO = param1;
      }
      
      public function get eventInventoryItemInfo() : EventInventoryItemInfo
      {
         return _eventInventoryItemInfo;
      }
      
      public function get eventItemId() : int
      {
         return _eventItemId;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get eventItemCancelIcon() : DisplayObject
      {
         return _eventItemCancelIcon;
      }
      
      public function get eventItemDIO() : EventItemDIO
      {
         return _eventItemDIO;
      }
      
      public function get finishNowButton() : WomGreenSmallButton
      {
         return _finishNowButton;
      }
      
      public function get requiredGoldForFinish() : Number
      {
         return _requiredGoldForFinish;
      }
   }
}

