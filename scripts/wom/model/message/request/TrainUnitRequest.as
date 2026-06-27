package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class TrainUnitRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _unitTypeId:int;
      
      private var _instanceId:int;
      
      private var _byGold:Boolean;
      
      private var _completeResources:Boolean;
      
      public function TrainUnitRequest(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super();
         _unitTypeId = param1;
         _instanceId = param2;
         _byGold = param3;
         _completeResources = param4;
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = {
            "unitTypeId":_unitTypeId,
            "instanceId":_instanceId
         };
         if(_byGold)
         {
            _loc1_.byGold = _byGold;
         }
         else if(_completeResources)
         {
            _loc1_.completeResources = _completeResources;
         }
         return _loc1_;
      }
   }
}

