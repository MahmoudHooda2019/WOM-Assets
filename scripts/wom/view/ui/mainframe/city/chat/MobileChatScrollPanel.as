package wom.view.ui.mainframe.city.chat
{
   import peak.component.mobile.MPScrollPane;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Graphics;
   import starling.display.Shape;
   import starling.display.Sprite;
   import wom.model.game.chat.ChatMessage;
   import wom.model.game.chat.ChatMessageType;
   import wom.view.component.MobileWomScrollPane;
   
   public class MobileChatScrollPanel extends Sprite
   {
      
      private var _scrollPane:MPScrollPane;
      
      private var _chatMuteView:MobileChatMutePanel;
      
      private var lines:Vector.<String>;
      
      private var lineVectorIndex:int;
      
      private var _lineViews:Vector.<MobileChatLineView>;
      
      private var _chatMessageType:ChatMessageType;
      
      public function MobileChatScrollPanel(param1:ChatMessageType)
      {
         super();
         _chatMessageType = param1;
         initLayout();
      }
      
      private function initLayout() : void
      {
         _scrollPane = new MobileWomScrollPane();
         _scrollPane.height = 590;
         _scrollPane.width = 282;
         _scrollPane.horizontalScrollPolicy = "off";
         _scrollPane.verticalScrollPolicy = "on";
         addChild(_scrollPane);
         var _loc2_:Shape = new Shape();
         var _loc1_:Graphics = _loc2_.graphics;
         _loc1_.beginFill(16777215,0);
         _loc1_.drawRect(0,0,1,1);
         _loc1_.endFill();
         _scrollPane.addChild(_loc2_);
         lines = new Vector.<String>();
         _lineViews = new Vector.<MobileChatLineView>();
         lineVectorIndex = 0;
         _chatMuteView = new MobileChatMutePanel();
         _chatMuteView.visible = false;
         addChild(_chatMuteView);
      }
      
      private function drawLayout() : void
      {
         var _loc3_:MobileChatLineView = null;
         var _loc2_:MobileChatLineView = null;
         var _loc4_:int = 0;
         var _loc1_:Boolean = true;
         _loc4_ = _lineViews.length - 1;
         while(_loc4_ >= 0)
         {
            _loc3_ = _lineViews[_loc4_];
            if(_loc3_.visible)
            {
               if(_loc1_)
               {
                  _loc3_.x = 0;
                  _loc3_.y = 3;
                  _loc1_ = false;
               }
               else
               {
                  MobileAlignmentUtil.alignHeightSpecifiedBelowOf(_loc3_,_loc2_,2,_loc2_.visibleHeight);
               }
               _loc2_ = _loc3_;
            }
            else
            {
               _loc3_.x = 0;
               _loc3_.y = 0;
            }
            _loc4_--;
         }
         _chatMuteView.x = 8;
         _chatMuteView.y = 2;
      }
      
      public function fillReceivedChatMessage(param1:ChatMessage) : void
      {
         var _loc2_:MobileChatLineView = null;
         if(_lineViews.length >= 20)
         {
            _loc2_ = (_lineViews.splice(0,1) as Vector.<MobileChatLineView>)[0];
         }
         else
         {
            _loc2_ = new MobileChatLineView();
            _scrollPane.addChild(_loc2_);
         }
         _lineViews.push(_loc2_);
         _loc2_.updateWithChatMessage(param1);
         drawLayout();
      }
      
      public function showMutePanel(param1:String, param2:String) : void
      {
         if(!_chatMuteView.visible)
         {
            _chatMuteView.updateMutePanel(param1,param2);
            _chatMuteView.visible = true;
         }
      }
      
      public function clearMessages() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MobileChatLineView = null;
         _loc2_ = 0;
         while(_loc2_ < _lineViews.length)
         {
            _loc1_ = _lineViews[_loc2_];
            if(_scrollPane.contains(_loc1_))
            {
               _scrollPane.removeChild(_loc1_);
            }
            _loc2_++;
         }
         _lineViews.length = 0;
      }
      
      public function get chatMessageType() : ChatMessageType
      {
         return _chatMessageType;
      }
      
      public function get lineViews() : Vector.<MobileChatLineView>
      {
         return _lineViews;
      }
   }
}

