package peak.cuckoo.game.pathfinding
{
   import peak.cuckoo.game.dto.IntBounds;
   import peak.cuckoo.game.dto.IntPoint;
   
   public class PointPathFinder extends AreaPathFinder
   {
      
      public function PointPathFinder(param1:Array, param2:IntBounds, param3:IntPoint, param4:IntPoint, param5:int)
      {
         super(param1,param2,param3,new IntBounds(param4.x,param4.x,param4.y,param4.y),param5);
      }
   }
}

