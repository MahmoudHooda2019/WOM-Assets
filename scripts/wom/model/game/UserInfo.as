package wom.model.game
{
   import flash.utils.Dictionary;
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
   import wom.model.game.tutorial.TutorialListInfo;
   import wom.model.game.viral.UserNotification;
   import wom.model.game.viral.ViralAction;
   import wom.model.game.watchpost.WatchpostHelpInfo;
   
   public interface UserInfo
   {
      
      function get authResponseReceived() : Boolean;
      
      function set authResponseReceived(param1:Boolean) : void;
      
      function get profile() : Profile;
      
      function set profile(param1:Profile) : void;
      
      function get items() : Vector.<InventoryItemDTO>;
      
      function set items(param1:Vector.<InventoryItemDTO>) : void;
      
      function get resourceGifts() : Vector.<ResourceGiftDTO>;
      
      function set resourceGifts(param1:Vector.<ResourceGiftDTO>) : void;
      
      function get serverSpeed() : int;
      
      function set serverSpeed(param1:int) : void;
      
      function get loginServerTime() : Number;
      
      function set loginServerTime(param1:Number) : void;
      
      function get viewport() : Viewport;
      
      function set viewport(param1:Viewport) : void;
      
      function get currentScreen() : WomScreenType;
      
      function set currentScreen(param1:WomScreenType) : void;
      
      function get numberOfGolds() : int;
      
      function set numberOfGolds(param1:int) : void;
      
      function get quests() : Vector.<QuestInfo>;
      
      function set quests(param1:Vector.<QuestInfo>) : void;
      
      function get experiencePoints() : Number;
      
      function set experiencePoints(param1:Number) : void;
      
      function get reconPoints() : int;
      
      function set reconPoints(param1:int) : void;
      
      function get eventPoints() : int;
      
      function set eventPoints(param1:int) : void;
      
      function get battlePoints() : int;
      
      function set battlePoints(param1:int) : void;
      
      function get unlockedEventItems() : Vector.<int>;
      
      function set unlockedEventItems(param1:Vector.<int>) : void;
      
      function get storeItemEffects() : Vector.<ItemEffectInfo>;
      
      function set storeItemEffects(param1:Vector.<ItemEffectInfo>) : void;
      
      function get storeItemCooldownDurations() : Dictionary;
      
      function set storeItemCooldownDurations(param1:Dictionary) : void;
      
      function get stockpileBoostCount() : int;
      
      function set stockpileBoostCount(param1:int) : void;
      
      function get gameMode() : GameModeType;
      
      function set gameMode(param1:GameModeType) : void;
      
      function get lastGameTickUpdateTime() : Date;
      
      function set lastGameTickUpdateTime(param1:Date) : void;
      
      function get subscribedActions() : Vector.<int>;
      
      function set subscribedActions(param1:Vector.<int>) : void;
      
      function get unitArmorModifier() : Number;
      
      function get unitDamageModifier() : Number;
      
      function get unitSpeedModifier() : Number;
      
      function get barracksSpaceModifier() : Number;
      
      function get towerDamageModifier() : Number;
      
      function get hiringSpeedModifier() : int;
      
      function get productionBoostModifier() : int;
      
      function get viralActions() : Vector.<ViralAction>;
      
      function set viralActions(param1:Vector.<ViralAction>) : void;
      
      function get lastKeepAliveSendTimer() : int;
      
      function set lastKeepAliveSendTimer(param1:int) : void;
      
      function get blockedFriendsMap() : Dictionary;
      
      function get rankingInfo() : RankingInfo;
      
      function set rankingInfo(param1:RankingInfo) : void;
      
      function get activeDamageProtectionWithBegginerProtection() : ItemEffectInfo;
      
      function get activeDamageProtection() : ItemEffectInfo;
      
      function get attackLogs() : Vector.<AttackLog>;
      
      function set attackLogs(param1:Vector.<AttackLog>) : void;
      
      function get battleReports() : Dictionary;
      
      function get resourceGiftBonusPercent() : int;
      
      function set resourceGiftBonusPercent(param1:int) : void;
      
      function get thankYouResourceGiftBonusPercent() : int;
      
      function set thankYouResourceGiftBonusPercent(param1:int) : void;
      
      function get helpCountDictionary() : Dictionary;
      
      function set helpCountDictionary(param1:Dictionary) : void;
      
      function get helpedUserCounts() : int;
      
      function get helpedBuildingsDictionary() : Dictionary;
      
      function set helpedBuildingsDictionary(param1:Dictionary) : void;
      
      function get tutorialsInfo() : TutorialListInfo;
      
      function get remainingDurationToNextNPCAttack() : Number;
      
      function set remainingDurationToNextNPCAttack(param1:Number) : void;
      
      function get npcDurationSaveTime() : Number;
      
      function set npcDurationSaveTime(param1:Number) : void;
      
      function get npcAttackStatus() : NPCAttackStatus;
      
      function set npcAttackStatus(param1:NPCAttackStatus) : void;
      
      function get npcAttackDelayed() : Boolean;
      
      function set npcAttackDelayed(param1:Boolean) : void;
      
      function get helps() : Dictionary;
      
      function get playingMusicId() : String;
      
      function get ignoreNPCAttackPopup() : Boolean;
      
      function set ignoreNPCAttackPopup(param1:Boolean) : void;
      
      function get disconnectionReason() : DisconnectionReasonType;
      
      function set disconnectionReason(param1:DisconnectionReasonType) : void;
      
      function get canReceiveNPCAttacks() : Boolean;
      
      function set canReceiveNPCAttacks(param1:Boolean) : void;
      
      function get mandatoryTutorialCompleted() : Boolean;
      
      function set mandatoryTutorialCompleted(param1:Boolean) : void;
      
      function get autoClaimQuests() : Boolean;
      
      function set autoClaimQuests(param1:Boolean) : void;
      
      function get delayPopups() : Boolean;
      
      function set delayPopups(param1:Boolean) : void;
      
      function get chatMessages() : Vector.<ChatMessage>;
      
      function set chatMessages(param1:Vector.<ChatMessage>) : void;
      
      function get notifications() : Vector.<UserNotification>;
      
      function get toolMenuEnabled() : Boolean;
      
      function set toolMenuEnabled(param1:Boolean) : void;
      
      function get abModeTutorial() : ABMode;
      
      function set abModeTutorial(param1:ABMode) : void;
      
      function get chatRetryAttemptCount() : int;
      
      function set chatRetryAttemptCount(param1:int) : void;
      
      function get lastBuildingActionType() : ActionType;
      
      function set lastBuildingActionType(param1:ActionType) : void;
      
      function get lastBuildingActionTimer() : int;
      
      function set lastBuildingActionTimer(param1:int) : void;
      
      function get claimedQuestIds() : Dictionary;
      
      function set claimedQuestIds(param1:Dictionary) : void;
      
      function get lastLogoutTime() : Number;
      
      function set lastLogoutTime(param1:Number) : void;
      
      function get npcAttackPrepared() : Boolean;
      
      function set npcAttackPrepared(param1:Boolean) : void;
      
      function get redirectToMap() : Boolean;
      
      function set redirectToMap(param1:Boolean) : void;
      
      function get chatBanDuration() : Number;
      
      function set chatBanDuration(param1:Number) : void;
      
      function get catapultActivationRemainingTimes() : Dictionary;
      
      function set catapultActivationRemainingTimes(param1:Dictionary) : void;
      
      function set usesListForMap(param1:Boolean) : void;
      
      function get usesListForMap() : Boolean;
      
      function get offlineReceivedGoldGifts() : Vector.<GoldGift>;
      
      function set fromMap(param1:Boolean) : void;
      
      function get fromMap() : Boolean;
      
      function get captchaEnabled() : Boolean;
      
      function set captchaEnabled(param1:Boolean) : void;
      
      function get mapInCampaignMode() : Boolean;
      
      function set mapInCampaignMode(param1:Boolean) : void;
      
      function get currentScreenIsCampaignMap() : Boolean;
      
      function set currentScreenIsCampaignMap(param1:Boolean) : void;
      
      function get eventStartTime() : Number;
      
      function set eventStartTime(param1:Number) : void;
      
      function get eventEndTime() : Number;
      
      function set eventEndTime(param1:Number) : void;
      
      function get eventStoreEndTime() : Number;
      
      function set eventStoreEndTime(param1:Number) : void;
      
      function get receivedOfflineAttack() : Boolean;
      
      function set receivedOfflineAttack(param1:Boolean) : void;
      
      function get repairPopupShown() : Boolean;
      
      function set repairPopupShown(param1:Boolean) : void;
      
      function get friendWatchPostInfos() : Dictionary;
      
      function set friendWatchPostInfos(param1:Dictionary) : void;
      
      function get offlineFriendWatchpostHelps() : WatchpostHelpInfo;
      
      function set offlineFriendWatchpostHelps(param1:WatchpostHelpInfo) : void;
      
      function get mutedUsers() : Dictionary;
      
      function set mutedUsers(param1:Dictionary) : void;
      
      function set tournamentNextAttackRemainingDuration(param1:Number) : void;
      
      function get tournamentNextAttackRemainingDuration() : Number;
      
      function set tournamentRemainingDuration(param1:Number) : void;
      
      function get tournamentRemainingDuration() : Number;
      
      function set tournamentStartRemainingDuration(param1:Number) : void;
      
      function get tournamentStartRemainingDuration() : Number;
      
      function get mobileSpecialOffer() : MobileSpecialOfferDTO;
      
      function set mobileSpecialOffer(param1:MobileSpecialOfferDTO) : void;
      
      function get completedAchievements() : Dictionary;
      
      function set completedAchievements(param1:Dictionary) : void;
   }
}

