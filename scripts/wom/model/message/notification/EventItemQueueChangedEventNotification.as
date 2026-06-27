package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.store.EventInventoryItemInfo;
   
   public class EventItemQueueChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _eventItemQueue:Vector.<EventInventoryItemInfo>;
      
      public function EventItemQueueChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc3_:int = 0;
         _eventItemQueue = new Vector.<EventInventoryItemInfo>();
         for each(var _loc2_ in param1.itemsQueue)
         {
            _eventItemQueue.push(new EventInventoryItemInfo(_loc2_.itemId,_loc2_.duration,_loc3_));
            _loc3_ += _loc2_.duration;
         }
      }
      
      public function get eventItemQueue() : Vector.<EventInventoryItemInfo>
      {
         return _eventItemQueue;
      }
   }
}

