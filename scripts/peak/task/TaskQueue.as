package peak.task
{
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.behavior.task.PathFinderValidator;
   import peak.cuckoo.game.behavior.task.TaskRunner;
   import peak.cuckoo.game.behavior.task.TaskRunnerValidator;
   
   public class TaskQueue
   {
      
      public static var _instance:TaskQueue;
      
      private var queue:Vector.<Task>;
      
      private var taskRunner:TaskRunner;
      
      public function TaskQueue()
      {
         super();
         queue = new Vector.<Task>();
         _instance = this;
      }
      
      public function get currentTask() : Task
      {
         if(queue.length > 0)
         {
            return queue[0];
         }
         return null;
      }
      
      public function addTask(param1:Task) : int
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         taskRunner.enable();
         queue.push(param1);
         return queue.length;
      }
      
      public function completeTask(param1:uint = 0) : void
      {
         queue.splice(param1,1);
      }
      
      public function snoozeCurrentTask() : void
      {
         if(queue.length != 0)
         {
            queue.push(queue.shift());
         }
      }
      
      public function isEmpty() : Boolean
      {
         return queue.length == 0;
      }
      
      public function get length() : uint
      {
         return queue.length;
      }
      
      public function connectToRunner(param1:TaskRunner) : void
      {
         this.taskRunner = param1;
      }
      
      public function removeAllTasks() : void
      {
         queue.length = 0;
         taskRunner.disable();
      }
      
      public function removeTask(param1:Task) : void
      {
         var _loc3_:Boolean = false;
         if(taskRunner.task == param1)
         {
            taskRunner.task = null;
            _loc3_ = true;
         }
         var _loc2_:int = queue.indexOf(param1);
         if(_loc2_ != -1)
         {
            queue.splice(_loc2_,1);
            _loc3_ = true;
         }
         if(_loc3_)
         {
            param1.cancel();
         }
         if(queue.length == 0)
         {
            taskRunner.disable();
         }
      }
      
      public function getTaskByReference(param1:Task) : int
      {
         return queue.indexOf(param1);
      }
   }
}

