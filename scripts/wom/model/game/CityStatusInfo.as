package wom.model.game
{
   import flash.utils.Dictionary;
   import wom.model.dto.BeastCannonInfoDTO;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.DecorationInfo;
   import wom.model.game.helper.RowColumnPair;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.UnitRecruitJob;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.resource.GoldCapacityInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.viral.ViralAction;
   
   public interface CityStatusInfo
   {
      
      function get dimensions() : RowColumnPair;
      
      function get buildings() : Vector.<BuildingInfo>;
      
      function get buildingRepairJobs() : Vector.<BuildingRepairJob>;
      
      function get buildingTypes() : Dictionary;
      
      function get decorations() : Vector.<DecorationInfo>;
      
      function set decorations(param1:Vector.<DecorationInfo>) : void;
      
      function get totalResourceCapacity() : int;
      
      function get resourceAmounts() : Array;
      
      function set dimensions(param1:RowColumnPair) : void;
      
      function set buildings(param1:Vector.<BuildingInfo>) : void;
      
      function set buildingRepairJobs(param1:Vector.<BuildingRepairJob>) : void;
      
      function set buildingTypes(param1:Dictionary) : void;
      
      function set totalResourceCapacity(param1:int) : void;
      
      function set resourceAmounts(param1:Array) : void;
      
      function get buildingUpgradeJobs() : Vector.<BuildingUpgradeJob>;
      
      function set buildingUpgradeJobs(param1:Vector.<BuildingUpgradeJob>) : void;
      
      function get interruptedConstructionJobs() : Dictionary;
      
      function set interruptedConstructionJobs(param1:Dictionary) : void;
      
      function get unitTypes() : Dictionary;
      
      function set unitTypes(param1:Dictionary) : void;
      
      function get activeRecruitJob() : UnitRecruitJob;
      
      function set activeRecruitJob(param1:UnitRecruitJob) : void;
      
      function get unitTrainJobs() : Vector.<UnitTrainJob>;
      
      function set unitTrainJobs(param1:Vector.<UnitTrainJob>) : void;
      
      function get numberOfWorkers() : int;
      
      function set numberOfWorkers(param1:int) : void;
      
      function get numberOfWorkingWorkers() : int;
      
      function set numberOfWorkingWorkers(param1:int) : void;
      
      function get workerStaffStatus() : Vector.<Profile>;
      
      function set workerStaffStatus(param1:Vector.<Profile>) : void;
      
      function get units() : Vector.<UnitInfo>;
      
      function set units(param1:Vector.<UnitInfo>) : void;
      
      function get hiringInfoDictionary() : Dictionary;
      
      function set hiringInfoDictionary(param1:Dictionary) : void;
      
      function get beast() : BeastInfo;
      
      function set beast(param1:BeastInfo) : void;
      
      function get beastLevelBonusTuples() : Dictionary;
      
      function set beastLevelBonusTuples(param1:Dictionary) : void;
      
      function get beastOpenCaveAtNextNotification() : Boolean;
      
      function set beastOpenCaveAtNextNotification(param1:Boolean) : void;
      
      function get goldCapacity() : GoldCapacityInfo;
      
      function set goldCapacity(param1:GoldCapacityInfo) : void;
      
      function get viralActions() : Vector.<ViralAction>;
      
      function set viralActions(param1:Vector.<ViralAction>) : void;
      
      function get maxCityPlanSlots() : int;
      
      function set maxCityPlanSlots(param1:int) : void;
      
      function get cityPlans() : Dictionary;
      
      function set cityPlans(param1:Dictionary) : void;
      
      function set spyEnabled(param1:Boolean) : void;
      
      function get spyEnabled() : Boolean;
      
      function get ownerLevel() : int;
      
      function set ownerLevel(param1:int) : void;
      
      function get ownerBattlePoints() : int;
      
      function set ownerBattlePoints(param1:int) : void;
      
      function get version() : int;
      
      function set version(param1:int) : void;
      
      function get ownerAlliance() : AllianceSummaryInfo;
      
      function set ownerAlliance(param1:AllianceSummaryInfo) : void;
      
      function get beastCannonInfo() : BeastCannonInfoDTO;
      
      function set beastCannonInfo(param1:BeastCannonInfoDTO) : void;
      
      function get hiringSessionResourceAmounts() : Array;
      
      function set hiringSessionResourceAmounts(param1:Array) : void;
   }
}

