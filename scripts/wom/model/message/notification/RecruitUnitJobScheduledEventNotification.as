package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.job.UnitRecruitJobDTO;
   
   public class RecruitUnitJobScheduledEventNotification extends AbstractIncomingMessage
   {
      
      private var _unitRecruitJob:UnitRecruitJobDTO;
      
      public function RecruitUnitJobScheduledEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _unitRecruitJob = new UnitRecruitJobDTO(param1.activeJob.unitTypeId,param1.activeJob.remainingDuration);
      }
      
      public function get unitRecruitJob() : UnitRecruitJobDTO
      {
         return _unitRecruitJob;
      }
   }
}

