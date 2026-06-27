package peak.cuckoo.game.attribute.projection
{
   import flash.geom.Point;
   import peak.cuckoo.game.Root;
   import peak.cuckoo.game.dto.Point3;
   
   public class IsoProjection extends BaseProjection
   {
      
      public var pitchX:Number;
      
      public var pitchY:Number;
      
      public function IsoProjection(param1:Point3 = null, param2:Number = 0, param3:Number = 0)
      {
         super(param1);
         this.pitchX = param2 == 0 ? Root.PROJECTION_PITCH_X : param2;
         this.pitchY = param3 == 0 ? Root.PROJECTION_PITCH_Y : param3;
      }
      
      override public function transform(param1:Point3, param2:Point3) : void
      {
         param2.x = (param1.x - param1.y) * pitchX / 2;
         param2.y = (param1.x + param1.y) * pitchY / 2;
         param2.z = param2.y + sortPoint.y + (param2.x + sortPoint.x) / 100000 + owner.id / 100000000;
      }
      
      override public function reverse(param1:Point, param2:Point3) : void
      {
         param2.x = (param1.x * pitchY + param1.y * pitchX) / (pitchX * pitchY);
         param2.y = (param1.y * pitchX - param1.x * pitchY) / (pitchX * pitchY);
      }
   }
}

