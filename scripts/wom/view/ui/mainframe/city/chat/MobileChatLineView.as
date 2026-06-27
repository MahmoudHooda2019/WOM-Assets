package wom.view.ui.mainframe.city.chat
{
   import feathers.controls.Label;
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.display.View;
   import peak.i18n.lang.Languages;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Shape;
   import starling.display.Sprite;
   import wom.model.game.chat.ChatMessage;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileChatLineView extends Sprite implements View
   {
      
      protected var _textField:Label;
      
      protected var _nameField:Label;
      
      private var _seperatorLine:Shape;
      
      protected var _chatMessage:ChatMessage;
      
      public function MobileChatLineView()
      {
         super();
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _textField = new MobileWomTextField();
         _textField.textRendererProperties.textFormat = Languages.activeLanguageId == "ar" ? getWomTextFormat(21,"right") : getWomTextFormat(21,"left",16777215);
         _textField.textRendererProperties.wordWrap = true;
         _textField.width = 245;
         addChild(_textField);
         _nameField = new MobileCaptionTextField();
         _nameField.textRendererProperties.textFormat = Languages.activeLanguageId == "ar" ? getCaptionTextFormat(21,"right") : getCaptionTextFormat(21,"left",16777215);
         _nameField.width = 245;
         addChild(_nameField);
         _seperatorLine = new Shape();
         _seperatorLine.graphics.lineStyle(2,5650742,0.6);
         _seperatorLine.graphics.moveTo(0,0);
         _seperatorLine.graphics.lineTo(245,0);
         addChild(_seperatorLine);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignHeightSpecifiedBelowOf(_textField,_nameField,1,_nameField.height);
         MobileAlignmentUtil.alignHeightSpecifiedBelowOf(_seperatorLine,_textField,8,_textField.height);
      }
      
      public function updateWithChatMessage(param1:ChatMessage) : void
      {
         _chatMessage = param1;
         var _loc2_:String = "";
         if(_chatMessage.senderName != null && _chatMessage.senderName != "")
         {
            _loc2_ = _chatMessage.senderName;
            if(Languages.activeLanguageId == "ar")
            {
               _loc2_ += "\n";
            }
            else
            {
               _loc2_ += ":";
            }
         }
         _nameField.text = _loc2_;
         if(Languages.activeLanguageId != "ar")
         {
            _nameField.width += 5;
         }
         _textField.text = _chatMessage.chatMessage;
         drawLayout();
      }
      
      public function get visibleHeight() : int
      {
         return _textField.height + _nameField.height + 15;
      }
      
      public function get nameField() : Label
      {
         return _nameField;
      }
      
      public function get chatMessage() : ChatMessage
      {
         return _chatMessage;
      }
   }
}

