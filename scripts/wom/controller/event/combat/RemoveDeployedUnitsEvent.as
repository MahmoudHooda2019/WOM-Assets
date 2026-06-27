package wom.controller.event.combat
{
   import flash.events.Event;
   import wom.model.dto.DeployUnitCircleInfoDTO;
   
   public class RemoveDeployedUnitsEvent extends Event
   {
      
      public static const UNIT_DEPLOYED:String = "unitDeployed";
      
      public static const FLUSH_DEPLOYED_UNITS:String = "flushDeployedUnits";
      
      private var _deployUnitCircleInfoDTO:DeployUnitCircleInfoDTO;
      
      public function RemoveDeployedUnitsEvent(param1:String, param2:DeployUnitCircleInfoDTO = null)
      {
         super(param1);
         _deployUnitCircleInfoDTO = param2;
      }
      
      public function get deployUnitCircleInfoDTO() : DeployUnitCircleInfoDTO
      {
         return _deployUnitCircleInfoDTO;
      }
   }
}

