package wom.model.message.response
{
   import flash.geom.Point;
   import peak.messaging.AbstractIncomingMessage;
   
   public class MoveBuildingResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _instanceId:int;
      
      private var _targetPosition:Point;
      
      public function MoveBuildingResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _resultMessage = param1.resultMessage;
         if(_resultCode == 0)
         {
            _instanceId = param1.instanceId;
            _targetPosition = new Point(param1.targetPosition.x,param1.targetPosition.y);
         }
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get targetPosition() : Point
      {
         return _targetPosition;
      }
   }
}

