package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class NumberOfWorkersChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _numberOfWorkers:int;
      
      public function NumberOfWorkersChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _numberOfWorkers = param1.numberOfWorkers;
      }
      
      public function get numberOfWorkers() : int
      {
         return _numberOfWorkers;
      }
   }
}

