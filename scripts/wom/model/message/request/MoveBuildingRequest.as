package wom.model.message.request
{
   import flash.geom.Point;
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class MoveBuildingRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public var _instanceId:int;
      
      public var _targetPosition:Point;
      
      public function MoveBuildingRequest(param1:int, param2:Point)
      {
         super();
         _instanceId = param1;
         _targetPosition = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "instanceId":_instanceId,
            "targetPosition":{
               "x":_targetPosition.x,
               "y":_targetPosition.y
            }
         };
      }
   }
}

