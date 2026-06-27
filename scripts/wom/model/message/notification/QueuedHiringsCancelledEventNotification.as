package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   
   public class QueuedHiringsCancelledEventNotification extends AbstractIncomingMessage
   {
      
      private var _instanceId:int;
      
      private var _hiringQueueInfo:HiringQueueInfo;
      
      private var _usesCentralQueue:Boolean;
      
      public function QueuedHiringsCancelledEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _instanceId = param1.instanceId;
         _usesCentralQueue = param1.usesCentralQueue;
         var _loc2_:Vector.<HiringSlotView> = new Vector.<HiringSlotView>();
         for each(var _loc3_ in param1.queueInfo.hiringSlots)
         {
            _loc2_.push(new HiringSlotView(_loc3_.slotIndex,_loc3_.unitId,_loc3_.numberOfUnits));
         }
         _hiringQueueInfo = new HiringQueueInfo(param1.queueInfo.maxNumberOfHiringSlots,_loc2_);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get hiringQueueInfo() : HiringQueueInfo
      {
         return _hiringQueueInfo;
      }
      
      public function get usesCentralQueue() : Boolean
      {
         return _usesCentralQueue;
      }
   }
}

