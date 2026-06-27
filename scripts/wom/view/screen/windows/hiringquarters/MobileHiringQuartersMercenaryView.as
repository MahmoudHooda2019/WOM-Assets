package wom.view.screen.windows.hiringquarters
{
   import com.greensock.TweenLite;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileIconLabelView;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileHiringQuartersMercenaryView extends Sprite implements View
   {
      
      public static const IN_PROGRESS:int = 0;
      
      public static const QUEUED:int = 1;
      
      public static const SELECT:int = 2;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _unitTypeId:int;
      
      private var _buildingInstanceId:int;
      
      private var _viewType:int;
      
      private var _numberOfUnits:int;
      
      private var _slotIndex:int;
      
      private var _dontAskForOverflow:Boolean;
      
      private var _isCentralHiring:Boolean;
      
      protected var _mercenaryPortrait:DisplayObject;
      
      private var _clockIcon:DisplayObject;
      
      private var _unitTypeInfo:UnitTypeInfo;
      
      private var _mercButton:MobileWomButton;
      
      private var _subButton:MPRigidButton;
      
      private var _infoButton:MPRigidButton;
      
      private var _requiredResourceView:MobileIconLabelView;
      
      private var _selectedCountTextField:MPTextField;
      
      private var _timeRequiredTextField:MPTextField;
      
      private var _hireAnimationIcons:Dictionary;
      
      private var _hireAnimationCounter:int;
      
      private var _cancelAnimationTFs:Dictionary;
      
      private var _cancelAnimationCounter:int;
      
      private var _selectedCount:int;
      
      private var _unitTypeDIO:UnitTypeDIO;
      
      private var _isMercButtonDown:Boolean;
      
      public function MobileHiringQuartersMercenaryView(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0, param6:Boolean = false)
      {
         super();
         _unitTypeId = param1;
         _buildingInstanceId = param2;
         _viewType = param3;
         _numberOfUnits = param4;
         _slotIndex = param5;
         _dontAskForOverflow = param6;
         _hireAnimationIcons = new Dictionary();
         _cancelAnimationTFs = new Dictionary();
         _hireAnimationCounter = 0;
         _cancelAnimationCounter = 0;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _mercenaryPortrait = assetRepository.getDisplayObject(_unitTypeDIO.assetName + "Portrait");
         _mercButton = MobileWomUIComponentFactory.createMobileColoredButton("Beige","Large");
         _mercButton.width = 92;
         _mercButton.defaultIcon = _mercenaryPortrait;
         addChild(_mercButton);
         _clockIcon = assetRepository.getDisplayObject("IconTimerM");
         _clockIcon.visible = _viewType == 2;
         _clockIcon.scaleX = _clockIcon.scaleY = 21 / _clockIcon.height;
         addChild(_clockIcon);
         var _loc3_:int = _unitTypeInfo.currentLevel - 1;
         var _loc2_:Number = unitTypeDIO.hiringDurationPerLevelInSecs[_loc3_];
         var _loc1_:Number = unitTypeDIO.hiringCostsPerLevel[_loc3_][0].resourceAmount;
         _timeRequiredTextField = new MobileCaptionTextField();
         _timeRequiredTextField.visible = _viewType == 2;
         _timeRequiredTextField.isEnabled = false;
         _timeRequiredTextField.textRendererProperties.textFormat = getCaptionTextFormat(18);
         _timeRequiredTextField.text = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc2_);
         addChild(_timeRequiredTextField);
         _requiredResourceView = new MobileIconLabelView("IconIronMBordered",NumberUtil.format(_loc1_),null,null,getCaptionTextFormat(18),null,true,0.45,"right",-10);
         _requiredResourceView.visible = _viewType == 2;
         _requiredResourceView.touchable = false;
         addChild(_requiredResourceView);
         _selectedCountTextField = new MobileCaptionTextField();
         _selectedCountTextField.visible = _viewType == 1;
         _selectedCountTextField.isEnabled = false;
         _selectedCountTextField.textRendererProperties.textFormat = getCaptionTextFormat(23);
         _selectedCountTextField.touchable = false;
         addChild(_selectedCountTextField);
         _selectedCountTextField.text = _numberOfUnits + "";
         _subButton = new MPRigidButton("IconRedDecrease","IconRedDecreaseHover");
         _subButton.setPaddings(0,10,10);
         _subButton.visible = _viewType != 2;
         addChild(_subButton);
         _infoButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _infoButton.setPaddings(0,10,10);
         _infoButton.visible = _viewType == 2;
         addChild(_infoButton);
      }
      
      public function drawLayout() : void
      {
         switch(_viewType - 2)
         {
            case 0:
               MobileAlignmentUtil.alignRightWithYMarginOf(_infoButton,_mercButton,-10,-30);
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_requiredResourceView,_mercButton,54 + (_isMercButtonDown ? 3 : 0));
               MobileAlignmentUtil.alignBelowWithXMarginOf(_clockIcon,_mercButton,12,-5);
               MobileAlignmentUtil.alignRightWithYMarginOf(_timeRequiredTextField,_clockIcon,5,-6);
               break;
            default:
               MobileAlignmentUtil.alignRightWithYMarginOf(_subButton,_mercButton,-10,-30);
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_selectedCountTextField,_mercButton,61);
         }
      }
      
      public function updateUnit(param1:UnitTypeInfo) : void
      {
         _unitTypeInfo = param1;
         _mercenaryPortrait.alpha = (_mercButton.isEnabled = param1.recruited) ? 1 : 0.5;
      }
      
      public function showHireAnimation() : void
      {
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("SymbolGreenPlus");
         _loc1_.touchable = false;
         addChild(_loc1_);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_loc1_,_mercButton,-(_loc1_.height + 5));
         _hireAnimationIcons[++_hireAnimationCounter] = _loc1_;
         TweenLite.to(_loc1_,0.75,{
            "delay":0,
            "alpha":0,
            "y":_loc1_.y - 30,
            "onComplete":hireAnimationEnded,
            "onCompleteParams":[_hireAnimationCounter]
         });
      }
      
      private function hireAnimationEnded(param1:int) : void
      {
         removeChild(_hireAnimationIcons[param1]);
         TweenLite.killTweensOf(_hireAnimationIcons[param1]);
         delete _hireAnimationIcons[param1];
         _hireAnimationCounter = _hireAnimationCounter - 1;
      }
      
      public function showCancelQueuedAnimation() : void
      {
         var _loc1_:MPTextField = new MobileCaptionTextField();
         _loc1_.textRendererProperties.textFormat = getCaptionTextFormat(33,"center",15016227);
         _loc1_.touchable = false;
         addChild(_loc1_);
         _loc1_.text = _numberOfUnits.toString();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_loc1_,_mercButton,-(_loc1_.height - 5));
         _cancelAnimationTFs[++_cancelAnimationCounter] = _loc1_;
         TweenLite.to(_loc1_,0.75,{
            "delay":0,
            "alpha":0,
            "y":_loc1_.y - 30,
            "onComplete":cancelQueuedAnimationEnded,
            "onCompleteParams":[_cancelAnimationCounter]
         });
      }
      
      private function cancelQueuedAnimationEnded(param1:int) : void
      {
         removeChild(_cancelAnimationTFs[param1]);
         TweenLite.killTweensOf(_cancelAnimationTFs[param1]);
         delete _cancelAnimationTFs[param1];
         _cancelAnimationCounter = _cancelAnimationCounter - 1;
      }
      
      public function get unitTypeDIO() : UnitTypeDIO
      {
         return _unitTypeDIO;
      }
      
      public function set unitTypeDIO(param1:UnitTypeDIO) : void
      {
         _unitTypeDIO = param1;
      }
      
      public function get selectedCountTextField() : MPTextField
      {
         return _selectedCountTextField;
      }
      
      public function set selectedCountTextField(param1:MPTextField) : void
      {
         _selectedCountTextField = param1;
      }
      
      public function get timeRequiredTextField() : MPTextField
      {
         return _timeRequiredTextField;
      }
      
      public function set timeRequiredTextField(param1:MPTextField) : void
      {
         _timeRequiredTextField = param1;
      }
      
      public function get selectedCount() : int
      {
         return _selectedCount;
      }
      
      public function set selectedCount(param1:int) : void
      {
         _selectedCount = param1;
      }
      
      public function get unitTypeInfo() : UnitTypeInfo
      {
         return _unitTypeInfo;
      }
      
      public function get subButton() : MPRigidButton
      {
         return _subButton;
      }
      
      public function get infoButton() : MPRigidButton
      {
         return _infoButton;
      }
      
      public function get viewType() : int
      {
         return _viewType;
      }
      
      public function set unitTypeInfo(param1:UnitTypeInfo) : void
      {
         _unitTypeInfo = param1;
      }
      
      public function get mercButton() : MobileWomButton
      {
         return _mercButton;
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
      
      public function set unitTypeId(param1:int) : void
      {
         _unitTypeId = param1;
      }
      
      public function get numberOfUnits() : int
      {
         return _numberOfUnits;
      }
      
      public function set numberOfUnits(param1:int) : void
      {
         _numberOfUnits = param1;
         _selectedCountTextField.text = _numberOfUnits.toString();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_selectedCountTextField,_mercButton,61);
      }
      
      public function get slotIndex() : int
      {
         return _slotIndex;
      }
      
      public function set slotIndex(param1:int) : void
      {
         _slotIndex = param1;
      }
      
      public function get visibleWidth() : int
      {
         return 93;
      }
      
      public function get visibleHeight() : int
      {
         return 112;
      }
      
      public function get dontAskForOverflow() : Boolean
      {
         return _dontAskForOverflow;
      }
      
      public function set dontAskForOverflow(param1:Boolean) : void
      {
         _dontAskForOverflow = param1;
      }
      
      public function get isCentralHiring() : Boolean
      {
         return _isCentralHiring;
      }
      
      public function set isCentralHiring(param1:Boolean) : void
      {
         _isCentralHiring = param1;
      }
      
      public function set buildingInstanceId(param1:int) : void
      {
         _buildingInstanceId = param1;
      }
      
      public function set viewType(param1:int) : void
      {
         _viewType = param1;
      }
      
      public function get isMercButtonDown() : Boolean
      {
         return _isMercButtonDown;
      }
      
      public function set isMercButtonDown(param1:Boolean) : void
      {
         _isMercButtonDown = param1;
      }
   }
}

