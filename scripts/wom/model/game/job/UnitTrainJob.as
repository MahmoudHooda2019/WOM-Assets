package wom.model.game.job
{
   public class UnitTrainJob
   {
      
      private var _unitTypeId:int;
      
      private var _durationRemaining:Number;
      
      private var _originalDuration:Number;
      
      private var _jobCreationTime:Number;
      
      private var _instanceId:int;
      
      public function UnitTrainJob(param1:int, param2:Number, param3:Number, param4:Number, param5:int)
      {
         super();
         _unitTypeId = param1;
         _durationRemaining = param2;
         _originalDuration = param3;
         _jobCreationTime = param4;
         _instanceId = param5;
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
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function set unitTypeId(param1:int) : void
      {
         _unitTypeId = param1;
      }
      
      public function set durationRemaining(param1:Number) : void
      {
         _durationRemaining = param1;
      }
      
      public function set originalDuration(param1:Number) : void
      {
         _originalDuration = param1;
      }
      
      public function set jobCreationTime(param1:Number) : void
      {
         _jobCreationTime = param1;
      }
      
      public function set instanceId(param1:int) : void
      {
         _instanceId = param1;
      }
   }
}

