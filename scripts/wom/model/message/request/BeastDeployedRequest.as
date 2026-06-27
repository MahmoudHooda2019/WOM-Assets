package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.dto.DeployBeastCircleInfoDTO;
   
   public class BeastDeployedRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var timeDifference:Number;
      
      private var deployBeastInfoDTO:DeployBeastCircleInfoDTO;
      
      public function BeastDeployedRequest(param1:Number, param2:DeployBeastCircleInfoDTO)
      {
         super();
         this.timeDifference = param1;
         this.deployBeastInfoDTO = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "dbci":deployBeastInfoDTO.serialize(),
            "timeDifference":timeDifference
         };
      }
   }
}

