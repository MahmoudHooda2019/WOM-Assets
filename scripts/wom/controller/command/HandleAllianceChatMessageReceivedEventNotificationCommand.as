package wom.controller.command
{
   import wom.controller.PCommand;
   import wom.controller.command.util.SwearFilter;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ui.ChatMessageReceivedEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.chat.ChatMessage;
   import wom.model.game.chat.ChatMessageType;
   import wom.model.message.notification.AllianceChatMessageReceivedEventNotification;
   
   public class HandleAllianceChatMessageReceivedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var swearFilter:SwearFilter;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleAllianceChatMessageReceivedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:AllianceChatMessageReceivedEventNotification = messageReceivedEvent.message as AllianceChatMessageReceivedEventNotification;
         var _loc2_:String = swearFilter.censorText(_loc3_.chatMessage);
         var _loc1_:ChatMessage = new ChatMessage(ChatMessageType.ALLIANCE,_loc3_.senderPid.toString(),_loc3_.senderName,_loc2_,userInfo.profile.gameId == _loc3_.senderPid.toString(),_loc3_.isAdmin,new Date());
         putChatMessageToUserInfo(_loc1_);
         if(_loc3_.senderPid.toString() in userInfo.mutedUsers && userInfo.mutedUsers[_loc3_.senderPid.toString()] == true)
         {
            return;
         }
         dispatch(new ChatMessageReceivedEvent("allianceChatMessageReceived",_loc1_));
      }
      
      private function putChatMessageToUserInfo(param1:ChatMessage) : void
      {
         if(userInfo.chatMessages.length >= 20 * 2)
         {
            userInfo.chatMessages.shift();
         }
         userInfo.chatMessages.push(param1);
      }
   }
}

