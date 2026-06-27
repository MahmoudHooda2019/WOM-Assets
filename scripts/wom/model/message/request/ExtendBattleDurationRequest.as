package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   
   public class ExtendBattleDurationRequest extends AbstractOutgoingMessage
   {
      
      public function ExtendBattleDurationRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return null;
      }
   }
}

