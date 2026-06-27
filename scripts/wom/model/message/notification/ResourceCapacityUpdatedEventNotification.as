package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class ResourceCapacityUpdatedEventNotification extends AbstractIncomingMessage
   {
      
      private var _newCapacity:int;
      
      public function ResourceCapacityUpdatedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _newCapacity = param1.newCapacity;
      }
      
      public function get newCapacity() : int
      {
         return _newCapacity;
      }
   }
}

