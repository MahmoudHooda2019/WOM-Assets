package wom.view.ui.common
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPTextField;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileIconLabelViewExtra extends Sprite
   {
      
      public static const TEXT_FIELD_WIDTH:int = 92;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _textMarginFromIconY:Number = NaN;
      
      private var _textMarginFromIconX:Number = NaN;
      
      private var _icon:DisplayObject;
      
      private var iconAssetId:String;
      
      private var _label:String;
      
      private var defaultTextFormat:MPBitmapFontTextFormat;
      
      private var redTextFormat:MPBitmapFontTextFormat;
      
      private var textField:MPTextField;
      
      private var _textFieldWidth:int = 92;
      
      private var _textSize:int = 21;
      
      private var _redColor:uint = 16737894;
      
      private var _iconAlign:String = "center";
      
      private var _textAlign:String = "center";
      
      private var _useCaptionFont:Boolean = true;
      
      private var _initialized:Boolean = false;
      
      private var _scaleFactor:Number = 1;
      
      public function MobileIconLabelViewExtra(param1:String, param2:String)
      {
         super();
         this.iconAssetId = param1;
         this._label = param2;
         generateTextFormats();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function generateTextFormats() : void
      {
         defaultTextFormat = _useCaptionFont ? getCaptionTextFormat(_textSize,_textAlign) : getWomTextFormat(_textSize,_textAlign);
         redTextFormat = _useCaptionFont ? getCaptionTextFormat(_textSize,_textAlign,_redColor) : getWomTextFormat(_textSize,_textAlign,_redColor);
         if(_initialized)
         {
            textField.textRendererProperties.textFormat = defaultTextFormat;
            textField.text = label;
            drawLayout();
         }
      }
      
      private function initLayout() : void
      {
         _icon = assetRepository.getDisplayObject(iconAssetId);
         addChild(_icon);
         _icon.scaleX = _icon.scaleY = _scaleFactor;
         createTextField();
         _initialized = true;
         drawLayout();
      }
      
      private function createTextField() : void
      {
         if(textField)
         {
            removeChild(textField);
         }
         textField = _useCaptionFont ? new MobileCaptionTextField() : new MobileWomTextField();
         textField.textRendererProperties.textFormat = defaultTextFormat;
         if(_textAlign == "center")
         {
            textField.width = _textFieldWidth;
         }
         textField.textRendererProperties.wordWrap = true;
         addChild(textField);
         textField.text = _label;
      }
      
      override public function get width() : Number
      {
         if(_iconAlign == "center")
         {
            return _icon.width;
         }
         return textField.width + _textMarginFromIconX + 3;
      }
      
      public function drawLayout() : void
      {
         if(!_initialized)
         {
            return;
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(textField,_icon,!isNaN(_textMarginFromIconX) ? _textMarginFromIconX : 0,!isNaN(_textMarginFromIconY) ? _textMarginFromIconY : 0);
         if(_iconAlign == "center")
         {
            if(isNaN(_textMarginFromIconX))
            {
               MobileAlignmentUtil.alignMiddleXAxisOf(textField,_icon);
            }
         }
         else if(isNaN(_textMarginFromIconY))
         {
            MobileAlignmentUtil.alignMiddleYAxisOf(textField,_icon);
         }
      }
      
      public function updateTextFormatRed(param1:Boolean) : void
      {
         textField.textRendererProperties.textFormat = param1 ? redTextFormat : defaultTextFormat;
         textField.text = textField.text;
         drawLayout();
      }
      
      public function get label() : String
      {
         return _label;
      }
      
      public function set label(param1:String) : void
      {
         textField.text = _label = param1;
         drawLayout();
      }
      
      public function set textMarginFromIconY(param1:int) : void
      {
         _textMarginFromIconY = param1;
         drawLayout();
      }
      
      public function set textMarginFromIconX(param1:int) : void
      {
         _textMarginFromIconX = param1;
         drawLayout();
      }
      
      public function set useCaptionFont(param1:Boolean) : void
      {
         _useCaptionFont = param1;
         generateTextFormats();
      }
      
      public function set textFieldWidth(param1:int) : void
      {
         _textFieldWidth = param1;
         generateTextFormats();
      }
      
      public function set textSize(param1:int) : void
      {
         _textSize = param1;
         generateTextFormats();
      }
      
      public function set redColor(param1:uint) : void
      {
         _redColor = param1;
         generateTextFormats();
      }
      
      public function set iconAlign(param1:String) : void
      {
         _iconAlign = param1;
         generateTextFormats();
      }
      
      public function set textAlign(param1:String) : void
      {
         _textAlign = param1;
         if(_textAlign == "center")
         {
            textField.width = _textFieldWidth;
         }
         generateTextFormats();
      }
      
      public function scaleIcon(param1:Number) : void
      {
         _scaleFactor = param1;
         if(_initialized)
         {
            drawLayout();
         }
      }
   }
}

