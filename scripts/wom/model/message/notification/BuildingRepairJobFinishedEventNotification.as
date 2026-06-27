package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.job.BuildingRepairJobDTO;
   
   public class BuildingRepairJobFinishedEventNotification extends AbstractIncomingMessage
   {
      
      private var _buildingRepairJob:BuildingRepairJobDTO;
      
      public function BuildingRepairJobFinishedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _buildingRepairJob = new BuildingRepairJobDTO(param1.instanceId,param1.durationRemaining);
      }
      
      public function get buildingRepairJob() : BuildingRepairJobDTO
      {
         return _buildingRepairJob;
      }
   }
}

