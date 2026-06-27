package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.job.BuildingUpgradeJobDTO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingUpgradeJobType;
   
   public class BuildingLevelUpgradeJobFinishedEventNotification extends AbstractIncomingMessage
   {
      
      private var _buildingLevelUpgradeJob:BuildingUpgradeJobDTO;
      
      private var _buildingIncomplete:Boolean;
      
      private var _buildingInfo:BuildingInfo;
      
      public function BuildingLevelUpgradeJobFinishedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _buildingIncomplete = param1.buildingIncomplete;
         _buildingLevelUpgradeJob = new BuildingUpgradeJobDTO(param1.instanceId,param1.targetLevel,param1.durationRemaining,BuildingUpgradeJobType.determineRBuildingUpgradeJobType(param1.type));
         if(param1.buildingView)
         {
            _buildingInfo = BuildingInfo.deserialize(param1.buildingView);
         }
      }
      
      public function get buildingLevelUpgradeJob() : BuildingUpgradeJobDTO
      {
         return _buildingLevelUpgradeJob;
      }
      
      public function get buildingIncomplete() : Boolean
      {
         return _buildingIncomplete;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
   }
}

