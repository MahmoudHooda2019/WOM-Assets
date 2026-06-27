package wom.model.game
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import org.robotlegs.mvcs.Actor;
   import peak.display.Viewport;
   import wom.model.component.enum.ActionType;
   import wom.model.dto.MobileSpecialOfferDTO;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.chat.ChatMessage;
   import wom.model.game.connection.DisconnectionReasonType;
   import wom.model.game.defense.NPCAttackStatus;
   import wom.model.game.gold.GoldGift;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.game.inventory.ResourceGiftDTO;
   import wom.model.game.quest.QuestInfo;
   import wom.model.game.rank.RankingInfo;
   import wom.model.game.report.AttackLog;
   import wom.model.game.store.ItemEffectInfo;
   import wom.model.game.store.ItemEffectType;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.tutorial.TutorialListInfo;
   import wom.model.game.viral.UserNotification;
   import wom.model.game.viral.ViralAction;
   import wom.model.game.watchpost.WatchpostHelpInfo;
   
   public class DefaultUserInfo extends Actor implements UserInfo
   {
      
      private var _authResponseReceived:Boolean;
      
      private var _profile:Profile;
      
      private var _serverSpeed:int;
      
      private var _loginServerTime:Number;
      
      private var _viewport:Viewport;
      
      private var _currentScreen:WomScreenType;
      
      private var _numberOfGolds:int;
      
      private var _items:Vector.<InventoryItemDTO>;
      
      private var _resourceGifts:Vector.<ResourceGiftDTO>;
      
      private var _quests:Vector.<QuestInfo>;
      
      private var _experiencePoints:Number;
      
      private var _reconPoints:int;
      
      private var _eventPoints:int;
      
      private var _battlePoints:int;
      
      private var _unlockedEventItems:Vector.<int>;
      
      private var _storeItemEffects:Vector.<ItemEffectInfo>;
      
      private var _storeItemCooldownDurations:Dictionary;
      
      private var _stockpileBoostCount:int;
      
      private var _lastGameTickUpdateTime:Date;
      
      private var _lastKeepAliveSendTimer:int;
      
      private var _subscribedActions:Vector.<int>;
      
      private var _viralActions:Vector.<ViralAction>;
      
      private var _chatMessages:Vector.<ChatMessage>;
      
      private var _blockedFriendsMap:Dictionary;
      
      private var _rankingInfo:RankingInfo;
      
      private var _attackLogs:Vector.<AttackLog>;
      
      private var _battleReports:Dictionary;
      
      private var _resourceGiftBonusPercent:int;
      
      private var _thankYouResourceGiftBonusPercent:int;
      
      private var _tutorialsInfo:TutorialListInfo;
      
      private var _helps:Dictionary;
      
      private var _gameMode:GameModeType;
      
      private var _helpCountDictionary:Dictionary;
      
      private var _helpedBuildingsDictionary:Dictionary;
      
      private var _remainingDurationToNextNPCAttack:Number;
      
      private var _npcDurationSaveTime:Number;
      
      private var _npcAttackStatus:NPCAttackStatus;
      
      private var _npcAttackPrepared:Boolean;
      
      private var _npcAttackDelayed:Boolean;
      
      private var _ignoreNPCAttackPopup:Boolean;
      
      private var _canReceiveNPCAttacks:Boolean;
      
      private var _mandatoryTutorialCompleted:Boolean;
      
      private var _autoClaimQuests:Boolean;
      
      private var _toolMenuEnabled:Boolean;
      
      private var _playingMusicId:String;
      
      private var _disconnectionReason:DisconnectionReasonType;
      
      private var _delayPopups:Boolean;
      
      private var _chatRetryAttemptCount:int = 5;
      
      private var _notifications:Vector.<UserNotification>;
      
      private var _abModeTutorial:ABMode;
      
      private var _lastBuildingActionType:ActionType;
      
      private var _lastBuildingActionTimer:int;
      
      private var _claimedQuestIds:Dictionary;
      
      private var _lastLogoutTime:Number;
      
      private var _redirectToMap:Boolean;
      
      private var _catapultActivationRemainingTimes:Dictionary;
      
      private var _chatBanDuration:Number;
      
      private var _usesListForMap:Boolean;
      
      private var _offlineReceivedGoldGifts:Vector.<GoldGift>;
      
      private var _fromMap:Boolean;
      
      private var _captchaEnabled:Boolean;
      
      private var _mapInCampaignMode:Boolean;
      
      private var _currentScreenIsCampaignMap:Boolean;
      
      private var _eventStartTime:Number;
      
      private var _eventEndTime:Number;
      
      private var _eventStoreEndTime:Number;
      
      private var _receivedOfflineAttack:Boolean;
      
      private var _repairPopupShown:Boolean;
      
      private var _friendWatchPostInfos:Dictionary;
      
      private var _offlineFriendWatchpostHelps:WatchpostHelpInfo;
      
      private var _mutedUsers:Dictionary;
      
      private var _tournamentNextAttackRemainingDuration:Number;
      
      private var _tournamentRemainingDuration:Number;
      
      private var _tournamentStartRemainingDuration:Number;
      
      private var _mobileSpecialOffer:MobileSpecialOfferDTO;
      
      private var _completedAchievements:Dictionary;
      
      public function DefaultUserInfo()
      {
         super();
         _authResponseReceived = false;
         _profile = null;
         _lastGameTickUpdateTime = new Date();
         _lastKeepAliveSendTimer = getTimer();
         _blockedFriendsMap = new Dictionary();
         _resourceGiftBonusPercent = 3;
         _thankYouResourceGiftBonusPercent = 1;
         _battleReports = new Dictionary();
         _gameMode = GameModeType.UNKNOWN;
         _tutorialsInfo = new TutorialListInfo();
         _helps = new Dictionary();
         _chatMessages = new Vector.<ChatMessage>();
         _playingMusicId = null;
         _ignoreNPCAttackPopup = true;
         _disconnectionReason = DisconnectionReasonType.UNKNOWN_REASON;
         _canReceiveNPCAttacks = true;
         _mandatoryTutorialCompleted = true;
         _autoClaimQuests = false;
         _delayPopups = true;
         _notifications = new Vector.<UserNotification>();
         _abModeTutorial = TutorialListInfo.DEFAULT_AB_MODE;
         _lastBuildingActionType = ActionType.ARROW;
         _lastBuildingActionTimer = getTimer();
         _claimedQuestIds = new Dictionary();
         _lastLogoutTime = 0;
         _npcAttackPrepared = false;
         _redirectToMap = false;
         _catapultActivationRemainingTimes = new Dictionary();
         _chatBanDuration = -1;
         _usesListForMap = false;
         _offlineReceivedGoldGifts = new Vector.<GoldGift>();
         _fromMap = false;
         _captchaEnabled = false;
         _mapInCampaignMode = false;
         _currentScreenIsCampaignMap = false;
         _receivedOfflineAttack = false;
         _repairPopupShown = false;
         _items = new Vector.<InventoryItemDTO>();
         _offlineFriendWatchpostHelps = null;
         _mutedUsers = new Dictionary();
      }
      
      public function get authResponseReceived() : Boolean
      {
         return _authResponseReceived;
      }
      
      public function set authResponseReceived(param1:Boolean) : void
      {
         _authResponseReceived = param1;
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function set profile(param1:Profile) : void
      {
         _profile = param1;
      }
      
      public function get items() : Vector.<InventoryItemDTO>
      {
         return _items;
      }
      
      public function set items(param1:Vector.<InventoryItemDTO>) : void
      {
         _items = param1;
      }
      
      public function get resourceGifts() : Vector.<ResourceGiftDTO>
      {
         return _resourceGifts;
      }
      
      public function set resourceGifts(param1:Vector.<ResourceGiftDTO>) : void
      {
         _resourceGifts = param1;
      }
      
      public function get serverSpeed() : int
      {
         return _serverSpeed;
      }
      
      public function set serverSpeed(param1:int) : void
      {
         _serverSpeed = param1;
      }
      
      public function get loginServerTime() : Number
      {
         return _loginServerTime;
      }
      
      public function set loginServerTime(param1:Number) : void
      {
         _loginServerTime = param1;
      }
      
      public function get viewport() : Viewport
      {
         return _viewport;
      }
      
      public function set viewport(param1:Viewport) : void
      {
         _viewport = param1;
      }
      
      public function get currentScreen() : WomScreenType
      {
         return _currentScreen;
      }
      
      public function set currentScreen(param1:WomScreenType) : void
      {
         _currentScreen = param1;
      }
      
      public function get numberOfGolds() : int
      {
         return _numberOfGolds;
      }
      
      public function set numberOfGolds(param1:int) : void
      {
         _numberOfGolds = param1;
      }
      
      public function get quests() : Vector.<QuestInfo>
      {
         return _quests;
      }
      
      public function set quests(param1:Vector.<QuestInfo>) : void
      {
         _quests = param1;
      }
      
      public function get experiencePoints() : Number
      {
         return _experiencePoints;
      }
      
      public function set experiencePoints(param1:Number) : void
      {
         _experiencePoints = param1;
      }
      
      public function get reconPoints() : int
      {
         return _reconPoints;
      }
      
      public function set reconPoints(param1:int) : void
      {
         _reconPoints = param1;
      }
      
      public function get eventPoints() : int
      {
         return _eventPoints;
      }
      
      public function set eventPoints(param1:int) : void
      {
         _eventPoints = param1;
      }
      
      public function get battlePoints() : int
      {
         return _battlePoints;
      }
      
      public function set battlePoints(param1:int) : void
      {
         _battlePoints = param1;
      }
      
      public function get unlockedEventItems() : Vector.<int>
      {
         return _unlockedEventItems;
      }
      
      public function set unlockedEventItems(param1:Vector.<int>) : void
      {
         _unlockedEventItems = param1;
      }
      
      public function get storeItemEffects() : Vector.<ItemEffectInfo>
      {
         return _storeItemEffects;
      }
      
      public function set storeItemEffects(param1:Vector.<ItemEffectInfo>) : void
      {
         _storeItemEffects = param1;
      }
      
      public function get storeItemCooldownDurations() : Dictionary
      {
         return _storeItemCooldownDurations;
      }
      
      public function set storeItemCooldownDurations(param1:Dictionary) : void
      {
         _storeItemCooldownDurations = param1;
      }
      
      public function get stockpileBoostCount() : int
      {
         return _stockpileBoostCount;
      }
      
      public function set stockpileBoostCount(param1:int) : void
      {
         _stockpileBoostCount = param1;
      }
      
      public function get gameMode() : GameModeType
      {
         return _gameMode;
      }
      
      public function set gameMode(param1:GameModeType) : void
      {
         _gameMode = param1;
      }
      
      public function get lastGameTickUpdateTime() : Date
      {
         return _lastGameTickUpdateTime;
      }
      
      public function set lastGameTickUpdateTime(param1:Date) : void
      {
         _lastGameTickUpdateTime = param1;
      }
      
      public function get subscribedActions() : Vector.<int>
      {
         return _subscribedActions;
      }
      
      public function set subscribedActions(param1:Vector.<int>) : void
      {
         _subscribedActions = param1;
      }
      
      public function get unitArmorModifier() : Number
      {
         return itemEffectModifier(ItemEffectType.MERCENARY_ARMOR_BOOST);
      }
      
      public function get unitDamageModifier() : Number
      {
         return itemEffectModifier(ItemEffectType.MERCENARY_DAMAGE_BOOST);
      }
      
      public function get unitSpeedModifier() : Number
      {
         return itemEffectModifier(ItemEffectType.MERCENARY_SPEED_BOOST);
      }
      
      public function get barracksSpaceModifier() : Number
      {
         return itemEffectModifier(ItemEffectType.EXTRA_BARRACKS);
      }
      
      public function get towerDamageModifier() : Number
      {
         return itemEffectModifier(ItemEffectType.TOWER_DAMAGE_BOOST);
      }
      
      public function get hiringSpeedModifier() : int
      {
         return itemEffectModifier(ItemEffectType.HIRING_BOOST);
      }
      
      public function get productionBoostModifier() : int
      {
         return itemEffectModifier(ItemEffectType.PRODUCTION_BOOST);
      }
      
      private function itemEffectModifier(param1:ItemEffectType) : Number
      {
         if(!_storeItemEffects)
         {
            return 1;
         }
         return StoreUtil.itemEffectModifier(param1,_storeItemEffects);
      }
      
      public function get viralActions() : Vector.<ViralAction>
      {
         return _viralActions;
      }
      
      public function set viralActions(param1:Vector.<ViralAction>) : void
      {
         _viralActions = param1;
      }
      
      public function get lastKeepAliveSendTimer() : int
      {
         return _lastKeepAliveSendTimer;
      }
      
      public function set lastKeepAliveSendTimer(param1:int) : void
      {
         _lastKeepAliveSendTimer = param1;
      }
      
      public function get blockedFriendsMap() : Dictionary
      {
         return _blockedFriendsMap;
      }
      
      public function get rankingInfo() : RankingInfo
      {
         return _rankingInfo;
      }
      
      public function set rankingInfo(param1:RankingInfo) : void
      {
         _rankingInfo = param1;
      }
      
      public function get activeDamageProtectionWithBegginerProtection() : ItemEffectInfo
      {
         var _loc2_:ItemEffectInfo = null;
         if(_storeItemEffects)
         {
            for each(var _loc1_ in storeItemEffects)
            {
               if(_loc1_.type.id == ItemEffectType.BEGINNER_PROTECTION.id)
               {
                  _loc2_ = _loc1_;
               }
            }
         }
         return _loc2_ || activeDamageProtection;
      }
      
      public function get activeDamageProtection() : ItemEffectInfo
      {
         var _loc2_:ItemEffectInfo = null;
         if(_storeItemEffects)
         {
            for each(var _loc1_ in storeItemEffects)
            {
               if(_loc1_.type.id == ItemEffectType.BATTLE_PROTECTION.id)
               {
                  if(!_loc2_ || _loc2_.creationDate + _loc2_.durationRemaining < _loc1_.creationDate + _loc1_.durationRemaining)
                  {
                     _loc2_ = _loc1_;
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function get attackLogs() : Vector.<AttackLog>
      {
         return _attackLogs;
      }
      
      public function set attackLogs(param1:Vector.<AttackLog>) : void
      {
         _attackLogs = param1;
      }
      
      public function get battleReports() : Dictionary
      {
         return _battleReports;
      }
      
      public function get resourceGiftBonusPercent() : int
      {
         return _resourceGiftBonusPercent;
      }
      
      public function get helpCountDictionary() : Dictionary
      {
         return _helpCountDictionary;
      }
      
      public function get helpedUserCounts() : int
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         for(var _loc2_ in helpCountDictionary)
         {
            if(_loc2_ != "NPC_5")
            {
               _loc1_ = int(helpCountDictionary[_loc2_]);
               if(_loc1_ > 0)
               {
                  _loc3_++;
               }
            }
         }
         return _loc3_;
      }
      
      public function set helpCountDictionary(param1:Dictionary) : void
      {
         _helpCountDictionary = param1;
      }
      
      public function get helpedBuildingsDictionary() : Dictionary
      {
         return _helpedBuildingsDictionary;
      }
      
      public function set helpedBuildingsDictionary(param1:Dictionary) : void
      {
         _helpedBuildingsDictionary = param1;
      }
      
      public function set resourceGiftBonusPercent(param1:int) : void
      {
         _resourceGiftBonusPercent = param1;
      }
      
      public function get thankYouResourceGiftBonusPercent() : int
      {
         return _thankYouResourceGiftBonusPercent;
      }
      
      public function set thankYouResourceGiftBonusPercent(param1:int) : void
      {
         _thankYouResourceGiftBonusPercent = param1;
      }
      
      public function get tutorialsInfo() : TutorialListInfo
      {
         return _tutorialsInfo;
      }
      
      public function get remainingDurationToNextNPCAttack() : Number
      {
         return _remainingDurationToNextNPCAttack;
      }
      
      public function set remainingDurationToNextNPCAttack(param1:Number) : void
      {
         _remainingDurationToNextNPCAttack = param1;
      }
      
      public function get npcDurationSaveTime() : Number
      {
         return _npcDurationSaveTime;
      }
      
      public function set npcDurationSaveTime(param1:Number) : void
      {
         _npcDurationSaveTime = param1;
      }
      
      public function get npcAttackStatus() : NPCAttackStatus
      {
         return _npcAttackStatus;
      }
      
      public function set npcAttackStatus(param1:NPCAttackStatus) : void
      {
         _npcAttackStatus = param1;
      }
      
      public function get npcAttackDelayed() : Boolean
      {
         return _npcAttackDelayed;
      }
      
      public function set npcAttackDelayed(param1:Boolean) : void
      {
         _npcAttackDelayed = param1;
      }
      
      public function get helps() : Dictionary
      {
         return _helps;
      }
      
      public function get playingMusicId() : String
      {
         return _playingMusicId;
      }
      
      public function set playingMusicId(param1:String) : void
      {
         _playingMusicId = param1;
      }
      
      public function get ignoreNPCAttackPopup() : Boolean
      {
         return _ignoreNPCAttackPopup;
      }
      
      public function set ignoreNPCAttackPopup(param1:Boolean) : void
      {
         _ignoreNPCAttackPopup = param1;
      }
      
      public function get disconnectionReason() : DisconnectionReasonType
      {
         return _disconnectionReason;
      }
      
      public function set disconnectionReason(param1:DisconnectionReasonType) : void
      {
         _disconnectionReason = param1;
      }
      
      public function get canReceiveNPCAttacks() : Boolean
      {
         return _canReceiveNPCAttacks;
      }
      
      public function set canReceiveNPCAttacks(param1:Boolean) : void
      {
         _canReceiveNPCAttacks = param1;
      }
      
      public function get mandatoryTutorialCompleted() : Boolean
      {
         return _mandatoryTutorialCompleted;
      }
      
      public function set mandatoryTutorialCompleted(param1:Boolean) : void
      {
         _mandatoryTutorialCompleted = param1;
      }
      
      public function get autoClaimQuests() : Boolean
      {
         return _autoClaimQuests;
      }
      
      public function set autoClaimQuests(param1:Boolean) : void
      {
         _autoClaimQuests = param1;
      }
      
      public function get delayPopups() : Boolean
      {
         return _delayPopups;
      }
      
      public function set delayPopups(param1:Boolean) : void
      {
         _delayPopups = param1;
      }
      
      public function get chatMessages() : Vector.<ChatMessage>
      {
         return _chatMessages;
      }
      
      public function set chatMessages(param1:Vector.<ChatMessage>) : void
      {
         _chatMessages = param1;
      }
      
      public function get notifications() : Vector.<UserNotification>
      {
         return _notifications;
      }
      
      public function get toolMenuEnabled() : Boolean
      {
         return _toolMenuEnabled;
      }
      
      public function set toolMenuEnabled(param1:Boolean) : void
      {
         _toolMenuEnabled = param1;
      }
      
      public function get abModeTutorial() : ABMode
      {
         return _abModeTutorial;
      }
      
      public function set abModeTutorial(param1:ABMode) : void
      {
         _abModeTutorial = param1;
      }
      
      public function get chatRetryAttemptCount() : int
      {
         return _chatRetryAttemptCount;
      }
      
      public function set chatRetryAttemptCount(param1:int) : void
      {
         _chatRetryAttemptCount = param1;
      }
      
      public function get lastBuildingActionType() : ActionType
      {
         return _lastBuildingActionType;
      }
      
      public function set lastBuildingActionType(param1:ActionType) : void
      {
         _lastBuildingActionType = param1;
      }
      
      public function get lastBuildingActionTimer() : int
      {
         return _lastBuildingActionTimer;
      }
      
      public function set lastBuildingActionTimer(param1:int) : void
      {
         _lastBuildingActionTimer = param1;
      }
      
      public function get claimedQuestIds() : Dictionary
      {
         return _claimedQuestIds;
      }
      
      public function set claimedQuestIds(param1:Dictionary) : void
      {
         _claimedQuestIds = param1;
      }
      
      public function get lastLogoutTime() : Number
      {
         return _lastLogoutTime;
      }
      
      public function set lastLogoutTime(param1:Number) : void
      {
         _lastLogoutTime = param1;
      }
      
      public function get npcAttackPrepared() : Boolean
      {
         return _npcAttackPrepared;
      }
      
      public function set npcAttackPrepared(param1:Boolean) : void
      {
         _npcAttackPrepared = param1;
      }
      
      public function get redirectToMap() : Boolean
      {
         return _redirectToMap;
      }
      
      public function set redirectToMap(param1:Boolean) : void
      {
         _redirectToMap = param1;
      }
      
      public function get catapultActivationRemainingTimes() : Dictionary
      {
         return _catapultActivationRemainingTimes;
      }
      
      public function set catapultActivationRemainingTimes(param1:Dictionary) : void
      {
         _catapultActivationRemainingTimes = param1;
      }
      
      public function get chatBanDuration() : Number
      {
         return _chatBanDuration;
      }
      
      public function set chatBanDuration(param1:Number) : void
      {
         _chatBanDuration = param1;
      }
      
      public function set usesListForMap(param1:Boolean) : void
      {
         _usesListForMap = param1;
      }
      
      public function get usesListForMap() : Boolean
      {
         return _usesListForMap;
      }
      
      public function get offlineReceivedGoldGifts() : Vector.<GoldGift>
      {
         return _offlineReceivedGoldGifts;
      }
      
      public function set fromMap(param1:Boolean) : void
      {
         _fromMap = param1;
      }
      
      public function get fromMap() : Boolean
      {
         return _fromMap;
      }
      
      public function get captchaEnabled() : Boolean
      {
         return _captchaEnabled;
      }
      
      public function set captchaEnabled(param1:Boolean) : void
      {
         _captchaEnabled = param1;
      }
      
      public function get mapInCampaignMode() : Boolean
      {
         return _mapInCampaignMode;
      }
      
      public function set mapInCampaignMode(param1:Boolean) : void
      {
         _mapInCampaignMode = param1;
      }
      
      public function get currentScreenIsCampaignMap() : Boolean
      {
         return _currentScreenIsCampaignMap;
      }
      
      public function set currentScreenIsCampaignMap(param1:Boolean) : void
      {
         _currentScreenIsCampaignMap = param1;
      }
      
      public function get eventStartTime() : Number
      {
         return _eventStartTime;
      }
      
      public function set eventStartTime(param1:Number) : void
      {
         _eventStartTime = param1;
      }
      
      public function get eventEndTime() : Number
      {
         return _eventEndTime;
      }
      
      public function set eventEndTime(param1:Number) : void
      {
         _eventEndTime = param1;
      }
      
      public function get eventStoreEndTime() : Number
      {
         return _eventStoreEndTime;
      }
      
      public function set eventStoreEndTime(param1:Number) : void
      {
         _eventStoreEndTime = param1;
      }
      
      public function get friendWatchPostInfos() : Dictionary
      {
         return _friendWatchPostInfos;
      }
      
      public function set friendWatchPostInfos(param1:Dictionary) : void
      {
         _friendWatchPostInfos = param1;
      }
      
      public function get repairPopupShown() : Boolean
      {
         return _repairPopupShown;
      }
      
      public function set repairPopupShown(param1:Boolean) : void
      {
         _repairPopupShown = param1;
      }
      
      public function get receivedOfflineAttack() : Boolean
      {
         return _receivedOfflineAttack;
      }
      
      public function set receivedOfflineAttack(param1:Boolean) : void
      {
         _receivedOfflineAttack = param1;
      }
      
      public function get offlineFriendWatchpostHelps() : WatchpostHelpInfo
      {
         return _offlineFriendWatchpostHelps;
      }
      
      public function set offlineFriendWatchpostHelps(param1:WatchpostHelpInfo) : void
      {
         _offlineFriendWatchpostHelps = param1;
      }
      
      public function get mutedUsers() : Dictionary
      {
         return _mutedUsers;
      }
      
      public function set mutedUsers(param1:Dictionary) : void
      {
         _mutedUsers = param1;
      }
      
      public function set tournamentNextAttackRemainingDuration(param1:Number) : void
      {
         _tournamentNextAttackRemainingDuration = param1;
      }
      
      public function get tournamentNextAttackRemainingDuration() : Number
      {
         return _tournamentNextAttackRemainingDuration;
      }
      
      public function get mobileSpecialOffer() : MobileSpecialOfferDTO
      {
         return _mobileSpecialOffer;
      }
      
      public function set mobileSpecialOffer(param1:MobileSpecialOfferDTO) : void
      {
         _mobileSpecialOffer = param1;
      }
      
      public function get completedAchievements() : Dictionary
      {
         return _completedAchievements;
      }
      
      public function set completedAchievements(param1:Dictionary) : void
      {
         _completedAchievements = param1;
      }
      
      public function set tournamentRemainingDuration(param1:Number) : void
      {
         _tournamentRemainingDuration = param1;
      }
      
      public function get tournamentRemainingDuration() : Number
      {
         return _tournamentRemainingDuration;
      }
      
      public function set tournamentStartRemainingDuration(param1:Number) : void
      {
         _tournamentStartRemainingDuration = param1;
      }
      
      public function get tournamentStartRemainingDuration() : Number
      {
         return _tournamentStartRemainingDuration;
      }
   }
}

