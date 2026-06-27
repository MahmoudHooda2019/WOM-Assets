package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.dto.DeployUnitCircleInfoDTO;
   
   public class RemoveDeployedUnitsRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _deployUnitCircleInfoDTO:Vector.<DeployUnitCircleInfoDTO>;
      
      public function RemoveDeployedUnitsRequest(param1:Vector.<DeployUnitCircleInfoDTO>)
      {
         super();
         _deployUnitCircleInfoDTO = param1;
      }
      
      override public function serialize() : Object
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in _deployUnitCircleInfoDTO)
         {
            _loc2_.push(_loc1_.serialize());
         }
         return {"duci":_loc2_};
      }
   }
}

