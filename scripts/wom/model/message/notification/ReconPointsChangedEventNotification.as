package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class ReconPointsChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _reconPoints:int;
      
      public function ReconPointsChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _reconPoints = param1.reconPoints;
      }
      
      public function get reconPoints() : int
      {
         return _reconPoints;
      }
   }
}

