package wom.model.dto
{
   import peak.cuckoo.game.attribute.Position;
   
   public class PlannerBuildingDTO
   {
      
      private var _instanceId:int;
      
      private var _position:Position;
      
      public function PlannerBuildingDTO(param1:int, param2:Position)
      {
         super();
         _instanceId = param1;
         _position = param2;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function set instanceId(param1:int) : void
      {
         _instanceId = param1;
      }
      
      public function get position() : Position
      {
         return _position;
      }
      
      public function set position(param1:Position) : void
      {
         _position = param1;
      }
   }
}

