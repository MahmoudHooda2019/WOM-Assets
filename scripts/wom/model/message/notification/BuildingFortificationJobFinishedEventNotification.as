package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.job.BuildingUpgradeJobDTO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingUpgradeJobType;
   
   public class BuildingFortificationJobFinishedEventNotification extends AbstractIncomingMessage
   {
      
      private var _buildingFortificationJob:BuildingUpgradeJobDTO;
      
      private var _buildingInfo:BuildingInfo;
      
      public function BuildingFortificationJobFinishedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _buildingFortificationJob = new BuildingUpgradeJobDTO(param1.instanceId,param1.targetLevel,param1.durationRemaining,BuildingUpgradeJobType.determineRBuildingUpgradeJobType(param1.type));
         if(param1.buildingView)
         {
            _buildingInfo = BuildingInfo.deserialize(param1.buildingView);
         }
      }
      
      public function get buildingFortificationJob() : BuildingUpgradeJobDTO
      {
         return _buildingFortificationJob;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
   }
}

