package wom.model.component.enum
{
   public class BuildingTypeHolder extends ConstructableTypeHolder
   {
      
      public static const positioningMap:Array = [];
      
      positioningMap[15] = PlannerBuildingGroupPositioning.STOCK_PILE_GROUP;
      positioningMap[11] = PlannerBuildingGroupPositioning.LUMBER_BLADE_GROUP;
      positioningMap[12] = PlannerBuildingGroupPositioning.STONE_GRINDER_GROUP;
      positioningMap[14] = PlannerBuildingGroupPositioning.IRON_SMELTER_GROUP;
      positioningMap[13] = PlannerBuildingGroupPositioning.STATUE_OF_MIGHT_GROUP;
      positioningMap[31] = PlannerBuildingGroupPositioning.ARCHERS_TOWER_GROUP;
      positioningMap[32] = PlannerBuildingGroupPositioning.BOMBARD_TOWER_GROUP;
      positioningMap[35] = PlannerBuildingGroupPositioning.SKY_TOWER_GROUP;
      positioningMap[33] = PlannerBuildingGroupPositioning.FLAMER_TOWER_GROUP;
      positioningMap[36] = PlannerBuildingGroupPositioning.BURNING_MIRRORS_GROUP;
      positioningMap[34] = PlannerBuildingGroupPositioning.GATLING_ARROW_TOWER_GROUP;
      positioningMap[45] = PlannerBuildingGroupPositioning.BEAST_CANNON_GROUP;
      positioningMap[37] = PlannerBuildingGroupPositioning.WATCH_POST_GROUP;
      positioningMap[38] = PlannerBuildingGroupPositioning.WATCH_POST_GROUP;
      positioningMap[40] = PlannerBuildingGroupPositioning.FIRE_TRAP_GROUP;
      positioningMap[39] = PlannerBuildingGroupPositioning.FIRE_TRAP_GROUP;
      positioningMap[10] = PlannerBuildingGroupPositioning.CITY_CENTER_GROUP;
      positioningMap[30] = PlannerBuildingGroupPositioning.CITY_CENTER_GROUP;
      positioningMap[29] = PlannerBuildingGroupPositioning.CITY_CENTER_GROUP;
      positioningMap[19] = PlannerBuildingGroupPositioning.MERCENARY_BARRACKS_GROUP;
      positioningMap[43] = PlannerBuildingGroupPositioning.MERCENARY_BARRACKS_GROUP;
      positioningMap[20] = PlannerBuildingGroupPositioning.HIRING_QUARTERS_GROUP;
      positioningMap[17] = PlannerBuildingGroupPositioning.RECRUITMENT_CHAMBER_GROUP;
      positioningMap[21] = PlannerBuildingGroupPositioning.RECRUITMENT_CHAMBER_GROUP;
      positioningMap[44] = PlannerBuildingGroupPositioning.RECRUITMENT_CHAMBER_GROUP;
      positioningMap[18] = PlannerBuildingGroupPositioning.TRAININIG_CHAMBER_GROUP;
      positioningMap[26] = PlannerBuildingGroupPositioning.TRAININIG_CHAMBER_GROUP;
      positioningMap[27] = PlannerBuildingGroupPositioning.PIGEON_POST_GROUP;
      positioningMap[28] = PlannerBuildingGroupPositioning.PIGEON_POST_GROUP;
      positioningMap[25] = PlannerBuildingGroupPositioning.PIGEON_POST_GROUP;
      positioningMap[23] = PlannerBuildingGroupPositioning.CATAPULT_AREA_GROUP;
      positioningMap[42] = PlannerBuildingGroupPositioning.CATAPULT_AREA_GROUP;
      positioningMap[41] = PlannerBuildingGroupPositioning.WALL_GROUP;
      
      private var _typeId:int;
      
      public function BuildingTypeHolder(param1:int)
      {
         _typeId = param1;
         super();
      }
      
      public function get typeId() : int
      {
         return _typeId;
      }
   }
}

