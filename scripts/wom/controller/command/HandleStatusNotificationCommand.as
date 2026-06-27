package wom.controller.command
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import peak.logging.log;
   import wom.controller.command.city.CityLoaderCommand;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.WindowCreationEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.controller.event.ui.SettingsEvent;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.dto.HiringInfoDTO;
   import wom.model.dto.QuestDTO;
   import wom.model.dto.TaskDTO;
   import wom.model.dto.job.BuildingRepairJobDTO;
   import wom.model.game.CityInfoDTO;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingInfoUtil;
   import wom.model.game.friend.InboxInfo;
   import wom.model.game.gold.GoldGift;
   import wom.model.game.help.HelpInfo;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.quest.QuestInfo;
   import wom.model.game.quest.QuestUtil;
   import wom.model.game.resource.GoldCapacityInfo;
   import wom.model.game.settings.ClientSettingType;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.tutorial.TutorialInfo;
   import wom.model.game.tutorial.TutorialState;
   import wom.model.game.viral.ViralAction;
   import wom.model.message.notification.StatusNotification;
   import wom.model.message.request.BuyItemRequest;
   import wom.model.message.request.ClaimQuestRequest;
   import wom.model.message.request.GetAttackLogsRequest;
   import wom.model.message.request.GetVisibleQuestsRequest;
   import wom.service.facebook.FacebookAPIManager;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.screen.popups.FeatureAvailablePopUp;
   import wom.view.screen.popups.MobileFortificationCompletedPopUp;
   import wom.view.screen.popups.building.BuildingCompletedPopUp;
   import wom.view.screen.popups.building.BuildingUpgradedPopUp;
   import wom.view.screen.popups.friendwatchpost.MobileFriendWatchpostHelpPopUp;
   import wom.view.screen.popups.help.GiftGoldThanksPopUp;
   import wom.view.screen.popups.help.MobileHelpedFriendPopUp;
   import wom.view.screen.popups.league.LeagueSeasonEndedPopUp;
   import wom.view.screen.popups.league.LeagueSeasonEndedSuccessPopUp;
   import wom.view.screen.popups.league.LeagueStatusChangedPopUp;
   import wom.view.screen.popups.league.LeagueStatusDroppedPopUp;
   import wom.view.screen.popups.league.LeagueStatusPlacedPopUp;
   import wom.view.screen.popups.levelup.MobileLevelupPopup;
   import wom.view.screen.popups.npcattack.mobile.MobileNPCAttackRepelledPopup;
   import wom.view.screen.popups.quest.MobileQuestCompletedPopup;
   import wom.view.screen.popups.repair.MobileRepairNewPopUp;
   import wom.view.screen.popups.tournament.MobileTournamentEndedPopUp;
   import wom.view.screen.popups.unit.MobileRecruitmentCompletedPopUp;
   import wom.view.screen.popups.unit.TrainingCompletedPopUp;
   
   public class HandleStatusNotificationCommand extends CityLoaderCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var inboxInfo:InboxInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      public function HandleStatusNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc6_:StatusNotification = messageReceivedEvent.message as StatusNotification;
         var _loc4_:Boolean = false;
         if(userInfo.gameMode == GameModeType.TUSK_HORN || userInfo.gameMode == GameModeType.ATTACK || userInfo.gameMode == GameModeType.DEFEND || userInfo.gameMode == GameModeType.VISIT)
         {
            _loc4_ = userInfo.gameMode == GameModeType.DEFEND;
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetVisibleQuestsRequest()));
         }
         userInfo.gameMode = GameModeType.NORMAL;
         dispatch(new GameModeChangedEvent("gameModeChange"));
         gameRootHolder.init();
         coreManager.setFactories();
         var _loc1_:CityInfoDTO = _loc6_.city;
         loadCity(_loc1_,userInfo.barracksSpaceModifier,userInfo.unitArmorModifier,userInfo.unitSpeedModifier,userInfo.unitDamageModifier);
         coreManager.manageResourceProducerAnimations();
         var _loc3_:Boolean = false;
         for each(var _loc5_ in _loc1_.hiringInfos)
         {
            if(_loc5_.isHiringPaused)
            {
               _loc3_ = true;
            }
         }
         city.goldCapacity = new GoldCapacityInfo(_loc6_.goldCapacityRemainingTime,getTimer());
         city.viralActions = _loc6_.viralActions;
         enableTutorial();
         if(userInfo.mandatoryTutorialCompleted && inboxInfo.inboxMode == 0)
         {
            inboxInfo.inboxMode = 2;
            userInfo.delayPopups = false;
         }
         else
         {
            inboxInfo.inboxMode = 2;
            userInfo.delayPopups = false;
         }
         executeRepairSpecificActionsAndToolMenuEnabling(_loc1_);
         checkOfflineReceivedHelps();
         executeViralActionSpecificOperations();
         if(_loc4_ && userInfo.mandatoryTutorialCompleted)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileNPCAttackRepelledPopup()));
         }
         for each(var _loc2_ in userInfo.offlineReceivedGoldGifts)
         {
            dispatch(new PopUpWindowEvent("showPopUpWindow",new GiftGoldThanksPopUp(_loc2_)));
         }
         userInfo.offlineReceivedGoldGifts.length = 0;
         dispatch(new ModelUpdateEvent("questInfoUpdated"));
         dispatch(new ModelUpdateEvent("toolMenuEnabled"));
         dispatch(new SettingsEvent("applySettings",ClientSettingType.ALL,null));
         coreManager.manageMercenaryBarracksNotEnoughSpaceIndicator();
         coreManager.manageIncompleteBuildingIndicators();
         coreManager.manageHiringQuartersAnimations();
         coreManager.manageTrainingChamberAnimations();
         coreManager.manageTrainingChamberIndicators();
         coreManager.manageRecruitmentChamberIndicator();
         coreManager.manageBlacksmithAnimation();
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAttackLogsRequest()));
         userInfo.ignoreNPCAttackPopup = false;
         gameRootHolder.gameRoot.timeOut.addJobToFrame(2,triggerTutorial);
         if(allianceInfo.windowLastState != null)
         {
            dispatch(new WindowCreationEvent("createWindow",allianceInfo.windowLastState));
            allianceInfo.windowLastState = null;
         }
         dispatch(new MobileExternalInterfaceEvent("checkWallPostLocalStore"));
         if(userInfo.mandatoryTutorialCompleted)
         {
            dispatch(new MobileExternalInterfaceEvent("getAnnouncements"));
         }
      }
      
      private function executeViralActionSpecificOperations() : void
      {
         var _loc14_:* = null;
         var _loc17_:int = 0;
         var _loc4_:int = 0;
         var _loc12_:QuestDTO = null;
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc3_:int = 0;
         var _loc6_:Number = NaN;
         var _loc1_:int = 0;
         var _loc11_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc15_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc9_:LeagueLevelDIO = null;
         if(city.viralActions.length > 0 && userInfo.mandatoryTutorialCompleted)
         {
            for each(_loc14_ in city.viralActions)
            {
               switch(_loc14_.type)
               {
                  case "buildingUpgraded":
                     _loc17_ = int(_loc14_.attributes["newLevel"]);
                     _loc4_ = int(_loc14_.attributes["buildingTypeId"]);
                     if(_loc17_ == 1)
                     {
                        dispatch(new PopUpWindowEvent("showPopUpWindow",new BuildingCompletedPopUp(domainInfo.getBuilding(_loc4_))));
                        if(_loc4_ == 26)
                        {
                           dispatch(new PopUpWindowEvent("showPopUpWindow",new FeatureAvailablePopUp(2)));
                        }
                     }
                     else
                     {
                        dispatch(new PopUpWindowEvent("showPopUpWindow",new BuildingUpgradedPopUp(domainInfo.getBuilding(_loc4_),_loc17_)));
                     }
                     break;
                  case "buildingFortified":
                     dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFortificationCompletedPopUp(domainInfo.getBuilding(int(_loc14_.attributes["buildingTypeId"])),int(_loc14_.attributes["newLevel"]))));
                     break;
                  case "unitRecruited":
                     dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileRecruitmentCompletedPopUp(domainInfo.getUnit(int(_loc14_.attributes["unitTypeId"])))));
                     break;
                  case "unitTrained":
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new TrainingCompletedPopUp(domainInfo.getUnit(int(_loc14_.attributes["unitTypeId"])),int(_loc14_.attributes["newLevel"]))));
               }
            }
            city.viralActions.length = 0;
         }
         if(userInfo.viralActions.length > 0)
         {
            for each(_loc14_ in userInfo.viralActions)
            {
               if(_loc14_.type == "questCompleted")
               {
                  _loc12_ = _loc14_.attributes["questDTO"] as QuestDTO;
                  _loc10_ = 0;
                  while(_loc10_ < userInfo.quests.length)
                  {
                     if(userInfo.quests[_loc10_].questId == _loc12_.questId && !userInfo.quests[_loc10_].claiming)
                     {
                        if(userInfo.autoClaimQuests)
                        {
                           dispatch(new OutgoingMessageEvent("outgoingMessage",new ClaimQuestRequest(userInfo.quests[_loc10_].questId)));
                        }
                        else
                        {
                           userInfo.quests[_loc10_].claiming = true;
                           dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileQuestCompletedPopup(userInfo.quests[_loc10_],facebookAPIManager.getUserNameByProfile(userInfo.profile,false))));
                        }
                        break;
                     }
                     _loc10_++;
                  }
               }
            }
            for each(_loc14_ in userInfo.viralActions)
            {
               if(_loc14_.type == "userLevelUp")
               {
                  if(userInfo.mandatoryTutorialCompleted)
                  {
                     dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileLevelupPopup(int(_loc14_.attributes["newLevel"]))));
                  }
               }
            }
            for each(_loc14_ in userInfo.viralActions)
            {
               if(_loc14_.type == "tournamentEnded")
               {
                  if("allianceRanking" in _loc14_.attributes && _loc14_.attributes["allianceRanking"] != null && "endTime" in _loc14_.attributes && _loc14_.attributes["endTime"] != null)
                  {
                     _loc2_ = int(_loc14_.attributes["allianceRanking"]);
                     _loc7_ = Number(_loc14_.attributes["endTime"]);
                     if(_loc2_ > 0 && !isNaN(_loc7_))
                     {
                        _loc8_ = "goldReward" in _loc14_.attributes ? Number(_loc14_.attributes["goldReward"]) : 0;
                        _loc3_ = "decorationGiftId" in _loc14_.attributes ? Number(_loc14_.attributes["decorationGiftId"]) : -1;
                        dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileTournamentEndedPopUp(_loc2_,_loc7_,_loc8_,_loc3_)));
                     }
                  }
               }
            }
            for each(_loc14_ in userInfo.viralActions)
            {
               if(_loc14_.type == "seasonEnded")
               {
                  if("leagueLevelId" in _loc14_.attributes && _loc14_.attributes["leagueLevelId"] != null && "position" in _loc14_.attributes && _loc14_.attributes["position"] != null && "seasonEndTime" in _loc14_.attributes && _loc14_.attributes["seasonEndTime"] != null)
                  {
                     _loc6_ = Number(_loc14_.attributes["leagueLevelId"]);
                     _loc1_ = int(_loc14_.attributes["position"]);
                     _loc11_ = Number(_loc14_.attributes["seasonEndTime"]);
                     _loc16_ = "leagueRewardRatio" in _loc14_.attributes ? Number(_loc14_.attributes["leagueRewardRatio"]) : 1;
                     _loc15_ = "leagueRewardType" in _loc14_.attributes ? _loc14_.attributes["leagueRewardType"] != "gold" : true;
                     if(!isNaN(_loc6_) && _loc1_ > 0 && !isNaN(_loc11_))
                     {
                        _loc5_ = Number("reward" in _loc14_.attributes && _loc14_.attributes["reward"] != null ? _loc14_.attributes["reward"] : NaN);
                        if(_loc1_ >= 1 && _loc1_ <= 3 && !isNaN(_loc5_))
                        {
                           dispatch(new PopUpWindowEvent("showPopUpWindow",new LeagueSeasonEndedSuccessPopUp(_loc6_,_loc1_,_loc11_,int(_loc5_ * _loc16_),_loc15_)));
                        }
                        else
                        {
                           dispatch(new PopUpWindowEvent("showPopUpWindow",new LeagueSeasonEndedPopUp(_loc6_,_loc1_,_loc11_)));
                        }
                     }
                  }
               }
               else if(_loc14_.type == "userIsPlacedIntoALeague")
               {
                  if("leagueLevelId" in _loc14_.attributes && _loc14_.attributes["leagueLevelId"] != null && "firstTime" in _loc14_.attributes && _loc14_.attributes["firstTime"] != null)
                  {
                     _loc6_ = Number(_loc14_.attributes["leagueLevelId"]);
                     _loc13_ = Boolean(_loc14_.attributes["firstTime"]);
                     if(!isNaN(_loc6_))
                     {
                        _loc9_ = domainInfo.getLeagueLevel(_loc6_);
                        if(_loc9_ != null)
                        {
                           if(_loc13_)
                           {
                              dispatch(new PopUpWindowEvent("showPopUpWindow",new LeagueStatusPlacedPopUp(_loc9_)));
                           }
                           else
                           {
                              dispatch(new PopUpWindowEvent("showPopUpWindow",new LeagueStatusChangedPopUp(_loc9_)));
                           }
                        }
                     }
                  }
               }
               else if(_loc14_.type == "userIsRemovedFromLeague")
               {
                  dispatch(new PopUpWindowEvent("showPopUpWindow",new LeagueStatusDroppedPopUp()));
               }
            }
            userInfo.viralActions.length = 0;
         }
      }
      
      private function executeRepairSpecificActionsAndToolMenuEnabling(param1:CityInfoDTO) : void
      {
         var _loc7_:BuildingTypeDIO = null;
         var _loc6_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc4_:Number = 0;
         var _loc3_:Dictionary = getBuildingsWithRepairJobs(param1);
         var _loc10_:Boolean = false;
         userInfo.toolMenuEnabled = false;
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_ && _loc2_.buildingTypeId == 10 && _loc2_.level >= 5)
            {
               userInfo.toolMenuEnabled = true;
            }
            if(_loc2_.instanceId in _loc3_)
            {
               _loc4_ += _loc3_[_loc2_.instanceId] / 1000;
            }
            else
            {
               _loc7_ = domainInfo.getBuilding(_loc2_.buildingTypeId);
               if(!_loc7_.isHealthy(_loc2_.level,_loc2_.healthPoint))
               {
                  _loc6_ = _loc2_.level > 0 ? _loc2_.level - 1 : 0;
                  _loc8_ = _loc7_.healthPointsPerLevel[_loc6_];
                  _loc9_ = (_loc8_ - _loc2_.healthPoint) / _loc8_ * _loc7_.repairDurationsPerLevel[_loc6_];
                  if(_loc9_ > 0)
                  {
                     _loc10_ = true;
                  }
                  log(WomLoggerContexts.GAME,"Repair duration for " + _loc2_.instanceId + " " + _loc9_);
                  _loc4_ += _loc9_;
               }
            }
         }
         var _loc5_:int = StoreUtil.buildingPrice(0,_loc4_ / userInfo.serverSpeed);
         if(_loc10_)
         {
            if(!userInfo.mandatoryTutorialCompleted && userInfo.numberOfGolds > _loc5_)
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2008)));
            }
            else
            {
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileRepairNewPopUp(1,_loc5_)));
            }
         }
         else if(_loc4_ > 0)
         {
            if(!userInfo.mandatoryTutorialCompleted && userInfo.numberOfGolds > _loc5_)
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2008)));
            }
            else if(!userInfo.repairPopupShown)
            {
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileRepairNewPopUp(1,_loc5_)));
            }
         }
         else if(userInfo.receivedOfflineAttack && !userInfo.repairPopupShown)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileRepairNewPopUp(2)));
         }
      }
      
      private function getBuildingsWithRepairJobs(param1:CityInfoDTO) : Dictionary
      {
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc2_ in param1.repairBuildingJobs)
         {
            _loc3_[_loc2_.instanceId] = _loc2_.durationRemaining;
         }
         return _loc3_;
      }
      
      private function triggerTutorial() : void
      {
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      private function enableTutorial() : void
      {
         var _loc5_:TutorialInfo = null;
         var _loc11_:int = 0;
         var _loc9_:QuestInfo = null;
         var _loc8_:TaskDTO = null;
         var _loc1_:int = 0;
         var _loc7_:TutorialState = null;
         var _loc2_:Number = NaN;
         var _loc6_:BuildingInfo = null;
         var _loc4_:Boolean = false;
         if(userInfo.tutorialsInfo.enabled)
         {
            _loc5_ = "bed" in userInfo.tutorialsInfo.tutorials ? userInfo.tutorialsInfo.tutorials["bed"] : null;
            if(_loc5_ != null)
            {
               _loc11_ = int(_loc5_.states[0].additionalInfo["questId"]);
               if(!(_loc11_ in userInfo.claimedQuestIds))
               {
                  _loc9_ = QuestUtil.getQuest(userInfo.quests,_loc11_);
                  if(_loc9_ != null && !_loc9_.completed)
                  {
                     _loc8_ = QuestUtil.getTask(_loc9_.tasks,_loc5_.states[0].additionalInfo["taskId"]);
                     if(_loc8_ != null && !_loc8_.completed && !_loc8_.skipped)
                     {
                        _loc7_ = _loc5_.states[_loc5_.states[0].additionalInfo["stateIndexHireUnit"]];
                        _loc1_ = int(_loc7_.additionalInfo["unitTypeId"]);
                        _loc2_ = _loc8_.progressValue;
                        _loc6_ = BuildingInfoUtil.getBuildingByBuildingTypeId(city.buildings,21);
                        _loc4_ = _loc6_ != null && _loc6_.level > 0;
                        for each(var _loc10_ in city.hiringInfoDictionary)
                        {
                           if(_loc10_.activeHiring != null && _loc10_.activeHiring.unitTypeId == _loc1_)
                           {
                              _loc2_ += 1;
                           }
                           if(_loc10_.hiringQueue != null && _loc10_.hiringQueue.hiringSlots != null)
                           {
                              for each(var _loc3_ in _loc10_.hiringQueue.hiringSlots)
                              {
                                 if(_loc3_.unitId == _loc1_)
                                 {
                                    _loc2_ += _loc3_.numberOfUnits;
                                 }
                              }
                           }
                           if(_loc4_)
                           {
                              break;
                           }
                        }
                        _loc7_.additionalInfo["progress"] = _loc2_;
                        if(_loc2_ < _loc7_.additionalInfo["amountOfUnits"])
                        {
                           _loc5_.currentStateIndex = 0;
                        }
                     }
                  }
               }
            }
            dispatch(new TutorialEvent("enableTutorials"));
         }
      }
      
      private function checkOfflineReceivedHelps() : void
      {
         var _loc4_:Dictionary = new Dictionary();
         var _loc2_:int = 0;
         for(var _loc5_ in userInfo.helps)
         {
            _loc4_[_loc5_] = new Vector.<HelpInfo>();
            for each(var _loc3_ in userInfo.helps[_loc5_])
            {
               for each(var _loc1_ in city.buildings)
               {
                  if(_loc1_.instanceId == _loc3_.buildingInstanceId)
                  {
                     _loc3_.buildingTypeId = _loc1_.buildingTypeId;
                     break;
                  }
               }
               _loc4_[_loc5_].push(_loc3_.clone());
            }
            userInfo.helps[_loc5_].length = 0;
            delete userInfo.helps[_loc5_];
            _loc2_++;
         }
         if(userInfo.mandatoryTutorialCompleted)
         {
            if(_loc2_ > 0)
            {
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileHelpedFriendPopUp(_loc4_)));
            }
            if(userInfo.offlineFriendWatchpostHelps)
            {
               if(userInfo.offlineFriendWatchpostHelps.helpedFriends.length > 0)
               {
                  dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFriendWatchpostHelpPopUp(userInfo.offlineFriendWatchpostHelps)));
                  userInfo.offlineFriendWatchpostHelps = null;
               }
            }
         }
      }
   }
}

