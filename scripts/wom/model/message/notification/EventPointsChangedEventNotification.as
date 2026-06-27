package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class EventPointsChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _eventPoints:int;
      
      private var _maxEventPointsReached:int;
      
      public function EventPointsChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _eventPoints = param1.eventPoints;
         _maxEventPointsReached = param1.maxEventPointsReached;
      }
      
      public function get eventPoints() : int
      {
         return _eventPoints;
      }
      
      public function get maxEventPointsReached() : int
      {
         return _maxEventPointsReached;
      }
   }
}

