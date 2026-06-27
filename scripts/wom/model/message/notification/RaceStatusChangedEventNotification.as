package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class RaceStatusChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _eventStartTime:Number;
      
      private var _eventEndTime:Number;
      
      private var _eventStoreEndTime:Number;
      
      public function RaceStatusChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:Object = param1.raceStatus;
         _eventStartTime = _loc2_ ? _loc2_.raceStartDuration : -1;
         _eventEndTime = _loc2_ ? _loc2_.raceEndDuration : -1;
         _eventStoreEndTime = _loc2_ ? _loc2_.storeEndDuration : -1;
      }
      
      public function get eventStartTime() : Number
      {
         return _eventStartTime;
      }
      
      public function get eventEndTime() : Number
      {
         return _eventEndTime;
      }
      
      public function get eventStoreEndTime() : Number
      {
         return _eventStoreEndTime;
      }
   }
}

