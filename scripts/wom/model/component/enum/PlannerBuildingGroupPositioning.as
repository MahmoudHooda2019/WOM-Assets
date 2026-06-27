package wom.model.component.enum
{
   public class PlannerBuildingGroupPositioning extends PlannerConstructableGroupPositioning
   {
      
      public static const STOCK_PILE_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,-117,true,15);
      
      public static const LUMBER_BLADE_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,-97,true,11);
      
      public static const STONE_GRINDER_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,-79,true,12);
      
      public static const IRON_SMELTER_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,-61,true,14);
      
      public static const STATUE_OF_MIGHT_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,-43,true,13);
      
      public static const ARCHERS_TOWER_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,-25,true,31);
      
      public static const BOMBARD_TOWER_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,-7,true,32);
      
      public static const SKY_TOWER_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,11,true,35);
      
      public static const FLAMER_TOWER_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,29,true,33);
      
      public static const BURNING_MIRRORS_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,47,true,36);
      
      public static const GATLING_ARROW_TOWER_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,65,true,34);
      
      public static const BEAST_CANNON_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,81,true,45);
      
      public static const WATCH_POST_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,97,true,37);
      
      public static const FIRE_TRAP_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(-152,115,true,40);
      
      public static const CITY_CENTER_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(152,-117,false,10);
      
      public static const MERCENARY_BARRACKS_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(152,-81,false,19);
      
      public static const HIRING_QUARTERS_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(152,-51,false,20);
      
      public static const RECRUITMENT_CHAMBER_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(152,-27,false,17);
      
      public static const TRAININIG_CHAMBER_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(152,-3,false,18);
      
      public static const CATAPULT_AREA_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(152,21,false,23);
      
      public static const PIGEON_POST_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(152,43,false,28);
      
      public static const WALL_GROUP:PlannerBuildingGroupPositioning = new PlannerBuildingGroupPositioning(152,63,false,41);
      
      private var _groupType:int;
      
      public function PlannerBuildingGroupPositioning(param1:int, param2:int, param3:Boolean, param4:int)
      {
         super(param1,param2,param3);
         _groupType = param4;
      }
      
      public function get groupType() : int
      {
         return _groupType;
      }
   }
}

