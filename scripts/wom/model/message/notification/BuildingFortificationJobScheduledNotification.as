package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.job.BuildingUpgradeJobDTO;
   import wom.model.game.job.BuildingUpgradeJobType;
   
   public class BuildingFortificationJobScheduledNotification extends AbstractIncomingMessage
   {
      
      private var _buildingFortificationJob:BuildingUpgradeJobDTO;
      
      public function BuildingFortificationJobScheduledNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _buildingFortificationJob = new BuildingUpgradeJobDTO(param1.instanceId,param1.targetLevel,param1.durationRemaining,BuildingUpgradeJobType.determineRBuildingUpgradeJobType(param1.type));
      }
      
      public function get buildingFortificationJob() : BuildingUpgradeJobDTO
      {
         return _buildingFortificationJob;
      }
   }
}

