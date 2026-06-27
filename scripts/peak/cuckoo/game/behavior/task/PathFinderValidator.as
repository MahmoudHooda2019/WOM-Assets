package peak.cuckoo.game.behavior.task
{
   import flash.geom.Point;
   import peak.cuckoo.game.pathfinding.AreaPathFinder;
   import peak.task.Task;
   
   public class PathFinderValidator extends PathFinderTemplate
   {
      
      public var pathFinder:AreaPathFinder;
      
      private var taskID:int;
      
      private var finishedFrameNum:int;
      
      private var waypoint:Vector.<Point>;
      
      internal var canceled:Boolean;
      
      public function PathFinderValidator(param1:int, param2:int, param3:Vector.<Point>, param4:Boolean)
      {
         super();
         this.taskID = param1;
         this.finishedFrameNum = param2;
         this.waypoint = param3;
         this.canceled = param4;
      }
      
      override public function doFinishJob() : void
      {
         pathFinder.finished.dispatch(waypoint,pathFinder.taskId);
      }
      
      public function setPathFinder(param1:Task) : void
      {
         this.pathFinder = param1 as AreaPathFinder;
      }
   }
}

