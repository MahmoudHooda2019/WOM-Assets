package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.dto.DeployedCatapultCircleInfoDTO;
   
   public class CatapultUsedRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _deployedCatapultCircleInfo:DeployedCatapultCircleInfoDTO;
      
      private var _timeDifference:Number;
      
      public function CatapultUsedRequest(param1:DeployedCatapultCircleInfoDTO, param2:Number)
      {
         super();
         this._deployedCatapultCircleInfo = param1;
         this._timeDifference = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "dcci":_deployedCatapultCircleInfo.serialize(),
            "td":_timeDifference
         };
      }
   }
}

