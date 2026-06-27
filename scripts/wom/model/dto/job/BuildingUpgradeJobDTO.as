package wom.model.dto.job
{
   import wom.model.game.job.BuildingUpgradeJobType;
   
   public class BuildingUpgradeJobDTO
   {
      
      private var _instanceId:int;
      
      private var _targetLevel:int;
      
      private var _durationRemaining:Number;
      
      private var _type:BuildingUpgradeJobType;
      
      public function BuildingUpgradeJobDTO(param1:int, param2:int, param3:Number, param4:BuildingUpgradeJobType)
      {
         super();
         _instanceId = param1;
         _targetLevel = param2;
         _durationRemaining = param3;
         _type = param4;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get targetLevel() : int
      {
         return _targetLevel;
      }
      
      public function get durationRemaining() : Number
      {
         return _durationRemaining;
      }
      
      public function get type() : BuildingUpgradeJobType
      {
         return _type;
      }
   }
}

