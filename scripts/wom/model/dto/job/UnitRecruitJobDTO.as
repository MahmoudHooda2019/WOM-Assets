package wom.model.dto.job
{
   public class UnitRecruitJobDTO
   {
      
      private var _unitTypeId:int;
      
      private var _durationRemaining:Number;
      
      public function UnitRecruitJobDTO(param1:int, param2:Number)
      {
         super();
         _unitTypeId = param1;
         _durationRemaining = param2;
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

