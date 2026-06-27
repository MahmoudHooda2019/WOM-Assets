package wom.model.message.notification
{
   import flash.geom.Point;
   import peak.messaging.AbstractIncomingMessage;
   
   public class CityBuildingMovedEventNotification extends AbstractIncomingMessage
   {
      
      private var _instanceId:int;
      
      private var _position:Point;
      
      public function CityBuildingMovedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _instanceId = param1.instanceId;
         _position = new Point(param1.position.x,param1.position.y);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get position() : Point
      {
         return _position;
      }
   }
}

