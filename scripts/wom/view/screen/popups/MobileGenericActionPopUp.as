package wom.view.screen.popups
{
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.window.MobileWindowEnumerationButton;
   import wom.view.component.button.MobileWomButton;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileGenericActionPopUp extends MobileBasePopUp
   {
      
      protected static const WINDOW_WIDTH:int = 536;
      
      protected static const WINDOW_HEIGHT:int = 217;
      
      private var _header:String;
      
      private var _desc:String;
      
      private var _enumerationButtons:Vector.<MobileWindowEnumerationButton>;
      
      private var _buttons:Vector.<MobileWomButton>;
      
      private var _buttonsWidth:int = 0;
      
      public function MobileGenericActionPopUp(param1:String = "", param2:String = "", param3:Vector.<MobileWindowEnumerationButton> = null, param4:int = 536, param5:int = 217)
      {
         super(param4,param5);
         _header = param1;
         _desc = param2;
         _enumerationButtons = param3 != null ? param3 : new Vector.<MobileWindowEnumerationButton>();
      }
      
      override protected function initLayout() : void
      {
         var _loc3_:MobileWomButton = null;
         super.initLayout();
         setHeader(_header);
         _imageAsset = assetRepository.getDisplayObject(getClementineAsset());
         _staticLayer.addChildAt(_imageAsset,_staticLayer.getChildIndex(_windowHeader) + 1);
         _speechBubble = new MobileSpeechBubbleView(getDescTextFieldWidth(),_desc,null,false,30,38,getSpeechBubbleArrowYMargin());
         addChild(_speechBubble);
         _buttons = new Vector.<MobileWomButton>();
         for each(var _loc1_ in _enumerationButtons)
         {
            _loc3_ = _loc1_.button;
            if(_loc1_.buttonIconAssetId != null)
            {
               _loc3_.defaultIcon = assetRepository.getDisplayObject(_loc1_.buttonIconAssetId);
            }
            addChild(_loc3_);
            _buttons.push(_loc3_);
            _buttonsWidth += _loc3_.width;
         }
         _buttonsWidth += (_buttons.length - 1) * 10;
         var _loc2_:int = _speechBubble.height + 103 - _windowHeight;
         if(_loc2_ > 0)
         {
            _speechBubble.speechArrowVerticalPosition += _loc2_;
            windowHeight = _windowHeight + _loc2_;
            drawBackground();
         }
         drawLayout();
      }
      
      protected function getDescTextFieldWidth() : Number
      {
         return windowWidth - getSpeechBubbleXIndent() - 30;
      }
      
      protected function getClementineAsset() : String
      {
         return "MPose2Left";
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         drawClementineLayout();
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,getSpeechBubbleXIndent(),getSpeechBubbleYIndent());
         if(_buttons.length > 0)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_buttons[0],_background,_windowWidth - _buttonsWidth >> 1,_windowHeight - _buttons[0].height / 2);
            _loc1_ = 1;
            while(_loc1_ < _buttons.length)
            {
               MobileAlignmentUtil.alignRightOf(_buttons[_loc1_],_buttons[_loc1_ - 1],6);
               _loc1_++;
            }
         }
      }
      
      protected function drawClementineLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,12,_windowHeight - 18 - _imageAsset.height);
      }
      
      protected function getSpeechBubbleXIndent() : int
      {
         return 170;
      }
      
      protected function getSpeechBubbleYIndent() : int
      {
         return 50;
      }
      
      public function get clementineAsset() : DisplayObject
      {
         return _imageAsset;
      }
      
      public function get enumerationButtons() : Vector.<MobileWindowEnumerationButton>
      {
         return _enumerationButtons;
      }
      
      public function get buttons() : Vector.<MobileWomButton>
      {
         return _buttons;
      }
      
      protected function getSpeechBubbleArrowYMargin() : int
      {
         return 45;
      }
   }
}

