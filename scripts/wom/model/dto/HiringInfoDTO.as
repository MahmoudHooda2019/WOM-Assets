package wom.model.dto
{
   import wom.model.dto.job.UnitHireJobDTO;
   import wom.model.game.hiring.HiringPauseReasonType;
   import wom.model.game.hiring.HiringQueueInfo;
   
   public class HiringInfoDTO
   {
      
      private var _hiringBuildingInstanceId:int;
      
      private var _hiringQueue:HiringQueueInfo;
      
      private var _activeHiring:UnitHireJobDTO;
      
      private var _isHiringPaused:Boolean;
      
      private var _pauseReason:HiringPauseReasonType;
      
      private var _lastHiredUnitId:int;
      
      public function HiringInfoDTO(param1:int, param2:HiringQueueInfo, param3:UnitHireJobDTO, param4:Boolean, param5:HiringPauseReasonType, param6:int)
      {
         super();
         this._hiringBuildingInstanceId = param1;
         this._hiringQueue = param2;
         this._activeHiring = param3;
         this._isHiringPaused = param4;
         this._pauseReason = param5;
         this._lastHiredUnitId = param6;
      }
      
      public function get hiringBuildingInstanceId() : int
      {
         return _hiringBuildingInstanceId;
      }
      
      public function get hiringQueue() : HiringQueueInfo
      {
         return _hiringQueue;
      }
      
      public function get activeHiring() : UnitHireJobDTO
      {
         return _activeHiring;
      }
      
      public function get isHiringPaused() : Boolean
      {
         return _isHiringPaused;
      }
      
      public function get pauseReason() : HiringPauseReasonType
      {
         return _pauseReason;
      }
      
      public function get lastHiredUnitId() : int
      {
         return _lastHiredUnitId;
      }
   }
}

