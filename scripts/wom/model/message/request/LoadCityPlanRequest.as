package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class LoadCityPlanRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public var _slot:int;
      
      public function LoadCityPlanRequest(param1:int)
      {
         super();
         _slot = param1;
      }
      
      override public function serialize() : Object
      {
         return {"slot":_slot};
      }
   }
}

