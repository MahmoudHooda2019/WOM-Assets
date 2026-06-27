package wom.model.dto.combat
{
   public class BuildingHealth
   {
      
      private var _instanceId:int;
      
      private var _healthPoint:Number;
      
      public function BuildingHealth(param1:int, param2:Number)
      {
         super();
         this._instanceId = param1;
         this._healthPoint = param2;
      }
      
      public static function deserialize(param1:Object) : BuildingHealth
      {
         return new BuildingHealth(param1.id,param1.healthPoints);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get healthPoint() : Number
      {
         return _healthPoint;
      }
   }
}

