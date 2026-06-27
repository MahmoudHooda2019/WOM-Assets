package peak.cuckoo.game.dto
{
   public class IntBounds
   {
      
      public var lowY:int;
      
      public var lowX:int;
      
      public var highY:int;
      
      public var highX:int;
      
      public function IntBounds(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0)
      {
         lowX = param1;
         highX = param2;
         lowY = param3;
         highY = param4;
      }
   }
}

