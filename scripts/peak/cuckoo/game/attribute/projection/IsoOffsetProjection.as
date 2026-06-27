package peak.cuckoo.game.attribute.projection
{
   import flash.geom.Point;
   import peak.cuckoo.game.dto.Point3;
   
   public class IsoOffsetProjection extends IsoProjection
   {
      
      public var offset:Point3;
      
      public function IsoOffsetProjection(param1:Point3 = null)
      {
         super(param1);
         offset = new Point3();
      }
      
      override public function transform(param1:Point3, param2:Point3) : void
      {
         super.transform(param1,param2);
         param2.x += offset.x;
         param2.y += offset.y;
      }
      
      override public function reverse(param1:Point, param2:Point3) : void
      {
         param2.x = (param1.x * pitchY + param1.y * pitchX) / (pitchX * pitchY);
         param2.y = (param1.y * pitchX - param1.x * pitchY) / (pitchX * pitchY);
      }
   }
}

