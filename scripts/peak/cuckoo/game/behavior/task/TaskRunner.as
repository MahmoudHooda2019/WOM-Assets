package peak.cuckoo.game.behavior.task
{
   import flash.utils.getTimer;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.task.Task;
   import peak.task.TaskQueue;
   
   public class TaskRunner extends Behavior
   {
      
      public static const TYPE_ID:String = "TaskRunner";
      
      private static const RUN_FOR:Number = 20;
      
      protected var queue:TaskQueue;
      
      public var task:Task;
      
      private var sync:FpsSync;
      
      public function TaskRunner()
      {
         super();
         priority = 0;
      }
      
      override public function get typeId() : String
      {
         return "TaskRunner";
      }
      
      override public function init() : void
      {
         super.init();
         queue = TaskQueue._instance;
         queue.connectToRunner(this);
         sync = owner.root.sync;
         startEnabled = false;
      }
      
      override public function update() : void
      {
         var _loc2_:int = 0;
         if(task == null)
         {
            _loc2_ = 0;
            task = queue.currentTask;
            if(!task)
            {
               this.disable();
               return;
            }
         }
         var _loc1_:Number = 20;
         do
         {
            _loc2_ += sync.precise;
            if(_loc2_ > 180)
            {
               queue.snoozeCurrentTask();
               _loc2_ = 0;
               task = queue.currentTask;
            }
            if(task.run(_loc1_))
            {
               queue.completeTask();
               _loc2_ = 0;
               task = queue.currentTask;
               if(!task)
               {
                  this.disable();
                  break;
               }
            }
            _loc1_ -= getTimer();
         }
         while(_loc1_ > 0);
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

