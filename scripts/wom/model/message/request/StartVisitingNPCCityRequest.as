package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class StartVisitingNPCCityRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _npcName:String;
      
      public function StartVisitingNPCCityRequest(param1:String)
      {
         super();
         _npcName = param1;
      }
      
      override public function serialize() : Object
      {
         return {"npcName":_npcName};
      }
   }
}

