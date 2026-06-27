package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import wom.model.game.chat.ChatAnomalyType;
   
   public class ChatAnomalyDetectionRequest extends AbstractOutgoingMessage
   {
      
      private var _anomalyType:ChatAnomalyType;
      
      public function ChatAnomalyDetectionRequest(param1:ChatAnomalyType)
      {
         super();
         _anomalyType = param1;
      }
      
      override public function serialize() : Object
      {
         return {"banType":_anomalyType.id};
      }
   }
}

