package wom.model.component.attribute.viewManager
{
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.entity.gamesprite.PlannerBuilding;
   
   public class PlannerBuildingViewManager extends PlannerConstructableViewManager
   {
      
      public function PlannerBuildingViewManager(param1:PlannerBuilding, param2:BuildingData)
      {
         this.ownerBuildingRootData = param2;
         this.constructableTypeDIO = param2.buildingTypeDIO;
         var _loc3_:Boolean = param2.buildingInfo.buildingTypeId != 41 && !param2.buildingInfo.isTrap;
         super(param1,_loc3_,param2);
      }
   }
}

