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
   
   public class DefaultCityStatusInfo implements CityStatusInfo
   {
      
      private var _dimensions:RowColumnPair;
      
      private var _buildings:Vector.<BuildingInfo>;
      
      private var _buildingRepairJobs:Vector.<BuildingRepairJob>;
      
      private var _interruptedConstructionJobs:Dictionary;
      
      private var _buildingTypes:Dictionary;
      
      private var _totalResourceCapacity:int;
      
      private var _resourceAmounts:Array;
      
      private var _numberOfWorkers:int;
      
      private var _numberOfWorkingWorkers:int;
      
      private var _workerStaffStatus:Vector.<Profile>;
      
      private var _unitTypes:Dictionary;
      
      private var _units:Vector.<UnitInfo>;
      
      private var _buildingUpgradeJobs:Vector.<BuildingUpgradeJob>;
      
      private var _activeRecruitJob:UnitRecruitJob;
      
      private var _unitTrainJobs:Vector.<UnitTrainJob>;
      
      private var _hiringInfoDictionary:Dictionary;
      
      private var _beast:BeastInfo;
      
      private var _beastLevelBonusTuples:Dictionary;
      
      private var _beastOpenCaveAtNextNotification:Boolean = false;
      
      private var _goldCapacity:GoldCapacityInfo;
      
      private var _viralActions:Vector.<ViralAction>;
      
      private var _cityPlans:Dictionary;
      
      private var _maxCityPlanSlots:int;
      
      private var _spyEnabled:Boolean;
      
      private var _ownerLevel:int;
      
      private var _ownerBattlePoints:int;
      
      private var _version:int;
      
      private var _ownerAlliance:AllianceSummaryInfo;
      
      private var _decorations:Vector.<DecorationInfo>;
      
      private var _repairedOffline:Boolean;
      
      private var _beastCannonInfo:BeastCannonInfoDTO;
      
      private var _hiringSessionResourceAmounts:Array;
      
      public function DefaultCityStatusInfo()
      {
         super();
      }
      
      public function get dimensions() : RowColumnPair
      {
         return _dimensions;
      }
      
      public function get buildings() : Vector.<BuildingInfo>
      {
         return _buildings;
      }
      
      public function get buildingRepairJobs() : Vector.<BuildingRepairJob>
      {
         return _buildingRepairJobs;
      }
      
      public function get buildingTypes() : Dictionary
      {
         return _buildingTypes;
      }
      
      public function get decorations() : Vector.<DecorationInfo>
      {
         return _decorations;
      }
      
      public function set decorations(param1:Vector.<DecorationInfo>) : void
      {
         _decorations = param1;
      }
      
      public function get totalResourceCapacity() : int
      {
         return _totalResourceCapacity;
      }
      
      public function get resourceAmounts() : Array
      {
         return _resourceAmounts;
      }
      
      public function set dimensions(param1:RowColumnPair) : void
      {
         _dimensions = param1;
      }
      
      public function set buildings(param1:Vector.<BuildingInfo>) : void
      {
         _buildings = param1;
      }
      
      public function set buildingRepairJobs(param1:Vector.<BuildingRepairJob>) : void
      {
         _buildingRepairJobs = param1;
      }
      
      public function set buildingTypes(param1:Dictionary) : void
      {
         _buildingTypes = param1;
      }
      
      public function get interruptedConstructionJobs() : Dictionary
      {
         return _interruptedConstructionJobs;
      }
      
      public function set interruptedConstructionJobs(param1:Dictionary) : void
      {
         _interruptedConstructionJobs = param1;
      }
      
      public function get buildingUpgradeJobs() : Vector.<BuildingUpgradeJob>
      {
         return _buildingUpgradeJobs;
      }
      
      public function set buildingUpgradeJobs(param1:Vector.<BuildingUpgradeJob>) : void
      {
         _buildingUpgradeJobs = param1;
      }
      
      public function set totalResourceCapacity(param1:int) : void
      {
         _totalResourceCapacity = param1;
      }
      
      public function set resourceAmounts(param1:Array) : void
      {
         _resourceAmounts = param1;
      }
      
      public function get unitTypes() : Dictionary
      {
         return _unitTypes;
      }
      
      public function set unitTypes(param1:Dictionary) : void
      {
         _unitTypes = param1;
      }
      
      public function get activeRecruitJob() : UnitRecruitJob
      {
         return _activeRecruitJob;
      }
      
      public function set activeRecruitJob(param1:UnitRecruitJob) : void
      {
         _activeRecruitJob = param1;
      }
      
      public function get unitTrainJobs() : Vector.<UnitTrainJob>
      {
         return _unitTrainJobs;
      }
      
      public function set unitTrainJobs(param1:Vector.<UnitTrainJob>) : void
      {
         _unitTrainJobs = param1;
      }
      
      public function get numberOfWorkers() : int
      {
         return _numberOfWorkers;
      }
      
      public function set numberOfWorkers(param1:int) : void
      {
         _numberOfWorkers = param1;
      }
      
      public function get numberOfWorkingWorkers() : int
      {
         return _numberOfWorkingWorkers;
      }
      
      public function set numberOfWorkingWorkers(param1:int) : void
      {
         _numberOfWorkingWorkers = param1;
      }
      
      public function get workerStaffStatus() : Vector.<Profile>
      {
         return _workerStaffStatus;
      }
      
      public function set workerStaffStatus(param1:Vector.<Profile>) : void
      {
         _workerStaffStatus = param1;
      }
      
      public function get units() : Vector.<UnitInfo>
      {
         return _units;
      }
      
      public function set units(param1:Vector.<UnitInfo>) : void
      {
         _units = param1;
      }
      
      public function get hiringInfoDictionary() : Dictionary
      {
         return _hiringInfoDictionary;
      }
      
      public function set hiringInfoDictionary(param1:Dictionary) : void
      {
         _hiringInfoDictionary = param1;
      }
      
      public function get beast() : BeastInfo
      {
         return _beast;
      }
      
      public function set beast(param1:BeastInfo) : void
      {
         _beast = param1;
      }
      
      public function get beastLevelBonusTuples() : Dictionary
      {
         return _beastLevelBonusTuples;
      }
      
      public function set beastLevelBonusTuples(param1:Dictionary) : void
      {
         _beastLevelBonusTuples = param1;
      }
      
      public function get beastOpenCaveAtNextNotification() : Boolean
      {
         return _beastOpenCaveAtNextNotification;
      }
      
      public function set beastOpenCaveAtNextNotification(param1:Boolean) : void
      {
         _beastOpenCaveAtNextNotification = param1;
      }
      
      public function get goldCapacity() : GoldCapacityInfo
      {
         return _goldCapacity;
      }
      
      public function set goldCapacity(param1:GoldCapacityInfo) : void
      {
         _goldCapacity = param1;
      }
      
      public function get viralActions() : Vector.<ViralAction>
      {
         return _viralActions;
      }
      
      public function set viralActions(param1:Vector.<ViralAction>) : void
      {
         _viralActions = param1;
      }
      
      public function get cityPlans() : Dictionary
      {
         return _cityPlans;
      }
      
      public function set cityPlans(param1:Dictionary) : void
      {
         _cityPlans = param1;
      }
      
      public function get maxCityPlanSlots() : int
      {
         return _maxCityPlanSlots;
      }
      
      public function set maxCityPlanSlots(param1:int) : void
      {
         _maxCityPlanSlots = param1;
      }
      
      public function set spyEnabled(param1:Boolean) : void
      {
         _spyEnabled = param1;
      }
      
      public function get spyEnabled() : Boolean
      {
         return _spyEnabled;
      }
      
      public function get ownerLevel() : int
      {
         return _ownerLevel;
      }
      
      public function set ownerLevel(param1:int) : void
      {
         _ownerLevel = param1;
      }
      
      public function get version() : int
      {
         return _version;
      }
      
      public function set version(param1:int) : void
      {
         _version = param1;
      }
      
      public function get ownerBattlePoints() : int
      {
         return _ownerBattlePoints;
      }
      
      public function set ownerBattlePoints(param1:int) : void
      {
         _ownerBattlePoints = param1;
      }
      
      public function get ownerAlliance() : AllianceSummaryInfo
      {
         return _ownerAlliance;
      }
      
      public function set ownerAlliance(param1:AllianceSummaryInfo) : void
      {
         _ownerAlliance = param1;
      }
      
      public function get beastCannonInfo() : BeastCannonInfoDTO
      {
         return _beastCannonInfo;
      }
      
      public function set beastCannonInfo(param1:BeastCannonInfoDTO) : void
      {
         _beastCannonInfo = param1;
      }
      
      public function get hiringSessionResourceAmounts() : Array
      {
         return _hiringSessionResourceAmounts;
      }
      
      public function set hiringSessionResourceAmounts(param1:Array) : void
      {
         _hiringSessionResourceAmounts = param1;
      }
   }
}

