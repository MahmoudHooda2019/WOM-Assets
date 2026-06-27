package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class BuildingDamagedEventNotification extends AbstractIncomingMessage
   {
      
      private var _instanceId:int;
      
      private var _healthPoints:int;
      
      public function BuildingDamagedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _instanceId = param1.instanceId;
         _healthPoints = param1.healthPoints;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get healthPoints() : int
      {
         return _healthPoints;
      }
   }
}

