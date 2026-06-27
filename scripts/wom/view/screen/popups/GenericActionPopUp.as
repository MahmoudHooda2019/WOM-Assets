package wom.view.screen.popups
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import peak.component.PTextField;
   import peak.util.AlignmentUtil;
   import wom.model.game.window.WindowEnumerationButton;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.util.GenericWindow;
   
   public class GenericActionPopUp extends GenericWindow
   {
      
      protected static const WINDOW_WIDTH:int = 562;
      
      protected static const WINDOW_HEIGHT:int = 145;
      
      private var _header:String;
      
      private var _desc:String;
      
      private var _enumerationButtons:Vector.<WindowEnumerationButton>;
      
      protected var _clementineAsset:DisplayObject;
      
      private var _descTextField:PTextField;
      
      private var _buttons:Vector.<Button>;
      
      private var _buttonsWidth:int = 0;
      
      public function GenericActionPopUp(param1:String = "", param2:String = "", param3:Vector.<WindowEnumerationButton> = null, param4:int = 562, param5:int = 145)
      {
         super(param4,param5);
         _header = param1;
         _desc = param2;
         _enumerationButtons = param3 != null ? param3 : new Vector.<WindowEnumerationButton>();
      }
      
      override protected function initLayout() : void
      {
         var _loc2_:Button = null;
         super.initLayout();
         setHeader(_header);
         _clementineAsset = assetRepository.getDisplayObject(getClementineAsset());
         addChild(_clementineAsset);
         _descTextField = new WomTextField();
         _descTextField.extraCharWidth = 4;
         _descTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_22;
         _descTextField.autoSize = "left";
         _descTextField.multiline = true;
         _descTextField.wordWrap = true;
         _descTextField.width = getDescTextFieldWidth();
         _descTextField.text = _desc;
         addChild(_descTextField);
         _buttons = new Vector.<Button>();
         for each(var _loc1_ in _enumerationButtons)
         {
            _loc2_ = _loc1_.button;
            if(_loc1_.buttonIconAssetId != null)
            {
               _loc2_.setStyle("icon",assetRepository.getDisplayObject(_loc1_.buttonIconAssetId));
            }
            addChild(_loc2_);
            _buttons.push(_loc2_);
            _buttonsWidth += _loc2_.width;
         }
         _buttonsWidth += (_buttons.length - 1) * 10;
         drawLayout();
      }
      
      protected function getDescTextFieldWidth() : Number
      {
         return 350;
      }
      
      protected function getClementineAsset() : String
      {
         return "PoseSmall2";
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         drawClementineLayout();
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_descTextField,_background,_windowWidth - _descTextField.width - 22);
         if(_buttons.length > 0)
         {
            _descTextField.y -= 10;
            AlignmentUtil.alignAccordingToPositionOf(_buttons[0],_background,_windowWidth - _buttonsWidth >> 1,_windowHeight - 35);
            _loc1_ = 1;
            while(_loc1_ < _buttons.length)
            {
               AlignmentUtil.alignRightOf(_buttons[_loc1_],_buttons[_loc1_ - 1],10);
               _loc1_++;
            }
         }
      }
      
      protected function drawClementineLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_clementineAsset,_background,8,-75);
      }
      
      public function get clementineAsset() : DisplayObject
      {
         return _clementineAsset;
      }
      
      public function get enumerationButtons() : Vector.<WindowEnumerationButton>
      {
         return _enumerationButtons;
      }
      
      public function get buttons() : Vector.<Button>
      {
         return _buttons;
      }
   }
}

