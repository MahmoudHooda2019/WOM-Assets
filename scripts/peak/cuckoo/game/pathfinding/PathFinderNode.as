package peak.cuckoo.game.pathfinding
{
   import peak.cuckoo.game.dto.WeightNode;
   
   public class PathFinderNode
   {
      
      public var weightNode:WeightNode;
      
      public var nextOpenNode:PathFinderNode;
      
      public var gScore:Number = fScore = 1 / 0;
      
      public var fScore:Number;
      
      public var direction:int;
      
      public var comeFrom:PathFinderNode;
      
      public var closed:Boolean;
      
      public function PathFinderNode(param1:WeightNode)
      {
         weightNode = param1;
      }
   }
}

