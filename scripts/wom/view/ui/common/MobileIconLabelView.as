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
   
   public class MobileIconLabelView extends Sprite
   {
      
      public static const WIDTH:int = 92;
      
      public static const HEIGHT:int = 72;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _assetId:String;
      
      private var _label:String;
      
      protected var _textField:MPTextField;
      
      private var _icon:DisplayObject;
      
      private var _componentWidth:int;
      
      private var _componentHeight:int;
      
      private var _useCaptionFont:Boolean;
      
      private var _align:String;
      
      private var _textMargin:int;
      
      private var _labelMidOffsetY:int;
      
      protected var defaultTextFormat:MPBitmapFontTextFormat;
      
      protected var redTextFormat:MPBitmapFontTextFormat;
      
      private var _scaleForIcon:Number;
      
      public function MobileIconLabelView(param1:String, param2:String, param3:Object = null, param4:Object = null, param5:MPBitmapFontTextFormat = null, param6:MPBitmapFontTextFormat = null, param7:Boolean = true, param8:Number = 1, param9:String = null, param10:int = 5)
      {
         super();
         _assetId = param1;
         _label = param2;
         _align = param9 ? param9 : "center";
         _componentWidth = param3 != null ? int(param3) : 92;
         _componentHeight = param4 != null ? int(param4) : 72;
         this.defaultTextFormat = param5 ? param5 : (param7 ? getCaptionTextFormat(21,_align) : getWomTextFormat(21,_align));
         this.redTextFormat = param6 ? param6 : (param7 ? getCaptionTextFormat(21,_align,12210471) : getWomTextFormat(21,_align,12210471));
         _useCaptionFont = param7;
         _textMargin = param10;
         _scaleForIcon = param8;
         _labelMidOffsetY = 0;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         _icon = assetRepository.getDisplayObject(_assetId);
         _icon.scaleX = _icon.scaleY = _scaleForIcon;
         addChild(_icon);
         _textField = _useCaptionFont ? new MobileCaptionTextField() : new MobileWomTextField();
         _textField.textRendererProperties.textFormat = defaultTextFormat;
         if(_align == "center")
         {
            _textField.width = _componentWidth;
         }
         _textField.textRendererProperties.wordWrap = true;
         addChild(_textField);
         _textField.text = _label;
         drawLayout();
      }
      
      override public function get width() : Number
      {
         return _componentWidth;
      }
      
      public function drawLayout() : void
      {
         _icon.x = _componentWidth - _icon.width >> 1;
         if(_align == "center")
         {
            _textField.validate();
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_textField,_icon,47);
         }
         else
         {
            _icon.x = _icon.y = 0;
            MobileAlignmentUtil.alignRightOf(_textField,_icon,textMargin);
            MobileAlignmentUtil.alignMiddleYAxisOf(_textField,_icon);
            _textField.y += _labelMidOffsetY;
            _componentWidth = _textField.width + _icon.width + textMargin;
         }
      }
      
      public function updateTextFormat(param1:Boolean) : void
      {
         _textField.textRendererProperties.textFormat = param1 ? redTextFormat : defaultTextFormat;
         _textField.text = _textField.text;
      }
      
      public function get assetId() : String
      {
         return _assetId;
      }
      
      public function get label() : String
      {
         return _label;
      }
      
      public function get icon() : DisplayObject
      {
         return _icon;
      }
      
      public function get componentWidth() : int
      {
         return _componentWidth;
      }
      
      public function get componentHeight() : int
      {
         return _componentHeight;
      }
      
      public function set label(param1:String) : void
      {
         _textField.text = _label = param1;
         drawLayout();
      }
      
      public function get align() : String
      {
         return _align;
      }
      
      public function get textMargin() : int
      {
         return _textMargin;
      }
      
      public function set textMargin(param1:int) : void
      {
         _textMargin = param1;
      }
      
      public function get labelMidOffsetY() : int
      {
         return _labelMidOffsetY;
      }
      
      public function set labelMidOffsetY(param1:int) : void
      {
         _labelMidOffsetY = param1;
      }
   }
}

