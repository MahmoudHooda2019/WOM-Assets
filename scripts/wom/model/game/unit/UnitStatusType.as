package wom.model.game.unit
{
   public class UnitStatusType
   {
      
      public static const UNKNOWN:UnitStatusType = new UnitStatusType(0,"Unknown");
      
      public static const IN_BARRACKS:UnitStatusType = new UnitStatusType(11,"InBarracks");
      
      public static const IN_WATCH_POST:UnitStatusType = new UnitStatusType(12,"InWatchPost");
      
      public static const IN_CAVE:UnitStatusType = new UnitStatusType(13,"InCave");
      
      public static const IN_KEEPER:UnitStatusType = new UnitStatusType(14,"InKeeper");
      
      public static const IN_CAGE:UnitStatusType = new UnitStatusType(15,"InCage");
      
      public static const IN_ALLIANCE_BARRACKS:UnitStatusType = new UnitStatusType(16,"InAllianceBarracks");
      
      public static const DEFENDING:UnitStatusType = new UnitStatusType(21,"Defending");
      
      public static const WAITING_TO_DEPLOY:UnitStatusType = new UnitStatusType(22,"WaitingToDeploy");
      
      public static const DEPLOYING:UnitStatusType = new UnitStatusType(23,"Deploying");
      
      public static const ATTACKING:UnitStatusType = new UnitStatusType(24,"Attacking");
      
      public static const RETREATED:UnitStatusType = new UnitStatusType(25,"Retreated");
      
      public static const DEAD:UnitStatusType = new UnitStatusType(50,"Dead");
      
      private var _id:int;
      
      private var _name:String;
      
      public function UnitStatusType(param1:int, param2:String)
      {
         super();
         this._id = param1;
         this._name = param2;
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

