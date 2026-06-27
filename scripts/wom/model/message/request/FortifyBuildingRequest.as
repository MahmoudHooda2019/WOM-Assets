package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class FortifyBuildingRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _instanceId:int;
      
      private var _byGold:Boolean;
      
      private var _completeResources:Boolean;
      
      public function FortifyBuildingRequest(param1:int, param2:Boolean = false, param3:Boolean = false)
      {
         super();
         _instanceId = param1;
         _byGold = param2;
         _completeResources = param3;
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
         if(_completeResources)
         {
            return {
               "instanceId":_instanceId,
               "completeResources":_completeResources
            };
         }
         return {"instanceId":_instanceId};
      }
   }
}

