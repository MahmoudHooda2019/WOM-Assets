package peak.cuckoo.game.behavior.task
{
   import flash.utils.Dictionary;
   import peak.cuckoo.game.behavior.FpsSync;
   
   public class TaskRunnerValidator extends TaskRunner
   {
      
      public var waitingPathFinding:Dictionary;
      
      public var pathFinishFrameMap:Dictionary;
      
      public function TaskRunnerValidator()
      {
         super();
      }
      
      override public function init() : void
      {
         super.init();
         waitingPathFinding = new Dictionary();
      }
      
      override public function update() : void
      {
         var _loc3_:int = 0;
         var _loc2_:PathFinderValidator = null;
         var _loc1_:int = FpsSync.frameNum;
         if(pathFinishFrameMap[_loc1_])
         {
            _loc3_ = 0;
            while(_loc3_ < pathFinishFrameMap[_loc1_].length)
            {
               _loc2_ = (pathFinishFrameMap[_loc1_] as Vector.<PathFinderValidator>)[_loc3_];
               if(!_loc2_.canceled && _loc2_.pathFinder)
               {
                  _loc2_.doFinishJob();
                  queue.completeTask(queue.getTaskByReference(_loc2_.pathFinder));
                  if(queue.isEmpty())
                  {
                     this.disable();
                  }
               }
               _loc3_++;
            }
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         queue.removeAllTasks();
      }
      
      override public function terminate() : void
      {
         queue.removeAllTasks();
         task = null;
      }
   }
}

