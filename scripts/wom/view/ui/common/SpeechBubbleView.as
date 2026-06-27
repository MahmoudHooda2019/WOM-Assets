package wom.view.ui.common
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import peak.component.PTextField;
   import peak.i18n.lang.Languages;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.WomTextField;
   
   public class SpeechBubbleView extends Sprite
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var speechBubble:DisplayObject;
      
      private var textField:PTextField;
      
      private var _speechBubbleWidth:int;
      
      private var _speechBubbleHeight:int;
      
      private var _text:String;
      
      private var _fontSize:int;
      
      private var _flipBubble:Boolean;
      
      private var _textFieldMarginTop:int;
      
      private var _textFieldMarginBottom:int;
      
      private var _respectMargins:Boolean = true;
      
      public function SpeechBubbleView(param1:int, param2:String, param3:Object = null, param4:Object = null, param5:Object = null, param6:Object = null, param7:Object = null)
      {
         super();
         _speechBubbleWidth = param1;
         _text = param2;
         var _loc8_:* = param3 != null ? int(param3) : 20;
         _fontSize = peak.i18n.lang.Languages.isActiveLanguageEmdedded() ? _loc8_ : _loc8_ - 4;
         _flipBubble = param4 != null ? Boolean(param4) : false;
         _speechBubbleHeight = param5 != null ? int(param5) : -1;
         _textFieldMarginTop = param6 != null ? int(param6) : 20;
         _textFieldMarginBottom = param7 != null ? int(param7) : 20;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         textField = new WomTextField();
         textField.extraCharWidth = 4;
         var _loc1_:TextFormat = textField.defaultTextFormat;
         _loc1_.align = "center";
         _loc1_.size = _fontSize;
         textField.defaultTextFormat = _loc1_;
         textField.autoSize = "left";
         textField.width = _speechBubbleWidth - 70;
         textField.multiline = true;
         textField.wordWrap = true;
         textField.text = _text;
         addChild(textField);
         speechBubble = assetRepository.getDisplayObject(_flipBubble ? "SpeechBubbleFlippedScaled" : "SpeechBubble");
         speechBubble.width = _speechBubbleWidth;
         addChildAt(speechBubble,0);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         speechBubble.height = _speechBubbleHeight != -1 ? _speechBubbleHeight : textField.textHeight + _textFieldMarginTop + _textFieldMarginBottom;
         textField.x = _flipBubble ? 22 : 48;
         textField.y = _speechBubbleHeight != -1 && !_respectMargins ? speechBubble.height - textField.textHeight - 4 >> 1 : _textFieldMarginTop;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
         textField.text = _text;
         drawLayout();
      }
      
      public function set respectMargins(param1:Boolean) : void
      {
         _respectMargins = param1;
      }
   }
}

