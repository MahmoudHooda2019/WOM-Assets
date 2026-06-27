package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.HiringInfoDTO;
   import wom.model.dto.job.UnitHireJobDTO;
   import wom.model.game.hiring.HiringPauseReasonType;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   
   public class GetHiringStatusResponse extends AbstractIncomingMessage
   {
      
      private var _instanceId:int;
      
      private var _hiringInfo:Vector.<HiringInfoDTO>;
      
      private var _usesCentralQueue:Boolean;
      
      public function GetHiringStatusResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc5_:UnitHireJobDTO = null;
         var _loc2_:HiringQueueInfo = null;
         var _loc3_:* = undefined;
         _instanceId = param1.instanceId;
         _usesCentralQueue = param1.usesCentralQueue;
         _hiringInfo = new Vector.<HiringInfoDTO>();
         for each(var _loc4_ in param1.hiringInfo)
         {
            _loc3_ = new Vector.<HiringSlotView>();
            for each(var _loc6_ in _loc4_.hiringQueue.hiringSlots)
            {
               _loc3_.push(new HiringSlotView(_loc6_.slotIndex,_loc6_.unitId,_loc6_.numberOfUnits));
            }
            _loc2_ = new HiringQueueInfo(_loc4_.hiringQueue.maxNumberOfHiringSlots,_loc3_);
            _loc5_ = null;
            if(_loc4_.activeHiring)
            {
               _loc5_ = new UnitHireJobDTO(_loc4_.activeHiring.unitTypeId,_loc4_.activeHiring.executionTime,_loc4_.activeHiring.remainingDuration,_loc4_.hiringBuildingInstanceId);
            }
            _hiringInfo.push(new HiringInfoDTO(_loc4_.hiringBuildingInstanceId,_loc2_,_loc5_,_loc4_.hiringPaused,HiringPauseReasonType.determineHiringPauseReasonType(_loc4_.pauseReason),_loc4_.lastHiredUnitId));
         }
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get hiringInfo() : Vector.<HiringInfoDTO>
      {
         return _hiringInfo;
      }
      
      public function get usesCentralQueue() : Boolean
      {
         return _usesCentralQueue;
      }
   }
}

