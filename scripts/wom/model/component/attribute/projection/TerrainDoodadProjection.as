package wom.model.component.attribute.projection
{
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.dto.Point3;
   
   public class TerrainDoodadProjection extends BaseProjection
   {
      
      public static const SCALE_CONSTANT:int = 1;
      
      public function TerrainDoodadProjection()
      {
         super();
      }
      
      override public function transform(param1:Point3, param2:Point3) : void
      {
         param2.x = param1.x * 1;
         param2.y = param1.y * 1;
         param2.z = param1.y * 10000 + param1.x;
      }
   }
}

