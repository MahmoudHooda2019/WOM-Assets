package wom.model.dto.job
{
   public class UnitHireJobDTO
   {
      
      private var _unitTypeId:int;
      
      private var _executionTime:Number;
      
      private var _remainingDuration:Number;
      
      private var _hiringBuildingInstanceId:int;
      
      public function UnitHireJobDTO(param1:int, param2:Number, param3:Number, param4:int)
      {
         super();
         _unitTypeId = param1;
         _executionTime = param2;
         _remainingDuration = param3;
         _hiringBuildingInstanceId = param4;
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
   }
}

