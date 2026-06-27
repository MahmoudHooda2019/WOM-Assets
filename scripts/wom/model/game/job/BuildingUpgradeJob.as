package wom.model.game.job
{
   public class BuildingUpgradeJob
   {
      
      private var _instanceId:int;
      
      private var _targetLevel:int;
      
      private var _durationRemaining:Number;
      
      private var _originalDuration:Number;
      
      private var _type:BuildingUpgradeJobType;
      
      private var _jobCreationTime:Number;
      
      public function BuildingUpgradeJob(param1:int, param2:int, param3:Number, param4:Number, param5:BuildingUpgradeJobType, param6:Number)
      {
         super();
         this._instanceId = param1;
         this._targetLevel = param2;
         this._durationRemaining = param3;
         this._originalDuration = param4;
         this._type = param5;
         _jobCreationTime = param6;
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
      
      public function get originalDuration() : Number
      {
         return _originalDuration;
      }
      
      public function get type() : BuildingUpgradeJobType
      {
         return _type;
      }
      
      public function get jobCreationTime() : Number
      {
         return _jobCreationTime;
      }
   }
}

