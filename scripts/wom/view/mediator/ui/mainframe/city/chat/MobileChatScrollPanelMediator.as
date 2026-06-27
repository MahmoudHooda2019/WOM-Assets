package wom.view.mediator.ui.mainframe.city.chat
{
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ui.ChatMessageReceivedEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.chat.ChatMessage;
   import wom.view.ui.mainframe.city.chat.MobileChatLineView;
   import wom.view.ui.mainframe.city.chat.MobileChatScrollPanel;
   
   public class MobileChatScrollPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileChatScrollPanel;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileChatScrollPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         addContextListener("MESSAGE_RECEIVED",onChatMessageReceived,ChatMessageReceivedEvent);
         addContextListener("allianceChatMessageReceived",onChatMessageReceived,ChatMessageReceivedEvent);
         updateWithChatMessages();
      }
      
      private function updateWithChatMessages() : void
      {
         for each(var _loc1_ in userInfo.chatMessages)
         {
            if(_loc1_.messageType == view.chatMessageType)
            {
               view.fillReceivedChatMessage(_loc1_);
            }
         }
      }
      
      private function onChatMessageReceived(param1:ChatMessageReceivedEvent) : void
      {
         var _loc2_:MobileChatLineView = null;
         if(view.chatMessageType == param1.chatMessage.messageType)
         {
            view.fillReceivedChatMessage(param1.chatMessage);
            _loc2_ = view.lineViews[view.lineViews.length - 1];
            if(!_loc2_.hasEventListener("touch"))
            {
               eventMap.mapStarlingListener(_loc2_.nameField,"touch",onUsernameClickToBlock,TouchEvent);
            }
         }
      }
      
      private function onUsernameClickToBlock(param1:TouchEvent) : void
      {
         var _loc4_:MobileChatLineView = null;
         var _loc3_:ChatMessage = null;
         var _loc2_:Touch = param1.getTouch(view,"ended");
         if(_loc2_)
         {
            _loc4_ = _loc2_.target.parent as MobileChatLineView;
            if(_loc4_)
            {
               _loc3_ = _loc4_.chatMessage;
               if(!(_loc3_.senderPid in userInfo.mutedUsers) && !_loc3_.senderPid.length == 0 && !_loc3_.fromThisUser && !_loc3_.fromAdmin)
               {
                  view.showMutePanel(_loc3_.senderName,_loc3_.senderPid);
               }
            }
         }
      }
   }
}

