package wom.controller.command
{
   import peak.logging.LoggerContext;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.messaging.DataToMessageContainerConverter;
   import peak.messaging.IncomingMessage;
   import peak.messaging.IncomingMessageContainer;
   import peak.messaging.IncomingMessageMap;
   import peak.network.NetworkEvent;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.UserInfo;
   
   public class HandleIncomingDataCommand extends PCommand
   {
      
      [Inject]
      public var networkEvent:NetworkEvent;
      
      [Inject]
      public var dataToMessageContainerConverter:DataToMessageContainerConverter;
      
      [Inject]
      public var messageMap:IncomingMessageMap;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleIncomingDataCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:IncomingMessage = null;
         var _loc4_:* = undefined;
         var _loc3_:String = null;
         var _loc2_:IncomingMessageContainer = dataToMessageContainerConverter.convert(networkEvent.data);
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.message;
            _loc4_ = _loc2_.messageType;
            log(LoggerContexts.MESSAGING,"INC " + _loc4_,_loc1_);
            if(!(messageMap as WomIncomingMessageMap).hasGameModeTypeDictionaryForType(_loc4_) || userInfo.gameMode && (messageMap as WomIncomingMessageMap).hasGameModeTypeForMessageType(_loc4_,userInfo.gameMode))
            {
               _loc3_ = messageMap.getEventTypeFor(messageMap.getClassByType(_loc4_));
               dispatch(new MessageReceivedEvent(_loc3_,_loc1_,_loc2_.messageId));
            }
            else
            {
               log(LoggerContexts.INFRASTRUCTURE,"ERROR Unexpected message type \'" + _loc4_ + "\' for game mode \'" + (userInfo.gameMode ? userInfo.gameMode.name : "NULL") + "\'");
            }
         }
         else
         {
            log(LoggerContext.combine(LoggerContexts.INFRASTRUCTURE,LoggerContexts.NETWORK),"Incoming data could not be converted to message: " + networkEvent.data.toString());
         }
      }
   }
}

