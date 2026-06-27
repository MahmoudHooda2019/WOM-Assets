package wom.controller.command
{
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.messaging.DefaultOutgoingMessageContainer;
   import peak.messaging.MessageContainerToDataConverter;
   import peak.messaging.OutgoingMessage;
   import peak.messaging.OutgoingMessageContainer;
   import peak.messaging.OutgoingMessageMap;
   import peak.network.ServerConnection;
   import wom.controller.PCommand;
   import wom.controller.event.OutgoingMessageEvent;
   
   public class SendMessageCommand extends PCommand
   {
      
      [Inject]
      public var outgoingMessageEvent:OutgoingMessageEvent;
      
      [Inject]
      public var messageContainerToDataConverter:MessageContainerToDataConverter;
      
      [Inject]
      public var messageMap:OutgoingMessageMap;
      
      [Inject(name="gameServer")]
      public var connection:ServerConnection;
      
      public function SendMessageCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:OutgoingMessageContainer = null;
         var _loc3_:* = undefined;
         var _loc1_:OutgoingMessage = outgoingMessageEvent.message;
         var _loc5_:* = messageMap.getTypeByInstance(_loc1_);
         var _loc4_:int = 1;
         if(_loc5_ != null)
         {
            _loc2_ = new DefaultOutgoingMessageContainer(_loc5_,_loc4_,_loc1_);
            log(LoggerContexts.MESSAGING,"OUT " + _loc5_,_loc2_);
            _loc3_ = messageContainerToDataConverter.convert(_loc2_);
            connection.write(_loc3_);
         }
      }
   }
}

