package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.HiringInfoDTO;
   import wom.model.dto.job.UnitHireJobDTO;
   import wom.model.game.hiring.HiringPauseReasonType;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   
   public class HiringInfoChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _instanceId:int;
      
      private var _hiringInfo:HiringInfoDTO;
      
      private var _usesCentralQueue:Boolean;
      
      public function HiringInfoChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc4_:UnitHireJobDTO = null;
         _instanceId = param1.instanceId;
         _usesCentralQueue = param1.usesCentralQueue;
         var _loc5_:Object = param1.hiringInfo;
         var _loc3_:Vector.<HiringSlotView> = new Vector.<HiringSlotView>();
         for each(var _loc6_ in _loc5_.hiringQueue.hiringSlots)
         {
            _loc3_.push(new HiringSlotView(_loc6_.slotIndex,_loc6_.unitId,_loc6_.numberOfUnits));
         }
         var _loc2_:HiringQueueInfo = new HiringQueueInfo(_loc5_.hiringQueue.maxNumberOfHiringSlots,_loc3_);
         if(_loc5_.activeHiring)
         {
            _loc4_ = new UnitHireJobDTO(_loc5_.activeHiring.unitTypeId,_loc5_.activeHiring.executionTime,_loc5_.activeHiring.remainingDuration,_loc5_.hiringBuildingInstanceId);
         }
         _hiringInfo = new HiringInfoDTO(_loc5_.hiringBuildingInstanceId,_loc2_,_loc4_,_loc5_.hiringPaused,HiringPauseReasonType.determineHiringPauseReasonType(_loc5_.pauseReason),_loc5_.lastHiredUnitId);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get hiringInfo() : HiringInfoDTO
      {
         return _hiringInfo;
      }
      
      public function get usesCentralQueue() : Boolean
      {
         return _usesCentralQueue;
      }
   }
}

