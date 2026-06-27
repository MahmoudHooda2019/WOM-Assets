package wom.model.game.job
{
   public class BuildingRepairJob
   {
      
      private var _instanceId:int;
      
      private var _durationRemaining:Number;
      
      private var _jobCreationTime:Number;
      
      public function BuildingRepairJob(param1:int, param2:Number, param3:Number)
      {
         super();
         _instanceId = param1;
         _durationRemaining = param2;
         _jobCreationTime = param3;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get durationRemaining() : Number
      {
         return _durationRemaining;
      }
      
      public function get jobCreationTime() : Number
      {
         return _jobCreationTime;
      }
      
      public function set durationRemaining(param1:Number) : void
      {
         _durationRemaining = param1;
      }
      
      public function set jobCreationTime(param1:Number) : void
      {
         _jobCreationTime = param1;
      }
   }
}

