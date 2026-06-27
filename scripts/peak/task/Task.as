package peak.task
{
   public class Task
   {
      
      public static var TASK_ID_COUNTER:int = 0;
      
      public var taskId:int;
      
      public function Task()
      {
         var _temp_1:* = Task;
         var _loc1_:int;
         _temp_1.TASK_ID_COUNTER = (_loc1_ = int(_temp_1.TASK_ID_COUNTER)) + 1;
         taskId = _loc1_;
      }
      
      public function run(param1:uint) : Boolean
      {
         return true;
      }
      
      public function cancel() : void
      {
      }
   }
}

