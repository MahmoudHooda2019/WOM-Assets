package wom.controller.command.city
{
   import flash.utils.Dictionary;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.serialization.json.PJSON;
   import wom.controller.PCommand;
   import wom.controller.command.util.InventoryUtil;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.alliance.RetrieveAllianceInvitationsEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.dto.QuestDTO;
   import wom.model.dto.QuestRewardDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.attack.CatapultTimeUtil;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.defense.NPCAttackStatus;
   import wom.model.game.gold.GoldGift;
   import wom.model.game.help.HelpInfo;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.game.league.LeagueInfo;
   import wom.model.game.league.LeagueManager;
   import wom.model.game.league.LeagueSeasonInfo;
   import wom.model.game.quest.QuestInfo;
   import wom.model.game.quest.QuestRewardType;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.tavern.TavernInfo;
   import wom.model.game.tutorial.TutorialInfo;
   import wom.model.game.tutorial.TutorialListInfo;
   import wom.model.message.response.UserStatusResponse;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class HandleUserStatusResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      [Inject]
      public var tavernInfo:TavernInfo;
      
      public function HandleUserStatusResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc5_:LeagueLevelDIO = null;
         var _loc10_:int = 0;
         var _loc7_:BeastTypeDIO = null;
         var _loc1_:UserStatusResponse = messageReceivedEvent.message as UserStatusResponse;
         var _loc4_:Vector.<InventoryItemDTO> = InventoryUtil.createItemsList(domainInfo,city,_loc1_.partAmounts,_loc1_.resourceGifts,_loc1_.unitGifts,_loc1_.decorationGifts);
         var _loc11_:Boolean = false;
         var _loc6_:Vector.<QuestInfo> = new Vector.<QuestInfo>();
         for each(var _loc8_ in _loc1_.quests)
         {
            if(_loc8_.completed)
            {
               _loc11_ = true;
            }
            for each(var _loc3_ in _loc8_.rewards)
            {
               switch(_loc3_.rewardType)
               {
                  case QuestRewardType.QRT_UNIT:
                     _loc3_.visualId = domainInfo.getUnit(_loc3_.subTypeId).assetName + "QR";
                     break;
                  case QuestRewardType.QRT_RESOURCE:
                     _loc3_.visualId = ResourceType.determineResourceType(_loc3_.subTypeId).iconAssetName;
                     break;
                  case QuestRewardType.QRT_GOLD:
                     _loc3_.visualId = "Gold";
                     break;
                  case QuestRewardType.QRT_XP:
                     _loc3_.visualId = "ExperienceStar";
               }
            }
            _loc6_.push(new QuestInfo(_loc8_.questId,_loc8_.order,_loc8_.family,_loc8_.rewards,_loc8_.visualId,_loc8_.completed,_loc8_.tasks,false,false));
         }
         userInfo.helpCountDictionary = _loc1_.helpCountDictionary;
         userInfo.helpedBuildingsDictionary = _loc1_.helpedBuildingsDictionary;
         userInfo.items = _loc4_;
         userInfo.resourceGifts = _loc1_.resourceGifts;
         userInfo.numberOfGolds = _loc1_.numberOfGolds;
         userInfo.quests = _loc6_;
         userInfo.claimedQuestIds = _loc1_.claimedQuestIds;
         userInfo.reconPoints = _loc1_.reconPoints;
         userInfo.experiencePoints = _loc1_.experiencePoints;
         userInfo.eventPoints = _loc1_.eventPoints;
         userInfo.battlePoints = _loc1_.battlePoints;
         userInfo.unlockedEventItems = _loc1_.unlockedEventItems;
         userInfo.stockpileBoostCount = _loc1_.stockpileBoostCount;
         userInfo.storeItemCooldownDurations = _loc1_.storeItemCooldownDurations;
         userInfo.storeItemEffects = _loc1_.storeItemEffects;
         userInfo.subscribedActions = _loc1_.subscribedActions;
         userInfo.viralActions = _loc1_.viralActions;
         userInfo.remainingDurationToNextNPCAttack = _loc1_.remainingDurationToNextNPCAttack;
         userInfo.npcDurationSaveTime = new Date().getTime();
         userInfo.npcAttackDelayed = _loc1_.isNPCAttackDelayed;
         userInfo.mandatoryTutorialCompleted = userInfo.canReceiveNPCAttacks = _loc1_.mandatoryTutorialCompleted;
         userInfo.lastLogoutTime = _loc1_.lastLogoutTime;
         userInfo.catapultActivationRemainingTimes = CatapultTimeUtil.calculateCatapultRemainingTimes(userInfo.catapultActivationRemainingTimes,_loc1_.lastCatapultFiredTimes);
         userInfo.eventStartTime = _loc1_.eventStartTime;
         userInfo.eventEndTime = _loc1_.eventEndTime;
         userInfo.eventStoreEndTime = _loc1_.eventStoreEndTime;
         userInfo.friendWatchPostInfos = _loc1_.friendWatchPosts;
         userInfo.receivedOfflineAttack = _loc1_.receivedOfflineAttack;
         userInfo.offlineFriendWatchpostHelps = _loc1_.offlineFriendWatchpostHelps;
         userInfo.offlineFriendWatchpostHelps = _loc1_.offlineFriendWatchpostHelps;
         userInfo.tournamentNextAttackRemainingDuration = _loc1_.tournamentNextAttackRemainingDuration;
         userInfo.tournamentRemainingDuration = _loc1_.tournamentRemainingDuration;
         userInfo.tournamentStartRemainingDuration = _loc1_.tournamentStartRemainingDuration;
         allianceInfo.myAllianceSummary = _loc1_.allianceSummary;
         allianceInfo.requestedAllianceIds = _loc1_.requestedAllianceIds;
         tavernInfo.freeSpinCount = _loc1_.pastTavernFreeSpinCount;
         tavernInfo.paidSpinCount = _loc1_.pastTavernPaidSpinCount;
         documentConfiguration.setParameter("allianceName",null);
         log(WomLoggerContexts.GAME,"Can receive NPC attacks : " + userInfo.canReceiveNPCAttacks);
         log(WomLoggerContexts.GAME,"Remaining duration to next NPC attack : " + userInfo.remainingDurationToNextNPCAttack);
         log(WomLoggerContexts.GAME,"Formatted : " + LocalizedDateTimeUtil.getUserFriendlyTime(Math.abs(userInfo.remainingDurationToNextNPCAttack)));
         log(WomLoggerContexts.GAME,"NPC attack delayed : " + userInfo.npcAttackDelayed);
         if(userInfo.remainingDurationToNextNPCAttack < 300000 && userInfo.npcAttackDelayed)
         {
            userInfo.npcAttackStatus = NPCAttackStatus.DELAY;
         }
         else
         {
            userInfo.npcAttackStatus = NPCAttackStatus.WAIT;
         }
         userInfo.gameMode = GameModeType.NORMAL;
         fillTutorialCompletionStatus(_loc1_);
         fillOfflineReceivedHelps(_loc1_.offlineReceivedHelps);
         fillOfflineReceivedGoldGifts(_loc1_.offlineReceivedGoldGifts);
         if(!isNaN(_loc1_.leagueLevelId) && !isNaN(_loc1_.leagueRemainingSeasonDuration))
         {
            _loc5_ = domainInfo.getLeagueLevel(_loc1_.leagueLevelId);
            if(_loc5_ != null)
            {
               leagueManager.myLeague = new LeagueInfo(new LeagueSeasonInfo(_loc1_.leagueRemainingSeasonDuration),_loc5_,_loc1_.leagueRpReward,_loc1_.leagueRewardRatio);
               dispatch(new ModelUpdateEvent("leagueStatusUpdated"));
            }
         }
         tavernInfo.tillNextSpin = _loc1_.tillNextSpin;
         _loc10_ = 0;
         while(_loc10_ < 6)
         {
            tavernInfo.unlockedCards[_loc10_] = _loc1_.unlockedTavernCards[_loc10_];
            _loc10_++;
         }
         var _loc9_:Boolean = false;
         for each(var _loc2_ in _loc1_.unlockedExtraBeastIds)
         {
            _loc7_ = domainInfo.getBeast(_loc2_);
            if(_loc7_ != null)
            {
               _loc7_.unlocked = true;
               _loc9_ = true;
            }
         }
         if(_loc9_)
         {
            dispatch(new ModelUpdateEvent("beastUpdated"));
         }
         dispatch(new ModelUpdateEvent("friendsUpdated"));
         dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
         dispatch(new ModelUpdateEvent("goldAmountUpdated"));
         dispatch(new ModelUpdateEvent("reconPoinrsUpdated"));
         dispatch(new ModelUpdateEvent("experiencePointsUpdated"));
         dispatch(new ModelUpdateEvent("battlePointsUpdated"));
         dispatch(new ModelUpdateEvent("goldAmountUpdated"));
         dispatch(new ModelUpdateEvent("stockpileBoostCountChanged"));
         dispatch(new ModelUpdateEvent("storeItemCooldownDurationsUpdated"));
         dispatch(new ModelUpdateEvent("storeItemEffectsUpdated"));
         dispatch(new ModelUpdateEvent("eventItemsUpdated"));
         dispatch(new GameTickEvent("start"));
         dispatch(new TutorialEvent("mandatoryTutorialsCompletionChanged"));
         dispatch(new RetrieveAllianceInvitationsEvent("retrieveAllianceInvitations",_loc1_.allianceInvitations));
         dispatch(new MobileExternalInterfaceEvent("retrieveFriends"));
      }
      
      private function fillTutorialCompletionStatus(param1:UserStatusResponse) : void
      {
         var _loc9_:Object = null;
         var _loc3_:TutorialListInfo = null;
         var _loc7_:Object = null;
         var _loc5_:Dictionary = null;
         var _loc6_:TutorialInfo = null;
         if(param1.tutorial)
         {
            log(LoggerContexts.INFRASTRUCTURE,"tutorial: " + param1.tutorial);
            _loc9_ = PJSON.decode(param1.tutorial);
            _loc3_ = userInfo.tutorialsInfo;
            _loc3_.enabled = "enabled" in _loc9_ && _loc9_["enabled"];
            if("additionalInfo" in _loc9_)
            {
               _loc7_ = _loc9_["additionalInfo"];
               _loc3_.additionalInfo.tempVar1 = "tempVar1" in _loc7_ && _loc7_["tempVar1"];
               _loc3_.additionalInfo.firstNpcBattle = "firstNpcBattle" in _loc7_ && _loc7_["firstNpcBattle"];
               _loc3_.additionalInfo.firstPvPBattle = "firstPvPBattle" in _loc7_ && _loc7_["firstPvPBattle"];
               _loc3_.additionalInfo.beastCageStatus = _loc7_["beastCageStatus"];
            }
            if("tutorials" in _loc9_)
            {
               _loc5_ = new Dictionary();
               for each(var _loc8_ in _loc9_.tutorials)
               {
                  _loc5_[_loc8_.id] = _loc8_;
               }
               for(var _loc2_ in _loc3_.tutorials)
               {
                  _loc6_ = _loc3_.tutorials[_loc2_];
                  if(_loc6_.tutorialId in _loc5_)
                  {
                     _loc6_.isCompleted = _loc5_[_loc6_.tutorialId].isCompleted;
                     if(!_loc6_.isCompleted)
                     {
                        _loc6_.currentStateIndex = _loc5_[_loc6_.tutorialId].currentStateIndex;
                        for each(var _loc4_ in _loc5_[_loc6_.tutorialId].states)
                        {
                           for each(_loc7_ in _loc4_.additionalInfo)
                           {
                              _loc6_.states[_loc4_.index].additionalInfo[_loc7_.key] = _loc7_.val;
                           }
                        }
                     }
                  }
               }
            }
            else
            {
               log(LoggerContexts.UNEXPECTED,"Tutorial array could not be found when decoding tutorials");
            }
         }
         userInfo.autoClaimQuests = !(70 in userInfo.claimedQuestIds);
         if(!userInfo.mandatoryTutorialCompleted)
         {
            for(var _loc10_ in userInfo.claimedQuestIds)
            {
               if(int(_loc10_) > 70)
               {
                  dispatch(new TutorialEvent("setMandatoryTutorialsCompleted"));
                  break;
               }
            }
         }
      }
      
      private function fillOfflineReceivedHelps(param1:Vector.<HelpInfo>) : void
      {
         for each(var _loc2_ in param1)
         {
            if(!(_loc2_.helper.gameId in userInfo.helps))
            {
               userInfo.helps[_loc2_.helper.gameId] = new Vector.<HelpInfo>();
            }
            userInfo.helps[_loc2_.helper.gameId].push(_loc2_);
         }
      }
      
      private function fillOfflineReceivedGoldGifts(param1:Vector.<GoldGift>) : void
      {
         var _loc3_:Boolean = false;
         for each(var _loc4_ in param1)
         {
            _loc3_ = false;
            for each(var _loc2_ in userInfo.offlineReceivedGoldGifts)
            {
               if(_loc2_.sender.toString() == _loc4_.sender.toString())
               {
                  _loc2_.amountOfGold += _loc4_.amountOfGold;
                  _loc3_ = true;
               }
            }
            if(!_loc3_)
            {
               userInfo.offlineReceivedGoldGifts.push(_loc4_);
            }
         }
      }
   }
}

