package wom.model.domain.domaininfoobject
{
   public class BuildingSpecificInfoType
   {
      
      public static const UNHARVESTED_RESOURCE:BuildingSpecificInfoType = new BuildingSpecificInfoType(100,"unharvestedResource",false);
      
      public static const EVENT_ITEM_INVENTORY:BuildingSpecificInfoType = new BuildingSpecificInfoType(101,"eventItemQueue",false);
      
      public static const FORTIFICATION_INFO:BuildingSpecificInfoType = new BuildingSpecificInfoType(0,"FortificationInfo",false);
      
      public static const PART_REQUIREMENTS_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(1,"PartRequirementsPerLevel",false);
      
      public static const PRODUCED_RESOURCE:BuildingSpecificInfoType = new BuildingSpecificInfoType(2,"ProducedResource",false);
      
      public static const PRODUCTION_AMOUNTS_PER_HOUR_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(3,"productionAmountsPerHourPerLevel",true);
      
      public static const STORAGE_CAPACITIES_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(4,"storageCapacitiesPerLevel",true);
      
      public static const MERCENARY_CAPACITIES_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(5,"mercenaryCapacitiesPerLevel",true);
      
      public static const STAFF_PREREQUISITES_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(10,"staffPrerequisitesPerLevel",false);
      
      public static const GOLD_COST_PER_STAFF:BuildingSpecificInfoType = new BuildingSpecificInfoType(11,"goldCostPerStaff",false);
      
      public static const GOLD_COST_DISCOUNT_PERCENTAGE:BuildingSpecificInfoType = new BuildingSpecificInfoType(12,"goldCostDiscountPercentage",false);
      
      public static const HIRING_QUEUE_SLOT_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(13,"hiringQueueSlotPerLevel",true);
      
      public static const GOLD_COSTS_PER_PLANNER_SAVE_SLOT:BuildingSpecificInfoType = new BuildingSpecificInfoType(14,"goldCostsPerSlot",false);
      
      public static const RP_COSTS_PER_PLANNER_SAVE_SLOT:BuildingSpecificInfoType = new BuildingSpecificInfoType(15,"rpCostsPerSlot",false);
      
      public static const RANGES_PER_LEVEL_IN_PX:BuildingSpecificInfoType = new BuildingSpecificInfoType(16,"range",true);
      
      public static const DAMAGES_PER_SHOT_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(17,"damagesPerShotPerLevel",true);
      
      public static const ATTACKS_AIR:BuildingSpecificInfoType = new BuildingSpecificInfoType(18,"attacksAir",false);
      
      public static const ATTACKS_GROUND:BuildingSpecificInfoType = new BuildingSpecificInfoType(19,"attacksGround",false);
      
      public static const EXPLOSION_RANGES_PER_LEVEL_IN_PX:BuildingSpecificInfoType = new BuildingSpecificInfoType(20,"explosionRangesPerLevel",true);
      
      public static const SHOTS_FIRED_PER_CHARGE_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(21,"shotsFiredPerChargePerLevel",true);
      
      public static const RELOAD_TIME_IN_SECS:BuildingSpecificInfoType = new BuildingSpecificInfoType(22,"reloadTimeInSecs",false);
      
      public static const SHOTS_PER_SECOND_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(23,"shotsPerSecondPerLevel",true);
      
      public static const DAMAGE:BuildingSpecificInfoType = new BuildingSpecificInfoType(24,"damage",true);
      
      public static const GOLD_PRODUCTION_AMOUNT:BuildingSpecificInfoType = new BuildingSpecificInfoType(25,"goldProductionAmount",false);
      
      public static const GOLD_PRODUCTION_PERIODS_IN_HOURS_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(26,"goldProductionPeriodsInHoursPerLevel",false);
      
      public static const GOLD_CAPACITY:BuildingSpecificInfoType = new BuildingSpecificInfoType(27,"goldCapacity",false);
      
      public static const SMALL_GIFT_AMOUNTS:BuildingSpecificInfoType = new BuildingSpecificInfoType(28,"smallGiftAmounts",false);
      
      public static const LARGE_GIFT_AMOUNTS:BuildingSpecificInfoType = new BuildingSpecificInfoType(29,"largeGiftAmounts",false);
      
      public static const STAFF_TIME_REDUCTION_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(30,"staffTimeReduction",false);
      
      public static const MUSK_CAPACITIES_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(31,"muskCapacitiesPerLevel",true);
      
      public static const MUSK_PRICES_PER_LEVEL:BuildingSpecificInfoType = new BuildingSpecificInfoType(32,"muskPricesPerLevel",true);
      
      public static const HUGE_GIFT_AMOUNTS:BuildingSpecificInfoType = new BuildingSpecificInfoType(33,"hugeGiftAmounts",false);
      
      public static const BEAST_CANNON_MAX_AMMUNITION:BuildingSpecificInfoType = new BuildingSpecificInfoType(34,"beastCannonMaxAmmunition",false);
      
      public static const BEAST_CANNON_RECHARGE_PER_AMMUNITION:BuildingSpecificInfoType = new BuildingSpecificInfoType(35,"beastCannonRechargePerAmmunition",false);
      
      private var _id:int;
      
      private var _name:String;
      
      private var _preview:Boolean;
      
      public function BuildingSpecificInfoType(param1:int, param2:String, param3:Boolean)
      {
         super();
         this._id = param1;
         this._name = param2;
         this._preview = param3;
      }
      
      public static function determineBuildingSpecificInfoType(param1:int) : BuildingSpecificInfoType
      {
         var _loc2_:BuildingSpecificInfoType = null;
         switch(param1)
         {
            case FORTIFICATION_INFO.id:
               _loc2_ = BuildingSpecificInfoType.FORTIFICATION_INFO;
               break;
            case PART_REQUIREMENTS_PER_LEVEL.id:
               _loc2_ = BuildingSpecificInfoType.PART_REQUIREMENTS_PER_LEVEL;
               break;
            case PRODUCED_RESOURCE.id:
               _loc2_ = BuildingSpecificInfoType.PRODUCED_RESOURCE;
               break;
            case PRODUCTION_AMOUNTS_PER_HOUR_PER_LEVEL.id:
               _loc2_ = BuildingSpecificInfoType.PRODUCTION_AMOUNTS_PER_HOUR_PER_LEVEL;
               break;
            case MERCENARY_CAPACITIES_PER_LEVEL.id:
               _loc2_ = BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL;
               break;
            case STORAGE_CAPACITIES_PER_LEVEL.id:
               _loc2_ = BuildingSpecificInfoType.STORAGE_CAPACITIES_PER_LEVEL;
               break;
            case STAFF_PREREQUISITES_PER_LEVEL.id:
               _loc2_ = BuildingSpecificInfoType.STAFF_PREREQUISITES_PER_LEVEL;
               break;
            case GOLD_COST_PER_STAFF.id:
               _loc2_ = BuildingSpecificInfoType.GOLD_COST_PER_STAFF;
               break;
            case GOLD_COST_DISCOUNT_PERCENTAGE.id:
               _loc2_ = BuildingSpecificInfoType.GOLD_COST_DISCOUNT_PERCENTAGE;
               break;
            case GOLD_COSTS_PER_PLANNER_SAVE_SLOT.id:
               _loc2_ = BuildingSpecificInfoType.GOLD_COSTS_PER_PLANNER_SAVE_SLOT;
               break;
            case RP_COSTS_PER_PLANNER_SAVE_SLOT.id:
               _loc2_ = BuildingSpecificInfoType.RP_COSTS_PER_PLANNER_SAVE_SLOT;
               break;
            case HIRING_QUEUE_SLOT_PER_LEVEL.id:
               _loc2_ = BuildingSpecificInfoType.HIRING_QUEUE_SLOT_PER_LEVEL;
               break;
            case RANGES_PER_LEVEL_IN_PX.id:
               _loc2_ = BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX;
               break;
            case DAMAGES_PER_SHOT_PER_LEVEL.id:
               _loc2_ = BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL;
               break;
            case ATTACKS_AIR.id:
               _loc2_ = BuildingSpecificInfoType.ATTACKS_AIR;
               break;
            case ATTACKS_GROUND.id:
               _loc2_ = BuildingSpecificInfoType.ATTACKS_GROUND;
               break;
            case EXPLOSION_RANGES_PER_LEVEL_IN_PX.id:
               _loc2_ = BuildingSpecificInfoType.EXPLOSION_RANGES_PER_LEVEL_IN_PX;
               break;
            case SHOTS_FIRED_PER_CHARGE_PER_LEVEL.id:
               _loc2_ = BuildingSpecificInfoType.SHOTS_FIRED_PER_CHARGE_PER_LEVEL;
               break;
            case RELOAD_TIME_IN_SECS.id:
               _loc2_ = BuildingSpecificInfoType.RELOAD_TIME_IN_SECS;
               break;
            case SHOTS_PER_SECOND_PER_LEVEL.id:
               _loc2_ = BuildingSpecificInfoType.SHOTS_PER_SECOND_PER_LEVEL;
               break;
            case DAMAGE.id:
               _loc2_ = BuildingSpecificInfoType.DAMAGE;
         }
         return _loc2_;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get preview() : Boolean
      {
         return _preview;
      }
   }
}

