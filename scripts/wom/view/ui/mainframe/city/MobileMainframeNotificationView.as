package wom.view.ui.mainframe.city
{
   import feathers.controls.Button;
   import feathers.controls.Label;
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileMainframeNotificationView extends Sprite
   {
      
      private var _button:Button;
      
      private var _textField:Label;
      
      private var _visibleHeight:int;
      
      private var _buttonOffset:int;
      
      private var _label:String;
      
      private var _defaultTextFormat:MPBitmapFontTextFormat;
      
      private var _multiline:Boolean;
      
      public function MobileMainframeNotificationView(param1:Button, param2:String, param3:int = 0, param4:MPBitmapFontTextFormat = null, param5:Boolean = false)
      {
         super();
         _button = param1;
         _buttonOffset = param3;
         _label = param2;
         _defaultTextFormat = param4;
         _multiline = param5;
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         if(_button != null)
         {
            addChild(_button);
         }
         _textField = new MobileCaptionTextField();
         _textField.textRendererProperties.textFormat = _defaultTextFormat != null ? _defaultTextFormat : getCaptionTextFormat(21,"center");
         if(_multiline)
         {
            _textField.textRendererProperties.wordWrap = true;
            _textField.width = 60;
         }
         _textField.text = _label;
         addChild(_textField);
      }
      
      public function drawLayout() : void
      {
         if(_button)
         {
            _button.validate();
            _textField.validate();
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_textField,_button,(_button.height - _textField.height) / 2 - _buttonOffset);
            _visibleHeight = _button.height + _textField.height;
         }
      }
      
      public function set label(param1:String) : void
      {
         _textField.text = param1;
         drawLayout();
      }
      
      public function updateButton(param1:Button) : void
      {
         if(_button != null && contains(_button))
         {
            removeChild(_button);
         }
         _button = param1;
         if(!contains(_button))
         {
            addChildAt(_button,0);
         }
         drawLayout();
      }
      
      public function get visibleHeight() : int
      {
         return _visibleHeight;
      }
   }
}

