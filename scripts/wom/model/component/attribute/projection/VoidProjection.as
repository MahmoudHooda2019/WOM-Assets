package wom.model.component.attribute.projection
{
   import flash.geom.Point;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.dto.Point3;
   
   public class VoidProjection extends BaseProjection
   {
      
      public function VoidProjection()
      {
         super();
      }
      
      override public function transform(param1:Point3, param2:Point3) : void
      {
      }
      
      override public function reverse(param1:Point, param2:Point3) : void
      {
      }
   }
}

