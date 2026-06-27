package wom.model.message.response
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.DecorationTypeAmountDTO;
   import wom.model.dto.FriendWatchPostInfo;
   import wom.model.dto.PartInfoDTO;
   import wom.model.dto.QuestDTO;
   import wom.model.dto.UnitTypeAmountBatchDTO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.alliance.AllianceInvitationInfo;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.attack.CatapultTimeUtil;
   import wom.model.game.gold.GoldGift;
   import wom.model.game.help.HelpInfo;
   import wom.model.game.inventory.ResourceGiftDTO;
   import wom.model.game.store.ItemCooldownDurationInfo;
   import wom.model.game.store.ItemEffectInfo;
   import wom.model.game.store.ItemEffectType;
   import wom.model.game.viral.ViralAction;
   import wom.model.game.watchpost.WatchpostHelpInfo;
   import wom.model.game.watchpost.WatchpostHelpedFriendDTO;
   import wom.model.message.notification.FriendWatchpostHelpNotification;
   import wom.model.message.util.AllianceDeserializeUtil;
   import wom.model.message.util.CoatOfArmsDeserializeUtil;
   import wom.model.message.util.QuestDeserializeUtil;
   import wom.model.message.util.ViralActionDeserializeUtil;
   
   public class UserStatusResponse extends AbstractIncomingMessage
   {
      
      private var _resourceGifts:Vector.<ResourceGiftDTO>;
      
      private var _partAmounts:Vector.<PartInfoDTO>;
      
      private var _numberOfGolds:int;
      
      private var _quests:Vector.<QuestDTO>;
      
      private var _reconPoints:int;
      
      private var _experiencePoints:Number;
      
      private var _eventPoints:int;
      
      private var _battlePoints:int;
      
      private var _unlockedEventItems:Vector.<int>;
      
      private var _storeItemEffects:Vector.<ItemEffectInfo>;
      
      private var _storeItemCooldownDurations:Dictionary;
      
      private var _stockpileBoostCount:int;
      
      private var _serverSpeed:int;
      
      private var _subscribedActions:Vector.<int>;
      
      private var _viralActions:Vector.<ViralAction>;
      
      private var _helpCountDictionary:Dictionary;
      
      private var _helpedBuildingsDictionary:Dictionary;
      
      private var _tutorial:String;
      
      private var _remainingDurationToNextNPCAttack:Number;
      
      private var _isNPCAttackDelayed:Boolean;
      
      private var _offlineReceivedHelps:Vector.<HelpInfo>;
      
      private var _mandatoryTutorialCompleted:Boolean;
      
      private var _claimedQuestIds:Dictionary;
      
      private var _lastLogoutTime:Number;
      
      private var _lastCatapultFiredTimes:Dictionary;
      
      private var _offlineReceivedGoldGifts:Vector.<GoldGift>;
      
      private var _allianceSummary:AllianceSummaryInfo;
      
      private var _requestedAllianceIds:Dictionary;
      
      private var _allianceInvitations:Vector.<AllianceInvitationInfo>;
      
      private var _eventStartTime:Number;
      
      private var _eventEndTime:Number;
      
      private var _eventStoreEndTime:Number;
      
      private var _leagueLevelId:Number = NaN;
      
      private var _leagueRpReward:Boolean;
      
      private var _leagueRewardRatio:Number = 1;
      
      private var _leagueRemainingSeasonDuration:Number = NaN;
      
      private var _friendWatchPosts:Dictionary;
      
      private var _receivedOfflineAttack:Boolean;
      
      private var _offlineFriendWatchpostHelps:WatchpostHelpInfo;
      
      private var _tillNextSpin:Number;
      
      private var _unlockedTavernCards:Vector.<Boolean>;
      
      private var _unlockedExtraBeastIds:Vector.<int>;
      
      private var _unitGifts:Vector.<UnitTypeAmountBatchDTO>;
      
      private var _decorationGifts:Vector.<DecorationTypeAmountDTO>;
      
      private var _pastTavernPaidSpinCount:int;
      
      private var _pastTavernFreeSpinCount:int;
      
      private var _tournamentNextAttackRemainingDuration:Number;
      
      private var _tournamentRemainingDuration:Number;
      
      private var _tournamentStartRemainingDuration:Number;
      
      public function UserStatusResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc17_:String = null;
         var _loc27_:ItemEffectType = null;
         var _loc11_:GoldGift = null;
         var _loc22_:int = 0;
         var _loc16_:Object = param1.status;
         var _loc26_:Object = param1.raceStatus;
         _serverSpeed = _loc16_.serverSpeed;
         _numberOfGolds = _loc16_.numberOfGolds;
         _reconPoints = _loc16_.reconPoints;
         _experiencePoints = _loc16_.experiencePoints;
         _eventPoints = _loc16_.eventPoints;
         _battlePoints = _loc16_.battlePoints;
         _remainingDurationToNextNPCAttack = _loc16_.remainingDurationToNextNPCAttack;
         _isNPCAttackDelayed = _loc16_.npcattackDelayed;
         _mandatoryTutorialCompleted = _loc16_.mandatoryTutorialCompleted;
         _receivedOfflineAttack = _loc16_.receivedAttackOffline;
         _tournamentNextAttackRemainingDuration = _loc16_.rdtnta;
         _tournamentRemainingDuration = _loc16_.tournamentRemainingDur;
         _tournamentStartRemainingDuration = _loc16_.tournamentStartRemainingDur;
         _eventStartTime = _loc26_ ? _loc26_.raceStartDuration : -1;
         _eventEndTime = _loc26_ ? _loc26_.raceEndDuration : -1;
         _eventStoreEndTime = _loc26_ ? _loc26_.storeEndDuration : -1;
         _friendWatchPosts = new Dictionary();
         for each(var _loc3_ in _loc16_.friendWatchPosts)
         {
            _friendWatchPosts[_loc3_.userId] = new FriendWatchPostInfo(_loc3_.level,_loc3_.availableCapacity);
         }
         _helpCountDictionary = new Dictionary();
         for each(var _loc2_ in _loc16_.helpCounts)
         {
            _loc17_ = "npcName" in _loc2_ && _loc2_.npcName != null ? _loc2_.npcName : _loc2_.gameUid;
            _helpCountDictionary[_loc17_] = _loc2_.count;
         }
         _helpedBuildingsDictionary = new Dictionary();
         for each(var _loc10_ in _loc16_.helpedBuildings)
         {
            _loc17_ = "npcName" in _loc10_ && _loc10_.npcName != null ? _loc10_.npcName : _loc10_.gameUid;
            if(!(_loc17_ in _helpedBuildingsDictionary))
            {
               _helpedBuildingsDictionary[_loc17_] = new Dictionary();
            }
            _helpedBuildingsDictionary[_loc17_][_loc10_.instanceId] = true;
         }
         _partAmounts = new Vector.<PartInfoDTO>();
         for(var _loc8_ in _loc16_.partAmounts)
         {
            _partAmounts.push(new PartInfoDTO(_loc8_,"",_loc16_.partAmounts[_loc8_]));
         }
         _unlockedEventItems = new Vector.<int>();
         for each(var _loc18_ in _loc16_.unlockedRaceItems)
         {
            _unlockedEventItems.push(_loc18_);
         }
         _resourceGifts = new Vector.<ResourceGiftDTO>();
         for each(var _loc24_ in _loc16_.resourceGifts)
         {
            _resourceGifts.push(new ResourceGiftDTO(_loc24_.info.id,_loc24_.info.resourceGiftAmountType,_loc24_.amount));
         }
         _quests = new Vector.<QuestDTO>();
         for each(var _loc7_ in _loc16_.visibleQuests)
         {
            _quests.push(QuestDeserializeUtil.createQuestDTO(_loc7_));
         }
         _claimedQuestIds = new Dictionary();
         if("claimedQuests" in _loc16_)
         {
            for each(var _loc20_ in _loc16_.claimedQuests)
            {
               _claimedQuestIds[int(_loc20_)] = true;
            }
         }
         var _loc21_:Object = _loc16_.itemInventory;
         _stockpileBoostCount = _loc21_.stockPileBoostCount;
         _storeItemEffects = new Vector.<ItemEffectInfo>();
         for each(var _loc12_ in _loc21_.effects)
         {
            _loc27_ = ItemEffectType.determineItemEffectType(_loc12_.itemEffectType);
            _storeItemEffects.push(new ItemEffectInfo(_loc27_,_loc12_.bonusPercent,_loc12_.dateStartedUsing,_loc12_.dateEndOfUsage,_loc12_.remainingDuration));
         }
         _storeItemCooldownDurations = new Dictionary();
         for each(var _loc5_ in _loc21_.cooldownDurations)
         {
            _storeItemCooldownDurations[_loc5_.itemId] = new ItemCooldownDurationInfo(_loc5_.itemId,_loc5_.cooldownDuration);
         }
         _subscribedActions = new Vector.<int>();
         for each(var _loc4_ in _loc16_.subscribedActions)
         {
            _subscribedActions.push(_loc4_);
         }
         var _loc13_:Vector.<WatchpostHelpedFriendDTO> = new Vector.<WatchpostHelpedFriendDTO>();
         _viralActions = new Vector.<ViralAction>();
         for each(var _loc15_ in _loc16_.viralActions)
         {
            if(_loc15_.type == "friendWatchPostHelped")
            {
               FriendWatchpostHelpNotification.deserializeHelpedFriend(_loc15_,_loc13_);
            }
            else
            {
               _viralActions.push(ViralActionDeserializeUtil.createViralAction(_loc15_));
            }
         }
         _offlineFriendWatchpostHelps = new WatchpostHelpInfo(_loc13_);
         _tutorial = "tutorial" in _loc16_ ? _loc16_.tutorial : null;
         _offlineReceivedHelps = new Vector.<HelpInfo>();
         if("offlineReceivedHelps" in _loc16_)
         {
            for each(var _loc19_ in _loc16_.offlineReceivedHelps)
            {
               _offlineReceivedHelps.push(HelpInfo.createHelpInfo(_loc19_));
            }
         }
         _lastLogoutTime = _loc16_.lastLogoutTime;
         _lastCatapultFiredTimes = CatapultTimeUtil.deserializeCatapultTimes(_loc16_.lastCatapultFiredTimes);
         _offlineReceivedGoldGifts = new Vector.<GoldGift>();
         if("offlineReceivedGoldGifts" in _loc16_)
         {
            for each(var _loc6_ in _loc16_.offlineReceivedGoldGifts)
            {
               _loc11_ = GoldGift.createGoldGift(_loc6_);
               if(_loc11_ != null)
               {
                  _offlineReceivedGoldGifts.push(_loc11_);
               }
            }
         }
         _allianceSummary = AllianceDeserializeUtil.deserializeAllianceSummary(_loc16_.alliance);
         _requestedAllianceIds = AllianceDeserializeUtil.deserializeRequestedAlliances(_loc16_);
         _allianceInvitations = new Vector.<AllianceInvitationInfo>();
         if("allianceInvitations" in _loc16_ && _loc16_.allianceInvitations != null)
         {
            for each(var _loc14_ in _loc16_.allianceInvitations)
            {
               _allianceInvitations.push(new AllianceInvitationInfo(_loc14_.allianceId,_loc14_.allianceName,CoatOfArmsDeserializeUtil.createCoatOfArmsInfo(_loc14_.coa)));
            }
         }
         if("leagueLevelId" in _loc16_ && _loc16_.leagueLevelId != null && "remainingSeasonDuration" in _loc16_ && _loc16_.remainingSeasonDuration != null)
         {
            _leagueLevelId = _loc16_.leagueLevelId;
            _leagueRemainingSeasonDuration = _loc16_.remainingSeasonDuration;
         }
         if("leagueRewardType" in _loc16_ && _loc16_.leagueRewardType != null)
         {
            _leagueRpReward = _loc16_.leagueRewardType != "gold";
         }
         if("leagueRewardRatio" in _loc16_ && _loc16_.leagueRewardRatio != null)
         {
            _leagueRewardRatio = _loc16_.leagueRewardRatio;
         }
         _tillNextSpin = "tillNextSpin" in _loc16_ && _loc16_.tillNextSpin != null ? Number(_loc16_.tillNextSpin) : 0;
         _unlockedTavernCards = new Vector.<Boolean>(6,true);
         if("unlockedTavernCards" in _loc16_ && _loc16_.unlockedTavernCards != null)
         {
            _loc22_ = 0;
            while(_loc22_ < 6 && _loc22_ < _loc16_.unlockedTavernCards.length)
            {
               _unlockedTavernCards[_loc22_] = _loc16_.unlockedTavernCards[_loc22_];
               _loc22_++;
            }
         }
         _unlockedExtraBeastIds = new Vector.<int>();
         if("unlockedExtraBeastIds" in _loc16_ && _loc16_.unlockedExtraBeastIds != null)
         {
            for each(var _loc25_ in _loc16_.unlockedExtraBeastIds)
            {
               _unlockedExtraBeastIds.push(int(_loc25_));
            }
         }
         _unitGifts = new Vector.<UnitTypeAmountBatchDTO>();
         for each(var _loc23_ in _loc16_.unitGifts)
         {
            _unitGifts.push(new UnitTypeAmountBatchDTO(UnitTypeAmountDTO.deserialize(_loc23_.info),int(_loc23_.amount)));
         }
         _decorationGifts = new Vector.<DecorationTypeAmountDTO>();
         for each(var _loc9_ in _loc16_.decorationGifts)
         {
            _decorationGifts.push(DecorationTypeAmountDTO.deserialize(_loc9_));
         }
         _pastTavernPaidSpinCount = _loc16_.paidSpinCount;
         _pastTavernFreeSpinCount = _loc16_.freeSpinCount;
      }
      
      public function get partAmounts() : Vector.<PartInfoDTO>
      {
         return _partAmounts;
      }
      
      public function get numberOfGolds() : int
      {
         return _numberOfGolds;
      }
      
      public function get quests() : Vector.<QuestDTO>
      {
         return _quests;
      }
      
      public function get reconPoints() : int
      {
         return _reconPoints;
      }
      
      public function get experiencePoints() : Number
      {
         return _experiencePoints;
      }
      
      public function get eventPoints() : int
      {
         return _eventPoints;
      }
      
      public function get battlePoints() : int
      {
         return _battlePoints;
      }
      
      public function get unlockedEventItems() : Vector.<int>
      {
         return _unlockedEventItems;
      }
      
      public function get storeItemEffects() : Vector.<ItemEffectInfo>
      {
         return _storeItemEffects;
      }
      
      public function get storeItemCooldownDurations() : Dictionary
      {
         return _storeItemCooldownDurations;
      }
      
      public function get stockpileBoostCount() : int
      {
         return _stockpileBoostCount;
      }
      
      public function get subscribedActions() : Vector.<int>
      {
         return _subscribedActions;
      }
      
      public function get viralActions() : Vector.<ViralAction>
      {
         return _viralActions;
      }
      
      public function get serverSpeed() : int
      {
         return _serverSpeed;
      }
      
      public function get resourceGifts() : Vector.<ResourceGiftDTO>
      {
         return _resourceGifts;
      }
      
      public function get helpCountDictionary() : Dictionary
      {
         return _helpCountDictionary;
      }
      
      public function get helpedBuildingsDictionary() : Dictionary
      {
         return _helpedBuildingsDictionary;
      }
      
      public function get tutorial() : String
      {
         return _tutorial;
      }
      
      public function get remainingDurationToNextNPCAttack() : Number
      {
         return _remainingDurationToNextNPCAttack;
      }
      
      public function get isNPCAttackDelayed() : Boolean
      {
         return _isNPCAttackDelayed;
      }
      
      public function get offlineReceivedHelps() : Vector.<HelpInfo>
      {
         return _offlineReceivedHelps;
      }
      
      public function get mandatoryTutorialCompleted() : Boolean
      {
         return _mandatoryTutorialCompleted;
      }
      
      public function get claimedQuestIds() : Dictionary
      {
         return _claimedQuestIds;
      }
      
      public function get lastLogoutTime() : Number
      {
         return _lastLogoutTime;
      }
      
      public function get lastCatapultFiredTimes() : Dictionary
      {
         return _lastCatapultFiredTimes;
      }
      
      public function get offlineReceivedGoldGifts() : Vector.<GoldGift>
      {
         return _offlineReceivedGoldGifts;
      }
      
      public function get allianceSummary() : AllianceSummaryInfo
      {
         return _allianceSummary;
      }
      
      public function get requestedAllianceIds() : Dictionary
      {
         return _requestedAllianceIds;
      }
      
      public function get allianceInvitations() : Vector.<AllianceInvitationInfo>
      {
         return _allianceInvitations;
      }
      
      public function get eventStartTime() : Number
      {
         return _eventStartTime;
      }
      
      public function get eventEndTime() : Number
      {
         return _eventEndTime;
      }
      
      public function get eventStoreEndTime() : Number
      {
         return _eventStoreEndTime;
      }
      
      public function get leagueLevelId() : Number
      {
         return _leagueLevelId;
      }
      
      public function get leagueRemainingSeasonDuration() : Number
      {
         return _leagueRemainingSeasonDuration;
      }
      
      public function get friendWatchPosts() : Dictionary
      {
         return _friendWatchPosts;
      }
      
      public function get receivedOfflineAttack() : Boolean
      {
         return _receivedOfflineAttack;
      }
      
      public function get offlineFriendWatchpostHelps() : WatchpostHelpInfo
      {
         return _offlineFriendWatchpostHelps;
      }
      
      public function get tillNextSpin() : Number
      {
         return _tillNextSpin;
      }
      
      public function get unlockedTavernCards() : Vector.<Boolean>
      {
         return _unlockedTavernCards;
      }
      
      public function get unlockedExtraBeastIds() : Vector.<int>
      {
         return _unlockedExtraBeastIds;
      }
      
      public function get unitGifts() : Vector.<UnitTypeAmountBatchDTO>
      {
         return _unitGifts;
      }
      
      public function get decorationGifts() : Vector.<DecorationTypeAmountDTO>
      {
         return _decorationGifts;
      }
      
      public function get pastTavernPaidSpinCount() : int
      {
         return _pastTavernPaidSpinCount;
      }
      
      public function get pastTavernFreeSpinCount() : int
      {
         return _pastTavernFreeSpinCount;
      }
      
      public function get leagueRpReward() : Boolean
      {
         return _leagueRpReward;
      }
      
      public function get leagueRewardRatio() : Number
      {
         return _leagueRewardRatio;
      }
      
      public function get tournamentNextAttackRemainingDuration() : Number
      {
         return _tournamentNextAttackRemainingDuration;
      }
      
      public function get tournamentRemainingDuration() : Number
      {
         return _tournamentRemainingDuration;
      }
      
      public function get tournamentStartRemainingDuration() : Number
      {
         return _tournamentStartRemainingDuration;
      }
   }
}

