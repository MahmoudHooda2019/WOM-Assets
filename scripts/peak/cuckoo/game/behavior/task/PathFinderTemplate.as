package peak.cuckoo.game.behavior.task
{
   import peak.cuckoo.game.dto.Point3;
   import peak.signal.Signal0;
   import peak.task.Task;
   
   public class PathFinderTemplate extends Task
   {
      
      public static var TASK_ID_COUNTER:int = 0;
      
      public static const TYPE_ID:String = "PathFinder";
      
      public var TASK_ID:int;
      
      public var finishJob:Signal0;
      
      public var wayPoints:Vector.<Point3>;
      
      public function PathFinderTemplate()
      {
         super();
      }
      
      public function get typeId() : String
      {
         return "PathFinder";
      }
      
      public function doFinishJob() : void
      {
      }
   }
}

