package wom.controller.command
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import peak.i18n.PText;
   import peak.network.ServerConnection;
   import wom.controller.PCommand;
   import wom.controller.event.chat.ChatClientEvent;
   import wom.controller.event.ui.ChatMessageReceivedEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.chat.ChatMessage;
   import wom.model.game.chat.ChatMessageType;
   
   public class HandleChatConnectionLostCommand extends PCommand
   {
      
      [Inject(name="chatServer")]
      public var serverConnection:ServerConnection;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleChatConnectionLostCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:Timer = null;
         if(userInfo.chatRetryAttemptCount > 0)
         {
            if(userInfo.chatRetryAttemptCount == 5)
            {
               serverConnection.reset();
               var _temp_6:* = §§findproperty(ChatMessageReceivedEvent);
               var _temp_5:* = "MESSAGE_RECEIVED";
               var _temp_4:* = §§findproperty(ChatMessage);
               var _temp_3:* = ChatMessageType.WORLD;
               var _temp_2:* = "";
               var _temp_1:* = "";
               var _loc2_:String = "ui.mainframe.city.chat.connectretry";
               dispatch(new ChatMessageReceivedEvent(_temp_5,new ChatMessage(_temp_3,_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_),false,false,new Date())));
            }
            userInfo.chatRetryAttemptCount--;
            _loc1_ = new Timer(10000 - userInfo.chatRetryAttemptCount * 1000,1);
            _loc1_.addEventListener("timerComplete",onTimerComplete);
            _loc1_.start();
         }
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         if(!serverConnection.connected)
         {
            dispatch(new ChatClientEvent("connectToChatServer"));
         }
      }
   }
}

