package wom.model.component.attribute.data
{
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   
   public class PlannerBuildingData extends PlannerConstructableData
   {
      
      public var buildingData:BuildingData;
      
      public var building:Building;
      
      public function PlannerBuildingData(param1:Building)
      {
         this.building = param1;
         buildingData = param1.data;
         var _loc2_:int = 0;
         if(buildingData.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id])
         {
            _loc2_ = buildingData.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id][buildingData.buildingInfo.level > 0 ? buildingData.buildingInfo.level - 1 : 0] / 5;
         }
         super(buildingData.buildingTypeDIO.baseSize,buildingData.buildingInfo.level,_loc2_);
      }
   }
}

