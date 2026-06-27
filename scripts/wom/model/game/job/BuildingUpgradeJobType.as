package wom.model.game.job
{
   public class BuildingUpgradeJobType
   {
      
      public static const INVALID_JOB:BuildingUpgradeJobType = new BuildingUpgradeJobType(0,"Invalid Job");
      
      public static const UPGRADE:BuildingUpgradeJobType = new BuildingUpgradeJobType(1,"Upgrade");
      
      public static const FORTIFY:BuildingUpgradeJobType = new BuildingUpgradeJobType(2,"Fortify");
      
      public static const buildingUpgradeJobTypes:Array = [INVALID_JOB,UPGRADE,FORTIFY];
      
      private var _id:int;
      
      private var _name:String;
      
      public function BuildingUpgradeJobType(param1:int, param2:String)
      {
         super();
         this._id = param1;
         this._name = param2;
      }
      
      public static function determineRBuildingUpgradeJobType(param1:int) : BuildingUpgradeJobType
      {
         var _loc2_:BuildingUpgradeJobType = BuildingUpgradeJobType.INVALID_JOB;
         switch(param1)
         {
            case INVALID_JOB.id:
               _loc2_ = BuildingUpgradeJobType.INVALID_JOB;
               break;
            case UPGRADE.id:
               _loc2_ = BuildingUpgradeJobType.UPGRADE;
               break;
            case FORTIFY.id:
               _loc2_ = BuildingUpgradeJobType.FORTIFY;
               break;
            default:
               _loc2_ = BuildingUpgradeJobType.INVALID_JOB;
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
   }
}

