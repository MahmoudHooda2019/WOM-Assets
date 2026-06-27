package peak.network
{
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import org.robotlegs.mvcs.Actor;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   
   public class NullTerminatedCipheredUtfSocketConnection extends Actor implements ServerConnection
   {
      
      private static const OUTGOING_KEEPALIVE:String = "0";
      
      private static const INCOMING_KEEPALIVE:String = "1";
      
      private static const KEEPALIVE_INTERVAL:Number = 15000;
      
      private var _socket:Socket;
      
      private var _cipher:Cipher;
      
      protected var connectionId:String;
      
      private var _mainBuffer:ByteArray;
      
      private var _incomingMsgBuffer:ByteArray;
      
      private var _outgoingMsgBuffer:ByteArray;
      
      private var _terminator:uint = 0;
      
      private var _keepAliveTimer:Timer;
      
      private var _initKeepAlive:Boolean;
      
      public function NullTerminatedCipheredUtfSocketConnection(param1:Cipher, param2:String = "", param3:Boolean = false)
      {
         super();
         _socket = null;
         _cipher = param1;
         this.connectionId = param2;
         _initKeepAlive = param3;
         reset();
      }
      
      private function onSocketData(param1:ProgressEvent) : void
      {
         _mainBuffer.clear();
         _socket.readBytes(_mainBuffer,_mainBuffer.position);
         readFromCipheredMainBuffer();
      }
      
      private function readFromCipheredMainBuffer() : void
      {
         var _loc2_:* = 0;
         var _loc1_:* = 0;
         var _loc3_:String = null;
         while(_mainBuffer.bytesAvailable > 0)
         {
            _loc2_ = _mainBuffer.readUnsignedByte();
            _loc1_ = _cipher.decodeByte(_loc2_);
            _incomingMsgBuffer.writeByte(_loc1_ as int);
            if(_loc1_ == _terminator)
            {
               _incomingMsgBuffer.position = 0;
               _loc3_ = _incomingMsgBuffer.readUTFBytes(_incomingMsgBuffer.bytesAvailable);
               _incomingMsgBuffer.clear();
               if(_loc3_ != "1" || !_initKeepAlive)
               {
                  log(LoggerContexts.NETWORK,"RECV: " + connectionId + _loc3_);
               }
               if(_loc3_ != "1")
               {
                  try
                  {
                     dispatch(new NetworkEvent("dataReceived",_loc3_));
                  }
                  catch(e:Error)
                  {
                     log(LoggerContexts.NETWORK,"COULD NOT PARSE MESSAGE: " + _loc3_);
                  }
               }
               if(_initKeepAlive)
               {
                  _keepAliveTimer.reset();
                  _keepAliveTimer.start();
               }
            }
         }
      }
      
      protected function startKeepAliveTimer() : void
      {
         if(_initKeepAlive)
         {
            _keepAliveTimer.start();
         }
      }
      
      protected function stopKeepAliveTimer() : void
      {
         if(_initKeepAlive)
         {
            _keepAliveTimer.stop();
         }
      }
      
      protected function onConnect(param1:Event) : void
      {
         log(LoggerContexts.NETWORK,"CONNECTED");
         startKeepAliveTimer();
         dispatch(new ClientEvent("connectionEstablished"));
      }
      
      protected function onConnectionError(param1:Event) : void
      {
         log(LoggerContexts.NETWORK,"CONNECTION LOST");
         stopKeepAliveTimer();
         dispatch(new ClientEvent("connectionLost"));
      }
      
      protected function onSocketClosed(param1:Event) : void
      {
         log(LoggerContexts.NETWORK,"SOCKET CLOSED BY SERVER");
         stopKeepAliveTimer();
         dispatch(new ClientEvent("connectionLost"));
      }
      
      public function connect(param1:String, param2:int) : void
      {
         log(LoggerContexts.NETWORK,"CONNECTING TO " + param1 + ":" + param2);
         _socket.connect(param1,param2);
      }
      
      public function write(param1:String) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         try
         {
            if(_socket.connected)
            {
               log(LoggerContexts.NETWORK,"SEND: " + param1);
               _outgoingMsgBuffer.clear();
               _outgoingMsgBuffer.writeUTFBytes(param1);
               _outgoingMsgBuffer.writeByte(_terminator);
               _outgoingMsgBuffer.position = 0;
               while(_outgoingMsgBuffer.bytesAvailable > 0)
               {
                  _loc3_ = _outgoingMsgBuffer.readUnsignedByte();
                  _loc2_ = _cipher.encodeByte(_loc3_);
                  _socket.writeByte(_loc2_);
               }
               _socket.flush();
               log(LoggerContexts.NETWORK,"Message Sent");
            }
            else
            {
               log(LoggerContexts.NETWORK,"Socket not connected, message not sent: " + param1);
            }
         }
         catch(e:Error)
         {
            log(LoggerContexts.NETWORK,"ERROR SENDING: " + param1);
            log(LoggerContexts.NETWORK,"ERROR MESSAGE",e.message);
         }
      }
      
      private function onKeepAlive(param1:TimerEvent) : void
      {
         keepAlive();
      }
      
      public function keepAlive() : void
      {
         write("0");
      }
      
      public function disconnect() : void
      {
         if(_socket.connected)
         {
            _socket.close();
         }
         stopKeepAliveTimer();
      }
      
      public function get connected() : Boolean
      {
         return _socket.connected;
      }
      
      public function reset() : void
      {
         _cipher.resetCipher();
         if(_socket != null)
         {
            eventMap.unmapListener(_socket,"socketData",onSocketData);
            eventMap.unmapListener(_socket,"close",onSocketClosed);
            eventMap.unmapListener(_socket,"connect",onConnect);
            eventMap.unmapListener(_socket,"securityError",onConnectionError);
            eventMap.unmapListener(_socket,"error",onConnectionError);
            eventMap.unmapListener(_socket,"ioError",onConnectionError);
            _socket.close();
            _socket = null;
         }
         _socket = new Socket();
         _incomingMsgBuffer = new ByteArray();
         _mainBuffer = new ByteArray();
         _outgoingMsgBuffer = new ByteArray();
         if(_initKeepAlive)
         {
            _keepAliveTimer = new Timer(15000);
            _keepAliveTimer.addEventListener("timer",onKeepAlive);
            _keepAliveTimer.start();
         }
         eventMap.mapListener(_socket,"socketData",onSocketData);
         eventMap.mapListener(_socket,"close",onSocketClosed);
         eventMap.mapListener(_socket,"connect",onConnect);
         eventMap.mapListener(_socket,"securityError",onConnectionError);
         eventMap.mapListener(_socket,"error",onConnectionError);
         eventMap.mapListener(_socket,"ioError",onConnectionError);
      }
   }
}

