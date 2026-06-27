package wom.controller.command.bootstrap
{
   import org.robotlegs.mvcs.StarlingCommand;
   import peak.cuckoo.game.attribute.view.StarlingCuckooOverlay;
   import wom.MobileClient;
   import wom.view.mediator.MobileClientMediator;
   import wom.view.mediator.screen.MobileCityPlannerScreenMediator;
   import wom.view.mediator.screen.MobileCityScreenMediator;
   import wom.view.mediator.screen.MobileLoadingScreenMediator;
   import wom.view.mediator.screen.MobileManualAuthenticationScreenMediator;
   import wom.view.mediator.screen.MobileMapScreenMediator;
   import wom.view.mediator.screen.MobileRootScreenMediator;
   import wom.view.mediator.screen.popups.MobileAnyoneHomePopUpMediator;
   import wom.view.mediator.screen.popups.MobileBeastConfirmationPopUpMediator;
   import wom.view.mediator.screen.popups.MobileBeastUnleashedPopUpMediator;
   import wom.view.mediator.screen.popups.MobileBoostConfirmationPopUpMediator;
   import wom.view.mediator.screen.popups.MobileDisconnectPopUpMediator;
   import wom.view.mediator.screen.popups.MobileDontKillMePopUpMediator;
   import wom.view.mediator.screen.popups.MobileFeatureAvailablePopUpMediator;
   import wom.view.mediator.screen.popups.MobileFortificationCompletedPopUpMediator;
   import wom.view.mediator.screen.popups.MobileGenericActionPopUpMediator;
   import wom.view.mediator.screen.popups.MobileGuestNamingPopUpMediator;
   import wom.view.mediator.screen.popups.MobileJobCapacityAlreadyReachedPopUpMediator;
   import wom.view.mediator.screen.popups.MobileLeaveGamePopUpMediator;
   import wom.view.mediator.screen.popups.MobileSpecialOfferPopUpMediator;
   import wom.view.mediator.screen.popups.MobileStoreItemPurchasedPopUpMediator;
   import wom.view.mediator.screen.popups.apologies.MobileActionNotPossiblePopUpMediator;
   import wom.view.mediator.screen.popups.attack.MobileAttackWarnPopupMediator;
   import wom.view.mediator.screen.popups.congratulations.MobileLevelupPopupMediator;
   import wom.view.mediator.screen.popups.emailpermission.MobileEmailPermissionPopUpMediator;
   import wom.view.mediator.screen.popups.event.MobileEventOngoingPanelMediator;
   import wom.view.mediator.screen.popups.event.MobileEventPopUpMediator;
   import wom.view.mediator.screen.popups.expandcity.MobileExpandCityPopUpMediator;
   import wom.view.mediator.screen.popups.facebook.MobileFBConfirmationPopUpMediator;
   import wom.view.mediator.screen.popups.facebook.MobileFBConnectToSendGiftPanelMediator;
   import wom.view.mediator.screen.popups.facebook.MobileFBGetGoldPopUpMediator;
   import wom.view.mediator.screen.popups.facebook.MobileFBProgressPopUpMediator;
   import wom.view.mediator.screen.popups.finishnow.MobileFinishNowHiringPopUpMediator;
   import wom.view.mediator.screen.popups.help.MobileFriendWatchpostHelpPopUpMediator;
   import wom.view.mediator.screen.popups.help.MobileHelpedFriendPopUpMediator;
   import wom.view.mediator.screen.popups.league.MobileLeagueSeasonEndedPopUpMediator;
   import wom.view.mediator.screen.popups.league.MobileLeagueSeasonEndedSuccessPopUpMediator;
   import wom.view.mediator.screen.popups.league.MobileLeagueStatusChangedPopUpMediator;
   import wom.view.mediator.screen.popups.league.MobileLeagueStatusDroppedPopUpMediator;
   import wom.view.mediator.screen.popups.league.MobileLeagueStatusPlacedPopUpMediator;
   import wom.view.mediator.screen.popups.notenough.MobileNotEnoughPopupMediator;
   import wom.view.mediator.screen.popups.npcattack.MobileNPCAttackPopupBatchViewMediator;
   import wom.view.mediator.screen.popups.npcattack.mobile.MobileNPCAttackPopupMediator;
   import wom.view.mediator.screen.popups.npcattack.mobile.MobileNPCAttackRepelledPopupMediator;
   import wom.view.mediator.screen.popups.passafriend.MobileAvatarWithArrowViewMediator;
   import wom.view.mediator.screen.popups.passafriend.MobilePassAFriendPopUpMediator;
   import wom.view.mediator.screen.popups.peakpay.MobileChoosePaymentProviderPopUpMediator;
   import wom.view.mediator.screen.popups.quest.MobileQuestCompletedPopupMediator;
   import wom.view.mediator.screen.popups.repair.MobileRepairNewPopUpMediator;
   import wom.view.mediator.screen.popups.repair.MobileRepairPopUpMediator;
   import wom.view.mediator.screen.popups.resource.MobileResourceCapacityExceedsPopupMediator;
   import wom.view.mediator.screen.popups.topoff.MobileBaseTopOffResourcesPopUpMediator;
   import wom.view.mediator.screen.popups.topoff.MobileConstructTopOffResourcesPopUpMediator;
   import wom.view.mediator.screen.popups.topoff.MobileDefaultTopOffResourcesPopUpMediator;
   import wom.view.mediator.screen.popups.tournament.MobileTournamentEndedPopUpMediator;
   import wom.view.mediator.screen.popups.tournament.MobileTournamentRewardViewMediator;
   import wom.view.mediator.screen.popups.underattack.MobileAlreadyUnderAttackPopUpMediator;
   import wom.view.mediator.screen.popups.underattack.MobileAuthErrorPopupMediator;
   import wom.view.mediator.screen.popups.unit.MobileGenericStopPopUpMediator;
   import wom.view.mediator.screen.popups.unit.MobileGenericUnitCompletionPopUpMediator;
   import wom.view.mediator.screen.popups.unit.MobileNotEnoughResourcePopUpMediator;
   import wom.view.mediator.screen.popups.unit.MobileRecruitmentCompletedPopUpMediator;
   import wom.view.mediator.screen.popups.unit.MobileRecruitmentStopPopUpMediator;
   import wom.view.mediator.screen.popups.unit.MobileTrainingCompletedPopUpMediator;
   import wom.view.mediator.screen.popups.unit.MobileTrainingStopPopUpMediator;
   import wom.view.mediator.screen.windows.MobileCityPlannerLoadWindowMediator;
   import wom.view.mediator.screen.windows.MobileCityPlannerSaveWindowMediator;
   import wom.view.mediator.screen.windows.MobileSettingsWindowMediator;
   import wom.view.mediator.screen.windows.MobileWebViewWindowMediator;
   import wom.view.mediator.screen.windows.activate.MobileActivateBuildingWindowMediator;
   import wom.view.mediator.screen.windows.activate.MobileRequiredItemViewMediator;
   import wom.view.mediator.screen.windows.alliance.coa.mobile.MobileVanityColorPaletteViewMediator;
   import wom.view.mediator.screen.windows.alliance.coa.mobile.MobileVanityColorSelectorViewMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileAllianceBarracksTransferWindowMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileAllianceCandidatesListPanelMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileAllianceCandidatesPanelMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileAllianceGeneralInfoPanelMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileAllianceMembersPanelMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileAlliancePanelMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileAllianceTipsPopUpMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileAllianceTournamentListPanelMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileAllianceTournamentPanelMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileAllianceTournamentTipsPopUpMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileAllianceWindowMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileBrowseAllianceListPanelMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileBrowseAlliancePanelMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileCreateAlliancePanelMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileEditCoatOfArmsPanelMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileLeaderboardBrowseAllianceListPanelMediator;
   import wom.view.mediator.screen.windows.alliance.mobile.MobileMyAllianceMembersPanelMediator;
   import wom.view.mediator.screen.windows.announcement.MobileAnnouncementPanelMediator;
   import wom.view.mediator.screen.windows.announcement.MobileAnnouncementWindowMediator;
   import wom.view.mediator.screen.windows.beast.cave.MobileBeastCaveBeastKeeperPanelMediator;
   import wom.view.mediator.screen.windows.beast.cave.MobileBeastCaveWindowMediator;
   import wom.view.mediator.screen.windows.beast.cave.MobileBeastPanelMediator;
   import wom.view.mediator.screen.windows.beast.cave.MobileDailyFeedPanelMediator;
   import wom.view.mediator.screen.windows.beast.cave.MobileEvolutionPanelMediator;
   import wom.view.mediator.screen.windows.beast.keeper.MobileBeastKeeperPanelMediator;
   import wom.view.mediator.screen.windows.beast.keeper.MobileBeastKeeperWindowMediator;
   import wom.view.mediator.screen.windows.blacksmith.MobileBlacksmithInventoryPanelMediator;
   import wom.view.mediator.screen.windows.blacksmith.MobileBlacksmithSelectEventItemPanelMediator;
   import wom.view.mediator.screen.windows.blacksmith.MobileBlacksmithWindowMediator;
   import wom.view.mediator.screen.windows.build.MobileBuildCategoryPanelMediator;
   import wom.view.mediator.screen.windows.build.MobileBuildDecorationCategoryPanelMediator;
   import wom.view.mediator.screen.windows.build.MobileBuildShowcaseWindowMediator;
   import wom.view.mediator.screen.windows.build.MobileBuildingSilhouetteMediator;
   import wom.view.mediator.screen.windows.build.MobileConstructBuildingWindowMediator;
   import wom.view.mediator.screen.windows.build.MobileDecorationCategoryTabMediator;
   import wom.view.mediator.screen.windows.build.MobileFlagSilhouetteMediator;
   import wom.view.mediator.screen.windows.build.MobileRearmTrapsWindowMediator;
   import wom.view.mediator.screen.windows.cancelconstruction.MobileCancelConstructionWindowMediatior;
   import wom.view.mediator.screen.windows.catapult.MobileCatapultElementRechargeViewMediator;
   import wom.view.mediator.screen.windows.catapult.MobileCatapultRechargeWindowMediator;
   import wom.view.mediator.screen.windows.cityplanner.MobileCityPlannerExitPopUpMediator;
   import wom.view.mediator.screen.windows.constructionsite.MobileCityCenterConstructionSiteWindowMediator;
   import wom.view.mediator.screen.windows.constructionsite.MobileConstructionSiteWindowMediator;
   import wom.view.mediator.screen.windows.event.MobileEventStorePanelMediator;
   import wom.view.mediator.screen.windows.executionalguillotine.MobileExecutionalGuillotineMercenaryViewMediator;
   import wom.view.mediator.screen.windows.executionalguillotine.MobileExecutionalGuillotineWindowMediator;
   import wom.view.mediator.screen.windows.fortify.MobileFortifyWindowMediator;
   import wom.view.mediator.screen.windows.friends.mobile.MobileSelectFriendsWindowMediator;
   import wom.view.mediator.screen.windows.general.MobileContactSupportWindowMediator;
   import wom.view.mediator.screen.windows.general.MobileGeneralInformationWindowMediator;
   import wom.view.mediator.screen.windows.gift.mobile.MobileGiftPanelMediator;
   import wom.view.mediator.screen.windows.gold.MobileGetGoldProductViewMediator;
   import wom.view.mediator.screen.windows.gold.MobileGetGoldWindowMediator;
   import wom.view.mediator.screen.windows.hiringquarters.MobileCentralHiringQuartersWindowMediator;
   import wom.view.mediator.screen.windows.hiringquarters.MobileHiringQuartersMercenaryViewMediator;
   import wom.view.mediator.screen.windows.hiringquarters.MobileHiringQuartersWindowMediator;
   import wom.view.mediator.screen.windows.inbox.mobile.MobileAllianceInvitationRequestViewMediator;
   import wom.view.mediator.screen.windows.inbox.mobile.MobileBaseRequestViewMediator;
   import wom.view.mediator.screen.windows.inbox.mobile.MobileGiftRequestViewMediator;
   import wom.view.mediator.screen.windows.inbox.mobile.MobileInboxPanelMediator;
   import wom.view.mediator.screen.windows.inbox.mobile.MobileInboxWindowMediator;
   import wom.view.mediator.screen.windows.inbox.mobile.MobileMysteryGoldRequestViewMediator;
   import wom.view.mediator.screen.windows.inbox.mobile.MobileMysteryResourceRequestViewMediator;
   import wom.view.mediator.screen.windows.inbox.mobile.MobileMysteryRpRequestViewMediator;
   import wom.view.mediator.screen.windows.inbox.mobile.MobilePartRequestViewMediator;
   import wom.view.mediator.screen.windows.inbox.mobile.MobileRequestContainerViewMediator;
   import wom.view.mediator.screen.windows.inbox.mobile.MobileRewardRequestViewMediator;
   import wom.view.mediator.screen.windows.league.mobile.MobileLeagueGeneralInfoPanelMediator;
   import wom.view.mediator.screen.windows.league.mobile.MobileLeagueHeaderPanelMediator;
   import wom.view.mediator.screen.windows.league.mobile.MobileLeagueInfoMediumViewMediator;
   import wom.view.mediator.screen.windows.league.mobile.MobileLeagueInfoSmallViewMediator;
   import wom.view.mediator.screen.windows.league.mobile.MobileLeagueMembersListPanelMediator;
   import wom.view.mediator.screen.windows.league.mobile.MobileLeaguePanelMediator;
   import wom.view.mediator.screen.windows.map.MobileMapListPanelMediator;
   import wom.view.mediator.screen.windows.map.MobileMapListWindowMediator;
   import wom.view.mediator.screen.windows.pigeonpost.MobilePigeonPostWindowMediator;
   import wom.view.mediator.screen.windows.quest.MobileQuestDetailTaskViewMediator;
   import wom.view.mediator.screen.windows.quest.MobileQuestDetailWindowMediator;
   import wom.view.mediator.screen.windows.quest.MobileQuestRowViewMediator;
   import wom.view.mediator.screen.windows.quest.MobileQuestWindowMediator;
   import wom.view.mediator.screen.windows.quest.MobileRewardGroupViewMediator;
   import wom.view.mediator.screen.windows.rank.mobile.MobileBaseRankingPanelMediator;
   import wom.view.mediator.screen.windows.rank.mobile.MobileLeaderboardWindowMediator;
   import wom.view.mediator.screen.windows.recruitmentchamber.MobileRecruitmentChamberWindowMediator;
   import wom.view.mediator.screen.windows.recycle.MobileRecycleDecorationWindowMediator;
   import wom.view.mediator.screen.windows.recycle.MobileRecycleTrapWindowMediator;
   import wom.view.mediator.screen.windows.report.attacklog.mobile.MobileAttackLogPanelMediator;
   import wom.view.mediator.screen.windows.report.battlereport.MobileBattleReportDetailViewMediator;
   import wom.view.mediator.screen.windows.report.battlereport.MobileBattleReportGeneralInfoViewMediator;
   import wom.view.mediator.screen.windows.report.battlereport.MobileBattleReportWindowMediator;
   import wom.view.mediator.screen.windows.social.MobileSocialMainWindowMediator;
   import wom.view.mediator.screen.windows.staff.MobileRequiredStaffViewMediator;
   import wom.view.mediator.screen.windows.staff.MobileRequiredStaffsPanelMediator;
   import wom.view.mediator.screen.windows.store.MobileCurrentProgressViewMediator;
   import wom.view.mediator.screen.windows.store.MobileHireWorkerWindowMediator;
   import wom.view.mediator.screen.windows.store.MobileInventoryCategoryPanelMediator;
   import wom.view.mediator.screen.windows.store.MobileInventoryPanelMediator;
   import wom.view.mediator.screen.windows.store.MobileStoreCategoryPanelMediator;
   import wom.view.mediator.screen.windows.store.MobileStorePanelMediator;
   import wom.view.mediator.screen.windows.store.MobileStoreWindowMediator;
   import wom.view.mediator.screen.windows.tavern.MobileTavernGiftViewMediator;
   import wom.view.mediator.screen.windows.tavern.MobileTavernUnlockPanelMediator;
   import wom.view.mediator.screen.windows.tavern.MobileTavernWheelSliceViewMediator;
   import wom.view.mediator.screen.windows.tavern.MobileTavernWheelViewMediator;
   import wom.view.mediator.screen.windows.tavern.MobileTavernWindowMediator;
   import wom.view.mediator.screen.windows.tavern.unlock.MobileBaseTavernUnlockedCardViewMediator;
   import wom.view.mediator.screen.windows.tavern.unlock.MobileTavernUnlockedBeastViewMediator;
   import wom.view.mediator.screen.windows.trainingchamber.MobileTrainingChamberWindowMediator;
   import wom.view.mediator.screen.windows.transfer.MobileMercenaryTransferWindowMediator;
   import wom.view.mediator.screen.windows.tuskhorn.MobileTuskHornMercenaryViewMediator;
   import wom.view.mediator.screen.windows.tuskhorn.MobileTuskHornWindowMediator;
   import wom.view.mediator.screen.windows.upgrade.MobileUpgradeBuildingWithRequirementPanelMediator;
   import wom.view.mediator.screen.windows.upgrade.MobileUpgradeComperativePanelMediator;
   import wom.view.mediator.screen.windows.upgrade.MobileUpgradeWindowMediator;
   import wom.view.mediator.screen.windows.watchpost.MobileFriendWatchPostTransferWindowMediator;
   import wom.view.mediator.screen.windows.watchpost.MobileWatchPostWindowMediator;
   import wom.view.mediator.ui.MobileCanvasOptionsPanelMediator;
   import wom.view.mediator.ui.MobileLoadingLayerMediator;
   import wom.view.mediator.ui.MobileWomCuckooUILayerMediator;
   import wom.view.mediator.ui.WomStarlingCuckooOverlayMediator;
   import wom.view.mediator.ui.common.MobileCondenseButtonViewMediator;
   import wom.view.mediator.ui.common.MobileIconLabelViewExtraMediator;
   import wom.view.mediator.ui.common.MobileIconLabelViewMediator;
   import wom.view.mediator.ui.common.MobileInboxMenuButtonViewMediator;
   import wom.view.mediator.ui.common.MobileLightAnimationViewMediator;
   import wom.view.mediator.ui.common.MobileListHeaderViewMediator;
   import wom.view.mediator.ui.common.MobileOrViewMediator;
   import wom.view.mediator.ui.common.MobileSharingPermissionsViewMediator;
   import wom.view.mediator.ui.common.MobileSpeechBubbleViewMediator;
   import wom.view.mediator.ui.mainframe.MobileCityPlannerUILayerMediator;
   import wom.view.mediator.ui.mainframe.MobileCombatHelpTextLayerMediator;
   import wom.view.mediator.ui.mainframe.MobileFloatingTextLayerMediator;
   import wom.view.mediator.ui.mainframe.city.MobileChatPanelMediator;
   import wom.view.mediator.ui.mainframe.city.MobileCityUILayerMediator;
   import wom.view.mediator.ui.mainframe.city.MobileCurrencyPanelMediator;
   import wom.view.mediator.ui.mainframe.city.MobileGetWomkongPanelMediator;
   import wom.view.mediator.ui.mainframe.city.MobileMenuPanelMediator;
   import wom.view.mediator.ui.mainframe.city.MobileNPCAttackCountDownPanelMediator;
   import wom.view.mediator.ui.mainframe.city.MobileProtectionPanelMediator;
   import wom.view.mediator.ui.mainframe.city.MobileResourceBarMediator;
   import wom.view.mediator.ui.mainframe.city.MobileResourcePanelMediator;
   import wom.view.mediator.ui.mainframe.city.MobileSpecialOfferPanelMediator;
   import wom.view.mediator.ui.mainframe.city.MobileWorkerPanelMediator;
   import wom.view.mediator.ui.mainframe.city.chat.MobileChatMutePanelMediator;
   import wom.view.mediator.ui.mainframe.city.chat.MobileChatScrollPanelMediator;
   import wom.view.mediator.ui.mainframe.city.friends.mobile.MobileFriendsPanelMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVBeastCannonViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVBeastCaveViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVBeastKeeperViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVBoostViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVCatapultViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVCityPlannerViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVConstructViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVDecorationViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVDefensiveViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVEnterViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVIdleViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVIncompleteViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVRepairViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVResourceViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVTrapViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVUpgradeViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVWallViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MCOVWorkViewMediator;
   import wom.view.mediator.ui.mainframe.city.mobile.MobileConstructableOptionsViewMediator;
   import wom.view.mediator.ui.mainframe.city.notification.MobileUserNotificationPanelMediator;
   import wom.view.mediator.ui.mainframe.city.notification.MobileUserNotificationViewMediator;
   import wom.view.mediator.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipBeastCannonInfoViewMediator;
   import wom.view.mediator.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipBeastCaveInfoViewMediator;
   import wom.view.mediator.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipCatapultInfoViewMediator;
   import wom.view.mediator.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipDefenseInfoViewMediator;
   import wom.view.mediator.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipHousingInfoViewMediator;
   import wom.view.mediator.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipProductionProgressInfoViewMediator;
   import wom.view.mediator.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipProgressInfoViewMediator;
   import wom.view.mediator.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipWithOneProgressInfoViewMediator;
   import wom.view.mediator.ui.mainframe.city.tooltip.mobile.MobileTooltipInfoViewMediator;
   import wom.view.mediator.ui.mainframe.combat.MobileBaseBottomMainframePanelMediator;
   import wom.view.mediator.ui.mainframe.combat.MobileBattleClockViewMediator;
   import wom.view.mediator.ui.mainframe.combat.MobileCombatMenuPanelMediator;
   import wom.view.mediator.ui.mainframe.combat.MobileCombatUILayerMediator;
   import wom.view.mediator.ui.mainframe.combat.MobileMercenaryDeployTabBeastViewMediator;
   import wom.view.mediator.ui.mainframe.combat.MobileMercenaryDeployTabMediator;
   import wom.view.mediator.ui.mainframe.combat.MobileMercenaryDeployTabMercenaryViewMediator;
   import wom.view.mediator.ui.mainframe.combat.MobileVictoryMeterPanelMediator;
   import wom.view.mediator.ui.mainframe.combat.catapult.MobileCatapultCombatRechargePopUpMediator;
   import wom.view.mediator.ui.mainframe.combat.catapult.MobileCatapultMenuOptionViewMediator;
   import wom.view.mediator.ui.mainframe.combat.catapult.MobileCatapultMenuOptionsViewMediator;
   import wom.view.mediator.ui.mainframe.combat.catapult.MobileCatapultMenuTabMediator;
   import wom.view.mediator.ui.mainframe.combat.catapult.MobileCatapultMenuViewMediator;
   import wom.view.mediator.ui.mainframe.combat.eventitems.MobileCatapultEventItemViewMediator;
   import wom.view.mediator.ui.mainframe.combat.eventitems.MobileCombatBuildingEventItemViewMediator;
   import wom.view.mediator.ui.mainframe.combat.eventitems.MobileCombatEventItemViewMediator;
   import wom.view.mediator.ui.mainframe.combat.eventitems.MobileCombatMenuEventItemsPanelMediator;
   import wom.view.mediator.ui.mainframe.combat.eventitems.MobileMercenaryEventItemViewMediator;
   import wom.view.mediator.ui.mainframe.visit.MobileLandlordPanelMediator;
   import wom.view.mediator.ui.mainframe.visit.MobileVisitMenuPanelMediator;
   import wom.view.mediator.ui.mainframe.visit.MobileVisitUILayerMediator;
   import wom.view.mediator.ui.tooltip.MobileBaseTooltipViewMediator;
   import wom.view.mediator.ui.tooltip.MobileExperiencePointsTooltipViewMediator;
   import wom.view.mediator.ui.tooltip.MobileResourceBarTooltipViewMediator;
   import wom.view.mediator.ui.tooltip.MobileTooltipLayerMediator;
   import wom.view.mediator.ui.tutorial.mobile.MobileDeployHandViewMediator;
   import wom.view.mediator.ui.tutorial.mobile.MobileGenericTutorialWindowMediator;
   import wom.view.mediator.ui.tutorial.mobile.MobileTutorialGirlViewMediator;
   import wom.view.mediator.ui.tutorial.mobile.MobileTutorialLayerMediator;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.mediator.util.MobileFooWindowMediator;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.MobileBoostButtonView;
   import wom.view.screen.MobileCityPlannerScreen;
   import wom.view.screen.MobileCityScreen;
   import wom.view.screen.MobileLoadingScreen;
   import wom.view.screen.MobileManualAuthenticationScreen;
   import wom.view.screen.MobileMapScreen;
   import wom.view.screen.MobileRootScreen;
   import wom.view.screen.popups.MobileAnyoneHomePopUp;
   import wom.view.screen.popups.MobileAuthErrorPopup;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.screen.popups.MobileBeastConfirmationPopUp;
   import wom.view.screen.popups.MobileBeastUnleashedPopUp;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   import wom.view.screen.popups.MobileDidYouKnowPopUp;
   import wom.view.screen.popups.MobileDidYouKnowPopUpMediator;
   import wom.view.screen.popups.MobileDisconnectPopUp;
   import wom.view.screen.popups.MobileDontKillMePopUp;
   import wom.view.screen.popups.MobileFeatureAvailablePopUp;
   import wom.view.screen.popups.MobileFortificationCompletedPopUp;
   import wom.view.screen.popups.MobileGenericActionPopUp;
   import wom.view.screen.popups.MobileGuestNamingPopUp;
   import wom.view.screen.popups.MobileJobCapacityAlreadyReachedPopUp;
   import wom.view.screen.popups.MobileLeaveGamePopUp;
   import wom.view.screen.popups.MobileOutOfOffersPopUp;
   import wom.view.screen.popups.MobileSpecialOfferPopUp;
   import wom.view.screen.popups.MobileStoreItemPurchasedPopUp;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   import wom.view.screen.popups.attack.MobileAttackWarnPopup;
   import wom.view.screen.popups.emailpermission.MobileEmailPermissionDeniedPopUp;
   import wom.view.screen.popups.emailpermission.MobileEmailPermissionPopUp;
   import wom.view.screen.popups.event.MobileEventAnnouncementPopUp;
   import wom.view.screen.popups.event.MobileEventOngoingPanel;
   import wom.view.screen.popups.event.MobileEventPopUp;
   import wom.view.screen.popups.event.MobileEventPopUpEventStorePanel;
   import wom.view.screen.popups.expandcity.MobileExpandCityPopUp;
   import wom.view.screen.popups.facebook.MobileFBConfirmationPopUp;
   import wom.view.screen.popups.facebook.MobileFBConnectToSendGiftPanel;
   import wom.view.screen.popups.facebook.MobileFBGetGoldPopUp;
   import wom.view.screen.popups.facebook.MobileFBProgressPopUp;
   import wom.view.screen.popups.finishnow.MobileFinishNowHiringPopUp;
   import wom.view.screen.popups.friendwatchpost.MobileFriendWatchpostHelpPopUp;
   import wom.view.screen.popups.help.MobileHelpedFriendPopUp;
   import wom.view.screen.popups.league.MobileLeagueSeasonEndedPopUp;
   import wom.view.screen.popups.league.MobileLeagueSeasonEndedSuccessPopUp;
   import wom.view.screen.popups.league.MobileLeagueStatusChangedPopUp;
   import wom.view.screen.popups.league.MobileLeagueStatusDroppedPopUp;
   import wom.view.screen.popups.league.MobileLeagueStatusPlacedPopUp;
   import wom.view.screen.popups.levelup.MobileLevelupPopup;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.popups.npcattack.MobileNPCAttackPopupBatchView;
   import wom.view.screen.popups.npcattack.mobile.MobileNPCAttackPopup;
   import wom.view.screen.popups.npcattack.mobile.MobileNPCAttackRepelledPopup;
   import wom.view.screen.popups.passafriend.MobileAvatarWithArrowView;
   import wom.view.screen.popups.passafriend.MobilePassAFriendPopUp;
   import wom.view.screen.popups.peakpay.MobileChoosePaymentProviderPopUp;
   import wom.view.screen.popups.quest.MobileQuestCompletedPopup;
   import wom.view.screen.popups.repair.MobileRepairNewPopUp;
   import wom.view.screen.popups.repair.MobileRepairPopUp;
   import wom.view.screen.popups.resource.MobileBoostConfirmationPopUp;
   import wom.view.screen.popups.resource.MobileResourceCapacityExceedsPopup;
   import wom.view.screen.popups.topoff.MobileBaseTopOffResourcesPopUp;
   import wom.view.screen.popups.topoff.MobileConstructTopOffResourcesPopUp;
   import wom.view.screen.popups.topoff.MobileDefaultTopOffResourcesPopUp;
   import wom.view.screen.popups.tournament.MobileTournamentEndedPopUp;
   import wom.view.screen.popups.tournament.MobileTournamentRewardView;
   import wom.view.screen.popups.underattack.MobileAlreadyUnderAttackPopUp;
   import wom.view.screen.popups.unit.MobileGenericStopPopUp;
   import wom.view.screen.popups.unit.MobileGenericUnitCompletionPopUp;
   import wom.view.screen.popups.unit.MobileNotEnoughResourcePopUp;
   import wom.view.screen.popups.unit.MobileRecruitmentCompletedPopUp;
   import wom.view.screen.popups.unit.MobileRecruitmentStopPopUp;
   import wom.view.screen.popups.unit.MobileTrainingCompletedPopUp;
   import wom.view.screen.popups.unit.MobileTrainingStopPopUp;
   import wom.view.screen.windows.MobileCityPlannerSaveWindow;
   import wom.view.screen.windows.MobileWebViewWindow;
   import wom.view.screen.windows.activate.MobileActivateBuildingWindow;
   import wom.view.screen.windows.activate.MobileRequiredItemView;
   import wom.view.screen.windows.alliance.coa.mobile.MobileEditCoatOfArmsPanel;
   import wom.view.screen.windows.alliance.coa.mobile.MobileVanityColorPaletteView;
   import wom.view.screen.windows.alliance.coa.mobile.MobileVanityColorSelectorView;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceBarracksTransferWindow;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceCandidatesListPanel;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceCandidatesPanel;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceGeneralInfoPanel;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceMembersPanel;
   import wom.view.screen.windows.alliance.mobile.MobileAlliancePanel;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceTipsPopUp;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceTournamentListPanel;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceTournamentPanel;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceTournamentTipsPopUp;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceWindow;
   import wom.view.screen.windows.alliance.mobile.MobileBrowseAllianceListPanel;
   import wom.view.screen.windows.alliance.mobile.MobileBrowseAlliancePanel;
   import wom.view.screen.windows.alliance.mobile.MobileCreateAlliancePanel;
   import wom.view.screen.windows.alliance.mobile.MobileLeaderboardBrowseAllianceListPanel;
   import wom.view.screen.windows.alliance.mobile.MobileMyAllianceMembersPanel;
   import wom.view.screen.windows.alliance.mobile.MobileMyAlliancePanel;
   import wom.view.screen.windows.announcement.MobileAnnouncementPanel;
   import wom.view.screen.windows.announcement.MobileAnnouncementWindow;
   import wom.view.screen.windows.battlepoints.MobileBattlePointsInfoWindow;
   import wom.view.screen.windows.beast.cave.MobileBeastCaveBeastKeeperPanel;
   import wom.view.screen.windows.beast.cave.MobileBeastCaveWindow;
   import wom.view.screen.windows.beast.cave.MobileBeastPanel;
   import wom.view.screen.windows.beast.cave.MobileDailyFeedPanel;
   import wom.view.screen.windows.beast.cave.MobileEvolutionPanel;
   import wom.view.screen.windows.beast.keeper.MobileBeastKeeperPanel;
   import wom.view.screen.windows.beast.keeper.MobileBeastKeeperWindow;
   import wom.view.screen.windows.beastcage.MobileBeastCageWindow;
   import wom.view.screen.windows.blacksmith.MobileBlacksmithEventItemInfoPanel;
   import wom.view.screen.windows.blacksmith.MobileBlacksmithInventoryPanel;
   import wom.view.screen.windows.blacksmith.MobileBlacksmithSelectEventItemPanel;
   import wom.view.screen.windows.blacksmith.MobileBlacksmithWindow;
   import wom.view.screen.windows.build.MobileBuildCategoryPanel;
   import wom.view.screen.windows.build.MobileBuildDecorationCategoryPanel;
   import wom.view.screen.windows.build.MobileBuildShowcaseWindow;
   import wom.view.screen.windows.build.MobileBuildingSilhouette;
   import wom.view.screen.windows.build.MobileConstructBuildingWindow;
   import wom.view.screen.windows.build.MobileDecorationCategoryTab;
   import wom.view.screen.windows.build.MobileFlagSilhouette;
   import wom.view.screen.windows.build.MobileRearmTrapsWindow;
   import wom.view.screen.windows.cancelconstruction.MobileCancelConstructionWindow;
   import wom.view.screen.windows.catapult.MobileCatapultElementRechargeView;
   import wom.view.screen.windows.catapult.MobileCatapultRechargeWindow;
   import wom.view.screen.windows.cityplanner.MobileCityPlannerExitPopUp;
   import wom.view.screen.windows.cityplanner.MobileCityPlannerLoadWindow;
   import wom.view.screen.windows.constructionsite.MobileCityCenterConstructionSiteWindow;
   import wom.view.screen.windows.constructionsite.MobileConstructionSiteWindow;
   import wom.view.screen.windows.event.MobileEventStorePanel;
   import wom.view.screen.windows.event.MobileEventStoreWindow;
   import wom.view.screen.windows.executionalguillotine.MobileAllianceBarracksWindow;
   import wom.view.screen.windows.executionalguillotine.MobileExecutionalGuillotineMercenaryView;
   import wom.view.screen.windows.executionalguillotine.MobileExecutionalGuillotineWindow;
   import wom.view.screen.windows.executionalguillotine.MobileFriendWatchPostWindow;
   import wom.view.screen.windows.fortify.MobileFortifyWindow;
   import wom.view.screen.windows.friends.mobile.MobileSelectFriendsWindow;
   import wom.view.screen.windows.general.MobileContactSupportWindow;
   import wom.view.screen.windows.general.MobileGeneralInformationWindow;
   import wom.view.screen.windows.gift.mobile.MobileGiftPanel;
   import wom.view.screen.windows.gold.MobileGetGoldProductView;
   import wom.view.screen.windows.gold.MobileGetGoldWindow;
   import wom.view.screen.windows.hiringquarters.MobileCentralHiringQuartersWindow;
   import wom.view.screen.windows.hiringquarters.MobileHiringQuartersMercenaryView;
   import wom.view.screen.windows.hiringquarters.MobileHiringQuartersWindow;
   import wom.view.screen.windows.inbox.mobile.MobileAllianceInvitationRequestView;
   import wom.view.screen.windows.inbox.mobile.MobileBaseRequestView;
   import wom.view.screen.windows.inbox.mobile.MobileGiftRequestView;
   import wom.view.screen.windows.inbox.mobile.MobileInboxPanel;
   import wom.view.screen.windows.inbox.mobile.MobileInboxWindow;
   import wom.view.screen.windows.inbox.mobile.MobileMysteryGoldRequestView;
   import wom.view.screen.windows.inbox.mobile.MobileMysteryResourceRequestView;
   import wom.view.screen.windows.inbox.mobile.MobileMysteryRpRequestView;
   import wom.view.screen.windows.inbox.mobile.MobilePartRequestView;
   import wom.view.screen.windows.inbox.mobile.MobileRequestContainerView;
   import wom.view.screen.windows.inbox.mobile.MobileRewardRequestView;
   import wom.view.screen.windows.inbox.mobile.MobileStaffRequestView;
   import wom.view.screen.windows.inbox.mobile.MobileWorkerStaffRequestView;
   import wom.view.screen.windows.league.mobile.MobileLeagueGeneralInfoPanel;
   import wom.view.screen.windows.league.mobile.MobileLeagueHeaderPanel;
   import wom.view.screen.windows.league.mobile.MobileLeagueInfoMediumView;
   import wom.view.screen.windows.league.mobile.MobileLeagueInfoSmallView;
   import wom.view.screen.windows.league.mobile.MobileLeagueMembersListPanel;
   import wom.view.screen.windows.league.mobile.MobileLeaguePanel;
   import wom.view.screen.windows.map.MobileMapListPanel;
   import wom.view.screen.windows.map.MobileMapListWindow;
   import wom.view.screen.windows.mercenarybarracks.MobileMercenaryBarracksWindow;
   import wom.view.screen.windows.pigeonpost.MobilePigeonPostWindow;
   import wom.view.screen.windows.quest.MobileQuestDetailTaskView;
   import wom.view.screen.windows.quest.MobileQuestDetailWindow;
   import wom.view.screen.windows.quest.MobileQuestRowView;
   import wom.view.screen.windows.quest.MobileQuestWindow;
   import wom.view.screen.windows.quest.MobileRewardGroupView;
   import wom.view.screen.windows.rank.mobile.MobileBaseRankingPanel;
   import wom.view.screen.windows.rank.mobile.MobileLeaderboardWindow;
   import wom.view.screen.windows.rank.mobile.MobilePlayerScoresPanel;
   import wom.view.screen.windows.rank.mobile.MobileTopLootersPanel;
   import wom.view.screen.windows.rank.mobile.MobileXPRankingPanel;
   import wom.view.screen.windows.recruitmentchamber.MobileRecruitmentChamberWindow;
   import wom.view.screen.windows.recycle.MobileRecycleDecorationWindow;
   import wom.view.screen.windows.recycle.MobileRecycleTrapWindow;
   import wom.view.screen.windows.report.attacklog.mobile.MobileAttackLogPanel;
   import wom.view.screen.windows.report.battlereport.MobileBattleReportDetailView;
   import wom.view.screen.windows.report.battlereport.MobileBattleReportGeneralInfoView;
   import wom.view.screen.windows.report.battlereport.MobileBattleReportWindow;
   import wom.view.screen.windows.settings.MobileSettingsWindow;
   import wom.view.screen.windows.social.MobileSocialMainWindow;
   import wom.view.screen.windows.staff.MobileRequiredStaffView;
   import wom.view.screen.windows.staff.MobileRequiredStaffsPanel;
   import wom.view.screen.windows.store.MobileCurrentProgressView;
   import wom.view.screen.windows.store.MobileHireWorkerWindow;
   import wom.view.screen.windows.store.MobileInventoryCategoryPanel;
   import wom.view.screen.windows.store.MobileInventoryPanel;
   import wom.view.screen.windows.store.MobileStoreCategoryPanel;
   import wom.view.screen.windows.store.MobileStorePanel;
   import wom.view.screen.windows.store.MobileStoreWindow;
   import wom.view.screen.windows.tavern.MobileTavernGiftView;
   import wom.view.screen.windows.tavern.MobileTavernUnlockPanel;
   import wom.view.screen.windows.tavern.MobileTavernWheelSliceView;
   import wom.view.screen.windows.tavern.MobileTavernWheelView;
   import wom.view.screen.windows.tavern.MobileTavernWindow;
   import wom.view.screen.windows.tavern.unlock.MobileBaseTavernUnlockedCardView;
   import wom.view.screen.windows.tavern.unlock.MobileTavernUnlockedBeastView;
   import wom.view.screen.windows.tavern.unlock.MobileTavernUnlockedCardView;
   import wom.view.screen.windows.trainingchamber.MobileTrainingChamberWindow;
   import wom.view.screen.windows.transfer.MobileMercenaryTransferWindow;
   import wom.view.screen.windows.tuskhorn.MobileTuskHornMercenaryView;
   import wom.view.screen.windows.tuskhorn.MobileTuskHornWindow;
   import wom.view.screen.windows.upgrade.MobileUpgradeBuildingWithRequirementPanel;
   import wom.view.screen.windows.upgrade.MobileUpgradeCityCenterPanel;
   import wom.view.screen.windows.upgrade.MobileUpgradeComperativePanel;
   import wom.view.screen.windows.upgrade.MobileUpgradeInformativePanel;
   import wom.view.screen.windows.upgrade.MobileUpgradeWindow;
   import wom.view.screen.windows.watchpost.MobileFriendWatchPostTransferWindow;
   import wom.view.screen.windows.watchpost.MobileWatchPostWindow;
   import wom.view.ui.MobileCanvasOptionsPanel;
   import wom.view.ui.MobileCombatHelpTextLayer;
   import wom.view.ui.MobileFloatingTextLayer;
   import wom.view.ui.MobileLoadingLayer;
   import wom.view.ui.MobileWomCuckooUILayer;
   import wom.view.ui.common.MobileCondenseButtonView;
   import wom.view.ui.common.MobileIconLabelView;
   import wom.view.ui.common.MobileIconLabelViewExtra;
   import wom.view.ui.common.MobileInboxMenuButtonView;
   import wom.view.ui.common.MobileLightAnimationView;
   import wom.view.ui.common.MobileListHeaderView;
   import wom.view.ui.common.MobileMercenaryButtonView;
   import wom.view.ui.common.MobileOrView;
   import wom.view.ui.common.MobileResourceView;
   import wom.view.ui.common.MobileSharingPermissionsView;
   import wom.view.ui.common.MobileSpeechBubbleView;
   import wom.view.ui.mainframe.MobileUILayer;
   import wom.view.ui.mainframe.city.MobileCityPlannerUILayer;
   import wom.view.ui.mainframe.city.MobileCityUILayer;
   import wom.view.ui.mainframe.city.MobileCurrencyPanel;
   import wom.view.ui.mainframe.city.MobileGetWomkongPanel;
   import wom.view.ui.mainframe.city.MobileLandlordPanel;
   import wom.view.ui.mainframe.city.MobileMenuPanel;
   import wom.view.ui.mainframe.city.MobileNPCAttackCountDownPanel;
   import wom.view.ui.mainframe.city.MobileProtectionPanel;
   import wom.view.ui.mainframe.city.MobileResourceBar;
   import wom.view.ui.mainframe.city.MobileResourcePanel;
   import wom.view.ui.mainframe.city.MobileSpecialOfferPanel;
   import wom.view.ui.mainframe.city.MobileWorkerPanel;
   import wom.view.ui.mainframe.city.chat.MobileChatMutePanel;
   import wom.view.ui.mainframe.city.chat.MobileChatPanel;
   import wom.view.ui.mainframe.city.chat.MobileChatScrollPanel;
   import wom.view.ui.mainframe.city.friends.mobile.MobileFriendsPanel;
   import wom.view.ui.mainframe.city.mobile.MCOVBeastCannonView;
   import wom.view.ui.mainframe.city.mobile.MCOVBeastCaveView;
   import wom.view.ui.mainframe.city.mobile.MCOVBeastKeeperView;
   import wom.view.ui.mainframe.city.mobile.MCOVBoostView;
   import wom.view.ui.mainframe.city.mobile.MCOVCatapultView;
   import wom.view.ui.mainframe.city.mobile.MCOVCityPlannerView;
   import wom.view.ui.mainframe.city.mobile.MCOVConstructView;
   import wom.view.ui.mainframe.city.mobile.MCOVDecorationView;
   import wom.view.ui.mainframe.city.mobile.MCOVDefensiveView;
   import wom.view.ui.mainframe.city.mobile.MCOVEnterView;
   import wom.view.ui.mainframe.city.mobile.MCOVIdleView;
   import wom.view.ui.mainframe.city.mobile.MCOVIncompleteView;
   import wom.view.ui.mainframe.city.mobile.MCOVRepairView;
   import wom.view.ui.mainframe.city.mobile.MCOVResourceView;
   import wom.view.ui.mainframe.city.mobile.MCOVTrapView;
   import wom.view.ui.mainframe.city.mobile.MCOVUpgradeView;
   import wom.view.ui.mainframe.city.mobile.MCOVWallView;
   import wom.view.ui.mainframe.city.mobile.MCOVWorkView;
   import wom.view.ui.mainframe.city.mobile.MobileConstructableOptionsView;
   import wom.view.ui.mainframe.city.notification.MobileUserNotificationPanel;
   import wom.view.ui.mainframe.city.notification.MobileUserNotificationView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBaseBuildingTooltipView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipBeastCannonInfoView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipBeastCaveInfoView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipCatapultInfoView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipDefenseInfoView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipHousingInfoView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipProductionProgressInfoView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipProgressInfoView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipWithOneProgressInfoView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileTooltipInfoView;
   import wom.view.ui.mainframe.combat.MobileBaseBottomMainframePanel;
   import wom.view.ui.mainframe.combat.MobileBattleClockView;
   import wom.view.ui.mainframe.combat.MobileCombatMenuPanel;
   import wom.view.ui.mainframe.combat.MobileCombatUILayer;
   import wom.view.ui.mainframe.combat.MobileMercenaryDeployTab;
   import wom.view.ui.mainframe.combat.MobileMercenaryDeployTabMercenaryView;
   import wom.view.ui.mainframe.combat.MobileVictoryMeterPanel;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultCombatRechargePopUp;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultMenuOptionView;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultMenuOptionsView;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultMenuTab;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultMenuView;
   import wom.view.ui.mainframe.combat.eventitems.MobileCatapultEventItemView;
   import wom.view.ui.mainframe.combat.eventitems.MobileCombatBuildingEventItemView;
   import wom.view.ui.mainframe.combat.eventitems.MobileCombatEventItemView;
   import wom.view.ui.mainframe.combat.eventitems.MobileCombatMenuEventItemsPanel;
   import wom.view.ui.mainframe.combat.eventitems.MobileMercenaryEventItemView;
   import wom.view.ui.mainframe.combat.tooltip.MobileMercenaryDeployTabBeastView;
   import wom.view.ui.mainframe.visit.MobileVisitMenuPanel;
   import wom.view.ui.mainframe.visit.MobileVisitUILayer;
   import wom.view.ui.tooltip.MobileBaseTooltipView;
   import wom.view.ui.tooltip.MobileExperiencePointsTooltipView;
   import wom.view.ui.tooltip.MobileInformativeTooltipView;
   import wom.view.ui.tooltip.MobileResourceBarTooltipView;
   import wom.view.ui.tooltip.MobileTooltipLayer;
   import wom.view.ui.tooltip.MobileVictoryTooltipView;
   import wom.view.ui.tutorial.mobile.MobileDeployHandView;
   import wom.view.ui.tutorial.mobile.MobileGenericTutorialWindow;
   import wom.view.ui.tutorial.mobile.MobileTutorialGirlView;
   import wom.view.ui.tutorial.mobile.MobileTutorialLayer;
   import wom.view.util.MobileBaseWindowPanel;
   import wom.view.util.MobileButtonTabbedWindow;
   import wom.view.util.MobileFooWindow;
   import wom.view.util.MobileFullScreenWindow;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileBootstrapMediatorsCommand extends StarlingCommand
   {
      
      public function MobileBootstrapMediatorsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         mediatorMap.mapView(MobileClient,MobileClientMediator);
         mapScreenMediators();
         mapGeneralUIMediators();
         mapMainframeUIMediators();
         mapCombatUIMediators();
         mapCityPlannerUIMediators();
         mapWindowMediators();
         mapPopUpMediators();
         mapTutorialMediators();
         mapTooltipMediators();
      }
      
      private function mapScreenMediators() : void
      {
         mediatorMap.mapView(MobileLoadingLayer,MobileLoadingLayerMediator);
         mediatorMap.mapView(MobileFloatingTextLayer,MobileFloatingTextLayerMediator);
         mediatorMap.mapView(MobileCombatHelpTextLayer,MobileCombatHelpTextLayerMediator);
         mediatorMap.mapView(MobileRootScreen,MobileRootScreenMediator);
         mediatorMap.mapView(MobileCityScreen,MobileCityScreenMediator);
         mediatorMap.mapView(MobileCityPlannerScreen,MobileCityPlannerScreenMediator);
         mediatorMap.mapView(MobileMapScreen,MobileMapScreenMediator);
         mediatorMap.mapView(MobileLoadingScreen,MobileLoadingScreenMediator);
         mediatorMap.mapView(MobileManualAuthenticationScreen,MobileManualAuthenticationScreenMediator);
         mediatorMap.mapView(MobileGenericWindow,MobileGenericWindowMediator);
         mediatorMap.mapView(MobileFullScreenWindow,MobileGenericWindowMediator,MobileGenericWindow);
         mediatorMap.mapView(StarlingCuckooOverlay,WomStarlingCuckooOverlayMediator);
         mediatorMap.mapView(MobileWomCuckooUILayer,MobileWomCuckooUILayerMediator);
         mediatorMap.mapView(MobileCanvasOptionsPanel,MobileCanvasOptionsPanelMediator);
         mediatorMap.mapView(MobileWebViewWindow,MobileWebViewWindowMediator,[MobileWebViewWindow,MobileFullScreenWindow,MobileGenericWindow]);
      }
      
      private function mapGeneralUIMediators() : void
      {
         mediatorMap.mapView(MobileFooWindow,MobileFooWindowMediator);
         mediatorMap.mapView(MobileBuildingSilhouette,MobileBuildingSilhouetteMediator);
         mediatorMap.mapView(MobileFlagSilhouette,MobileFlagSilhouetteMediator);
         mediatorMap.mapView(MobileHireWorkerWindow,MobileHireWorkerWindowMediator,[MobileHireWorkerWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileStoreWindow,MobileStoreWindowMediator,[MobileStoreWindow,MobileButtonTabbedWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileCurrentProgressView,MobileCurrentProgressViewMediator);
         mediatorMap.mapView(MobileStorePanel,MobileStorePanelMediator);
         mediatorMap.mapView(MobileInventoryPanel,MobileInventoryPanelMediator);
         mediatorMap.mapView(MobileStoreCategoryPanel,MobileStoreCategoryPanelMediator);
         mediatorMap.mapView(MobileInventoryCategoryPanel,MobileInventoryCategoryPanelMediator);
         mediatorMap.mapView(MobileIconLabelView,MobileIconLabelViewMediator);
         mediatorMap.mapView(MobileIconLabelViewExtra,MobileIconLabelViewExtraMediator);
         mediatorMap.mapView(MobileCondenseButtonView,MobileCondenseButtonViewMediator);
         mediatorMap.mapView(MobileBoostButtonView,MobileCondenseButtonViewMediator,[MobileBoostButtonView,MobileCondenseButtonView]);
         mediatorMap.mapView(MobileBaseWindowPanel,MobileBaseWindowPanelMediator);
         mediatorMap.mapView(MobileResourceView,MobileIconLabelViewMediator,[MobileIconLabelView,MobileResourceView]);
         mediatorMap.mapView(MobileListHeaderView,MobileListHeaderViewMediator);
         mediatorMap.mapView(MobileLightAnimationView,MobileLightAnimationViewMediator);
         mediatorMap.mapView(MobileInboxMenuButtonView,MobileInboxMenuButtonViewMediator);
         mediatorMap.mapView(MobileSharingPermissionsView,MobileSharingPermissionsViewMediator);
      }
      
      private function mapMainframeUIMediators() : void
      {
         mediatorMap.mapView(MobileSpecialOfferPanel,MobileSpecialOfferPanelMediator);
         mediatorMap.mapView(MobileLandlordPanel,MobileLandlordPanelMediator);
         mediatorMap.mapView(MobileWorkerPanel,MobileWorkerPanelMediator);
         mediatorMap.mapView(MobileGetWomkongPanel,MobileGetWomkongPanelMediator);
         mediatorMap.mapView(MobileCurrencyPanel,MobileCurrencyPanelMediator);
         mediatorMap.mapView(MobileChatPanel,MobileChatPanelMediator);
         mediatorMap.mapView(MobileChatScrollPanel,MobileChatScrollPanelMediator);
         mediatorMap.mapView(MobileChatMutePanel,MobileChatMutePanelMediator);
         mediatorMap.mapView(MobileUserNotificationPanel,MobileUserNotificationPanelMediator);
         mediatorMap.mapView(MobileUserNotificationView,MobileUserNotificationViewMediator);
         mediatorMap.mapView(MobileCityUILayer,MobileCityUILayerMediator,[MobileCityUILayer,MobileUILayer]);
         mediatorMap.mapView(MobileVisitUILayer,MobileVisitUILayerMediator,[MobileVisitUILayer,MobileUILayer]);
         mediatorMap.mapView(MobileMenuPanel,MobileMenuPanelMediator);
         mediatorMap.mapView(MobileVisitMenuPanel,MobileVisitMenuPanelMediator);
         mediatorMap.mapView(MobileNPCAttackCountDownPanel,MobileNPCAttackCountDownPanelMediator);
         mediatorMap.mapView(MobileResourcePanel,MobileResourcePanelMediator);
         mediatorMap.mapView(MobileResourceBar,MobileResourceBarMediator);
         mediatorMap.mapView(MobileRequiredStaffView,MobileRequiredStaffViewMediator);
         mediatorMap.mapView(MobileRequiredStaffsPanel,MobileRequiredStaffsPanelMediator);
         mediatorMap.mapView(MobileConstructableOptionsView,MobileConstructableOptionsViewMediator);
         mediatorMap.mapView(MCOVDecorationView,MCOVDecorationViewMediator,[MCOVDecorationView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVIdleView,MCOVIdleViewMediator,[MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVIncompleteView,MCOVIncompleteViewMediator,[MCOVIncompleteView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVConstructView,MCOVConstructViewMediator,[MCOVConstructView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVRepairView,MCOVRepairViewMediator,[MCOVRepairView,MCOVConstructView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVUpgradeView,MCOVUpgradeViewMediator,[MCOVUpgradeView,MCOVConstructView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVWorkView,MCOVWorkViewMediator,[MCOVWorkView,MCOVEnterView,MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVResourceView,MCOVResourceViewMediator,[MCOVResourceView,MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVEnterView,MCOVEnterViewMediator,[MCOVEnterView,MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVDefensiveView,MCOVDefensiveViewMediator,[MCOVDefensiveView,MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVTrapView,MCOVTrapViewMediator,[MCOVTrapView,MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVCityPlannerView,MCOVCityPlannerViewMediator,[MCOVCityPlannerView,MCOVEnterView,MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVBeastCaveView,MCOVBeastCaveViewMediator,[MCOVBeastCaveView,MCOVEnterView,MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVBeastKeeperView,MCOVBeastKeeperViewMediator,[MCOVBeastKeeperView,MCOVEnterView,MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVCatapultView,MCOVCatapultViewMediator,[MCOVCatapultView,MCOVEnterView,MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVBoostView,MCOVBoostViewMediator,[MCOVBoostView,MCOVEnterView,MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVWallView,MCOVWallViewMediator,[MCOVWallView,MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MCOVBeastCannonView,MCOVBeastCannonViewMediator,[MCOVBeastCannonView,MCOVIdleView,MobileConstructableOptionsView]);
         mediatorMap.mapView(MobileProtectionPanel,MobileProtectionPanelMediator);
         mediatorMap.mapView(MobileBattlePointsInfoWindow,MobileGenericWindowMediator,[MobileBattlePointsInfoWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileBuildingTooltipProductionProgressInfoView,MobileBuildingTooltipProductionProgressInfoViewMediator);
         mediatorMap.mapView(MobileBuildingTooltipDefenseInfoView,MobileBuildingTooltipDefenseInfoViewMediator);
         mediatorMap.mapView(MobileBuildingTooltipBeastCannonInfoView,MobileBuildingTooltipBeastCannonInfoViewMediator);
         mediatorMap.mapView(MobileTooltipInfoView,MobileTooltipInfoViewMediator);
         mediatorMap.mapView(MobileBuildingTooltipCatapultInfoView,MobileBuildingTooltipCatapultInfoViewMediator);
         mediatorMap.mapView(MobileBuildingTooltipWithOneProgressInfoView,MobileBuildingTooltipWithOneProgressInfoViewMediator);
         mediatorMap.mapView(MobileBuildingTooltipProgressInfoView,MobileBuildingTooltipProgressInfoViewMediator);
         mediatorMap.mapView(MobileBuildingTooltipHousingInfoView,MobileBuildingTooltipHousingInfoViewMediator);
         mediatorMap.mapView(MobileBuildingTooltipBeastCaveInfoView,MobileBuildingTooltipBeastCaveInfoViewMediator);
      }
      
      private function mapCombatUIMediators() : void
      {
         mediatorMap.mapView(MobileCombatUILayer,MobileCombatUILayerMediator,[MobileCombatUILayer,MobileUILayer]);
         mediatorMap.mapView(MobileBaseBottomMainframePanel,MobileBaseBottomMainframePanelMediator);
         mediatorMap.mapView(MobileMercenaryDeployTab,MobileMercenaryDeployTabMediator,[MobileBaseBottomMainframePanel,MobileMercenaryDeployTab]);
         mediatorMap.mapView(MobileCombatMenuPanel,MobileCombatMenuPanelMediator);
         mediatorMap.mapView(MobileCatapultMenuOptionsView,MobileCatapultMenuOptionsViewMediator);
         mediatorMap.mapView(MobileCatapultMenuOptionView,MobileCatapultMenuOptionViewMediator);
         mediatorMap.mapView(MobileCatapultMenuTab,MobileCatapultMenuTabMediator);
         mediatorMap.mapView(MobileCatapultMenuView,MobileCatapultMenuViewMediator);
         mediatorMap.mapView(MobileMercenaryDeployTabBeastView,MobileMercenaryDeployTabBeastViewMediator,[MobileMercenaryDeployTabBeastView,MobileMercenaryButtonView]);
         mediatorMap.mapView(MobileMercenaryDeployTabMercenaryView,MobileMercenaryDeployTabMercenaryViewMediator,[MobileMercenaryDeployTabMercenaryView,MobileMercenaryButtonView]);
         mediatorMap.mapView(MobileVictoryMeterPanel,MobileVictoryMeterPanelMediator);
         mediatorMap.mapView(MobileBattleClockView,MobileBattleClockViewMediator);
         mediatorMap.mapView(MobileCombatMenuEventItemsPanel,MobileCombatMenuEventItemsPanelMediator,[MobileCombatMenuEventItemsPanel,MobileBaseBottomMainframePanel]);
         mediatorMap.mapView(MobileCombatEventItemView,MobileCombatEventItemViewMediator,[MobileCombatEventItemView,MobileMercenaryButtonView]);
         mediatorMap.mapView(MobileCatapultEventItemView,MobileCatapultEventItemViewMediator,[MobileCatapultEventItemView,MobileCombatEventItemView,MobileMercenaryButtonView]);
         mediatorMap.mapView(MobileCombatBuildingEventItemView,MobileCombatBuildingEventItemViewMediator,[MobileCombatBuildingEventItemView,MobileCombatEventItemView,MobileMercenaryButtonView]);
         mediatorMap.mapView(MobileMercenaryEventItemView,MobileMercenaryEventItemViewMediator,[MobileMercenaryEventItemView,MobileCombatEventItemView,MobileMercenaryButtonView]);
      }
      
      private function mapCityPlannerUIMediators() : void
      {
         mediatorMap.mapView(MobileCityPlannerUILayer,MobileCityPlannerUILayerMediator,[MobileUILayer,MobileCityPlannerUILayer]);
         mediatorMap.mapView(MobileCityPlannerLoadWindow,MobileCityPlannerLoadWindowMediator,[MobileCityPlannerLoadWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileCityPlannerSaveWindow,MobileCityPlannerSaveWindowMediator,[MobileCityPlannerSaveWindow,MobileGenericWindow]);
      }
      
      private function mapWindowMediators() : void
      {
         mapTuskHornMediators();
         mapQuestMediators();
         mapInboxMediators();
         mapMapListMediators();
         mapFortifyMediators();
         mapUpgradeMediators();
         mapBeastCaveMediators();
         mapRankingMediators();
         mapBeastKeeperMediators();
         mapConstructBuildingMediators();
         mapSocialMediators();
         mapMercenaryTransferMediators();
         mapRecruitmentChamberMediators();
         mapExecutionalGuillotineMediators();
         mapTavernMediators();
         mapBattleReportMediators();
         mapHiringQuartersMediators();
         mapTrainingChamberMediators();
         mapBlacksmithMediators();
         mapBeastCageWindowMediators();
         mapActivateBuildingMediators();
         mapAllianceMediators();
         mapGetGoldMediators();
         mapSettingMediators();
         mapCatapultMediators();
         mapRecycleMediators();
         mapTrapMediators();
         mapEventStoreMediators();
         mapAnnouncementMediators();
      }
      
      private function mapAnnouncementMediators() : void
      {
         mediatorMap.mapView(MobileAnnouncementWindow,MobileAnnouncementWindowMediator,[MobileAnnouncementWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileAnnouncementPanel,MobileAnnouncementPanelMediator,[MobileAnnouncementPanel,MobileBaseWindowPanel]);
      }
      
      private function mapEventStoreMediators() : void
      {
         mediatorMap.mapView(MobileEventStoreWindow,MobileGenericWindowMediator,[MobileEventStoreWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileEventStorePanel,MobileEventStorePanelMediator,[MobileEventStorePanel,MobileBaseWindowPanel]);
         mediatorMap.mapView(MobileEventPopUp,MobileEventPopUpMediator,[MobileEventPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileEventOngoingPanel,MobileEventOngoingPanelMediator,[MobileEventOngoingPanel,MobileBaseWindowPanel]);
         mediatorMap.mapView(MobileEventPopUpEventStorePanel,MobileBaseWindowPanelMediator,[MobileEventPopUpEventStorePanel,MobileBaseWindowPanel]);
         mediatorMap.mapView(MobileEventAnnouncementPopUp,MobileGenericWindowMediator,[MobileEventAnnouncementPopUp,MobileGenericWindow]);
      }
      
      private function mapTrapMediators() : void
      {
         mediatorMap.mapView(MobileRearmTrapsWindow,MobileRearmTrapsWindowMediator,[MobileRearmTrapsWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileRecycleTrapWindow,MobileRecycleTrapWindowMediator,[MobileRecycleTrapWindow,MobileGenericWindow]);
      }
      
      private function mapRecycleMediators() : void
      {
         mediatorMap.mapView(MobileRecycleDecorationWindow,MobileRecycleDecorationWindowMediator,[MobileRecycleDecorationWindow,MobileGenericWindow]);
      }
      
      private function mapCatapultMediators() : void
      {
         mediatorMap.mapView(MobileCatapultElementRechargeView,MobileCatapultElementRechargeViewMediator);
         mediatorMap.mapView(MobileCatapultRechargeWindow,MobileCatapultRechargeWindowMediator,[MobileCatapultRechargeWindow,MobileGenericWindow]);
      }
      
      private function mapSettingMediators() : void
      {
         mediatorMap.mapView(MobileSettingsWindow,MobileSettingsWindowMediator,[MobileSettingsWindow,MobileGenericWindow]);
      }
      
      private function mapGetGoldMediators() : void
      {
         mediatorMap.mapView(MobileGetGoldWindow,MobileGetGoldWindowMediator,[MobileGetGoldWindow,MobileFullScreenWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileGetGoldProductView,MobileGetGoldProductViewMediator,MobileGetGoldProductView);
         mapPigeonPostMediators();
         mapGeneralInformationMediator();
      }
      
      private function mapGeneralInformationMediator() : void
      {
         mediatorMap.mapView(MobileGeneralInformationWindow,MobileGeneralInformationWindowMediator,[MobileGeneralInformationWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileContactSupportWindow,MobileContactSupportWindowMediator,[MobileContactSupportWindow,MobileFullScreenWindow,MobileGenericWindow]);
      }
      
      private function mapPigeonPostMediators() : void
      {
         mediatorMap.mapView(MobilePigeonPostWindow,MobilePigeonPostWindowMediator,[MobilePigeonPostWindow,MobileGenericWindow]);
      }
      
      private function mapActivateBuildingMediators() : void
      {
         mediatorMap.mapView(MobileActivateBuildingWindow,MobileActivateBuildingWindowMediator,[MobileActivateBuildingWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileRequiredItemView,MobileRequiredItemViewMediator,[MobileRequiredItemView]);
         mediatorMap.mapView(MobileOrView,MobileOrViewMediator,[MobileOrView]);
      }
      
      private function mapBeastCageWindowMediators() : void
      {
         mediatorMap.mapView(MobileBeastCageWindow,MobileGenericWindowMediator,[MobileBeastCageWindow,MobileGenericWindow]);
      }
      
      private function mapBlacksmithMediators() : void
      {
         mediatorMap.mapView(MobileBlacksmithWindow,MobileBlacksmithWindowMediator,[MobileBlacksmithWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileBlacksmithSelectEventItemPanel,MobileBlacksmithSelectEventItemPanelMediator,[MobileBlacksmithSelectEventItemPanel,MobileBaseWindowPanel]);
         mediatorMap.mapView(MobileBlacksmithEventItemInfoPanel,MobileBaseWindowPanelMediator,[MobileBlacksmithEventItemInfoPanel,MobileBaseWindowPanel]);
         mediatorMap.mapView(MobileBlacksmithInventoryPanel,MobileBlacksmithInventoryPanelMediator,[MobileBlacksmithInventoryPanel,MobileBaseWindowPanel]);
      }
      
      private function mapBattleReportMediators() : void
      {
         mediatorMap.mapView(MobileBattleReportDetailView,MobileBattleReportDetailViewMediator);
         mediatorMap.mapView(MobileBattleReportGeneralInfoView,MobileBattleReportGeneralInfoViewMediator);
         mediatorMap.mapView(MobileBattleReportWindow,MobileBattleReportWindowMediator,[MobileBattleReportWindow,MobileGenericWindow]);
      }
      
      private function mapHiringQuartersMediators() : void
      {
         mediatorMap.mapView(MobileHiringQuartersWindow,MobileHiringQuartersWindowMediator,[MobileHiringQuartersWindow,MobileFullScreenWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileCentralHiringQuartersWindow,MobileCentralHiringQuartersWindowMediator,[MobileCentralHiringQuartersWindow,MobileFullScreenWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileHiringQuartersMercenaryView,MobileHiringQuartersMercenaryViewMediator,MobileHiringQuartersMercenaryView);
      }
      
      private function mapTavernMediators() : void
      {
         mediatorMap.mapView(MobileTavernWindow,MobileTavernWindowMediator,[MobileTavernWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileTavernUnlockPanel,MobileTavernUnlockPanelMediator,[MobileBaseWindowPanel,MobileTavernUnlockPanel]);
         mediatorMap.mapView(MobileBaseTavernUnlockedCardView,MobileBaseTavernUnlockedCardViewMediator);
         mediatorMap.mapView(MobileTavernUnlockedCardView,MobileBaseTavernUnlockedCardViewMediator,[MobileBaseTavernUnlockedCardView,MobileTavernUnlockedCardView]);
         mediatorMap.mapView(MobileTavernUnlockedBeastView,MobileTavernUnlockedBeastViewMediator,[MobileBaseTavernUnlockedCardView,MobileTavernUnlockedBeastView]);
         mediatorMap.mapView(MobileTavernWheelSliceView,MobileTavernWheelSliceViewMediator);
         mediatorMap.mapView(MobileTavernWheelView,MobileTavernWheelViewMediator);
         mediatorMap.mapView(MobileTavernGiftView,MobileTavernGiftViewMediator);
      }
      
      private function mapExecutionalGuillotineMediators() : void
      {
         mediatorMap.mapView(MobileExecutionalGuillotineMercenaryView,MobileExecutionalGuillotineMercenaryViewMediator);
         mediatorMap.mapView(MobileExecutionalGuillotineWindow,MobileExecutionalGuillotineWindowMediator,[MobileExecutionalGuillotineWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileMercenaryBarracksWindow,MobileExecutionalGuillotineWindowMediator,[MobileMercenaryBarracksWindow,MobileExecutionalGuillotineWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileAllianceBarracksWindow,MobileExecutionalGuillotineWindowMediator,[MobileAllianceBarracksWindow,MobileExecutionalGuillotineWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileFriendWatchPostWindow,MobileExecutionalGuillotineWindowMediator,[MobileFriendWatchPostWindow,MobileExecutionalGuillotineWindow,MobileGenericWindow]);
      }
      
      private function mapMercenaryTransferMediators() : void
      {
         mediatorMap.mapView(MobileMercenaryTransferWindow,MobileMercenaryTransferWindowMediator,[MobileMercenaryTransferWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileWatchPostWindow,MobileWatchPostWindowMediator,[MobileWatchPostWindow,MobileMercenaryTransferWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileAllianceBarracksTransferWindow,MobileAllianceBarracksTransferWindowMediator,[MobileAllianceBarracksTransferWindow,MobileMercenaryTransferWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileFriendWatchPostTransferWindow,MobileFriendWatchPostTransferWindowMediator,[MobileFriendWatchPostTransferWindow,MobileMercenaryTransferWindow,MobileGenericWindow]);
      }
      
      private function mapQuestMediators() : void
      {
         mediatorMap.mapView(MobileQuestDetailWindow,MobileQuestDetailWindowMediator,[MobileQuestDetailWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileQuestDetailTaskView,MobileQuestDetailTaskViewMediator);
         mediatorMap.mapView(MobileQuestRowView,MobileQuestRowViewMediator);
         mediatorMap.mapView(MobileQuestWindow,MobileQuestWindowMediator,[MobileQuestWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileQuestCompletedPopup,MobileQuestCompletedPopupMediator,[MobileQuestCompletedPopup,MobileGenericWindow]);
         mediatorMap.mapView(MobileRewardGroupView,MobileRewardGroupViewMediator);
      }
      
      private function mapConstructBuildingMediators() : void
      {
         mediatorMap.mapView(MobileBuildShowcaseWindow,MobileBuildShowcaseWindowMediator,[MobileBuildShowcaseWindow,MobileButtonTabbedWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileBuildCategoryPanel,MobileBuildCategoryPanelMediator);
         mediatorMap.mapView(MobileBuildDecorationCategoryPanel,MobileBuildDecorationCategoryPanelMediator);
         mediatorMap.mapView(MobileDecorationCategoryTab,MobileDecorationCategoryTabMediator);
         mediatorMap.mapView(MobileConstructBuildingWindow,MobileConstructBuildingWindowMediator,[MobileGenericWindow,MobileConstructBuildingWindow]);
      }
      
      private function mapUpgradeMediators() : void
      {
         mediatorMap.mapView(MobileUpgradeWindow,MobileUpgradeWindowMediator,[MobileGenericWindow,MobileUpgradeWindow]);
         mediatorMap.mapView(MobileUpgradeBuildingWithRequirementPanel,MobileUpgradeBuildingWithRequirementPanelMediator,[MobileBaseWindowPanel,MobileUpgradeBuildingWithRequirementPanel]);
         mediatorMap.mapView(MobileUpgradeComperativePanel,MobileUpgradeComperativePanelMediator,[MobileBaseWindowPanel,MobileUpgradeComperativePanel]);
         mediatorMap.mapView(MobileUpgradeInformativePanel,MobileBaseWindowPanelMediator,MobileBaseWindowPanel);
         mediatorMap.mapView(MobileUpgradeCityCenterPanel,MobileBaseWindowPanelMediator,MobileBaseWindowPanel);
      }
      
      private function mapFortifyMediators() : void
      {
         mediatorMap.mapView(MobileFortifyWindow,MobileFortifyWindowMediator,[MobileFortifyWindow,MobileGenericWindow]);
      }
      
      private function mapTuskHornMediators() : void
      {
         mediatorMap.mapView(MobileTuskHornWindow,MobileTuskHornWindowMediator,[MobileTuskHornWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileTuskHornMercenaryView,MobileTuskHornMercenaryViewMediator,[MobileTuskHornMercenaryView,MobileMercenaryButtonView]);
      }
      
      private function mapInboxMediators() : void
      {
         mediatorMap.mapView(MobileInboxWindow,MobileInboxWindowMediator,[MobileInboxWindow,MobileButtonTabbedWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileInboxPanel,MobileInboxPanelMediator);
         mediatorMap.mapView(MobileRequestContainerView,MobileRequestContainerViewMediator);
         mediatorMap.mapView(MobileBaseRequestView,MobileBaseRequestViewMediator);
         mediatorMap.mapView(MobilePartRequestView,MobilePartRequestViewMediator,[MobilePartRequestView,MobileBaseRequestView]);
         mediatorMap.mapView(MobileStaffRequestView,MobileBaseRequestViewMediator,[MobileStaffRequestView,MobileBaseRequestView]);
         mediatorMap.mapView(MobileWorkerStaffRequestView,MobileBaseRequestViewMediator,MobileBaseRequestView);
         mediatorMap.mapView(MobileRewardRequestView,MobileRewardRequestViewMediator,[MobileBaseRequestView,MobileRewardRequestView]);
         mediatorMap.mapView(MobileGiftRequestView,MobileGiftRequestViewMediator,[MobileBaseRequestView,MobileGiftRequestView]);
         mediatorMap.mapView(MobileAllianceInvitationRequestView,MobileAllianceInvitationRequestViewMediator,[MobileBaseRequestView,MobileAllianceInvitationRequestView]);
         mediatorMap.mapView(MobileMysteryGoldRequestView,MobileMysteryGoldRequestViewMediator,[MobileBaseRequestView,MobileMysteryGoldRequestView]);
         mediatorMap.mapView(MobileMysteryRpRequestView,MobileMysteryRpRequestViewMediator,[MobileBaseRequestView,MobileMysteryRpRequestView]);
         mediatorMap.mapView(MobileMysteryResourceRequestView,MobileMysteryResourceRequestViewMediator,[MobileBaseRequestView,MobileMysteryResourceRequestView]);
         mediatorMap.mapView(MobileAttackLogPanel,MobileAttackLogPanelMediator);
      }
      
      private function mapMapListMediators() : void
      {
         mediatorMap.mapView(MobileMapListWindow,MobileMapListWindowMediator,[MobileGenericWindow,MobileMapListWindow]);
         mediatorMap.mapView(MobileMapListPanel,MobileMapListPanelMediator);
      }
      
      private function mapBeastCaveMediators() : void
      {
         mediatorMap.mapView(MobileBeastCaveWindow,MobileBeastCaveWindowMediator,[MobileGenericWindow,MobileBeastCaveWindow]);
         mediatorMap.mapView(MobileBeastPanel,MobileBeastPanelMediator,[MobileBeastPanel,MobileBaseWindowPanel]);
         mediatorMap.mapView(MobileEvolutionPanel,MobileEvolutionPanelMediator,[MobileEvolutionPanel,MobileBaseWindowPanel]);
         mediatorMap.mapView(MobileBeastCaveBeastKeeperPanel,MobileBeastCaveBeastKeeperPanelMediator,[MobileBeastCaveBeastKeeperPanel,MobileBaseWindowPanel]);
         mediatorMap.mapView(MobileDailyFeedPanel,MobileDailyFeedPanelMediator,[MobileDailyFeedPanel,MobileBaseWindowPanel]);
      }
      
      private function mapRankingMediators() : void
      {
         mediatorMap.mapView(MobileLeaguePanel,MobileLeaguePanelMediator);
         mediatorMap.mapView(MobileLeagueHeaderPanel,MobileLeagueHeaderPanelMediator);
         mediatorMap.mapView(MobileLeagueInfoSmallView,MobileLeagueInfoSmallViewMediator);
         mediatorMap.mapView(MobileLeagueMembersListPanel,MobileLeagueMembersListPanelMediator);
         mediatorMap.mapView(MobileLeagueGeneralInfoPanel,MobileLeagueGeneralInfoPanelMediator);
         mediatorMap.mapView(MobileLeaderboardWindow,MobileLeaderboardWindowMediator,[MobileLeaderboardWindow,MobileButtonTabbedWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobilePlayerScoresPanel,MobileBaseRankingPanelMediator,[MobileBaseRankingPanel]);
         mediatorMap.mapView(MobileXPRankingPanel,MobileBaseRankingPanelMediator,[MobileBaseRankingPanel]);
         mediatorMap.mapView(MobileTopLootersPanel,MobileBaseRankingPanelMediator,[MobileBaseRankingPanel]);
         mediatorMap.mapView(MobileLeaderboardBrowseAllianceListPanel,MobileLeaderboardBrowseAllianceListPanelMediator,[MobileLeaderboardBrowseAllianceListPanel,MobileBaseRankingPanel]);
      }
      
      private function mapBeastKeeperMediators() : void
      {
         mediatorMap.mapView(MobileBeastKeeperWindow,MobileBeastKeeperWindowMediator,[MobileGenericWindow,MobileBeastKeeperWindow]);
         mediatorMap.mapView(MobileBeastKeeperPanel,MobileBeastKeeperPanelMediator,[MobileBeastKeeperPanel,MobileBaseWindowPanel]);
      }
      
      private function mapRecruitmentChamberMediators() : void
      {
         mediatorMap.mapView(MobileRecruitmentChamberWindow,MobileRecruitmentChamberWindowMediator,[MobileGenericWindow,MobileRecruitmentChamberWindow]);
      }
      
      private function mapTrainingChamberMediators() : void
      {
         mediatorMap.mapView(MobileTrainingChamberWindow,MobileTrainingChamberWindowMediator,[MobileGenericWindow,MobileTrainingChamberWindow]);
      }
      
      private function mapAllianceMediators() : void
      {
         mediatorMap.mapView(MobileAllianceWindow,MobileAllianceWindowMediator,[MobileGenericWindow,MobileButtonTabbedWindow,MobileAllianceWindow]);
         mediatorMap.mapView(MobileBrowseAlliancePanel,MobileBrowseAlliancePanelMediator);
         mediatorMap.mapView(MobileAllianceTournamentPanel,MobileAllianceTournamentPanelMediator);
         mediatorMap.mapView(MobileBrowseAllianceListPanel,MobileBrowseAllianceListPanelMediator);
         mediatorMap.mapView(MobileAllianceTournamentListPanel,MobileAllianceTournamentListPanelMediator);
         mediatorMap.mapView(MobileAllianceMembersPanel,MobileAllianceMembersPanelMediator);
         mediatorMap.mapView(MobileAllianceCandidatesListPanel,MobileAllianceCandidatesListPanelMediator,[MobileAllianceCandidatesListPanel,MobileAllianceMembersPanel]);
         mediatorMap.mapView(MobileAllianceCandidatesPanel,MobileAllianceCandidatesPanelMediator);
         mediatorMap.mapView(MobileCreateAlliancePanel,MobileCreateAlliancePanelMediator);
         mediatorMap.mapView(MobileVanityColorPaletteView,MobileVanityColorPaletteViewMediator);
         mediatorMap.mapView(MobileVanityColorSelectorView,MobileVanityColorSelectorViewMediator);
         mediatorMap.mapView(MobileEditCoatOfArmsPanel,MobileEditCoatOfArmsPanelMediator);
         mediatorMap.mapView(MobileMyAllianceMembersPanel,MobileMyAllianceMembersPanelMediator,[MobileMyAllianceMembersPanel,MobileAllianceMembersPanel]);
         mediatorMap.mapView(MobileAlliancePanel,MobileAlliancePanelMediator);
         mediatorMap.mapView(MobileMyAlliancePanel,MobileAlliancePanelMediator,[MobileMyAlliancePanel,MobileAlliancePanel]);
         mediatorMap.mapView(MobileAllianceGeneralInfoPanel,MobileAllianceGeneralInfoPanelMediator,MobileAllianceGeneralInfoPanel);
      }
      
      private function mapPopUpMediators() : void
      {
         mediatorMap.mapView(MobileAnyoneHomePopUp,MobileAnyoneHomePopUpMediator,[MobileAnyoneHomePopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileDisconnectPopUp,MobileDisconnectPopUpMediator,[MobileDisconnectPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileDontKillMePopUp,MobileDontKillMePopUpMediator,[MobileDontKillMePopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileRepairPopUp,MobileRepairPopUpMediator,[MobileRepairPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileRepairNewPopUp,MobileRepairNewPopUpMediator,[MobileRepairNewPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileAlreadyUnderAttackPopUp,MobileAlreadyUnderAttackPopUpMediator,[MobileAlreadyUnderAttackPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileFinishNowHiringPopUp,MobileFinishNowHiringPopUpMediator,[MobileFinishNowHiringPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileNotEnoughResourcePopUp,MobileNotEnoughResourcePopUpMediator,[MobileNotEnoughResourcePopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileGenericUnitCompletionPopUp,MobileGenericUnitCompletionPopUpMediator,[MobileGenericUnitCompletionPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileRecruitmentCompletedPopUp,MobileRecruitmentCompletedPopUpMediator,[MobileRecruitmentCompletedPopUp,MobileGenericUnitCompletionPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileTrainingCompletedPopUp,MobileTrainingCompletedPopUpMediator,[MobileTrainingCompletedPopUp,MobileGenericUnitCompletionPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileDidYouKnowPopUp,MobileDidYouKnowPopUpMediator,[MobileDidYouKnowPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileConstructionSiteWindow,MobileConstructionSiteWindowMediator,[MobileConstructionSiteWindow,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileCityCenterConstructionSiteWindow,MobileCityCenterConstructionSiteWindowMediator,[MobileCityCenterConstructionSiteWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileCancelConstructionWindow,MobileCancelConstructionWindowMediatior,[MobileCancelConstructionWindow,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileAuthErrorPopup,MobileAuthErrorPopupMediator,[MobileAuthErrorPopup,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileActionNotPossiblePopup,MobileActionNotPossiblePopUpMediator,[MobileActionNotPossiblePopup,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileAttackWarnPopup,MobileAttackWarnPopupMediator,[MobileAttackWarnPopup,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileHelpedFriendPopUp,MobileHelpedFriendPopUpMediator,[MobileHelpedFriendPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileFriendWatchpostHelpPopUp,MobileFriendWatchpostHelpPopUpMediator,[MobileFriendWatchpostHelpPopUp,MobileHelpedFriendPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileGenericActionPopUp,MobileGenericActionPopUpMediator,[MobileGenericActionPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileClementineChangableActionPopUp,MobileGenericActionPopUpMediator,[MobileGenericActionPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileNotEnoughPopup,MobileNotEnoughPopupMediator,[MobileNotEnoughPopup,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileFBProgressPopUp,MobileFBProgressPopUpMediator,[MobileFBProgressPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileFBConnectToSendGiftPanel,MobileFBConnectToSendGiftPanelMediator);
         mediatorMap.mapView(MobileFBConfirmationPopUp,MobileFBConfirmationPopUpMediator,[MobileFBConfirmationPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileFBGetGoldPopUp,MobileFBGetGoldPopUpMediator,[MobileFBGetGoldPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileCityPlannerExitPopUp,MobileCityPlannerExitPopUpMediator,[MobileCityPlannerExitPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileResourceCapacityExceedsPopup,MobileResourceCapacityExceedsPopupMediator,[MobileResourceCapacityExceedsPopup,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileFeatureAvailablePopUp,MobileFeatureAvailablePopUpMediator,[MobileFeatureAvailablePopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileGenericStopPopUp,MobileGenericStopPopUpMediator,[MobileGenericStopPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileRecruitmentStopPopUp,MobileRecruitmentStopPopUpMediator,[MobileRecruitmentStopPopUp,MobileGenericStopPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileTrainingStopPopUp,MobileTrainingStopPopUpMediator,[MobileTrainingStopPopUp,MobileGenericStopPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileBaseTopOffResourcesPopUp,MobileBaseTopOffResourcesPopUpMediator,[MobileBaseTopOffResourcesPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileConstructTopOffResourcesPopUp,MobileConstructTopOffResourcesPopUpMediator,[MobileConstructTopOffResourcesPopUp,MobileBaseTopOffResourcesPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileDefaultTopOffResourcesPopUp,MobileDefaultTopOffResourcesPopUpMediator,[MobileDefaultTopOffResourcesPopUp,MobileBaseTopOffResourcesPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileBeastUnleashedPopUp,MobileBeastUnleashedPopUpMediator,[MobileBeastUnleashedPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileNPCAttackPopup,MobileNPCAttackPopupMediator,[MobileNPCAttackPopup,MobileGenericWindow]);
         mediatorMap.mapView(MobileNPCAttackRepelledPopup,MobileNPCAttackRepelledPopupMediator,[MobileNPCAttackRepelledPopup,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileJobCapacityAlreadyReachedPopUp,MobileJobCapacityAlreadyReachedPopUpMediator,[MobileJobCapacityAlreadyReachedPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileEmailPermissionPopUp,MobileEmailPermissionPopUpMediator,[MobileEmailPermissionPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileEmailPermissionDeniedPopUp,MobileGenericActionPopUpMediator,[MobileEmailPermissionDeniedPopUp,MobileClementineChangableActionPopUp,MobileGenericActionPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileStoreItemPurchasedPopUp,MobileStoreItemPurchasedPopUpMediator,[MobileStoreItemPurchasedPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileOutOfOffersPopUp,MobileGenericActionPopUpMediator,[MobileOutOfOffersPopUp,MobileClementineChangableActionPopUp,MobileGenericActionPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileLeagueSeasonEndedPopUp,MobileLeagueSeasonEndedPopUpMediator,[MobileLeagueSeasonEndedPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileLeagueStatusDroppedPopUp,MobileLeagueStatusDroppedPopUpMediator,[MobileLeagueStatusDroppedPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileLeagueStatusChangedPopUp,MobileLeagueStatusChangedPopUpMediator,[MobileLeagueStatusChangedPopUp,MobileLeagueStatusDroppedPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileLeagueStatusPlacedPopUp,MobileLeagueStatusPlacedPopUpMediator,[MobileLeagueStatusPlacedPopUp,MobileLeagueStatusChangedPopUp,MobileLeagueStatusDroppedPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileLeagueSeasonEndedSuccessPopUp,MobileLeagueSeasonEndedSuccessPopUpMediator,[MobileLeagueSeasonEndedSuccessPopUp,MobileLeagueSeasonEndedPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileBoostConfirmationPopUp,MobileBoostConfirmationPopUpMediator,[MobileBoostConfirmationPopUp,MobileClementineChangableActionPopUp,MobileGenericActionPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileBeastConfirmationPopUp,MobileBeastConfirmationPopUpMediator,[MobileBeastConfirmationPopUp,MobileClementineChangableActionPopUp,MobileGenericActionPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileExpandCityPopUp,MobileExpandCityPopUpMediator,[MobileExpandCityPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileLeagueInfoMediumView,MobileLeagueInfoMediumViewMediator);
         mediatorMap.mapView(MobileNPCAttackPopupBatchView,MobileNPCAttackPopupBatchViewMediator);
         mediatorMap.mapView(MobileCatapultCombatRechargePopUp,MobileCatapultCombatRechargePopUpMediator,[MobileCatapultCombatRechargePopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileLevelupPopup,MobileLevelupPopupMediator,[MobileLevelupPopup,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobilePassAFriendPopUp,MobilePassAFriendPopUpMediator,[MobilePassAFriendPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileFortificationCompletedPopUp,MobileFortificationCompletedPopUpMediator,[MobileFortificationCompletedPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileLeaveGamePopUp,MobileLeaveGamePopUpMediator,[MobileLeaveGamePopUp,MobileClementineChangableActionPopUp,MobileGenericActionPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileSpecialOfferPopUp,MobileSpecialOfferPopUpMediator,[MobileSpecialOfferPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileChoosePaymentProviderPopUp,MobileChoosePaymentProviderPopUpMediator,[MobileChoosePaymentProviderPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileAvatarWithArrowView,MobileAvatarWithArrowViewMediator);
         mediatorMap.mapView(MobileSpeechBubbleView,MobileSpeechBubbleViewMediator);
         mediatorMap.mapView(MobileAllianceTipsPopUp,MobileAllianceTipsPopUpMediator,[MobileAllianceTipsPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileAllianceTournamentTipsPopUp,MobileAllianceTournamentTipsPopUpMediator,[MobileAllianceTournamentTipsPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileGuestNamingPopUp,MobileGuestNamingPopUpMediator,[MobileGuestNamingPopUp,MobileBasePopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileTournamentEndedPopUp,MobileTournamentEndedPopUpMediator,[MobileTournamentEndedPopUp,MobileGenericWindow]);
         mediatorMap.mapView(MobileTournamentRewardView,MobileTournamentRewardViewMediator);
      }
      
      private function mapSocialMediators() : void
      {
         mediatorMap.mapView(MobileSocialMainWindow,MobileSocialMainWindowMediator,[MobileSocialMainWindow,MobileButtonTabbedWindow,MobileGenericWindow]);
         mediatorMap.mapView(MobileFriendsPanel,MobileFriendsPanelMediator);
         mediatorMap.mapView(MobileGiftPanel,MobileGiftPanelMediator);
         mediatorMap.mapView(MobileSelectFriendsWindow,MobileSelectFriendsWindowMediator,[MobileSelectFriendsWindow,MobileGenericWindow]);
      }
      
      private function mapTutorialMediators() : void
      {
         mediatorMap.mapView(MobileTutorialLayer,MobileTutorialLayerMediator);
         mediatorMap.mapView(MobileGenericTutorialWindow,MobileGenericTutorialWindowMediator);
         mediatorMap.mapView(MobileTutorialGirlView,MobileTutorialGirlViewMediator);
         mediatorMap.mapView(MobileDeployHandView,MobileDeployHandViewMediator);
      }
      
      private function mapTooltipMediators() : void
      {
         mediatorMap.mapView(MobileTooltipLayer,MobileTooltipLayerMediator);
         mediatorMap.mapView(MobileBaseTooltipView,MobileBaseTooltipViewMediator);
         mediatorMap.mapView(MobileBaseBuildingTooltipView,MobileBaseTooltipViewMediator,[MobileBaseBuildingTooltipView,MobileBaseTooltipView]);
         mediatorMap.mapView(MobileResourceBarTooltipView,MobileResourceBarTooltipViewMediator,[MobileResourceBarTooltipView,MobileBaseTooltipView]);
         mediatorMap.mapView(MobileInformativeTooltipView,MobileBaseTooltipViewMediator,[MobileInformativeTooltipView,MobileBaseTooltipView]);
         mediatorMap.mapView(MobileExperiencePointsTooltipView,MobileExperiencePointsTooltipViewMediator,[MobileExperiencePointsTooltipView,MobileBaseTooltipView]);
         mediatorMap.mapView(MobileVictoryTooltipView,MobileBaseTooltipViewMediator,[MobileVictoryTooltipView,MobileBaseTooltipView]);
      }
   }
}

