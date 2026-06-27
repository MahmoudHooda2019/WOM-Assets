package peak.cuckoo.game.attribute.projection
{
   import flash.geom.Point;
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.dto.Point3;
   
   public class BaseProjection extends Attribute
   {
      
      public static const TYPE_ID:String = "BaseProjection";
      
      public var sortPoint:Point3;
      
      public function BaseProjection(param1:Point3 = null)
      {
         super();
         if(param1)
         {
            this.sortPoint = param1;
         }
         else
         {
            this.sortPoint = new Point3();
         }
      }
      
      override public function get typeId() : String
      {
         return "BaseProjection";
      }
      
      public function transform(param1:Point3, param2:Point3) : void
      {
         param2.x = param1.x;
         param2.y = param1.y;
         param2.z = param1.z;
      }
      
      public function reverse(param1:Point, param2:Point3) : void
      {
         param2.x = param1.x;
         param2.y = param1.y;
      }
   }
}

