package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class UpdatePigeonPostSubscriptionsMessageRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _subscribedActions:Vector.<int>;
      
      public function UpdatePigeonPostSubscriptionsMessageRequest(param1:Vector.<int>)
      {
         super();
         _subscribedActions = param1;
      }
      
      override public function serialize() : Object
      {
         return {"subscribedActions":_subscribedActions};
      }
   }
}

