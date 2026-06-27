package wom.model.game.beast
{
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.game.job.BeastPreTrainingJob;
   import wom.model.game.job.BeastWaitTrainingJob;
   
   public class BeastJobScheduler
   {
      
      private var _preTrainingJob:BeastPreTrainingJob;
      
      private var _waitTrainingJob:BeastWaitTrainingJob;
      
      public function BeastJobScheduler(param1:BeastPreTrainingJob, param2:BeastWaitTrainingJob)
      {
         super();
         _preTrainingJob = param1;
         _waitTrainingJob = param2;
      }
      
      public static function createBeastJobScheduler(param1:Object, param2:BeastTypeDIO, param3:int) : BeastJobScheduler
      {
         var _loc4_:Number = NaN;
         var _loc5_:BeastPreTrainingJob = null;
         var _loc6_:BeastWaitTrainingJob = null;
         if(param1)
         {
            if(param1.preTrainingJob && param1.preTrainingJob != null && param1.preTrainingJob.remainingDuration > 0)
            {
               _loc4_ = param2.preTrainingDurationInSecs * 1000 / param3 << 0;
               _loc5_ = new BeastPreTrainingJob(param1.preTrainingJob.remainingDuration,param1.preTrainingJob.executionTime,_loc4_);
            }
            if(param1.waitTrainingJob && param1.waitTrainingJob != null && param1.waitTrainingJob.remainingDuration > 0)
            {
               _loc4_ = param2.waitTrainingDurationInSecs * 1000 / param3 << 0;
               _loc6_ = new BeastWaitTrainingJob(param1.waitTrainingJob.remainingDuration,param1.waitTrainingJob.executionTime,_loc4_);
            }
         }
         return new BeastJobScheduler(_loc5_,_loc6_);
      }
      
      public function get preTrainingJob() : BeastPreTrainingJob
      {
         return _preTrainingJob;
      }
      
      public function get waitTrainingJob() : BeastWaitTrainingJob
      {
         return _waitTrainingJob;
      }
   }
}

