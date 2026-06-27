package wom.model.component.factory
{
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Decoration;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.model.game.building.DecorationInfo;
   import wom.model.game.building.DecorationVariationInfo;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   
   public interface ConstructableFactory
   {
      
      function createBuilding(param1:BuildingInfo, param2:BuildingTypeDIO, param3:BuildingTypeInfo, param4:BuildingUpgradeJob, param5:BuildingRepairJob) : Building;
      
      function createBuildingSilhouette(param1:BuildingTypeDIO, param2:BuildingTypeInfo) : Building;
      
      function createDecoration(param1:DecorationInfo, param2:DecorationTypeDIO) : Decoration;
      
      function createDecorationSilhouette(param1:DecorationVariationInfo, param2:Boolean = false) : Decoration;
   }
}

