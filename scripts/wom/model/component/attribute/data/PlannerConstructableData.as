package wom.model.component.attribute.data
{
   import flash.geom.Point;
   import peak.cuckoo.core.Attribute;
   
   public class PlannerConstructableData extends Attribute
   {
      
      public var baseSize:Number;
      
      public var halfBaseSize:Number;
      
      public var level:int;
      
      public var range:int;
      
      public var collide:Boolean;
      
      public var startPoint:Point = new Point();
      
      public function PlannerConstructableData(param1:Number, param2:int, param3:int)
      {
         super();
         this.baseSize = param1;
         halfBaseSize = param1 / 2;
         this.level = param2;
         this.range = param3;
      }
   }
}

