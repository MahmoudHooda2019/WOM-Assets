package wom.model.component.attribute.projection
{
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.dto.Point3;
   
   public class IsoBuildingProjection extends IsoProjection
   {
      
      public var xDif:Number;
      
      public var yDif:Number;
      
      public function IsoBuildingProjection(param1:int, param2:Point3)
      {
         super(param2);
         xDif = param1 * pitchX / 2;
         yDif = param1 * pitchY;
      }
      
      override public function init() : void
      {
         super.init();
      }
      
      override public function transform(param1:Point3, param2:Point3) : void
      {
         param2.x = (param1.x - param1.y) * pitchX / 2;
         param2.y = (param1.x + param1.y) * pitchY / 2;
         param2.z = param2.y + sortPoint.y + yDif / 2 + (param2.x + sortPoint.x) / 100000 + owner.id / 100000000;
         param2.x -= xDif;
         param2.y += yDif;
      }
   }
}

