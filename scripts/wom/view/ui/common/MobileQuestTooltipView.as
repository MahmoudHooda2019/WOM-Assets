package wom.view.ui.common
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPTextField;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileQuestTooltipView extends Sprite
   {
      
      private var _assetRepository:MobileWomAssetRepository;
      
      private var _speechBubbleBg:DisplayObject;
      
      private var _speechBubbleArrow:DisplayObject;
      
      private var _textField:MPTextField;
      
      private var _speechBubbleWidth:int;
      
      private var _text:String;
      
      private var _textFormat:MPBitmapFontTextFormat;
      
      public function MobileQuestTooltipView(param1:MobileWomAssetRepository, param2:int, param3:String, param4:MPBitmapFontTextFormat = null)
      {
         super();
         _assetRepository = param1;
         _speechBubbleWidth = param2;
         _text = param3;
         _textFormat = param4 ? param4 : getCaptionTextFormat(30,"center");
         initLayout();
      }
      
      private function initLayout() : void
      {
         _textField = new MobileCaptionTextField();
         _textField.width = _speechBubbleWidth;
         _textField.textRendererProperties.textFormat = _textFormat;
         _textField.textRendererProperties.multiline = true;
         _textField.textRendererProperties.wordWrap = true;
         _textField.text = _text;
         addChild(_textField);
         _speechBubbleBg = _assetRepository.getDisplayObject("MobileYellowBackground");
         _speechBubbleBg.width = _speechBubbleWidth;
         _speechBubbleBg.height = 71;
         addChildAt(_speechBubbleBg,0);
         _speechBubbleArrow = _assetRepository.getDisplayObject("YellowTooltipArrowRight");
         addChildAt(_speechBubbleArrow,1);
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         _textField.validate();
         MobileAlignmentUtil.alignLeftOf(_speechBubbleArrow,_speechBubbleBg,-3);
         _speechBubbleArrow.y = _speechBubbleBg.height - _speechBubbleArrow.height >> 1;
         MobileAlignmentUtil.alignAccordingToPositionOf(_textField,_speechBubbleBg,-2,20);
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
   }
}

