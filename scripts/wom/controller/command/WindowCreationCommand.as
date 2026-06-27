package wom.controller.command
{
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import peak.config.DocumentConfiguration;
   import wom.controller.PCommand;
   import wom.controller.event.ExternalInterfaceEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.WindowCreationEvent;
   import wom.controller.event.friend.GetSelectFriendsWindowEvent;
   import wom.controller.event.mobile.MobileSelectEvent;
   import wom.controller.event.ui.ActionSelectEvent;
   import wom.controller.event.ui.AttackLogWindowEvent;
   import wom.controller.event.ui.GetGoldWindowEvent;
   import wom.controller.event.ui.GetMapListWindowEvent;
   import wom.controller.event.ui.GiftGoldWindowEvent;
   import wom.controller.event.ui.GiftWindowEvent;
   import wom.controller.event.ui.MobileCloseGenericWindowEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.controller.event.ui.SettingsEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.enum.ActionType;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CampaignMapInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.event.EventItemType;
   import wom.model.game.event.EventStoreItemInfo;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.quest.QuestInfo;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.settings.ClientSettingType;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.RecycleBuildingRequest;
   import wom.model.message.request.alliance.KickAllianceMemberRequest;
   import wom.model.message.request.alliance.QuitAllianceRequest;
   import wom.service.facebook.FacebookAPIManager;
   import wom.service.mobile.MobileGooglePlayGamesServicesManager;
   import wom.view.screen.popups.MobileJobCapacityAlreadyReachedPopUp;
   import wom.view.screen.popups.MobileStoreItemPurchasedPopUp;
   import wom.view.screen.popups.apologies.ActionNotPossiblePopUp;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   import wom.view.screen.popups.facebook.MobileFBGetGoldPopUp;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.popups.repair.MobileRepairPopUp;
   import wom.view.screen.popups.repair.RepairSitePopup;
   import wom.view.screen.popups.resource.MobileResourceCapacityExceedsPopup;
   import wom.view.screen.popups.topoff.MobileConstructTopOffResourcesPopUp;
   import wom.view.screen.popups.topoff.MobileDefaultTopOffResourcesPopUp;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceWindow;
   import wom.view.screen.windows.beast.cave.MobileBeastCaveWindow;
   import wom.view.screen.windows.beast.select.BeastSelectWindow;
   import wom.view.screen.windows.build.MobileBuildShowcaseWindow;
   import wom.view.screen.windows.build.MobileConstructBuildingWindow;
   import wom.view.screen.windows.cityplanner.CityPlannerSaveWindow;
   import wom.view.screen.windows.event.BaseEventStoreItemWindow;
   import wom.view.screen.windows.event.CatapultEventStoreItemWindow;
   import wom.view.screen.windows.event.UnitEventStoreItemWindow;
   import wom.view.screen.windows.fortify.MobileFortifyWindow;
   import wom.view.screen.windows.general.MobileContactSupportWindow;
   import wom.view.screen.windows.general.MobileGeneralInformationWindow;
   import wom.view.screen.windows.inventory.InventoryWindow;
   import wom.view.screen.windows.rank.LeaderboardWindow;
   import wom.view.screen.windows.report.battlereport.BattleReportDetailWindow;
   import wom.view.screen.windows.report.battlereport.MobileBattleReportWindow;
   import wom.view.screen.windows.settings.MobileSettingsWindow;
   import wom.view.screen.windows.social.MobileSocialMainWindow;
   import wom.view.screen.windows.store.MobileHireWorkerWindow;
   import wom.view.screen.windows.store.MobileStoreWindow;
   import wom.view.screen.windows.upgrade.MobileUpgradeWindow;
   
   public class WindowCreationCommand extends PCommand
   {
      
      [Inject]
      public var event:WindowCreationEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var campaignMapInfo:CampaignMapInfo;
      
      [Inject]
      public var facebookApiManager:FacebookAPIManager;
      
      [Inject]
      public var documentConfiguration:DocumentConfiguration;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var googlePlayGamesServicesManager:MobileGooglePlayGamesServicesManager;
      
      public function WindowCreationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc4_:BaseEventStoreItemWindow = null;
         var _loc8_:EventStoreItemInfo = null;
         var _loc6_:Object = null;
         var _loc5_:BuildingTypeDIO = null;
         var _loc1_:int = 0;
         var _loc3_:MobileBeastCaveWindow = null;
         var _loc2_:WindowEnumeration = event.windowEnumeration;
         var _loc7_:Object = _loc2_.attributes;
         if("womview" in _loc7_)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",_loc7_.womview));
            return;
         }
         switch(_loc2_.type)
         {
            case 30:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileConstructBuildingWindow(_loc7_["buildingTypeInfo"],_loc7_["buildingTypeDIO"],"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null)));
               break;
            case 39:
               switch((_loc8_ = _loc7_["storeItemInfo"]).eventItemType)
               {
                  case EventItemType.MERCENARY:
                     _loc4_ = new UnitEventStoreItemWindow(_loc8_,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null);
                     break;
                  case EventItemType.CATAPULT:
                     _loc4_ = new CatapultEventStoreItemWindow(_loc8_,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null);
                     break;
                  default:
                     _loc4_ = new BaseEventStoreItemWindow(_loc8_,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null);
               }
               dispatch(new PopUpWindowEvent("showPopUpWindow",_loc4_));
               break;
            case -3:
            case -4:
            case -5:
               break;
            case 23:
               dispatch(new AttackLogWindowEvent("showAttackLogWindow","tab" in _loc7_ ? _loc7_.tab : 2,null,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null));
               break;
            case 24:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBattleReportWindow(_loc7_.logId,_loc7_.startInMillis,_loc7_.afterAttack,"attacker" in _loc7_ ? _loc7_.attacker : null,"defender" in _loc7_ ? _loc7_.defender : null,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null),null,null,null,false,userInfo.delayPopups));
               break;
            case 33:
               dispatch(new PopUpWindowEvent("showPopUpWindow",new BattleReportDetailWindow(_loc7_.logId,_loc7_.startInMillis,_loc7_.afterAttack,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null)));
               break;
            case 1:
               buildingAction(29,ActionType.ENTER_BUILDING,_loc7_);
               break;
            case 2:
               buildingAction(30,ActionType.ENTER_BUILDING,_loc7_);
               break;
            case 20:
               if(city.beast == null)
               {
                  dispatch(new PopUpWindowEvent("showPopUpWindow",new BeastSelectWindow("beast" in _loc7_ ? _loc7_.beast : -1)));
               }
               break;
            case 3:
               buildingAction(37,ActionType.ENTER_BUILDING,_loc7_);
               break;
            case 4:
               buildingAction(10,ActionType.ACTIVATE,_loc7_);
               break;
            case 5:
               buildingAction(18,ActionType.ENTER_BUILDING,_loc7_);
               break;
            case -8:
               buildingAction(25,ActionType.ENTER_BUILDING,_loc7_);
               break;
            case 6:
               buildingAction(17,ActionType.ENTER_BUILDING,_loc7_);
               break;
            case 7:
               buildingAction(28,ActionType.ENTER_BUILDING,_loc7_);
               break;
            case 8:
               buildingAction(20,ActionType.ENTER_BUILDING,_loc7_);
               break;
            case 9:
               buildingAction(27,ActionType.ENTER_BUILDING,_loc7_);
               break;
            case 10:
               buildingAction(26,ActionType.ENTER_BUILDING,_loc7_);
               break;
            case 11:
               buildingAction(21,ActionType.ENTER_BUILDING,_loc7_);
               break;
            case 12:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBuildShowcaseWindow("tab" in _loc7_ ? _loc7_.tab : 0)));
               break;
            case -1:
               buildingAction(_loc7_.buildingTypeId,ActionType.CONSTRUCTION_SITE,_loc7_);
               break;
            case -2:
               buildingAction(0,ActionType.CONSTRUCTION_SITE,_loc7_);
               break;
            case 13:
               dispatch(new ExternalInterfaceEvent("openInboxWindow",null));
               break;
            case 14:
               dispatch(new GiftWindowEvent("showGiftWindow","friendId" in _loc7_ ? _loc7_.friendId : null,"stackable" in _loc7_ ? _loc7_.stackable : null));
               break;
            case 15:
               dispatch(new GetSelectFriendsWindowEvent("getSelectFriendsWindow",3,_loc7_.inventoryItemId));
               break;
            case -9:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileGeneralInformationWindow("windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null),0,null,null,false,userInfo.delayPopups));
               break;
            case 16:
               dispatch(new GetGoldWindowEvent("showGetGoldWindow","monetizationType" in _loc7_ ? _loc7_.monetizationType : null,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null,"vectorPosition" in _loc7_ ? _loc7_.vectorPosition : null,"stackable" in _loc7_ ? _loc7_.stackable : null));
               break;
            case 34:
               dispatch(new GiftGoldWindowEvent("showGiftGoldWindow","paymentMethod" in _loc7_ ? _loc7_.paymentMethod : null,"vectorPosition" in _loc7_ ? _loc7_.vectorPosition : null,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null));
               break;
            case 17:
               dispatch(new PopUpWindowEvent("showPopUpWindow",new InventoryWindow("tab" in _loc7_ ? _loc7_.tab : 0)));
               break;
            case 22:
               dispatch(new PopUpWindowEvent("showPopUpWindow",new LeaderboardWindow("tab" in _loc7_ ? _loc7_.tab : 0)));
               break;
            case -11:
               break;
            case 18:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileStoreWindow(0,"tab" in _loc7_ ? _loc7_.tab : 0,"instanceId" in _loc7_ ? _loc7_.instanceId : -1,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null)));
               break;
            case 19:
               dispatch(new GetSelectFriendsWindowEvent("getSelectFriendsWindow",4,0,"stackable" in _loc7_ ? _loc7_.stackable : null));
               break;
            case 21:
               if("id" in _loc7_)
               {
                  for each(var _loc9_ in userInfo.quests)
                  {
                     if(_loc9_.questId == _loc7_.id)
                     {
                     }
                  }
               }
               break;
            case 25:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileRepairPopUp(_loc7_.repairNowCost,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null),0));
               break;
            case 26:
               dispatch(new PopUpWindowEvent("showPopUpWindow",new RepairSitePopup(_loc7_.instanceId,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null)));
               break;
            case 27:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileJobCapacityAlreadyReachedPopUp("windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null)));
               break;
            case 28:
               if(ExternalInterface.available)
               {
                  dispatch(new SettingsEvent("applySettings",ClientSettingType.FULL_SCREEN,false));
                  ExternalInterface.call("showFanQuest");
               }
               break;
            case 29:
               if("thrz" in _loc7_)
               {
                  dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileSocialMainWindow(true)));
               }
               break;
            case 31:
               campaignMapInfo.byPassMap = true;
               dispatch(new GetMapListWindowEvent("showMap"));
               break;
            case 38:
               dispatch(new GetMapListWindowEvent("showMap"));
               break;
            case 32:
               dispatch(new PopUpWindowEvent("showPopUpWindow",new CityPlannerSaveWindow("windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null)));
               break;
            case 35:
               break;
            case 36:
               dispatch(new OutgoingMessageEvent("outgoingMessage",new QuitAllianceRequest()));
               break;
            case 37:
               if("memberId" in _loc7_)
               {
                  dispatch(new OutgoingMessageEvent("outgoingMessage",new KickAllianceMemberRequest(_loc7_["memberId"])));
               }
               break;
            case 40:
               facebookApiManager.uploadScreenshot(documentConfiguration.getParameter("access_token"),userInfo.profile.platformId);
               break;
            case 41:
               _loc6_ = userInfo.tutorialsInfo.additionalInfo.lastOpenedPopup;
               _loc3_ = _loc6_ != null && _loc6_ is MobileBeastCaveWindow ? _loc6_ as MobileBeastCaveWindow : null;
               if(_loc3_ != null)
               {
                  _loc5_ = domainInfo.getBuilding(30);
                  _loc1_ = StoreUtil.buildingPriceWithRequirementsVector(_loc5_.resourceCosts[0],_loc5_.upgradeDurationsPerLevel[0]);
                  if(userInfo.numberOfGolds < _loc1_)
                  {
                     _loc3_.addWindowEnumeration(new WindowEnumeration(0,{"womview":_loc3_}));
                     _loc3_.addWindowEnumeration(new WindowEnumeration(16,{"monetizationType":MonetizationType.NOT_ENOUGH_GOLD}));
                     dispatch(new MobileCloseGenericWindowEvent("mobileCloseGenericWindow",_loc3_));
                  }
                  else if(city.numberOfWorkingWorkers >= city.numberOfWorkers)
                  {
                     _loc3_.addWindowEnumeration(new WindowEnumeration(0,{"womview":_loc3_}));
                     _loc3_.addWindowEnumeration(new WindowEnumeration(27,{}));
                     dispatch(new MobileCloseGenericWindowEvent("mobileCloseGenericWindow",_loc3_));
                  }
                  else
                  {
                     dispatch(new MobileCloseGenericWindowEvent("mobileCloseGenericWindow",_loc3_));
                     dispatch(new ActionSelectEvent("actionSelect",ActionType.BUILD));
                     coreManager.startBuild(30,true);
                  }
               }
               break;
            case 43:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileDefaultTopOffResourcesPopUp(_loc7_.type,_loc7_.missingResourcesArray,_loc7_.outgoingMessage,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null)));
               break;
            case 44:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileConstructTopOffResourcesPopUp("construct",_loc7_.buildingTypeId,_loc7_.missingResourcesArray,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null)));
               break;
            case 42:
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold",null)));
               break;
            case 45:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileResourceCapacityExceedsPopup(_loc7_.type,_loc7_.confirmEvent,"closePopUpWindow","windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null)));
               break;
            case 47:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileUpgradeWindow(_loc7_.type,_loc7_.buildingInfo,_loc7_.buildingDIO,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null)));
               break;
            case 48:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFortifyWindow(_loc7_.buildingInfo,_loc7_.buildingDIO,"windowEnumerations" in _loc7_ ? _loc7_.windowEnumerations : null)));
               break;
            case 46:
               buildingAction(44,ActionType.ENTER_BUILDING,_loc7_);
               break;
            case 200:
               break;
            case 201:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileHireWorkerWindow()));
               break;
            case 202:
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileStoreItemPurchasedPopUp(_loc7_.storeItem)));
               break;
            case 204:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileContactSupportWindow()));
               break;
            case 205:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFBGetGoldPopUp()));
               break;
            case 206:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileSocialMainWindow("highligtThorzain" in _loc7_ ? _loc7_.highligtThorzain : false)));
               break;
            case 207:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileAllianceWindow("defaultPanel" in _loc7_ ? _loc7_.defaultPanel : 0,"defaultTab" in _loc7_ ? _loc7_.defaultTab : 0)));
               break;
            case 208:
               checkBuildingSellValidity(_loc7_);
               break;
            case 203:
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileSettingsWindow(googlePlayGamesServicesManager.isSupported())));
         }
      }
      
      private function checkBuildingSellValidity(param1:Object) : void
      {
         var _loc2_:Event = null;
         var _loc4_:* = null;
         var _loc14_:int = 0;
         var _loc21_:Boolean = false;
         var _loc11_:HiringInfo = null;
         var _loc17_:Boolean = false;
         var _loc3_:int = 0;
         var _loc10_:int = 0;
         var _loc22_:BuildingTypeDIO = null;
         var _loc5_:UnitTypeDIO = null;
         var _loc24_:int = 0;
         var _loc9_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc23_:BuildingTypeDIO = null;
         var _loc20_:* = undefined;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         if(param1.buildingInfo.buildingTypeId == 20)
         {
            _loc14_ = -1;
            _loc21_ = false;
            for each(_loc4_ in city.buildings)
            {
               if(_loc4_.buildingTypeId == 21)
               {
                  _loc14_ = _loc4_.instanceId;
                  break;
               }
            }
            _loc11_ = city.hiringInfoDictionary[param1.buildingInfo.instanceId];
            if(_loc11_)
            {
               if(_loc11_.activeHiring)
               {
                  _loc21_ = true;
               }
               else if(_loc11_.hiringQueue && _loc11_.hiringQueue.hiringSlots)
               {
                  for each(var _loc15_ in _loc11_.hiringQueue)
                  {
                     if(_loc15_.numberOfUnits != 0)
                     {
                        _loc21_ = true;
                        break;
                     }
                  }
               }
            }
            if(_loc21_)
            {
               if(_loc14_ == -1)
               {
                  dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(98)));
               }
               else
               {
                  dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(97)));
               }
               return;
            }
         }
         else if(param1.buildingInfo.buildingTypeId == 21)
         {
            if(city.hiringInfoDictionary != null)
            {
               _loc17_ = false;
               for each(_loc11_ in city.hiringInfoDictionary)
               {
                  if(_loc11_.activeHiring != null)
                  {
                     _loc17_ = true;
                     break;
                  }
               }
               if(_loc17_)
               {
                  dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(97)));
                  return;
               }
            }
         }
         else if(param1.buildingInfo.buildingTypeId == 29)
         {
            if(city.beast != null)
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(91)));
               return;
            }
         }
         else if(param1.buildingInfo.buildingTypeId == 19)
         {
            _loc3_ = 0;
            _loc10_ = 0;
            _loc22_ = domainInfo.getBuilding(19);
            for each(_loc4_ in city.buildings)
            {
               if(_loc4_.buildingTypeId == 19)
               {
                  _loc3_ += _loc22_.buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][_loc4_.level - 1];
               }
            }
            _loc3_ *= userInfo.barracksSpaceModifier;
            for each(var _loc16_ in city.units)
            {
               if(_loc16_.status != UnitStatusType.IN_WATCH_POST)
               {
                  _loc5_ = domainInfo.getUnit(_loc16_.typeId);
                  _loc10_ += _loc5_.spacesPerLevel[(city.unitTypes[_loc5_.id] as UnitTypeInfo).currentLevel - 1];
               }
            }
            _loc24_ = int(_loc22_.buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][param1.buildingInfo.level - 1]);
            _loc24_ = _loc24_ * userInfo.barracksSpaceModifier;
            if(_loc3_ - _loc24_ < _loc10_)
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(88)));
               return;
            }
         }
         else
         {
            if(param1.buildingInfo.buildingTypeId == 17 && city.activeRecruitJob)
            {
               dispatch(new PopUpWindowEvent("showSecondaryPopUpWindow",new ActionNotPossiblePopUp(86)));
               return;
            }
            if(param1.buildingInfo.buildingTypeId == 18)
            {
               _loc9_ = false;
               for each(var _loc19_ in city.unitTrainJobs)
               {
                  if(_loc19_.instanceId == param1.buildingInfo.instanceId)
                  {
                     _loc9_ = true;
                     break;
                  }
               }
               if(_loc9_)
               {
                  dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(85)));
                  return;
               }
            }
            else if(param1.buildingInfo.buildingTypeId == 15)
            {
               _loc18_ = false;
               _loc23_ = domainInfo.getBuilding(param1.buildingInfo.buildingTypeId);
               _loc20_ = _loc23_.buildingSpecificInfo[BuildingSpecificInfoType.STORAGE_CAPACITIES_PER_LEVEL.id];
               _loc6_ = _loc20_[param1.buildingInfo.level - 1];
               _loc8_ = city.totalResourceCapacity - _loc6_ >> 2;
               for each(var _loc13_ in ResourceType.resourceTypes)
               {
                  if(city.resourceAmounts[_loc13_.id] > _loc8_)
                  {
                     _loc18_ = true;
                     break;
                  }
               }
               if(_loc18_)
               {
                  _loc2_ = new OutgoingMessageEvent("outgoingMessage",new RecycleBuildingRequest(param1.buildingInfo.instanceId));
                  dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileResourceCapacityExceedsPopup("recycle",_loc2_,"closeSecondaryPopUpWindow")));
                  return;
               }
            }
         }
         var _loc7_:Boolean = false;
         for each(var _loc12_ in param1.buildingTypeDIO.calculateRecycleGainForLevel(param1.buildingInfo.level))
         {
            if(city.resourceAmounts[_loc12_.resourceType] + _loc12_.resourceAmount > city.totalResourceCapacity >> 2)
            {
               _loc7_ = true;
               break;
            }
         }
         if(_loc7_)
         {
            _loc2_ = new OutgoingMessageEvent("outgoingMessage",new RecycleBuildingRequest(param1.buildingInfo.instanceId));
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileResourceCapacityExceedsPopup("recycle",_loc2_,"closeSecondaryPopUpWindow")));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new RecycleBuildingRequest(param1.buildingInfo.instanceId)));
         }
      }
      
      private function buildingAction(param1:int, param2:ActionType, param3:Object) : void
      {
         var _loc4_:BuildingInfo = null;
         if(!("buildingInstanceId" in param3))
         {
            var _loc8_:int = 0;
            var _loc7_:Vector.<BuildingInfo> = city.buildings;
            do
            {
               if(§§hasnext(_loc7_,_loc8_))
               {
                  continue;
               }
            }
            while(_loc4_ = §§nextvalue(_loc8_,_loc7_), _loc4_.buildingTypeId != param1);
            dispatch(new MobileSelectEvent(_loc4_.instanceId,true,param3));
            return;
         }
         for each(_loc4_ in city.buildings)
         {
            if(_loc4_.instanceId == param3.buildingInstanceId)
            {
               dispatch(new MobileSelectEvent(_loc4_.instanceId,true,param3));
               return;
            }
         }
         dispatch(new PopUpWindowEvent("showSecondaryPopUpWindow",new ActionNotPossiblePopUp(99)));
      }
   }
}

