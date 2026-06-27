package wom.model.game.job
{
   public class UnitRecruitJob
   {
      
      private var _unitTypeId:int;
      
      private var _durationRemaining:Number;
      
      private var _originalDuration:Number;
      
      private var _jobCreationTime:Number;
      
      public function UnitRecruitJob(param1:int, param2:Number, param3:Number, param4:Number)
      {
         super();
         _unitTypeId = param1;
         _durationRemaining = param2;
         _originalDuration = param3;
         _jobCreationTime = param4;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
      
      public function get durationRemaining() : Number
      {
         return _durationRemaining;
      }
      
      public function get originalDuration() : Number
      {
         return _originalDuration;
      }
      
      public function get jobCreationTime() : Number
      {
         return _jobCreationTime;
      }
   }
}

