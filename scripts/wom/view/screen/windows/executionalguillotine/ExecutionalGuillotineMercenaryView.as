package wom.view.screen.windows.executionalguillotine
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.display.CustomCursorAwareSprite;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomGreenMiniButton;
   
   public class ExecutionalGuillotineMercenaryView extends CustomCursorAwareSprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var background:DisplayObject;
      
      private var shieldIcon:DisplayObject;
      
      private var levelTextField:TextField;
      
      private var mercenaryPortrait:DisplayObject;
      
      private var lockIcon:DisplayObject;
      
      private var mercenaryNameTextField:TextField;
      
      private var _mercenarySelectionStatusTextField:TextField;
      
      private var _mercenaryCount:int;
      
      private var _selectedCount:int;
      
      private var _unitTypeDIO:UnitTypeDIO;
      
      private var _unitTypeInfo:UnitTypeInfo;
      
      private var _hireButton:WomButton;
      
      private var _executeButton:WomButton;
      
      private var oldX:int;
      
      private var oldY:int;
      
      private var _viewType:int;
      
      public function ExecutionalGuillotineMercenaryView(param1:UnitTypeDIO, param2:int)
      {
         _viewType = param2;
         if(_viewType == 1)
         {
            super();
         }
         _unitTypeDIO = param1;
         oldX = oldY = -2147483648;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         if(_viewType == 1)
         {
            mouseChildren = false;
         }
         background = assetRepository.getDisplayObject("BackgroundLight");
         background.width = 220;
         background.height = 53;
         addChild(background);
         mercenaryPortrait = assetRepository.getDisplayObject(_unitTypeDIO.assetName + "Small");
         addChild(mercenaryPortrait);
         shieldIcon = assetRepository.getDisplayObject("MercenaryLevel41Px");
         shieldIcon.scaleX = shieldIcon.scaleY = 0.5609756097560976;
         addChild(shieldIcon);
         levelTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         levelTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         levelTextField.autoSize = "left";
         levelTextField.text = _unitTypeInfo.currentLevel + "";
         addChild(levelTextField);
         lockIcon = assetRepository.getDisplayObject("Lock");
         lockIcon.visible = _viewType == 2 && !_unitTypeInfo.recruited;
         addChild(lockIcon);
         mercenaryNameTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         mercenaryNameTextField.defaultTextFormat = WomTextFormats.CAPTION_16;
         mercenaryNameTextField.multiline = true;
         mercenaryNameTextField.wordWrap = true;
         mercenaryNameTextField.autoSize = "left";
         mercenaryNameTextField.width = 150;
         var _temp_9:* = mercenaryNameTextField;
         var _loc3_:String = "domain.units." + _unitTypeDIO.id + ".name";
         _temp_9.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(mercenaryNameTextField);
         _mercenarySelectionStatusTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         _mercenarySelectionStatusTextField.defaultTextFormat = WomTextFormats.CAPTION_24;
         _mercenarySelectionStatusTextField.autoSize = "left";
         addChild(_mercenarySelectionStatusTextField);
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("Gold27");
         _loc1_.scaleX = _loc1_.scaleY = 0.66;
         _hireButton = new WomGreenMiniButton();
         var _temp_12:* = _hireButton;
         var _loc4_:String = "ui.windows.mercenarybarracks.hire";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _hireButton.rightLabel = _unitTypeDIO.barracksGoldPricesPerLevel[_unitTypeInfo.currentLevel - 1] + "";
         _hireButton.setStyle("icon",_loc1_);
         _hireButton.visible = _viewType == 2 && _unitTypeInfo.recruited;
         _hireButton.width = 76;
         addChild(_hireButton);
         _executeButton = new WomGreenMiniButton();
         var _temp_15:* = _executeButton;
         var _loc5_:String = "ui.windows.watchpost.executeone";
         _temp_15.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _executeButton.width = 76;
         _executeButton.visible = _viewType == 4 && _mercenaryCount != 0;
         addChild(_executeButton);
         if(_viewType == 2)
         {
            resetTextField();
         }
      }
      
      public function drawLayout() : void
      {
         mercenaryPortrait.x = mercenaryPortrait.y = 2;
         AlignmentUtil.alignAccordingToPositionOf(shieldIcon,mercenaryPortrait,31,31);
         AlignmentUtil.alignAccordingToPositionOf(levelTextField,shieldIcon,7,-2);
         AlignmentUtil.alignMiddleOf(lockIcon,mercenaryPortrait);
         mercenaryNameTextField.x = 59;
         mercenaryNameTextField.y = 7;
         _mercenarySelectionStatusTextField.visible = _mercenaryCount != 0;
         AlignmentUtil.alignBelowOf(_mercenarySelectionStatusTextField,mercenaryNameTextField,-1);
         shieldIcon.alpha = levelTextField.alpha = background.alpha = mercenaryPortrait.alpha = mercenaryNameTextField.alpha = mercenaryCount == 0 ? 0.5 : 1;
         AlignmentUtil.alignMiddleYAxisOf(_hireButton,_mercenarySelectionStatusTextField);
         _hireButton.x = background.x + background.width - _hireButton.width - 4;
         _executeButton.visible = _viewType == 4 && _mercenaryCount != 0;
         AlignmentUtil.alignAccordingToPositionOf(_executeButton,_hireButton,0,0);
      }
      
      public function get mercenaryCount() : int
      {
         return _mercenaryCount;
      }
      
      public function get selectedCount() : int
      {
         return _selectedCount;
      }
      
      public function get unitTypeDIO() : UnitTypeDIO
      {
         return _unitTypeDIO;
      }
      
      public function set selectedCount(param1:int) : void
      {
         _selectedCount = param1;
         resetTextField();
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
         _mercenarySelectionStatusTextField.text = _viewType != 1 ? _mercenaryCount + "" : _selectedCount + " / " + _mercenaryCount;
         drawLayout();
      }
      
      public function get viewType() : int
      {
         return _viewType;
      }
      
      public function temporaryMove(param1:int, param2:int) : void
      {
         oldX = this.x;
         this.x = param1;
         oldY = this.y;
         this.y = param2;
      }
      
      public function returnOldPosition() : void
      {
         if(oldX != -2147483648)
         {
            this.x = oldX;
            this.y = oldY;
         }
      }
      
      public function get hireButton() : WomButton
      {
         return _hireButton;
      }
      
      private function updateState(param1:Boolean) : void
      {
         if(_hireButton && lockIcon)
         {
            _hireButton.visible = !param1;
            lockIcon.visible = param1;
            drawLayout();
         }
      }
      
      public function get executeButton() : WomButton
      {
         return _executeButton;
      }
      
      public function set unitTypeInfo(param1:UnitTypeInfo) : void
      {
         if(param1)
         {
            _unitTypeInfo = param1;
            if(levelTextField)
            {
               levelTextField.text = param1.currentLevel + "";
            }
            updateState(!param1.recruited);
         }
      }
      
      public function get unitTypeInfo() : UnitTypeInfo
      {
         return _unitTypeInfo;
      }
   }
}

