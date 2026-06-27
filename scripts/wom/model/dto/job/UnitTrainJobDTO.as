package wom.model.dto.job
{
   public class UnitTrainJobDTO
   {
      
      private var _unitTypeId:int;
      
      private var _durationRemaining:Number;
      
      private var _instanceId:int;
      
      public function UnitTrainJobDTO(param1:int, param2:Number, param3:int)
      {
         super();
         _unitTypeId = param1;
         _durationRemaining = param2;
         _instanceId = param3;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
      
      public function get durationRemaining() : Number
      {
         return _durationRemaining;
      }
   }
}

