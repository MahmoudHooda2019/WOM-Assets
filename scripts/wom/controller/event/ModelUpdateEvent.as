package wom.controller.event
{
   import flash.events.Event;
   
   public class ModelUpdateEvent extends Event
   {
      
      public static const USER_INFO_UPDATED:String = "userInfoUpdated";
      
      public static const CITY_LOADED:String = "cityLoaded";
      
      public static const RESOURCES_UPDATED:String = "resourcesUpdated";
      
      public static const UPGRADE_JOBS_INFO_UPDATED:String = "jobsInfoUpdated";
      
      public static const BUILDING_TYPES_UPDATED:String = "buildingTypesUpdated";
      
      public static const INVENTORY_UPDATED:String = "inventoryUpdated";
      
      public static const INVENTORY_ITEM_ADDED:String = "inventoryItemAdded";
      
      public static const RESOURCE_CAPACITY_UPDATED:String = "resourceCapacityUpdated";
      
      public static const GOLD_AMOUNT_UPDATED:String = "goldAmountUpdated";
      
      public static const QUEST_INFO_UPDATED:String = "questInfoUpdated";
      
      public static const FORTIFICATION_JOBS_INFO_UPDATED:String = "fortificationJobsInfoUpdated";
      
      public static const UNIT_TYPES_UPDATED:String = "unitTypesUpdated";
      
      public static const RECRUIT_JOB_INFO_UPDATED:String = "recruitJobInfoUpdated";
      
      public static const TRAIN_UNIT_JOBS_UPDATED:String = "trainUnitJobsUpdated";
      
      public static const WORKER_COUNT_UPDATED:String = "workerCountUpdated";
      
      public static const WORKER_ADD_BUTTON_CLICKED:String = "workerAddButtonClicked";
      
      public static const REPAIR_JOBS_UPDATED:String = "repairJobsUpdated";
      
      public static const RECON_POINTS_UPDATED:String = "reconPoinrsUpdated";
      
      public static const EXPERIENCE_POINTS_UPDATED:String = "experiencePointsUpdated";
      
      public static const EVENT_POINTS_UPDATED:String = "eventPointsUpdated";
      
      public static const BATTLE_POINTS_UPDATED:String = "battlePointsUpdated";
      
      public static const STOCKPILE_BOOST_COUNT_CHANGED:String = "stockpileBoostCountChanged";
      
      public static const STORE_ITEM_COOLDOWN_DURATIONS_UPDATED:String = "storeItemCooldownDurationsUpdated";
      
      public static const STORE_ITEM_EFFECTS_UPDATED:String = "storeItemEffectsUpdated";
      
      public static const EVENT_ITEMS_UPDATED:String = "eventItemsUpdated";
      
      public static const CITY_DIMENSIONS_UPDATED:String = "cityDimensionsUpdated";
      
      public static const UNITS_IN_WATCHPOST_UPDATED:String = "unitsInWatchPostUpdated";
      
      public static const UNITS_IN_BARRACKS_UPDATED:String = "unitsInBarracksUpdated";
      
      public static const HIRING_INFO_UPDATED:String = "hiringInfoUpdated";
      
      public static const FRIENDS_UPDATED:String = "friendsUpdated";
      
      public static const BEAST_UPDATED:String = "beastUpdated";
      
      public static const ATTACK_INFO_UPDATED:String = "attackInfoUpdated";
      
      public static const BEAST_HEALTH_UPDATED:String = "beastHealthUpdated";
      
      public static const CITY_PLANNER_MAX_SLOTS_CHANGED:String = "cityPlannerMaxSlotsChanged";
      
      public static const ATTACKING_UNITS_UPDATED:String = "attackingUnitUpdated";
      
      public static const LOOTED_RESOURCES_UPDATED:String = "lootedResourcesUpdated";
      
      public static const SUBSCRIBED_ACTIONS_UPDATED:String = "subscribedActionsUpdated";
      
      public static const GOLD_CAPACITY_REMAINING_TIME_UPDATED:String = "goldCapacityRemainingTimeUpdated";
      
      public static const RANKING_INFO_UPDATED:String = "rankingInfoUpdated";
      
      public static const ATTACK_LOGS_UPDATED:String = "attackLogsUpdated";
      
      public static const BATTLE_REPORT_UPDATED:String = "battleReportUpdated";
      
      public static const PLATFORM_USERS_UPDATED:String = "platformUsersUpdated";
      
      public static const WOM_FRIENDS_UPDATED:String = "womFriendsUpdated";
      
      public static const NPC_ATTACK_STATUS_UPDATED:String = "npcAttackStatusUpdated";
      
      public static const HELP_INFO_UPDATED:String = "helpInfoUpdated";
      
      public static const DAMAGE_PROTECTION_CHANGED:String = "damageProtectionChanged";
      
      public static const NUMBER_OF_SENT_NPC_ATTACK_UPDATED:String = "numberOfSentNPCAttackUpdated";
      
      public static const ZOOM_MODE_CHANGED:String = "zoomModeChanged";
      
      public static const TOOL_MENU_UPDATED:String = "toolMenuEnabled";
      
      public static const SPY_STATUS_CHANGE:String = "spyStatusChange";
      
      public static const SELECT_FRIEND_VIEW_UPDATED:String = "selectFriendViewUpdated";
      
      public static const FREE_COINS_STATUS_UPDATED:String = "freeCoinsStatusUpdated";
      
      public static const CHECK_FREE_COINS_STATUS:String = "checkFreeCoinsStatus";
      
      public static const SPECIAL_OFFER_STATUS_UPDATED:String = "specialOfferStatusUpdated";
      
      public static const CHECK_SPECIAL_OFFER_STATUS:String = "checkSpecialOfferStatus";
      
      public static const ALLIANCE_DETAILS_UPDATED:String = "allianceInfoUpdated";
      
      public static const ALLIANCE_SUMMARY_UPDATED:String = "allianceSummaryUpdated";
      
      public static const ALLIANCE_RANKING_INFO_UPDATED:String = "allianceRankingInfoUpdated";
      
      public static const ALLIANCE_MEMBERS_RANKING_INFO_UPDATED:String = "allianceMembersRankingInfoUpdated";
      
      public static const MY_ALLIANCE_MEMBERS_RANKING_INFO_UPDATED:String = "myAllianceMembersRankingInfoUpdated";
      
      public static const ALLIANCE_CANDIDATES_UPDATED:String = "myAllianceCandidatesUpdated";
      
      public static const SEARCHED_ALLIANCE_CANDIDATES_UPDATED:String = "searchedAllianceCandidatesUpdated";
      
      public static const ALLIANCE_SEARCH_RESULT_UPDATED:String = "allianceSearchResultUpdated";
      
      public static const WORKER_STAFF_UPDATED:String = "workerStaffUpdated";
      
      public static const EVENT_NPCS_UPDATED:String = "eventNpcsUpdated";
      
      public static const EVENT_TIMERS_UPDATED:String = "eventTimersUpdated";
      
      public static const LEAGUE_MEMBERS_RANKING_INFO_UPDATED:String = "leagueMembersRankingInfoUpdated";
      
      public static const LEAGUE_STATUS_UPDATED:String = "leagueStatusUpdated";
      
      public static const LEAGUE_INFO_VIEW_UPDATED:String = "leagueInfoViewUpdated";
      
      public static const ASK_FOR_OVERFLOW_INFO_UPDATED:String = "askForOverflowInfoUpdated";
      
      public static const UNITS_IN_ALLIANCE_BARRACKS_UPDATED:String = "unitsInAllianceBarracksUpdated";
      
      public static const FRIEND_WATCH_POST_INFO_UPDATED:String = "friendWatchPostDataUpdated";
      
      public static const STORE_ITEM_DISCOUNT_UPDATED:String = "storeItemDiscountUpdated";
      
      public static const EVENT_ITEM_QUEUE_UPDATED:String = "eventItemQueueUpdated";
      
      public static const SUPERSONIC_AD_STATUS_UPDATED:String = "supersonicAdStatusUpdated";
      
      public static const CHECK_SUPERSONIC_AD_STATUS:String = "checkSupersonicAdStatus";
      
      public static const TAVERN_CARD_UNLOCKED:String = "tavernCardUnlocked";
      
      public static const MOBILE_MAP_MEMBER_LIST_UPDATED:String = "mobileMapMemberListUpdated";
      
      public static const INBOX_COUNT_UPDATED:String = "inboxCountUpdated";
      
      public static const ALLIANCE_TOURNAMENTS_INFO_UPDATED:String = "tournamentsInfoUpdated";
      
      public static const INVITABLE_FRIENDS_UPDATED:String = "invitableFriendsUpdated";
      
      public static const AUTHENTICATION_COMPLETED:String = "authenticationCompleted";
      
      public static const MOBILE_ID_UPDATED:String = "mobileIdUpdated";
      
      public static const MOBILE_SPECIAL_OFFER_UPDATED:String = "mobileSpecialOfferUpdated";
      
      public function ModelUpdateEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new ModelUpdateEvent(type);
      }
   }
}

