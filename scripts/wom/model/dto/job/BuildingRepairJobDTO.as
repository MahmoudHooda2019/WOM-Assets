package wom.model.dto.job
{
   public class BuildingRepairJobDTO
   {
      
      private var _instanceId:int;
      
      private var _durationRemaining:Number;
      
      public function BuildingRepairJobDTO(param1:int, param2:Number)
      {
         super();
         _instanceId = param1;
         _durationRemaining = param2;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get durationRemaining() : Number
      {
         return _durationRemaining;
      }
   }
}

