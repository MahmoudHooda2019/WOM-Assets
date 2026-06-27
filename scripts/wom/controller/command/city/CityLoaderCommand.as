package wom.controller.command.city
{
   import flash.utils.Dictionary;
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.GenerateBuildingTypeInfosEvent;
   import wom.controller.event.model.GenerateUnitTypeInfosEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.CatapultTypeDIO;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.FortificationInfoDIO;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.HiringInfoDTO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.dto.job.BuildingRepairJobDTO;
   import wom.model.dto.job.BuildingUpgradeJobDTO;
   import wom.model.dto.job.UnitTrainJobDTO;
   import wom.model.game.CityInfoDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomScreenType;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.beast.BeastJobScheduler;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.event.EventItemType;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.game.inventory.PartSellPriceCalculationUtil;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.model.game.job.UnitHireJob;
   import wom.model.game.job.UnitRecruitJob;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.game.viral.ViralAction;
   
   public class CityLoaderCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function CityLoaderCommand()
      {
         super();
      }
      
      protected function loadCity(param1:CityInfoDTO, param2:Number = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1) : void
      {
         var _loc19_:BuildingTypeDIO = null;
         var _loc13_:int = 0;
         var _loc7_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc35_:int = 0;
         var _loc11_:Boolean = false;
         var _loc8_:UnitTypeDIO = null;
         var _loc25_:UnitTypeInfo = null;
         var _loc16_:* = 0;
         var _loc30_:int = 0;
         var _loc26_:int = 0;
         var _loc34_:Number = NaN;
         var _loc29_:Dictionary = null;
         var _loc20_:Dictionary = new Dictionary();
         city.buildings = param1.buildings;
         city.decorations = param1.decorations;
         var _loc24_:Number = userInfo.serverSpeed;
         var _loc23_:int = -1;
         for each(var _loc22_ in city.buildings)
         {
            if(_loc22_.buildingTypeId == 19 && _loc22_.level > 0)
            {
               _loc20_[_loc22_.instanceId] = int(domainInfo.getBuilding(_loc22_.buildingTypeId).buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][_loc22_.level - 1] * param2);
            }
            if(_loc22_.buildingTypeId == 43)
            {
               _loc23_ = _loc22_.instanceId;
            }
         }
         city.ownerLevel = param1.ownerLevel;
         city.ownerBattlePoints = param1.ownerBattlePoints;
         city.ownerAlliance = param1.ownerAlliance;
         city.numberOfWorkers = param1.numberOfWorkers;
         city.workerStaffStatus = param1.workerStaffInfo;
         dispatch(new GenerateBuildingTypeInfosEvent("generateBuildingTypeInfosEvent"));
         city.buildingUpgradeJobs = new Vector.<BuildingUpgradeJob>();
         for each(var _loc21_ in param1.constructionJobs)
         {
            _loc13_ = _loc21_.targetLevel == 0 ? 0 : _loc21_.targetLevel - 1;
            for each(var _loc32_ in city.buildings)
            {
               if(_loc32_.instanceId == _loc21_.instanceId)
               {
                  _loc19_ = domainInfo.getBuilding(_loc32_.buildingTypeId);
                  break;
               }
            }
            _loc7_ = _loc21_.type == BuildingUpgradeJobType.FORTIFY ? (_loc19_.buildingSpecificInfo[BuildingSpecificInfoType.FORTIFICATION_INFO.id] as FortificationInfoDIO).fortifyDurationsPerLevelInSecs[_loc13_] : Number(_loc19_.upgradeDurationsPerLevel[_loc13_]);
            _loc10_ = _loc7_ * 1000 / _loc24_;
            city.buildingUpgradeJobs.push(new BuildingUpgradeJob(_loc21_.instanceId,_loc21_.targetLevel,_loc21_.durationRemaining,_loc10_,_loc21_.type,new Date().getTime()));
         }
         city.interruptedConstructionJobs = param1.interruptedConstructionJobs;
         city.buildingRepairJobs = new Vector.<BuildingRepairJob>();
         for each(var _loc6_ in param1.repairBuildingJobs)
         {
            for each(_loc32_ in city.buildings)
            {
               if(_loc32_.instanceId == _loc6_.instanceId)
               {
                  _loc35_ = _loc32_.level == 0 ? 0 : _loc32_.level - 1;
                  _loc19_ = domainInfo.getBuilding(_loc32_.buildingTypeId);
                  break;
               }
            }
            city.buildingRepairJobs.push(new BuildingRepairJob(_loc6_.instanceId,_loc6_.durationRemaining,new Date().getTime()));
         }
         city.dimensions = param1.dimensions;
         city.totalResourceCapacity = param1.totalResourceCapacity;
         city.resourceAmounts = param1.resourceAmounts;
         city.unitTypes = new Dictionary();
         for each(var _loc27_ in domainInfo.getEventItems())
         {
            if(_loc27_.itemType == EventItemType.MERCENARY.id)
            {
               param1.recruitedUnits.push(_loc27_.relatedId);
            }
         }
         for(var _loc18_ in param1.unitLevels)
         {
            _loc11_ = false;
            for each(var _loc14_ in param1.recruitedUnits)
            {
               if(_loc14_ == int(_loc18_))
               {
                  _loc11_ = true;
                  break;
               }
            }
            city.unitTypes[_loc18_] = new UnitTypeInfo(int(_loc18_),param1.unitLevels[_loc18_],_loc11_,false,false,false,false,0,0,0);
         }
         if(param1.activeRecruitmentJob)
         {
            city.activeRecruitJob = new UnitRecruitJob(param1.activeRecruitmentJob.unitTypeId,param1.activeRecruitmentJob.durationRemaining,domainInfo.getUnit(param1.activeRecruitmentJob.unitTypeId).unlockDurationInSecs * 1000 / _loc24_,new Date().getTime());
         }
         else
         {
            city.activeRecruitJob = null;
         }
         city.unitTrainJobs = new Vector.<UnitTrainJob>();
         for each(var _loc9_ in param1.unitTrainJobs)
         {
            _loc8_ = domainInfo.getUnit(_loc9_.unitTypeId);
            _loc25_ = city.unitTypes[_loc9_.unitTypeId];
            _loc10_ = _loc8_.trainingDurationPerLevelInSecs[_loc25_.currentLevel] * 1000 / _loc24_;
            city.unitTrainJobs.push(new UnitTrainJob(_loc9_.unitTypeId,_loc9_.durationRemaining,_loc10_,new Date().getTime(),_loc9_.instanceId));
         }
         city.units = new Vector.<UnitInfo>();
         for(var _loc31_ in param1.unitAmounts)
         {
            _loc16_ = uint(param1.unitAmounts[_loc31_]);
            _loc30_ = 0;
            while(_loc30_ < _loc16_)
            {
               _loc26_ = -1;
               for(var _loc12_ in _loc20_)
               {
                  if(_loc26_ == -1 || _loc20_[_loc12_] > _loc20_[_loc26_])
                  {
                     _loc26_ = int(_loc12_);
                  }
               }
               var _loc37_:int = _loc26_;
               var _loc36_:Number = _loc20_[_loc37_] - domainInfo.getUnit(int(_loc31_)).spacesPerLevel[(city.unitTypes[_loc31_] as UnitTypeInfo).currentLevel - 1];
               _loc20_[_loc37_] = _loc36_;
               _loc25_ = city.unitTypes[int(_loc31_)];
               _loc8_ = domainInfo.getUnit(int(_loc31_));
               _loc35_ = _loc25_.currentLevel == 0 ? 0 : _loc25_.currentLevel - 1;
               _loc34_ = _loc8_.healthPointsPerLevel[_loc35_];
               city.units.push(new UnitInfo(DefaultUnitFactory.generateUnitId(),UnitStatusType.IN_BARRACKS,_loc26_,int(_loc31_),_loc34_,param3,param4,param5));
               _loc30_++;
            }
         }
         for(var _loc33_ in param1.deployedUnits)
         {
            for each(var _loc17_ in param1.deployedUnits[_loc33_] as Vector.<UnitTypeAmountDTO>)
            {
               _loc16_ = uint(_loc17_.amount);
               _loc30_ = 0;
               while(_loc30_ < _loc16_)
               {
                  _loc25_ = city.unitTypes[_loc17_.id];
                  _loc8_ = domainInfo.getUnit(_loc17_.id);
                  _loc35_ = _loc25_.currentLevel == 0 ? 0 : _loc25_.currentLevel - 1;
                  _loc34_ = _loc8_.healthPointsPerLevel[_loc35_];
                  city.units.push(new UnitInfo(DefaultUnitFactory.generateUnitId(),UnitStatusType.IN_WATCH_POST,int(_loc33_),_loc17_.id,_loc34_,param3,param4,param5));
                  _loc30_++;
               }
            }
         }
         for(_loc31_ in param1.allianceUnitAmounts)
         {
            _loc16_ = uint(param1.allianceUnitAmounts[_loc31_]);
            _loc30_ = 0;
            while(_loc30_ < _loc16_)
            {
               _loc25_ = city.unitTypes[int(_loc31_)];
               _loc8_ = domainInfo.getUnit(int(_loc31_));
               _loc35_ = _loc25_.currentLevel == 0 ? 0 : _loc25_.currentLevel - 1;
               _loc34_ = _loc8_.healthPointsPerLevel[_loc35_];
               city.units.push(new UnitInfo(DefaultUnitFactory.generateUnitId(),UnitStatusType.IN_ALLIANCE_BARRACKS,_loc23_,int(_loc31_),_loc34_,param3,param4,param5));
               _loc30_++;
            }
         }
         city.hiringInfoDictionary = new Dictionary();
         for each(var _loc28_ in param1.hiringInfos)
         {
            city.hiringInfoDictionary[_loc28_.hiringBuildingInstanceId] = new HiringInfo(_loc28_.hiringBuildingInstanceId,_loc28_.hiringQueue,_loc28_.activeHiring ? new UnitHireJob(_loc28_.activeHiring.unitTypeId,_loc28_.activeHiring.executionTime,_loc28_.activeHiring.remainingDuration,_loc28_.activeHiring.hiringBuildingInstanceId,new Date().getTime(),domainInfo.getUnit(_loc28_.activeHiring.unitTypeId).hiringDurationPerLevelInSecs[(city.unitTypes[_loc28_.activeHiring.unitTypeId] as UnitTypeInfo).currentLevel - 1] / _loc24_) : null,_loc28_.isHiringPaused,_loc28_.pauseReason,_loc28_.lastHiredUnitId);
         }
         var _loc15_:BeastInfo = param1.beastView;
         if(_loc15_ != null)
         {
            _loc15_.jobScheduler = BeastJobScheduler.createBeastJobScheduler(param1.beastJobSchedulerView,domainInfo.getBeast(_loc15_.typeId),_loc24_);
         }
         city.spyEnabled = false;
         city.beast = _loc15_;
         city.beastLevelBonusTuples = param1.beastLevelBonusTuples;
         city.goldCapacity = null;
         city.viralActions = new Vector.<ViralAction>();
         city.maxCityPlanSlots = param1.maxCityPlanSlots;
         city.cityPlans = param1.cityPlans;
         city.beastCannonInfo = param1.beastCannonInfo;
         fillItemSellingPrices();
         updateOriginalDurationsInBlacksmith();
         dispatch(new GenerateUnitTypeInfosEvent("generateUnitTypeInfosEvent"));
         dispatch(new ModelUpdateEvent("userInfoUpdated"));
         dispatch(new GameTickEvent("start"));
         dispatch(new GameModeChangedEvent("gameModeChange"));
         coreManager.addGrids(city.dimensions);
         coreManager.addBuildings(city.buildings,city.buildingUpgradeJobs,city.buildingRepairJobs);
         coreManager.addDecorations(city.decorations);
         coreManager.setWorkerCount(city.numberOfWorkers);
         coreManager.setUnits(city.units);
         coreManager.setBeast(_loc15_);
         coreManager.addBackground();
         coreManager.manageStockpileAnimations();
         coreManager.addTerrain(domainInfo.getTerrainLayout()["doodads"]);
         if(userInfo.gameMode == GameModeType.NORMAL)
         {
            coreManager.buildBeastCage();
            coreManager.buildCityExpansionSigns();
         }
         if(userInfo.redirectToMap && userInfo.gameMode == GameModeType.NORMAL)
         {
            userInfo.redirectToMap = false;
            _loc29_ = new Dictionary();
            if(userInfo.mapInCampaignMode)
            {
               userInfo.mapInCampaignMode = false;
               _loc29_["mapScreenCampaignMode"] = true;
            }
            dispatch(new ActivateScreenEvent("activate",WomScreenType.MAP,_loc29_));
         }
         else
         {
            dispatch(new ActivateScreenEvent("activate",WomScreenType.CITY));
         }
         dispatch(new ModelUpdateEvent("eventTimersUpdated"));
         dispatch(new ModelUpdateEvent("resourcesUpdated"));
         dispatch(new ModelUpdateEvent("workerCountUpdated"));
         dispatch(new ModelUpdateEvent("cityLoaded"));
      }
      
      private function fillItemSellingPrices() : void
      {
         var _loc1_:PartTypeDIO = null;
         var _loc3_:int = 0;
         var _loc2_:InventoryItemDTO = null;
         _loc3_ = 0;
         while(_loc3_ < userInfo.items.length)
         {
            _loc2_ = userInfo.items[_loc3_];
            _loc1_ = domainInfo.getPart(_loc2_.id);
            if(_loc1_ != null)
            {
               _loc2_.sellingPrice = PartSellPriceCalculationUtil.calculateSellPrice(_loc1_,domainInfo.getBuilding(10),city,_loc2_.resourceGiftBonusQuantity);
            }
            _loc3_++;
         }
      }
      
      private function updateOriginalDurationsInBlacksmith() : void
      {
         var _loc3_:EventItemDIO = null;
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.buildingTypeId == 44)
            {
               for each(var _loc2_ in _loc1_.buildingSpecificInfo[BuildingSpecificInfoType.EVENT_ITEM_INVENTORY.id])
               {
                  _loc3_ = domainInfo.getEventItem(_loc2_.id);
                  if(_loc3_)
                  {
                     _loc2_.originalDuration = originalDurationInMiliSec(_loc3_);
                  }
               }
            }
         }
      }
      
      private function originalDurationInMiliSec(param1:EventItemDIO) : int
      {
         var _loc2_:UnitTypeDIO = null;
         var _loc4_:UnitTypeInfo = null;
         var _loc3_:int = 0;
         var _loc5_:CatapultTypeDIO = null;
         var _loc6_:Number = 0;
         switch(param1.itemType)
         {
            case EventItemType.MERCENARY.id:
               _loc2_ = domainInfo.getUnit(param1.relatedId);
               _loc4_ = city.unitTypes[_loc2_.id];
               _loc3_ = _loc4_.currentLevel - 1;
               _loc6_ = _loc2_.hiringDurationPerLevelInSecs[_loc3_] * 1000;
               break;
            case EventItemType.CATAPULT.id:
               _loc5_ = domainInfo.getCatapult(param1.relatedId);
               _loc6_ = _loc5_.upgradeTimesInSecs.length > 0 ? _loc5_.upgradeTimesInSecs[0] * 1000 : 0;
         }
         return _loc6_;
      }
   }
}

