package wom.view.screen.windows.executionalguillotine
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileExecutionalGuillotineMercenaryView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var _mercenaryPortrait:DisplayObject;
      
      private var _unitTypeDIO:UnitTypeDIO;
      
      private var _unitTypeInfo:UnitTypeInfo;
      
      private var _selectionStatusTextField:MPTextField;
      
      private var _mercenaryCount:int;
      
      private var _selectedCount:int;
      
      private var _mercButton:MobileWomButton;
      
      private var _hireButton:MobileWomButton;
      
      private var _subButton:MPRigidButton;
      
      private var _isMercButtonDown:Boolean;
      
      private var _shieldIcon:DisplayObject;
      
      private var _levelTextField:MPTextField;
      
      private var _viewType:int;
      
      public function MobileExecutionalGuillotineMercenaryView(param1:UnitTypeDIO, param2:int)
      {
         super();
         _viewType = param2;
         _unitTypeDIO = param1;
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
         _mercButton.isEnabled = _viewType == 1;
         addChild(_mercButton);
         _selectionStatusTextField = new MobileCaptionTextField();
         _selectionStatusTextField.isEnabled = false;
         _selectionStatusTextField.textRendererProperties.textFormat = getCaptionTextFormat(23);
         addChild(_selectionStatusTextField);
         _shieldIcon = assetRepository.getDisplayObject("IconLevelBeastMBordered");
         _shieldIcon.width = 37;
         _shieldIcon.height = 37;
         _shieldIcon.visible = _viewType != 2;
         addChild(_shieldIcon);
         _levelTextField = new MobileCaptionTextField();
         _levelTextField.textRendererProperties.textFormat = getCaptionTextFormat(23);
         _levelTextField.visible = _viewType != 2;
         addChild(_levelTextField);
         _levelTextField.text = "" + _unitTypeInfo.currentLevel;
         _subButton = new MPRigidButton("IconRedDecrease","IconRedDecreaseHover");
         _subButton.setPaddings(0,10,10);
         _subButton.visible = _viewType == 1 || _viewType == 4;
         addChild(_subButton);
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("IconGoldS");
         _hireButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Small");
         _hireButton.isEnabled = _unitTypeInfo.recruited;
         var _temp_9:* = _hireButton;
         var _loc2_:String = "ui.windows.mercenarybarracks.hire";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _hireButton.rightLabel = _unitTypeDIO.barracksGoldPricesPerLevel[_unitTypeInfo.currentLevel - 1] + "";
         _hireButton.defaultIcon = _loc1_;
         _hireButton.width = 136;
         _hireButton.visible = _viewType == 2;
         addChild(_hireButton);
      }
      
      public function drawLayout() : void
      {
         var _loc1_:Boolean = false;
         if(_viewType == 2)
         {
            _mercButton.y = 0;
            _mercButton.x = (visibleWidth - _mercButton.width) / 2;
            MobileAlignmentUtil.alignBelowOf(_hireButton,_mercButton,2);
            _hireButton.x = 0;
         }
         else if(_viewType == 1 || _viewType == 4)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_subButton,_mercButton,64,-5);
            _loc1_ = _viewType == 1 && _selectedCount > 0 || _viewType == 4 && _mercenaryCount > 0;
            if(_loc1_)
            {
               _subButton.isEnabled = true;
               _subButton.visible = true;
            }
            else
            {
               _subButton.isEnabled = false;
               _subButton.visible = false;
            }
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_shieldIcon,_mercButton,-4,-6);
         MobileAlignmentUtil.alignMiddleOf(_levelTextField,_shieldIcon);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_selectionStatusTextField,_mercButton,61 + (_isMercButtonDown ? 3 : 0));
      }
      
      public function get visibleWidth() : int
      {
         if(_viewType == 1)
         {
            return 102;
         }
         if(_viewType == 2)
         {
            return 138;
         }
         return 91;
      }
      
      public function get visibleHeight() : int
      {
         if(_viewType == 1)
         {
            return 102;
         }
         if(_viewType == 2)
         {
            return 141;
         }
         return 91;
      }
      
      public function set selectionStatusText(param1:String) : void
      {
         _selectionStatusTextField.text = param1;
      }
      
      public function get unitTypeDIO() : UnitTypeDIO
      {
         return _unitTypeDIO;
      }
      
      public function get mercenaryCount() : int
      {
         return _mercenaryCount;
      }
      
      public function get selectedCount() : int
      {
         return _selectedCount;
      }
      
      public function set selectedCount(param1:int) : void
      {
         _selectedCount = param1;
         resetTextField();
      }
      
      public function get subButton() : MPRigidButton
      {
         return _subButton;
      }
      
      public function get viewType() : int
      {
         return _viewType;
      }
      
      public function get hireButton() : MobileWomButton
      {
         return _hireButton;
      }
      
      public function get unitTypeInfo() : UnitTypeInfo
      {
         return _unitTypeInfo;
      }
      
      public function set unitTypeInfo(param1:UnitTypeInfo) : void
      {
         _unitTypeInfo = param1;
      }
      
      public function updateMercenaryCount(param1:int) : void
      {
         if(_selectedCount > param1)
         {
            _selectedCount = param1;
         }
         _mercenaryCount = param1;
         resetTextField();
      }
      
      public function resetTextField() : void
      {
         _selectionStatusTextField.text = _viewType != 1 ? _mercenaryCount + "" : _selectedCount + " / " + _mercenaryCount;
         drawLayout();
      }
      
      public function get mercButton() : MobileWomButton
      {
         return _mercButton;
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

