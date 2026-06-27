package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.job.UnitTrainJobDTO;
   
   public class TrainUnitJobScheduledEventNotification extends AbstractIncomingMessage
   {
      
      private var _unitTrainJob:UnitTrainJobDTO;
      
      public function TrainUnitJobScheduledEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _unitTrainJob = new UnitTrainJobDTO(param1.activeJob.unitTypeId,param1.activeJob.remainingDuration,param1.activeJob.trainingBuildingInstanceId);
      }
      
      public function get unitTrainJob() : UnitTrainJobDTO
      {
         return _unitTrainJob;
      }
   }
}

