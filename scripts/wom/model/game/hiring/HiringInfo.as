package wom.model.game.hiring
{
   import wom.model.game.job.UnitHireJob;
   
   public class HiringInfo
   {
      
      private var _hiringBuildingInstanceId:int;
      
      private var _hiringQueue:HiringQueueInfo;
      
      private var _activeHiring:UnitHireJob;
      
      private var _isHiringPaused:Boolean;
      
      private var _pauseReason:HiringPauseReasonType;
      
      private var _lastHiredUnitId:int;
      
      public function HiringInfo(param1:int, param2:HiringQueueInfo, param3:UnitHireJob, param4:Boolean, param5:HiringPauseReasonType, param6:int)
      {
         super();
         _hiringBuildingInstanceId = param1;
         _hiringQueue = param2;
         _activeHiring = param3;
         _isHiringPaused = param4;
         _pauseReason = param5;
         _lastHiredUnitId = param6;
      }
      
      public function get hiringBuildingInstanceId() : int
      {
         return _hiringBuildingInstanceId;
      }
      
      public function get hiringQueue() : HiringQueueInfo
      {
         return _hiringQueue;
      }
      
      public function get activeHiring() : UnitHireJob
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
      
      public function set hiringQueue(param1:HiringQueueInfo) : void
      {
         _hiringQueue = param1;
      }
      
      public function set activeHiring(param1:UnitHireJob) : void
      {
         _activeHiring = param1;
      }
      
      public function set pauseReason(param1:HiringPauseReasonType) : void
      {
         _pauseReason = param1;
      }
      
      public function set isHiringPaused(param1:Boolean) : void
      {
         _isHiringPaused = param1;
      }
      
      public function set lastHiredUnitId(param1:int) : void
      {
         _lastHiredUnitId = param1;
      }
   }
}

