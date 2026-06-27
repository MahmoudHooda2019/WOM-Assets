package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   
   public class StartRepairsRequest extends AbstractOutgoingMessage
   {
      
      public function StartRepairsRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

