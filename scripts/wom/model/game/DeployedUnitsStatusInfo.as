package wom.model.game
{
   import wom.model.dto.DeployUnitCircleInfoDTO;
   
   public class DeployedUnitsStatusInfo
   {
      
      private var _deployedUnits:Vector.<DeployUnitCircleInfoDTO>;
      
      public function DeployedUnitsStatusInfo()
      {
         super();
         _deployedUnits = new Vector.<DeployUnitCircleInfoDTO>(0);
      }
      
      public function reset() : void
      {
         _deployedUnits.length = 0;
      }
      
      public function get deployedUnits() : Vector.<DeployUnitCircleInfoDTO>
      {
         return _deployedUnits;
      }
   }
}

