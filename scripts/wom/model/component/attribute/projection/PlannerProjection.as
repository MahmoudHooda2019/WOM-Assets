package wom.model.component.attribute.projection
{
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.dto.Point3;
   
   public class PlannerProjection extends BaseProjection
   {
      
      public function PlannerProjection()
      {
         super();
      }
      
      override public function transform(param1:Point3, param2:Point3) : void
      {
         param2.x = param1.x * 3;
         param2.y = param1.y * 3;
         param2.z = param1.z;
      }
   }
}

