package wom.view.ui.common
{
   import peak.component.mobile.*;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileCondenseButtonView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var _button:MPButton;
      
      protected var _icon:DisplayObject;
      
      protected var _mainLabel:MPTextField;
      
      protected var _subIconLabel:MobileIconLabelView;
      
      protected var _buttonColor:String;
      
      protected var _disabledButtonColor:String;
      
      protected var _buttonSize:String;
      
      protected var _mainLabelStr:String;
      
      protected var _subLabelStr:String;
      
      protected var _subIconId:String;
      
      protected var _iconId:String;
      
      protected var _iconScale:Number;
      
      protected var _subIconScale:Number;
      
      public function MobileCondenseButtonView(param1:String, param2:String, param3:String, param4:String, param5:Number = 1, param6:Number = 1, param7:String = "Green", param8:String = "", param9:String = "Medium")
      {
         super();
         _iconId = param1;
         _mainLabelStr = param2;
         _subLabelStr = param3;
         _subIconId = param4;
         _buttonColor = param7;
         if(param8 == "")
         {
            _disabledButtonColor = _buttonColor;
         }
         else
         {
            _disabledButtonColor = param8;
         }
         _buttonSize = param9;
         _iconScale = param5;
         _subIconScale = param6;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _button = MobileWomUIComponentFactory.createMobileColoredButton(_buttonColor,_buttonSize,null,getDisabledButtonSkin());
         _button.width = 143;
         _button.height = 63;
         addChild(_button);
         _button.validate();
         if(_iconId != null)
         {
            initIcon();
         }
         if(_mainLabelStr != null)
         {
            _mainLabel = new MobileCaptionTextField();
            _mainLabel.textRendererProperties.textFormat = getCaptionTextFormat(25);
            _mainLabel.touchable = false;
            addChild(_mainLabel);
            _mainLabel.text = _mainLabelStr;
         }
         if(_subLabelStr != null && _subIconId != null)
         {
            initSubIconLabel();
         }
         drawLayout();
      }
      
      protected function getDisabledButtonSkin() : String
      {
         return "Button" + _disabledButtonColor + _buttonSize + "Tap";
      }
      
      public function drawLayout() : void
      {
         if(_icon)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_icon,_button,(63 - _icon.width >> 1) + 6,_button.height - _icon.height - 11);
         }
         if(_mainLabel)
         {
            if(_icon)
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(_mainLabel,_button,67,10);
            }
            else
            {
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_mainLabel,_button,10);
            }
         }
         if(_subIconLabel)
         {
            if(_icon)
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(_subIconLabel,_button,75,29);
            }
            else
            {
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_subIconLabel,_button,29);
            }
         }
      }
      
      public function get button() : MPButton
      {
         return _button;
      }
      
      public function updateSubIconLabel(param1:String, param2:String) : void
      {
         _subLabelStr = param2;
         _subIconId = param1;
         if(_subIconLabel && getChildIndex(_subIconLabel) != -1)
         {
            removeChild(_subIconLabel);
         }
         initSubIconLabel();
         drawLayout();
      }
      
      protected function initSubIconLabel() : void
      {
         if(_subIconId != null && _subLabelStr != null)
         {
            _subIconLabel = new MobileIconLabelView(_subIconId,_subLabelStr,64,23,getCaptionTextFormat(21),null,true,_subIconScale,"left",-5);
            _subIconLabel.touchable = false;
            addChild(_subIconLabel);
         }
      }
      
      public function set iconId(param1:String) : void
      {
         _iconId = param1;
         if(_iconId && getChildIndex(_icon) != -1)
         {
            removeChild(_icon);
         }
         initIcon();
         drawLayout();
      }
      
      public function set subLabel(param1:String) : void
      {
         _subIconLabel.label = param1;
         drawLayout();
      }
      
      protected function initIcon() : void
      {
         _icon = assetRepository.getDisplayObject(_iconId);
         _icon.scaleX = _icon.scaleY = _iconScale;
         _icon.touchable = false;
         addChild(_icon);
      }
      
      public function updateMainLabel(param1:String) : void
      {
         _mainLabel.text = param1;
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         _button.isEnabled = param1;
      }
      
      public function get isEnabled() : Boolean
      {
         return _button.isEnabled;
      }
      
      override public function set width(param1:Number) : void
      {
         _button.width = param1;
         drawLayout();
      }
   }
}

