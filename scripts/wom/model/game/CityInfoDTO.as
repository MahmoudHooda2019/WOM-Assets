package wom.model.game
{
   import flash.utils.Dictionary;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.dto.BeastCannonInfoDTO;
   import wom.model.dto.CityPlanInfoDTO;
   import wom.model.dto.HiringInfoDTO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.dto.job.BuildingRepairJobDTO;
   import wom.model.dto.job.BuildingUpgradeJobDTO;
   import wom.model.dto.job.UnitHireJobDTO;
   import wom.model.dto.job.UnitRecruitJobDTO;
   import wom.model.dto.job.UnitTrainJobDTO;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.beast.FrozenBeastInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.DecorationInfo;
   import wom.model.game.helper.RowColumnPair;
   import wom.model.game.hiring.HiringPauseReasonType;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.model.game.store.ItemEffectInfo;
   import wom.model.game.store.ItemEffectType;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.message.util.AllianceDeserializeUtil;
   
   public class CityInfoDTO
   {
      
      private static const DECORATION_TYPE:String = "de";
      
      private var _dimensions:RowColumnPair;
      
      private var _buildings:Vector.<BuildingInfo>;
      
      private var _constructionJobs:Vector.<BuildingUpgradeJobDTO>;
      
      private var _repairBuildingJobs:Vector.<BuildingRepairJobDTO>;
      
      private var _totalResourceCapacity:int;
      
      private var _resourceAmounts:Array;
      
      private var _numberOfWorkers:int;
      
      private var _activeRecruitmentJob:UnitRecruitJobDTO;
      
      private var _unitTrainJobs:Vector.<UnitTrainJobDTO>;
      
      private var _unitLevels:Dictionary;
      
      private var _recruitedUnits:Vector.<int>;
      
      private var _unitAmounts:Dictionary;
      
      private var _allianceUnitAmounts:Dictionary;
      
      private var _deployedUnits:Dictionary;
      
      private var _friendWatchPostDeployedUnits:Vector.<UnitTypeAmountDTO>;
      
      private var _hiringInfos:Vector.<HiringInfoDTO>;
      
      private var _beastView:BeastInfo = null;
      
      private var _beastJobSchedulerView:Object = null;
      
      private var _beastLevelBonusTuples:Dictionary;
      
      private var _interruptedConstructionJobs:Dictionary;
      
      private var _cityPlans:Dictionary;
      
      private var _maxCityPlanSlots:int;
      
      private var _ownerLevel:int;
      
      private var _ownerBattlePoints:int;
      
      private var _ownerAlliance:AllianceSummaryInfo;
      
      private var _decorations:Vector.<DecorationInfo>;
      
      private var _workerStaffInfo:Vector.<Profile>;
      
      private var _combatItemEffects:Vector.<ItemEffectInfo>;
      
      private var _beastCannonInfo:BeastCannonInfoDTO;
      
      public function CityInfoDTO()
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
      
      public function get constructionJobs() : Vector.<BuildingUpgradeJobDTO>
      {
         return _constructionJobs;
      }
      
      public function get interruptedConstructionJobs() : Dictionary
      {
         return _interruptedConstructionJobs;
      }
      
      public function get repairBuildingJobs() : Vector.<BuildingRepairJobDTO>
      {
         return _repairBuildingJobs;
      }
      
      public function get totalResourceCapacity() : int
      {
         return _totalResourceCapacity;
      }
      
      public function get resourceAmounts() : Array
      {
         return _resourceAmounts;
      }
      
      public function get numberOfWorkers() : int
      {
         return _numberOfWorkers;
      }
      
      public function get activeRecruitmentJob() : UnitRecruitJobDTO
      {
         return _activeRecruitmentJob;
      }
      
      public function get unitTrainJobs() : Vector.<UnitTrainJobDTO>
      {
         return _unitTrainJobs;
      }
      
      public function get unitLevels() : Dictionary
      {
         return _unitLevels;
      }
      
      public function get recruitedUnits() : Vector.<int>
      {
         return _recruitedUnits;
      }
      
      public function get unitAmounts() : Dictionary
      {
         return _unitAmounts;
      }
      
      public function get allianceUnitAmounts() : Dictionary
      {
         return _allianceUnitAmounts;
      }
      
      public function get deployedUnits() : Dictionary
      {
         return _deployedUnits;
      }
      
      public function get hiringInfos() : Vector.<HiringInfoDTO>
      {
         return _hiringInfos;
      }
      
      public function get beastView() : BeastInfo
      {
         return _beastView;
      }
      
      public function get beastJobSchedulerView() : Object
      {
         return _beastJobSchedulerView;
      }
      
      public function get beastLevelBonusTuples() : Dictionary
      {
         return _beastLevelBonusTuples;
      }
      
      public function get cityPlans() : Dictionary
      {
         return _cityPlans;
      }
      
      public function get maxCityPlanSlots() : int
      {
         return _maxCityPlanSlots;
      }
      
      public function get friendWatchPostDeployedUnits() : Vector.<UnitTypeAmountDTO>
      {
         return _friendWatchPostDeployedUnits;
      }
      
      public function get beastCannonInfo() : BeastCannonInfoDTO
      {
         return _beastCannonInfo;
      }
      
      public function deserialize(param1:Object) : void
      {
         var _loc15_:BuildingInfo = null;
         var _loc5_:int = 0;
         var _loc12_:int = 0;
         var _loc6_:String = null;
         var _loc3_:* = undefined;
         var _loc7_:HiringQueueInfo = null;
         var _loc14_:UnitHireJobDTO = null;
         var _loc25_:ItemEffectType = null;
         var _loc11_:Object = param1.cityStatus;
         _ownerLevel = 0;
         if("ownerLevel" in _loc11_)
         {
            _ownerLevel = _loc11_.ownerLevel;
         }
         _ownerBattlePoints = 0;
         if("ownerBattlePoints" in _loc11_)
         {
            _ownerBattlePoints = _loc11_.ownerBattlePoints;
         }
         _ownerAlliance = AllianceDeserializeUtil.deserializeAllianceSummary(_loc11_.alliance);
         _numberOfWorkers = _loc11_.numberOfWorkers;
         _dimensions = new RowColumnPair(_loc11_.dimensions.numberOfRows,_loc11_.dimensions.numberOfColumns);
         _constructionJobs = new Vector.<BuildingUpgradeJobDTO>();
         for each(var _loc16_ in _loc11_.constructionJobs)
         {
            _constructionJobs.push(new BuildingUpgradeJobDTO(_loc16_.instanceId,_loc16_.targetLevel,_loc16_.durationRemaining,BuildingUpgradeJobType.determineRBuildingUpgradeJobType(_loc16_.type)));
         }
         _interruptedConstructionJobs = new Dictionary();
         for each(var _loc9_ in _loc11_.interruptedConstructionJobs)
         {
            _interruptedConstructionJobs[_loc9_.instanceId] = true;
         }
         _repairBuildingJobs = new Vector.<BuildingRepairJobDTO>();
         for each(var _loc20_ in _loc11_.repairBuildingJobs)
         {
            _repairBuildingJobs.push(new BuildingRepairJobDTO(_loc20_.instanceId,_loc20_.remainingDuration));
         }
         _totalResourceCapacity = _loc11_.totalResourceCapacity;
         var _loc21_:int = -1;
         _buildings = new Vector.<BuildingInfo>();
         _decorations = new Vector.<DecorationInfo>();
         for each(var _loc22_ in _loc11_.buildings)
         {
            if(_loc22_.t == "de")
            {
               _decorations.push(DecorationInfo.deserialize(_loc22_));
            }
            else
            {
               _loc15_ = BuildingInfo.deserialize(_loc22_);
               if(_loc15_.buildingTypeId == 29)
               {
                  _loc21_ = _loc15_.instanceId;
               }
               if(_loc11_.stocksByInstanceId && _loc15_.instanceId in _loc11_.stocksByInstanceId)
               {
                  _loc15_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] = _loc11_.stocksByInstanceId[_loc15_.instanceId];
               }
               _buildings.push(_loc15_);
            }
         }
         _unitAmounts = new Dictionary();
         for(var _loc26_ in _loc11_.unitAmounts)
         {
            _unitAmounts[_loc26_] = _loc11_.unitAmounts[_loc26_];
         }
         _allianceUnitAmounts = new Dictionary();
         for(_loc26_ in _loc11_.allianceUnitAmounts)
         {
            _allianceUnitAmounts[_loc26_] = _loc11_.allianceUnitAmounts[_loc26_];
         }
         _deployedUnits = new Dictionary();
         for(var _loc23_ in _loc11_.deployedUnits)
         {
            _deployedUnits[_loc23_] = new Vector.<UnitTypeAmountDTO>();
            for each(var _loc4_ in _loc11_.deployedUnits[_loc23_])
            {
               _deployedUnits[_loc23_].push(new UnitTypeAmountDTO(_loc4_.id,_loc4_.amount));
            }
         }
         _friendWatchPostDeployedUnits = new Vector.<UnitTypeAmountDTO>();
         for each(_loc4_ in _loc11_.friendWatchPostDeployedUnits)
         {
            _friendWatchPostDeployedUnits.push(new UnitTypeAmountDTO(_loc4_.id,_loc4_.amount));
         }
         _resourceAmounts = [];
         if(_loc11_.resourceAmounts)
         {
            _loc5_ = 1;
            while(_loc5_ < 5)
            {
               _loc12_ = 0;
               if(_loc11_.resourceAmounts[_loc5_])
               {
                  _loc12_ = int(_loc11_.resourceAmounts[_loc5_]);
               }
               _resourceAmounts[_loc5_] = _loc12_;
               _loc5_++;
            }
         }
         _unitLevels = new Dictionary();
         for(_loc6_ in _loc11_.unitLevels)
         {
            _unitLevels[_loc6_] = _loc11_.unitLevels[_loc6_];
         }
         _recruitedUnits = new Vector.<int>();
         for each(var _loc2_ in _loc11_.recruitedUnits)
         {
            _recruitedUnits.push(_loc2_);
         }
         if(_loc11_.activeRecruitmentJob)
         {
            _activeRecruitmentJob = new UnitRecruitJobDTO(_loc11_.activeRecruitmentJob.unitTypeId,_loc11_.activeRecruitmentJob.remainingDuration);
         }
         _unitTrainJobs = new Vector.<UnitTrainJobDTO>();
         for each(var _loc24_ in _loc11_.activeTrainJobs)
         {
            _unitTrainJobs.push(new UnitTrainJobDTO(_loc24_.unitTypeId,_loc24_.remainingDuration,_loc24_.trainingBuildingInstanceId));
         }
         _hiringInfos = new Vector.<HiringInfoDTO>();
         if("hiringInfo" in _loc11_ && _loc11_.hiringInfo != null)
         {
            for each(var _loc18_ in _loc11_.hiringInfo)
            {
               if(_loc18_ != null)
               {
                  _loc3_ = new Vector.<HiringSlotView>();
                  for each(var _loc13_ in _loc18_.hiringQueue.hiringSlots)
                  {
                     _loc3_.push(new HiringSlotView(_loc13_.slotIndex,_loc13_.unitId,_loc13_.numberOfUnits));
                  }
                  _loc7_ = new HiringQueueInfo(_loc18_.hiringQueue.maxNumberOfHiringSlots,_loc3_);
                  _loc14_ = null;
                  if(_loc18_.activeHiring)
                  {
                     _loc14_ = new UnitHireJobDTO(_loc18_.activeHiring.unitTypeId,_loc18_.activeHiring.executionTime,_loc18_.activeHiring.remainingDuration,_loc18_.hiringBuildingInstanceId);
                  }
                  _hiringInfos.push(new HiringInfoDTO(_loc18_.hiringBuildingInstanceId,_loc7_,_loc14_,_loc18_.hiringPaused,HiringPauseReasonType.determineHiringPauseReasonType(_loc18_.pauseReason),_loc18_.lastHiredUnitId));
               }
            }
         }
         if(_loc11_.beastView)
         {
            if(_loc11_.beastView.beastJobSchedulerView)
            {
               _beastJobSchedulerView = _loc11_.beastView.beastJobSchedulerView;
            }
            _beastView = new BeastInfo(DefaultUnitFactory.generateUnitId(),UnitStatusType.IN_CAVE,_loc21_,_loc11_.beastView.id,_loc11_.beastView.currentHealthPoints,_loc11_.beastView.numberOfTrainingsLeftToNextLevel,_loc11_.beastView.level,_loc11_.beastView.starved,_loc11_.beastView.bonusStage);
         }
         _beastLevelBonusTuples = new Dictionary();
         if(_loc11_.beastLevelBonusTuples)
         {
            for(_loc6_ in _loc11_.beastLevelBonusTuples)
            {
               _beastLevelBonusTuples[_loc6_] = new FrozenBeastInfo(DefaultUnitFactory.generateUnitId(),_loc11_.beastLevelBonusTuples[_loc6_]["level"],_loc11_.beastLevelBonusTuples[_loc6_]["bonusStage"]);
            }
         }
         _maxCityPlanSlots = _loc11_.maxCityPlanSlots;
         _cityPlans = new Dictionary();
         for each(var _loc19_ in _loc11_.cityPlans)
         {
            _cityPlans[_loc19_.slot] = new CityPlanInfoDTO(_loc19_.slot,_loc19_.name);
         }
         _workerStaffInfo = new Vector.<Profile>();
         if("workerStaff" in _loc11_)
         {
            for each(var _loc8_ in _loc11_.workerStaff)
            {
               _workerStaffInfo.push(new Profile(_loc8_.gid,_loc8_.pid,_loc8_.a));
            }
         }
         var _loc17_:Object = param1.combatItems;
         _combatItemEffects = new Vector.<ItemEffectInfo>();
         for each(var _loc10_ in _loc17_)
         {
            _loc25_ = ItemEffectType.determineItemEffectType(_loc10_.itemEffectType);
            _combatItemEffects.push(new ItemEffectInfo(_loc25_,_loc10_.bonusPercent,_loc10_.dateStartedUsing,_loc10_.dateEndOfUsage,_loc10_.remainingDuration));
         }
         _beastCannonInfo = new BeastCannonInfoDTO(0,0);
         if("beastCannonAmmo" in _loc11_)
         {
            _beastCannonInfo.ammoAmount = _loc11_.beastCannonAmmo;
         }
         if("rdfbc" in _loc11_)
         {
            _beastCannonInfo.remainingTimeToRecharge = _loc11_.rdfbc;
         }
      }
      
      public function get combatItemEffects() : Vector.<ItemEffectInfo>
      {
         return _combatItemEffects;
      }
      
      public function get ownerLevel() : int
      {
         return _ownerLevel;
      }
      
      public function get ownerBattlePoints() : int
      {
         return _ownerBattlePoints;
      }
      
      public function get ownerAlliance() : AllianceSummaryInfo
      {
         return _ownerAlliance;
      }
      
      public function get decorations() : Vector.<DecorationInfo>
      {
         return _decorations;
      }
      
      public function get workerStaffInfo() : Vector.<Profile>
      {
         return _workerStaffInfo;
      }
   }
}

