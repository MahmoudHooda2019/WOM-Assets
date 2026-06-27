package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class BuildingRecycledEventNotification extends AbstractIncomingMessage
   {
      
      private var _instanceId:int;
      
      public function BuildingRecycledEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _instanceId = param1.instanceId;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
   }
}

