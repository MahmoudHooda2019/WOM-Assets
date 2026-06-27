package wom.view.ui.common
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.util.AlignmentUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class IconLabelView extends Sprite
   {
      
      public static const WIDTH:int = 95;
      
      public static const HEIGHT:int = 70;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _assetId:String;
      
      private var _label:String;
      
      private var _textField:TextField;
      
      private var _icon:DisplayObject;
      
      private var _componentWidth:int;
      
      private var _componentHeight:int;
      
      private var _useCaptionFont:Boolean;
      
      private var _align:String;
      
      private var _textMargin:int;
      
      protected var defaultTextFormat:TextFormat;
      
      protected var redTextFormat:TextFormat;
      
      private var _scaleForIcon:Number;
      
      public function IconLabelView(param1:String, param2:String, param3:Object = null, param4:Object = null, param5:TextFormat = null, param6:TextFormat = null, param7:Boolean = true, param8:Number = 1)
      {
         super();
         _assetId = param1;
         _label = param2;
         _componentWidth = param3 != null ? int(param3) : 95;
         _componentHeight = param4 != null ? int(param4) : 70;
         this.defaultTextFormat = param5 ? param5 : WomTextFormats.CENTER_18;
         this.redTextFormat = param6 ? param6 : WomTextFormats.CENTER_18_DARK_RED;
         _useCaptionFont = param7;
         _align = _align == null ? "center" : _align;
         _textMargin = -4;
         _scaleForIcon = param8;
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
         _textField = _useCaptionFont ? new CaptionTextField() : new WomTextField();
         _textField.defaultTextFormat = defaultTextFormat;
         var _loc1_:TextFormat = _textField.defaultTextFormat;
         _loc1_.align = _align;
         _textField.defaultTextFormat = _loc1_;
         _textField.text = _label;
         if(_componentWidth == -1)
         {
            _textField.autoSize = "left";
         }
         else
         {
            _textField.width = _componentWidth;
         }
         _textField.height = 20;
         addChild(_textField);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         if(_align == "center")
         {
            _icon.x = (_componentWidth - _icon.width) / 2 << 0;
            _icon.y = 0;
            _textField.x = 0;
            _textField.y = _componentHeight - 20;
         }
         else
         {
            _textField.height = _textField.textHeight + 4;
            AlignmentUtil.alignRightOf(_textField,_icon,textMargin);
            AlignmentUtil.alignMiddleYAxisOf(_textField,_icon);
         }
      }
      
      public function updateTextFormat(param1:Boolean) : void
      {
         _textField.defaultTextFormat = param1 ? redTextFormat : defaultTextFormat;
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
      }
      
      public function get textField() : TextField
      {
         return _textField;
      }
      
      public function get align() : String
      {
         return _align;
      }
      
      public function set align(param1:String) : void
      {
         var _loc2_:TextFormat = null;
         _align = param1;
         if(_textField)
         {
            _loc2_ = _textField.defaultTextFormat;
            _loc2_.align = _align;
            _textField.defaultTextFormat = _loc2_;
            _textField.setTextFormat(_loc2_);
         }
      }
      
      public function get textMargin() : int
      {
         return _textMargin;
      }
      
      public function set textMargin(param1:int) : void
      {
         _textMargin = param1;
      }
   }
}

