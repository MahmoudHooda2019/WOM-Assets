package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class ActivateBuildingRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _instanceId:int;
      
      private var _byGold:Boolean;
      
      public function ActivateBuildingRequest(param1:int, param2:Boolean = false)
      {
         super();
         _instanceId = param1;
         _byGold = param2;
      }
      
      override public function serialize() : Object
      {
         if(_byGold)
         {
            return {
               "instanceId":_instanceId,
               "byGold":_byGold
            };
         }
         return {"instanceId":_instanceId};
      }
   }
}

