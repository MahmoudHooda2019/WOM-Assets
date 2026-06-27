package wom.model.game.job
{
   public class UnitHireJob
   {
      
      private var _unitTypeId:int;
      
      private var _executionTime:Number;
      
      private var _remainingDuration:Number;
      
      private var _hiringBuildingInstanceId:int;
      
      private var _jobCreationTime:Number;
      
      private var _originalDuration:Number;
      
      public function UnitHireJob(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:Number)
      {
         super();
         _unitTypeId = param1;
         _executionTime = param2;
         _remainingDuration = param3;
         _hiringBuildingInstanceId = param4;
         _jobCreationTime = param5;
         _originalDuration = param6;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
      
      public function get executionTime() : Number
      {
         return _executionTime;
      }
      
      public function get remainingDuration() : Number
      {
         return _remainingDuration;
      }
      
      public function get hiringBuildingInstanceId() : int
      {
         return _hiringBuildingInstanceId;
      }
      
      public function get jobCreationTime() : Number
      {
         return _jobCreationTime;
      }
      
      public function get originalDuration() : Number
      {
         return _originalDuration;
      }
   }
}

