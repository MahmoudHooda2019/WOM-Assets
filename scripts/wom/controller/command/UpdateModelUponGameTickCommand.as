package wom.controller.command
{
   import flash.external.ExternalInterface;
   import flash.utils.getTimer;
   import peak.config.DocumentConfiguration;
   import peak.i18n.PText;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.util.DateTimeUtil;
   import wom.controller.PCommand;
   import wom.controller.command.mobile.MobilePreSelectCommand;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.combat.EndAttackEvent;
   import wom.controller.event.combat.EndDeploymentEvent;
   import wom.controller.event.defense.EndNPCAttackEvent;
   import wom.controller.event.defense.EndTuskHornEvent;
   import wom.controller.event.ui.UserNotificationEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.attribute.data.WorkerStatus;
   import wom.model.component.behavior.unit.Speak;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Worker;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.attack.CatapultTimeDTO;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.defense.NPCAttackDirection;
   import wom.model.game.defense.NPCAttackStatus;
   import wom.model.game.defense.UnitBatchInfoDTO;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.league.LeagueManager;
   import wom.model.game.quest.QuestInfo;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.speech.SpeechType;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.viral.MobileUserNotification;
   import wom.model.game.viral.UserNotification;
   import wom.model.message.request.PrepareNPCAttackRequest;
   import wom.model.message.request.SetAttackerNPCUnitsRequest;
   import wom.model.message.request.StartNPCAttackRequest;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.screen.windows.build.MobileBuildingSilhouette;
   
   public class UpdateModelUponGameTickCommand extends PCommand
   {
      
      [Inject]
      public var gameTickEvent:GameTickEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var documentConfiguration:DocumentConfiguration;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      [Inject]
      public var storeInfo:StoreInfo;
      
      public function UpdateModelUponGameTickCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:Number = NaN;
         try
         {
            _loc1_ = calculateTimeDifference();
            updateLastGameTickUpdateTime(_loc1_);
            updateCatapultTimers(_loc1_);
            updateChatBanTimes(_loc1_);
            updateBPEventTimer(_loc1_);
            updateIronEventTimer(_loc1_);
            updateEventTimer(_loc1_);
            updateAllPopUpsClosed(_loc1_);
            updateLeagueSeasonRemainingDuration(_loc1_);
            updateTournamentTimer(_loc1_);
            if(userInfo.gameMode == GameModeType.NORMAL)
            {
               updateUnharvestedResources(_loc1_);
               updateCityCenterGoldStatus(_loc1_);
               updateRepairJobs(_loc1_);
               updateBeast(_loc1_);
               checkNPCAttackStatus();
               manageTimedIndicators();
               manageIdleWorkerSpeeches();
               updateStoreDiscount(_loc1_);
               updateBeastCannonTimer(_loc1_);
            }
            else if(userInfo.gameMode == GameModeType.ATTACK || userInfo.gameMode == GameModeType.TUSK_HORN)
            {
               checkAttackStatus();
               updateStockPileResources();
            }
            else if(userInfo.gameMode == GameModeType.DEFEND)
            {
               checkDefendStatus();
            }
         }
         catch(e:Error)
         {
            log(WomLoggerContexts.GAME,"Error in UMUGTC : " + e.message + " " + e.getStackTrace());
         }
      }
      
      private function updateLeagueSeasonRemainingDuration(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(leagueManager.myLeague != null)
         {
            _loc2_ = leagueManager.myLeague.season.remainingSeasonDuration;
            if(!isNaN(_loc2_) && _loc2_ > 0)
            {
               _loc2_ -= param1;
               if(_loc2_ < 0)
               {
                  _loc2_ = 0;
               }
               leagueManager.myLeague.season.remainingSeasonDuration = _loc2_;
            }
         }
      }
      
      private function updateBPEventTimer(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(documentConfiguration.hasParameter("event_timer") && !documentConfiguration.hasParameter("event_timer_checked"))
         {
            _loc2_ = documentConfiguration.getParameter("event_timer") - param1;
            documentConfiguration.setParameter("event_timer",_loc2_);
            if(_loc2_ < -600000 && ExternalInterface.available)
            {
               documentConfiguration.setParameter("event_timer_checked",true);
               log(LoggerContexts.INFRASTRUCTURE,"event_timer_checked: " + _loc2_);
               ExternalInterface.call("WOM.event.check");
            }
         }
      }
      
      private function updateIronEventTimer(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(documentConfiguration.hasParameter("iron_event_timer"))
         {
            _loc2_ = documentConfiguration.getParameter("iron_event_timer") - param1;
            documentConfiguration.setParameter("iron_event_timer",_loc2_);
         }
      }
      
      private function updateEventTimer(param1:Number) : void
      {
         if(userInfo.eventEndTime >= 0 && userInfo.eventEndTime - param1 < 0)
         {
            dispatch(new ModelUpdateEvent("eventNpcsUpdated"));
         }
         userInfo.eventStartTime -= param1;
         userInfo.eventEndTime -= param1;
         userInfo.eventStoreEndTime -= param1;
      }
      
      private function updateTournamentTimer(param1:Number) : void
      {
         if(userInfo.tournamentNextAttackRemainingDuration - param1 >= 0)
         {
            userInfo.tournamentNextAttackRemainingDuration -= param1;
         }
         else
         {
            userInfo.tournamentNextAttackRemainingDuration = 0;
         }
         if(userInfo.tournamentRemainingDuration - param1 >= 0)
         {
            userInfo.tournamentRemainingDuration -= param1;
         }
         else
         {
            userInfo.tournamentRemainingDuration = 0;
         }
         if(userInfo.tournamentStartRemainingDuration - param1 >= 0)
         {
            userInfo.tournamentStartRemainingDuration -= param1;
         }
         else
         {
            userInfo.tournamentStartRemainingDuration = 0;
         }
      }
      
      private function updateStoreDiscount(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(storeInfo.discount != null)
         {
            _loc2_ = storeInfo.discount.remainingDuration;
            _loc2_ -= param1;
            if(_loc2_ < 0)
            {
               storeInfo.discount = null;
               dispatch(new ModelUpdateEvent("storeItemDiscountUpdated"));
            }
            else
            {
               storeInfo.discount.remainingDuration = _loc2_;
            }
         }
      }
      
      private function updateAllPopUpsClosed(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(documentConfiguration.hasParameter("all_popups_closed"))
         {
            return;
         }
         if(userInfo.tutorialsInfo.additionalInfo.lastOpenedPopup == null)
         {
            if(documentConfiguration.hasParameter("all_popups_closed_timer"))
            {
               _loc2_ = documentConfiguration.getParameter("all_popups_closed_timer");
               _loc2_ += param1;
               documentConfiguration.setParameter("all_popups_closed_timer",_loc2_);
               if(_loc2_ > 1000 && ExternalInterface.available)
               {
                  documentConfiguration.setParameter("all_popups_closed",true);
                  if(ExternalInterface.available)
                  {
                     ExternalInterface.call("WOM.dialog.clientFinished");
                  }
               }
            }
            else
            {
               documentConfiguration.setParameter("all_popups_closed_timer",0);
            }
         }
         else if(documentConfiguration.hasParameter("all_popups_closed_timer"))
         {
            documentConfiguration.deleteParameter("all_popups_closed_timer");
         }
      }
      
      private function manageIdleWorkerSpeeches() : void
      {
         var _loc2_:WorkerStatus = null;
         for each(var _loc1_ in gameRootHolder.gameRoot.workers)
         {
            if(_loc1_ && "WorkerStatus" in _loc1_.componentManager)
            {
               _loc2_ = _loc1_.componentManager["WorkerStatus"] as WorkerStatus;
               if(!_loc2_.busy)
               {
                  if(_loc1_.lastWorkerSpeechTimer == 0)
                  {
                     _loc1_.scheduleScpeech();
                  }
                  else if(_loc1_.lastWorkerSpeechTimer < getTimer())
                  {
                     (_loc1_.componentManager["Speak"] as Speak).speak(SpeechType.WORKER_IDLE);
                     _loc1_.scheduleScpeech();
                  }
               }
            }
         }
      }
      
      private function updateChatBanTimes(param1:Number) : void
      {
         userInfo.chatBanDuration -= param1;
      }
      
      private function updateCatapultTimers(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:String = null;
         for each(var _loc4_ in userInfo.catapultActivationRemainingTimes)
         {
            _loc3_ = _loc4_.catapultTime;
            _loc2_ = "";
            if(_loc3_ > 0 && _loc3_ - param1 <= 0)
            {
               switch(_loc4_.id - 1)
               {
                  case 0:
                     var _loc7_:String = "ui.notification.lumbercatapultrecharged";
                     _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc7_);
                     break;
                  case 1:
                     var _loc8_:String = "ui.notification.stonecatapultrecharged";
                     _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc8_);
                     break;
                  case 2:
                     var _loc9_:String = "ui.notification.mightcatapultrecharged";
                     _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc9_);
               }
               dispatch(new UserNotificationEvent("userNotificationEventShow",new MobileUserNotification(8,0,"",_loc2_,new MobileBuildingSilhouette(23))));
            }
            _loc3_ -= param1;
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            _loc4_.catapultTime = _loc3_;
         }
      }
      
      private function updateBeastCannonTimer(param1:Number) : void
      {
         var _loc5_:Number = city.beastCannonInfo.remainingTimeToRecharge;
         _loc5_ = _loc5_ - param1;
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         var _loc2_:BuildingTypeDIO = domainInfo.getBuilding(45);
         var _loc4_:Number = Number(_loc2_.buildingSpecificInfo[BuildingSpecificInfoType.BEAST_CANNON_RECHARGE_PER_AMMUNITION.id]);
         var _loc3_:int = int(_loc2_.buildingSpecificInfo[BuildingSpecificInfoType.BEAST_CANNON_MAX_AMMUNITION.id]);
         city.beastCannonInfo.remainingTimeToRecharge = _loc5_;
         city.beastCannonInfo.ammoAmount = _loc3_ - Math.ceil(_loc5_ / (_loc4_ * 1000));
      }
      
      private function manageTimedIndicators() : void
      {
         var _loc2_:Building = null;
         var _loc1_:BeastInfo = null;
         var _loc5_:BeastTypeDIO = null;
         if(city.unitTrainJobs)
         {
            for each(var _loc4_ in city.unitTrainJobs)
            {
               if(gameRootHolder.gameRoot && _loc4_ && _loc4_.jobCreationTime + _loc4_.durationRemaining - new Date().getTime() < 300000)
               {
                  _loc2_ = gameRootHolder.gameRoot.buildings[_loc4_.instanceId];
                  if(!("BuildingUpgrade" in _loc2_.componentManager || "BuildingRepair" in _loc2_.componentManager))
                  {
                     _loc2_.viewManager.drawIndicator("SpeedupIcon");
                  }
               }
            }
         }
         if(city.activeRecruitJob)
         {
            if(gameRootHolder.gameRoot && city.activeRecruitJob.jobCreationTime + city.activeRecruitJob.durationRemaining - new Date().getTime() < 300000)
            {
               for each(_loc2_ in gameRootHolder.gameRoot.buildings)
               {
                  if(_loc2_.data && _loc2_.data.buildingInfo && _loc2_.data.buildingInfo.buildingTypeId == 17 && !("BuildingUpgrade" in _loc2_.componentManager || "BuildingRepair" in _loc2_.componentManager))
                  {
                     _loc2_.viewManager.drawIndicator("SpeedupIcon");
                  }
               }
            }
         }
         var _loc3_:Boolean = false;
         if(city.beast != null && city.beast.jobScheduler && city.beast.jobScheduler.waitTrainingJob != null)
         {
            _loc1_ = city.beast;
            _loc5_ = domainInfo.getBeast(_loc1_.typeId);
            if(_loc1_.level >= _loc5_.maxLevels)
            {
               _loc3_ = _loc1_.bonusStage > 0;
            }
            else
            {
               _loc3_ = _loc1_.numberOfTrainingsLeftToNextLevel < _loc5_.numberOfTrainingsToLevelUpPerLevel[_loc1_.level - 1];
            }
         }
         if(gameRootHolder.gameRoot)
         {
            for each(_loc2_ in gameRootHolder.gameRoot.buildings)
            {
               if(_loc2_.data && _loc2_.data.buildingInfo && _loc2_.data.buildingInfo.buildingTypeId == 29 && !("BuildingUpgrade" in _loc2_.componentManager || "BuildingRepair" in _loc2_.componentManager))
               {
                  if(_loc3_)
                  {
                     _loc2_.viewManager.drawIndicator("BeastReady");
                  }
                  else
                  {
                     _loc2_.viewManager.clearIndicator();
                  }
               }
            }
         }
      }
      
      private function checkNPCAttackStatus() : void
      {
         var _loc1_:int = 0;
         if(userInfo.canReceiveNPCAttacks)
         {
            _loc1_ = getTimer();
            if(userInfo.npcAttackStatus == NPCAttackStatus.WAIT && userInfo.npcDurationSaveTime + userInfo.remainingDurationToNextNPCAttack - new Date().getTime() < 300000)
            {
               if(allBuildingsAreHealthy())
               {
                  if(_loc1_ > 8000)
                  {
                     if(userInfo.npcAttackDelayed)
                     {
                        userInfo.npcAttackStatus = NPCAttackStatus.DELAY;
                        dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
                     }
                     else
                     {
                        userInfo.npcAttackStatus = NPCAttackStatus.INIT_ASK;
                        dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
                        checkTutorialQuest20();
                        dispatch(new OutgoingMessageEvent("outgoingMessage",new PrepareNPCAttackRequest()));
                     }
                  }
               }
               else
               {
                  userInfo.npcAttackStatus = NPCAttackStatus.POSTPONED_FROM_UNHEALTHY_BUILDING;
                  dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
               }
            }
            else if(userInfo.npcAttackStatus == NPCAttackStatus.DELAY && userInfo.npcDurationSaveTime + userInfo.remainingDurationToNextNPCAttack - new Date().getTime() <= 0 && !userInfo.delayPopups)
            {
               if(allBuildingsAreHealthy())
               {
                  if(userInfo.npcAttackPrepared)
                  {
                     userInfo.npcAttackStatus = NPCAttackStatus.INIT_ATTACK;
                     dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
                     dispatch(new OutgoingMessageEvent("outgoingMessage",new StartNPCAttackRequest()));
                  }
                  else if(_loc1_ > 8000)
                  {
                     dispatch(new OutgoingMessageEvent("outgoingMessage",new PrepareNPCAttackRequest()));
                  }
               }
               else
               {
                  userInfo.npcAttackStatus = NPCAttackStatus.POSTPONED_FROM_UNHEALTHY_BUILDING;
                  dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
               }
            }
         }
      }
      
      private function checkTutorialQuest20() : void
      {
         var _loc1_:* = undefined;
         for each(var _loc2_ in userInfo.quests)
         {
            if(_loc2_.questId == 20 && !_loc2_.completed)
            {
               _loc1_ = new Vector.<UnitBatchInfoDTO>();
               _loc1_.push(new UnitBatchInfoDTO(new UnitTypeAmountDTO(10,2),NPCAttackDirection.NORTH_WEST));
               dispatch(new OutgoingMessageEvent("outgoingMessage",new SetAttackerNPCUnitsRequest(_loc1_)));
            }
         }
      }
      
      private function allBuildingsAreHealthy() : Boolean
      {
         var _loc3_:BuildingTypeDIO = null;
         var _loc1_:Boolean = true;
         for each(var _loc2_ in city.buildings)
         {
            _loc3_ = domainInfo.getBuilding(_loc2_.buildingTypeId);
            if(_loc1_)
            {
               _loc1_ = _loc3_.isHealthy(_loc2_.level,_loc2_.healthPoint);
            }
            if(!_loc1_)
            {
               return _loc1_;
            }
         }
         return _loc1_;
      }
      
      private function updateCityCenterGoldStatus(param1:Number) : void
      {
         var _loc5_:BuildingTypeDIO = null;
         var _loc3_:Boolean = false;
         var _loc8_:Number = NaN;
         var _loc7_:Number = NaN;
         if(city != null && city.goldCapacity != null)
         {
            for each(var _loc4_ in city.buildings)
            {
               if(_loc4_.buildingTypeId == 10)
               {
                  _loc5_ = domainInfo.getBuilding(_loc4_.buildingTypeId);
                  _loc3_ = true;
                  if(!_loc4_.incomplete && _loc5_.isHealthy(_loc4_.level,_loc4_.healthPoint))
                  {
                     _loc3_ = false;
                     if(city.buildingUpgradeJobs != null)
                     {
                        for each(var _loc2_ in city.buildingUpgradeJobs)
                        {
                           if(_loc2_.instanceId == _loc4_.instanceId)
                           {
                              _loc3_ = true;
                              break;
                           }
                        }
                     }
                     if(!_loc3_ && city.buildingRepairJobs != null)
                     {
                        for each(var _loc6_ in city.buildingRepairJobs)
                        {
                           if(_loc6_.instanceId == _loc4_.instanceId)
                           {
                              _loc3_ = true;
                              break;
                           }
                        }
                     }
                  }
                  if(!_loc3_)
                  {
                     city.goldCapacity.remainingTime -= param1;
                     if(city.goldCapacity.remainingTime < 0)
                     {
                        city.goldCapacity.remainingTime = 0;
                     }
                     city.goldCapacity.updatedTimer = getTimer();
                  }
                  break;
               }
            }
            _loc8_ = city.goldCapacity.remainingTime + city.goldCapacity.updatedTimer;
            _loc7_ = getTimer();
            if(_loc8_ - 1000 < _loc7_ && _loc7_ < _loc8_ + 1000)
            {
               coreManager.manageCityCenterIndicatorStatus();
            }
         }
      }
      
      private function updateStockPileResources() : void
      {
         coreManager.manageStockpileAnimations();
      }
      
      private function updateUnharvestedResources(param1:Number) : void
      {
         var _loc7_:BuildingTypeDIO = null;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc8_:Number = NaN;
         for each(var _loc3_ in city.buildings)
         {
            if(BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id in _loc3_.buildingSpecificInfo && !_loc3_.incomplete && _loc3_.level >= 1)
            {
               _loc7_ = domainInfo.getBuilding(_loc3_.buildingTypeId);
               if(_loc7_.kind.id == 11 && _loc7_.isHealthy(_loc3_.level,_loc3_.healthPoint) && BuildingSpecificInfoType.PRODUCTION_AMOUNTS_PER_HOUR_PER_LEVEL.id in _loc7_.buildingSpecificInfo && BuildingSpecificInfoType.STORAGE_CAPACITIES_PER_LEVEL.id in _loc7_.buildingSpecificInfo)
               {
                  _loc9_ = false;
                  for each(var _loc2_ in city.buildingUpgradeJobs)
                  {
                     if(_loc2_.instanceId == _loc3_.instanceId)
                     {
                        _loc9_ = true;
                     }
                  }
                  if(!_loc9_)
                  {
                     _loc10_ = _loc3_.level == 0 ? 0 : _loc3_.level - 1;
                     _loc6_ = Number(_loc7_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCTION_AMOUNTS_PER_HOUR_PER_LEVEL.id][_loc10_]);
                     _loc5_ = Number(_loc7_.buildingSpecificInfo[BuildingSpecificInfoType.STORAGE_CAPACITIES_PER_LEVEL.id][_loc10_]);
                     _loc4_ = Number(_loc3_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id]);
                     if(_loc4_ < _loc5_)
                     {
                        _loc8_ = 1;
                        if(_loc3_.buildingTypeId == 14)
                        {
                           if(documentConfiguration.hasParameter("iron_event_timer") && documentConfiguration.getParameter("iron_event_timer") > 0 && documentConfiguration.getParameter("iron_event_timer") < 7 * 86400000)
                           {
                              _loc8_ = 3;
                           }
                           if(leagueManager.myLeague != null)
                           {
                              _loc8_ *= 1 + leagueManager.myLeague.levelDIO.ironProductionBonusPercentage / 100;
                           }
                        }
                        _loc4_ += _loc8_ * _loc6_ * param1 * userInfo.serverSpeed * userInfo.productionBoostModifier / 3600000;
                        if(_loc4_ >= _loc5_)
                        {
                           coreManager.stopResourceAnimation(_loc3_.instanceId);
                        }
                        if(_loc4_ > MobilePreSelectCommand.RESOURCE_PRODUCER_ONE_TAP_BARRIERS[_loc10_])
                        {
                           coreManager.drawIndicator(_loc3_.instanceId,(_loc7_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType).name + "Full");
                        }
                        _loc3_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] = Math.min(_loc5_,_loc4_);
                     }
                  }
               }
            }
         }
      }
      
      private function checkDefendStatus() : void
      {
         if(getTimer() - attackInfo.attackStartTime > 180000)
         {
            dispatch(new EndNPCAttackEvent("endNPCAttack"));
         }
      }
      
      private function checkAttackStatus() : void
      {
         if(userInfo.mandatoryTutorialCompleted)
         {
            if(attackInfo.deployPassed)
            {
               if(getTimer() > attackInfo.attackEndTime && !attackInfo.attackEnded)
               {
                  if(userInfo.gameMode == GameModeType.ATTACK)
                  {
                     dispatch(new EndAttackEvent("endAttack"));
                  }
                  else if(userInfo.gameMode == GameModeType.TUSK_HORN)
                  {
                     dispatch(new EndTuskHornEvent("endAttack"));
                  }
               }
            }
            else if(getTimer() - attackInfo.attackStartTime > 300000)
            {
               attackInfo.deployPassed = true;
               coreManager.setDeployDiameter(0,0);
               if(gameRootHolder.gameRoot.eventItemsManager.buildingSilhouette)
               {
                  gameRootHolder.gameRoot.eventItemsManager.cancelDeployWarBuilding();
               }
               dispatch(new ModelUpdateEvent("attackInfoUpdated"));
               dispatch(new EndDeploymentEvent("endDeployment"));
            }
         }
      }
      
      private function updateRepairJobs(param1:Number) : void
      {
         var _loc4_:BuildingTypeDIO = null;
         var _loc6_:int = 0;
         var _loc5_:Number = NaN;
         for each(var _loc2_ in city.buildingRepairJobs)
         {
            for each(var _loc3_ in city.buildings)
            {
               if(_loc3_.instanceId == _loc2_.instanceId)
               {
                  _loc4_ = domainInfo.getBuilding(_loc3_.buildingTypeId);
                  _loc6_ = _loc3_.level == 0 ? 0 : _loc3_.level - 1;
                  _loc5_ = _loc4_.healthPointsPerLevel[_loc6_];
                  _loc3_.healthPoint += userInfo.serverSpeed * _loc5_ * param1 / (_loc4_.repairDurationsPerLevel[_loc6_] * 1000);
                  if(_loc3_.healthPoint > _loc5_)
                  {
                     _loc3_.healthPoint = _loc5_;
                  }
                  break;
               }
            }
         }
      }
      
      private function calculateTimeDifference() : Number
      {
         var _loc1_:Date = new Date();
         var _loc2_:Date = userInfo.lastGameTickUpdateTime;
         return _loc1_.getTime() - _loc2_.getTime();
      }
      
      private function updateLastGameTickUpdateTime(param1:Number) : void
      {
         userInfo.lastGameTickUpdateTime = new Date(userInfo.lastGameTickUpdateTime.getTime() + param1);
      }
      
      private function updateBeast(param1:Number) : void
      {
         var _loc2_:BeastInfo = null;
         var _loc7_:BeastTypeDIO = null;
         var _loc6_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:Number = NaN;
         if(city.beast != null)
         {
            _loc2_ = city.beast;
            _loc7_ = domainInfo.getBeast(_loc2_.typeId);
            _loc6_ = DateTimeUtil.convertMillisecondToSecond(param1);
            _loc4_ = Math.ceil(_loc7_.healingTimesPerLevel[_loc2_.level - 1] / userInfo.serverSpeed);
            _loc5_ = int(_loc2_.bonusStage > 0 ? _loc7_.healthPointsPerStage[_loc2_.bonusStage - 1] : _loc7_.healthPointsPerLevel[_loc2_.level - 1]);
            if(_loc2_.healthPoints < _loc5_)
            {
               _loc3_ = _loc6_ * _loc5_ / _loc4_ + _loc2_.remainderHealthPoints;
               _loc2_.remainderHealthPoints = _loc3_ - Math.floor(_loc3_);
               _loc2_.healthPoints += Math.floor(_loc3_);
               if(_loc2_.healthPoints >= _loc5_)
               {
                  _loc2_.healthPoints = _loc5_;
                  var _temp_7:* = §§findproperty(UserNotificationEvent);
                  var _temp_6:* = "userNotificationEventShow";
                  var _temp_5:* = §§findproperty(UserNotification);
                  var _temp_4:* = 7;
                  var _temp_3:* = 0;
                  var _temp_2:* = _loc7_.assetName + _loc2_.level;
                  var _loc8_:String = "ui.notification.beasthealthfull";
                  dispatch(new UserNotificationEvent(_temp_6,new UserNotification(_temp_4,_temp_3,_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc8_))));
               }
               coreManager.notifyBeastHealthChange();
               dispatch(new ModelUpdateEvent("beastHealthUpdated"));
            }
         }
      }
   }
}

