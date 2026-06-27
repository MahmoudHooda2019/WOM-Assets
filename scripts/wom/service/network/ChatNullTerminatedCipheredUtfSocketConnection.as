package wom.service.network
{
   import flash.events.Event;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.network.Cipher;
   import peak.network.NullTerminatedCipheredUtfSocketConnection;
   import wom.controller.event.chat.ChatClientEvent;
   
   public class ChatNullTerminatedCipheredUtfSocketConnection extends NullTerminatedCipheredUtfSocketConnection
   {
      
      public function ChatNullTerminatedCipheredUtfSocketConnection(param1:Cipher, param2:String = "")
      {
         super(param1,param2,true);
      }
      
      override protected function onConnect(param1:Event) : void
      {
         log(LoggerContexts.NETWORK,"CHAT CONNECTED");
         startKeepAliveTimer();
         dispatch(new ChatClientEvent("chatConnectionEstablished"));
      }
      
      override protected function onConnectionError(param1:Event) : void
      {
         log(LoggerContexts.NETWORK,"CHAT CONNECTION LOST");
         stopKeepAliveTimer();
         dispatch(new ChatClientEvent("chatConnectionLost"));
      }
      
      override protected function onSocketClosed(param1:Event) : void
      {
         log(LoggerContexts.NETWORK,"CHAT SOCKET CLOSED BY SERVER");
         stopKeepAliveTimer();
         dispatch(new ChatClientEvent("chatConnectionLost"));
      }
   }
}

