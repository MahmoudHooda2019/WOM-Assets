package wom.view.ui.common
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPTextField;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getWomTextFormat;
   
   public class MobileSpeechBubbleView extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _speechBubbleBg:DisplayObject;
      
      private var _speechBubbleArrow:DisplayObject;
      
      private var _textField:MPTextField;
      
      private var _speechBubbleWidth:int;
      
      private var _text:String;
      
      private var _textFormat:MPBitmapFontTextFormat;
      
      private var _flipBubble:Boolean;
      
      private var _textFieldMarginTop:int;
      
      private var _textFieldMarginBottom:int;
      
      private var _speechArrowVerticalPosition:int;
      
      public function MobileSpeechBubbleView(param1:int, param2:String, param3:Object = null, param4:Object = null, param5:Object = null, param6:Object = null, param7:Object = null)
      {
         super();
         _speechBubbleWidth = param1;
         _text = param2;
         _textFormat = param3 != null ? MPBitmapFontTextFormat(param3) : getWomTextFormat(23,"center",0);
         _flipBubble = param4 != null ? Boolean(param4) : false;
         _textFieldMarginTop = param5 != null ? int(param5) : 42;
         _textFieldMarginBottom = param6 != null ? int(param6) : 49;
         _speechArrowVerticalPosition = param7 != null ? int(param7) : _textFieldMarginTop;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         _textField = new MobileWomTextField();
         _textField.width = _speechBubbleWidth - 40;
         _textField.textRendererProperties.textFormat = _textFormat;
         _textField.textRendererProperties.multiline = true;
         _textField.textRendererProperties.wordWrap = true;
         _textField.text = _text;
         addChild(_textField);
         _speechBubbleBg = assetRepository.getDisplayObject("MobileBeigeBackground");
         _speechBubbleBg.width = _speechBubbleWidth;
         addChildAt(_speechBubbleBg,0);
         _speechBubbleArrow = _flipBubble == false ? assetRepository.getDisplayObject("TooltipArrowLeft") : assetRepository.getDisplayObject("TooltipArrowRight");
         addChildAt(_speechBubbleArrow,1);
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         _textField.validate();
         _speechBubbleBg.height = _textField.height + _textFieldMarginTop + _textFieldMarginBottom;
         if(!_flipBubble)
         {
            MobileAlignmentUtil.alignLeftOf(_speechBubbleArrow,_speechBubbleBg,-3);
         }
         else
         {
            MobileAlignmentUtil.alignRightOf(_speechBubbleArrow,_speechBubbleBg,-3);
         }
         _speechBubbleArrow.y = _speechArrowVerticalPosition;
         MobileAlignmentUtil.alignAccordingToPositionOf(_textField,_speechBubbleBg,20,_textFieldMarginTop);
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
         _textField.text = _text;
         drawLayout();
      }
      
      public function get speechArrowVerticalPosition() : int
      {
         return _speechArrowVerticalPosition;
      }
      
      public function set speechArrowVerticalPosition(param1:int) : void
      {
         _speechArrowVerticalPosition = param1;
         _speechBubbleArrow.y = _speechArrowVerticalPosition;
      }
      
      public function get speechBubbleArrow() : DisplayObject
      {
         return _speechBubbleArrow;
      }
      
      public function get textField() : MPTextField
      {
         return _textField;
      }
      
      public function get speechBubbleBg() : DisplayObject
      {
         return _speechBubbleBg;
      }
      
      public function get speechBubbleWidth() : int
      {
         return _speechBubbleWidth;
      }
      
      public function get textFormat() : MPBitmapFontTextFormat
      {
         return _textFormat;
      }
      
      public function get flipBubble() : Boolean
      {
         return _flipBubble;
      }
      
      public function get textFieldMarginTop() : int
      {
         return _textFieldMarginTop;
      }
      
      public function get textFieldMarginBottom() : int
      {
         return _textFieldMarginBottom;
      }
   }
}

