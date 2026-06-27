package wom.model.dto.combat
{
   public class DefenderBuildingInfo
   {
      
      private var _instanceId:int;
      
      private var _damaged:Boolean;
      
      public function DefenderBuildingInfo(param1:int, param2:Boolean)
      {
         super();
         _instanceId = param1;
         _damaged = param2;
      }
      
      public static function deserialize(param1:Object) : DefenderBuildingInfo
      {
         return new DefenderBuildingInfo(param1.instanceId,param1.damaged);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get damaged() : Boolean
      {
         return _damaged;
      }
      
      public function serialize() : Object
      {
         return {
            "instanceId":_instanceId,
            "damaged":_damaged
         };
      }
   }
}

