package peak.cuckoo.game.dto
{
   public class WeightNode
   {
      
      public var y:int;
      
      public var x:int;
      
      public var weight:Number;
      
      public var id:int;
      
      public function WeightNode(param1:int = 0, param2:int = 0, param3:Number = 0)
      {
         x = param1;
         y = param2;
         weight = param3;
         id = (param1 << 10) + param2;
      }
      
      public static function getNodeId(param1:int, param2:int) : int
      {
         return (param1 << 10) + param2;
      }
      
      public function isInBounds(param1:IntBounds) : Boolean
      {
         return x >= param1.lowX && x <= param1.highX && (y >= param1.lowY && y <= param1.highY);
      }
   }
}

