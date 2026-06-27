package wom.controller.command.combat
{
   import wom.controller.PCommand;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.combat.RemoveDeployedUnitsEvent;
   import wom.model.dto.DeployUnitCircleInfoDTO;
   import wom.model.game.DeployedUnitsStatusInfo;
   import wom.model.message.request.RemoveDeployedUnitsRequest;
   
   public class RemoveDeployedUnitsCommand extends PCommand
   {
      
      [Inject]
      public var event:RemoveDeployedUnitsEvent;
      
      [Inject]
      public var deployedUnitsStatusInfo:DeployedUnitsStatusInfo;
      
      public function RemoveDeployedUnitsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(event.type == "unitDeployed")
         {
            addDeployedUnit(event.deployUnitCircleInfoDTO);
         }
         else if(event.type == "flushDeployedUnits")
         {
            flushDeployedUnits();
         }
      }
      
      private function addDeployedUnit(param1:DeployUnitCircleInfoDTO) : void
      {
         deployedUnitsStatusInfo.deployedUnits.push(param1);
         if(deployedUnitsStatusInfo.deployedUnits.length >= 50)
         {
            flushDeployedUnits();
         }
      }
      
      private function flushDeployedUnits() : void
      {
         if(deployedUnitsStatusInfo.deployedUnits.length > 0)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new RemoveDeployedUnitsRequest(deployedUnitsStatusInfo.deployedUnits)));
            deployedUnitsStatusInfo.reset();
         }
      }
   }
}

