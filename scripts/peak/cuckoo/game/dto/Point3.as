package peak.cuckoo.game.dto
{
   import flash.geom.Point;
   
   public class Point3 extends Point
   {
      
      public var z:Number;
      
      public function Point3(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.z = param3;
      }
   }
}

