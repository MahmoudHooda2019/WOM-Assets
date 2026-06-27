package wom.controller.command.chat
{
   import peak.i18n.PText;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import wom.controller.PCommand;
   import wom.controller.command.util.SwearFilter;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.chat.ChatClientEvent;
   import wom.controller.event.ui.ChatMessageReceivedEvent;
   import wom.model.dto.SwearFilterLanguageDTO;
   import wom.model.game.UserInfo;
   import wom.model.game.chat.ChatMessage;
   import wom.model.game.chat.ChatMessageType;
   import wom.model.message.response.ChatAuthResponse;
   
   public class HandleChatAuthResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var swearFilter:SwearFilter;
      
      public function HandleChatAuthResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ChatAuthResponse = messageReceivedEvent.message as ChatAuthResponse;
         if(_loc1_.success)
         {
            createSwearFilter(_loc1_.swearFilterLanguageDTO);
            var _temp_6:* = §§findproperty(ChatMessageReceivedEvent);
            var _temp_5:* = "MESSAGE_RECEIVED";
            var _temp_4:* = §§findproperty(ChatMessage);
            var _temp_3:* = ChatMessageType.WORLD;
            var _temp_2:* = "";
            var _temp_1:* = "";
            var _loc2_:String = "ui.mainframe.city.chat.ready";
            dispatch(new ChatMessageReceivedEvent(_temp_5,new ChatMessage(_temp_3,_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_),false,false,new Date())));
            userInfo.chatBanDuration = _loc1_.remainingDuration;
            dispatch(new ChatClientEvent("userBanned"));
         }
         else
         {
            log(LoggerContexts.INFRASTRUCTURE,"Chat Authentication failed!");
            var _temp_13:* = §§findproperty(ChatMessageReceivedEvent);
            var _temp_12:* = "MESSAGE_RECEIVED";
            var _temp_11:* = §§findproperty(ChatMessage);
            var _temp_10:* = ChatMessageType.WORLD;
            var _temp_9:* = "";
            var _temp_8:* = "";
            var _loc3_:String = "ui.mainframe.city.chat.authfail";
            dispatch(new ChatMessageReceivedEvent(_temp_12,new ChatMessage(_temp_10,_temp_9,_temp_8,peak.i18n.PText.INSTANCE.getText0(_loc3_),false,false,new Date())));
         }
      }
      
      private function createSwearFilter(param1:SwearFilterLanguageDTO) : void
      {
         if(param1)
         {
            swearFilter.updateWordLists(param1.wholeWords,param1.insideWords);
         }
      }
   }
}

