package wom.controller.command.city
{
   import flash.utils.getTimer;
   import peak.i18n.PText;
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.ConstructableActionEvent;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.resource.BankResourcesEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.enum.ActionType;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.FortificationInfoDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.resource.ResourceType;
   import wom.model.message.request.BuyItemRequest;
   import wom.model.message.request.HelpFriendRequest;
   import wom.model.message.request.RecycleBuildingRequest;
   import wom.view.screen.popups.apologies.ActionNotPossiblePopUp;
   import wom.view.screen.popups.apologies.ApologiesPopup;
   import wom.view.screen.popups.apologies.CannotFortifyPopup;
   import wom.view.screen.popups.repair.RepairSitePopup;
   import wom.view.screen.windows.activate.ActivateBuildingWindow;
   import wom.view.screen.windows.alliance.AllianceBarracksWindow;
   import wom.view.screen.windows.alliance.AllianceWindow;
   import wom.view.screen.windows.beast.keeper.BeastKeeperWindow;
   import wom.view.screen.windows.beast.select.BeastSelectWindow;
   import wom.view.screen.windows.beastcannon.BeastCannonRechargeWindow;
   import wom.view.screen.windows.blacksmith.BlacksmithWindow;
   import wom.view.screen.windows.build.RearmTrapsWindow;
   import wom.view.screen.windows.catapult.CatapultRechargeWindow;
   import wom.view.screen.windows.cityplanner.CityPlannerWindow;
   import wom.view.screen.windows.constructionsite.CityCenterConstructionSiteWindow;
   import wom.view.screen.windows.constructionsite.ConstructionSiteWindow;
   import wom.view.screen.windows.executionalguillotine.ExecutionalGuillotineWindow;
   import wom.view.screen.windows.fortify.MobileFortifyWindow;
   import wom.view.screen.windows.hiringquarters.CentralHiringQuartersWindow;
   import wom.view.screen.windows.hiringquarters.HiringQuartersWindow;
   import wom.view.screen.windows.mercenarybarracks.MercenaryBarracksWindow;
   import wom.view.screen.windows.pigeonpost.PigeonPostWindow;
   import wom.view.screen.windows.recruitmentchamber.RecruitmentChamberWindow;
   import wom.view.screen.windows.recycle.RecycleBuildingWindow;
   import wom.view.screen.windows.recycle.RecycleDecorationWindow;
   import wom.view.screen.windows.staff.ActivateBuildingByStaffsWindow;
   import wom.view.screen.windows.store.StoreWindow;
   import wom.view.screen.windows.trainingchamber.TrainingChamberWindow;
   import wom.view.screen.windows.tuskhorn.MobileTuskHornWindow;
   import wom.view.screen.windows.upgrade.UpgradeCityCenterWindow;
   import wom.view.screen.windows.upgrade.UpgradeComperativeWindow;
   import wom.view.screen.windows.upgrade.UpgradeInformativeWindow;
   import wom.view.screen.windows.watchpost.FriendWatchPostWindow;
   import wom.view.screen.windows.watchpost.WatchPostWindow;
   
   public class ExecuteConstructableActionCommand extends PCommand
   {
      
      private static const FIVE_MIN:int = 300000;
      
      private static const INSTANT_FINISH_ITEM:int = 2003;
      
      [Inject]
      public var constructableActionEvent:ConstructableActionEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function ExecuteConstructableActionCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc22_:BuildingInfo = null;
         var _loc7_:BuildingTypeDIO = null;
         var _loc19_:int = 0;
         var _loc1_:Boolean = false;
         var _loc13_:BuildingRepairJob = null;
         var _loc12_:Boolean = false;
         var _loc10_:BuildingUpgradeJob = null;
         var _loc16_:Boolean = false;
         var _loc24_:UnitTrainJob = null;
         var _loc8_:Object = null;
         var _loc21_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc23_:Boolean = false;
         var _loc17_:int = 0;
         var _loc11_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc25_:int = getTimer();
         if(_loc25_ - userInfo.lastBuildingActionTimer > 100)
         {
            userInfo.lastBuildingActionType = constructableActionEvent.actionType;
            userInfo.lastBuildingActionTimer = _loc25_;
            if(constructableActionEvent.actionType == ActionType.REMAINING_HELP_1 || constructableActionEvent.actionType == ActionType.REMAINING_HELP_2 || constructableActionEvent.actionType == ActionType.REMAINING_HELP_3 || constructableActionEvent.actionType == ActionType.REMAINING_HELP_4 || constructableActionEvent.actionType == ActionType.REMAINING_HELP_5)
            {
               soundPlayer.playSfxById("UseResources");
               eventDispatcher.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",new HelpFriendRequest(visitInfo.landlord,constructableActionEvent.instanceId)));
            }
            else
            {
               _loc22_ = ConstructableActionCommandHelper.findBuildingInfo(constructableActionEvent.instanceId,city);
               if(_loc22_ == null)
               {
                  if(constructableActionEvent.actionType == ActionType.MOVE)
                  {
                     coreManager.startMove(constructableActionEvent.instanceId);
                  }
                  else if(constructableActionEvent.actionType == ActionType.RECYCLE)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new RecycleDecorationWindow(constructableActionEvent.instanceId)));
                  }
                  return;
               }
               _loc7_ = domainInfo.getBuilding(_loc22_.buildingTypeId);
               _loc1_ = false;
               _loc19_ = 0;
               while(_loc19_ < city.buildingRepairJobs.length)
               {
                  _loc13_ = city.buildingRepairJobs[_loc19_];
                  if(_loc13_.instanceId == _loc22_.instanceId)
                  {
                     _loc1_ = true;
                     if(_loc13_.durationRemaining + _loc13_.jobCreationTime - new Date().getTime() < 300000)
                     {
                        dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2003,_loc22_.instanceId)));
                        return;
                     }
                     break;
                  }
                  _loc19_++;
               }
               if(_loc1_)
               {
                  if(city.buildingRepairJobs.length > 1)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new RepairSitePopup(_loc22_.instanceId)));
                  }
                  else
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new StoreWindow(_loc22_.instanceId)));
                  }
                  return;
               }
               _loc12_ = false;
               _loc19_ = 0;
               while(_loc19_ < city.buildingUpgradeJobs.length)
               {
                  _loc10_ = city.buildingUpgradeJobs[_loc19_];
                  if(_loc10_.instanceId == _loc22_.instanceId)
                  {
                     _loc12_ = true;
                     if(_loc10_.durationRemaining + _loc10_.jobCreationTime - new Date().getTime() < 300000)
                     {
                        dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2003,_loc22_.instanceId)));
                        return;
                     }
                     break;
                  }
                  _loc19_++;
               }
               _loc16_ = false;
               if(_loc7_.id == 18)
               {
                  _loc19_ = 0;
                  while(_loc19_ < city.unitTrainJobs.length)
                  {
                     _loc24_ = city.unitTrainJobs[_loc19_];
                     if(_loc24_.instanceId == _loc22_.instanceId)
                     {
                        _loc16_ = true;
                        if(_loc24_.durationRemaining + _loc24_.jobCreationTime - new Date().getTime() < 300000)
                        {
                           dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2003,_loc22_.instanceId)));
                           return;
                        }
                        break;
                     }
                     _loc19_++;
                  }
               }
               if(_loc7_.id == 17 && city.activeRecruitJob)
               {
                  if(city.activeRecruitJob.durationRemaining + city.activeRecruitJob.jobCreationTime - new Date().getTime() < 300000)
                  {
                     dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2003,_loc22_.instanceId)));
                     return;
                  }
               }
               _loc8_ = null;
               if(constructableActionEvent.actionType == ActionType.UPGRADE)
               {
                  if(_loc12_ || _loc1_)
                  {
                     openConstructionSiteWindow(_loc22_,_loc7_);
                  }
                  else if(_loc22_.incomplete)
                  {
                     streamlineLastBuildingActionTimer();
                     dispatch(new ConstructableActionEvent("execute",ActionType.ACTIVATE,constructableActionEvent.instanceId,constructableActionEvent.windowSpecificAttributes));
                  }
                  else if(_loc22_.level == _loc7_.maxLevels)
                  {
                     var _temp_13:* = §§findproperty(MobileUINotificationEvent);
                     var _temp_12:* = "mobileUINotificationEventShow";
                     var _loc36_:String = "ui.popups.fullyupgraded.message";
                     dispatch(new MobileUINotificationEvent(_temp_12,peak.i18n.PText.INSTANCE.getText0(_loc36_)));
                     trace("MobileUINotificationEvent -> fullyupgraded");
                  }
                  else if(_loc7_.id == 10)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new UpgradeCityCenterWindow(_loc22_,_loc7_)));
                  }
                  else if(_loc7_.id == 23 || _loc7_.id == 27 || _loc7_.id == 17 || _loc7_.id == 18 || _loc7_.id == 44)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new UpgradeInformativeWindow(_loc22_,_loc7_)));
                  }
                  else
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new UpgradeComperativeWindow(_loc22_,_loc7_)));
                  }
               }
               else if(constructableActionEvent.actionType == ActionType.HARVEST_ALL)
               {
                  _loc21_ = false;
                  _loc15_ = true;
                  for each(var _loc20_ in ResourceType.resourceTypes)
                  {
                     if(_loc15_)
                     {
                        _loc15_ = city.resourceAmounts[_loc20_.id] >= city.totalResourceCapacity >> 2;
                     }
                     if(city.resourceAmounts[_loc20_.id] < city.totalResourceCapacity >> 2)
                     {
                        for each(_loc22_ in city.buildings)
                        {
                           _loc7_ = domainInfo.getBuilding(_loc22_.buildingTypeId);
                           if(_loc7_.kind.id == 11 && (_loc7_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType).id == _loc20_.id && _loc22_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] >= 1)
                           {
                              _loc21_ = true;
                              break;
                           }
                        }
                     }
                     if(_loc21_)
                     {
                        break;
                     }
                  }
                  if(_loc21_)
                  {
                     soundPlayer.playSfxById("CollectResource");
                  }
                  if(_loc15_)
                  {
                     dispatch(new PopUpWindowEvent("showSecondaryPopUpWindow",new ActionNotPossiblePopUp(79)));
                  }
                  else
                  {
                     dispatch(new BankResourcesEvent("bankAllResources"));
                  }
               }
               else if(constructableActionEvent.actionType == ActionType.HARVEST)
               {
                  if(BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id in _loc22_.buildingSpecificInfo && BuildingSpecificInfoType.PRODUCED_RESOURCE.id in _loc7_.buildingSpecificInfo)
                  {
                     _loc2_ = _loc22_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] >= 1;
                     _loc23_ = city.resourceAmounts[(_loc7_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType).id] < city.totalResourceCapacity >> 2;
                     if(_loc2_ && _loc23_)
                     {
                        soundPlayer.playSfxById("CollectResource");
                     }
                  }
                  dispatch(new BankResourcesEvent("bankInstanceResources",constructableActionEvent.instanceId));
               }
               else if(constructableActionEvent.actionType == ActionType.HARVEST_GOLD)
               {
                  _loc17_ = ConstructableActionCommandHelper.calculateUnharvestedGoldAmount(_loc25_,_loc22_,_loc7_,userInfo,city);
                  if(_loc17_ > 0)
                  {
                     ConstructableActionCommandHelper.harvestGold(_loc17_,_loc22_.instanceId,soundPlayer,gameRootHolder,eventDispatcher);
                  }
                  else
                  {
                     streamlineLastBuildingActionTimer();
                     dispatch(new ConstructableActionEvent("execute",ActionType.UPGRADE,constructableActionEvent.instanceId,constructableActionEvent.windowSpecificAttributes));
                  }
               }
               else if(constructableActionEvent.actionType == ActionType.RECYCLE)
               {
                  if(_loc7_.recyclable)
                  {
                     if(_loc12_ || _loc22_.incomplete)
                     {
                        dispatch(new PopUpWindowEvent("showPopUpWindow",new ApologiesPopup(4)));
                     }
                     else if(_loc7_.id == 30)
                     {
                        _loc11_ = false;
                        for each(var _loc4_ in city.beastLevelBonusTuples)
                        {
                           _loc11_ = true;
                        }
                        if(_loc11_)
                        {
                           dispatch(new PopUpWindowEvent("showPopUpWindow",new ApologiesPopup(11)));
                        }
                        else
                        {
                           dispatch(new PopUpWindowEvent("showPopUpWindow",new RecycleBuildingWindow(_loc22_,_loc7_)));
                        }
                     }
                     else if(_loc22_.isTrap && _loc22_.healthPoint == 0)
                     {
                        dispatch(new OutgoingMessageEvent("outgoingMessage",new RecycleBuildingRequest(_loc22_.instanceId)));
                     }
                     else
                     {
                        dispatch(new PopUpWindowEvent("showPopUpWindow",new RecycleBuildingWindow(_loc22_,_loc7_)));
                     }
                  }
                  else
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new ApologiesPopup(5)));
                  }
               }
               else if(constructableActionEvent.actionType == ActionType.MOVE)
               {
                  _loc18_ = false;
                  for each(var _loc5_ in city.buildings)
                  {
                     if(_loc5_.buildingTypeId == 26 && _loc5_.level > 0)
                     {
                        _loc18_ = true;
                        break;
                     }
                  }
                  if(_loc12_ && !_loc18_)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new ApologiesPopup(0)));
                  }
                  else
                  {
                     coreManager.startMove(constructableActionEvent.instanceId);
                  }
               }
               else if(constructableActionEvent.actionType == ActionType.ACTIVATE)
               {
                  if(_loc22_ && _loc22_.buildingTypeId == 10)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new ActivateBuildingByStaffsWindow()));
                  }
                  else if(_loc22_ && _loc22_.isTrap)
                  {
                     showRearmWindow();
                  }
                  else
                  {
                     _loc9_ = 0;
                     _loc19_ = 0;
                     while(_loc19_ < city.buildings.length)
                     {
                        if(city.buildings[_loc19_].buildingTypeId == _loc22_.buildingTypeId)
                        {
                           if(!city.buildings[_loc19_].incomplete)
                           {
                              _loc9_++;
                           }
                        }
                        _loc19_++;
                     }
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new ActivateBuildingWindow(_loc22_,_loc7_.buildingSpecificInfo[BuildingSpecificInfoType.PART_REQUIREMENTS_PER_LEVEL.id][_loc9_])));
                  }
               }
               else if(constructableActionEvent.actionType == ActionType.CONSTRUCTION_SITE)
               {
                  openConstructionSiteWindow(_loc22_,_loc7_);
               }
               else if(constructableActionEvent.actionType == ActionType.FORTIFY)
               {
                  if(BuildingSpecificInfoType.FORTIFICATION_INFO.id in _loc7_.buildingSpecificInfo)
                  {
                     if(_loc12_)
                     {
                        dispatch(new PopUpWindowEvent("showPopUpWindow",new ApologiesPopup(2)));
                     }
                     else if(_loc22_.fortificationLevel == (_loc7_.buildingSpecificInfo[BuildingSpecificInfoType.FORTIFICATION_INFO.id] as FortificationInfoDIO).maxLevels)
                     {
                        var _temp_38:* = §§findproperty(MobileUINotificationEvent);
                        var _temp_37:* = "mobileUINotificationEventShow";
                        var _loc37_:String = "ui.popups.fullyfortified.message";
                        dispatch(new MobileUINotificationEvent(_temp_37,peak.i18n.PText.INSTANCE.getText0(_loc37_)));
                        trace("MobileUINotificationEvent -> fullyfortified");
                     }
                     else if(!_loc7_.isHealthy(_loc22_.level,_loc22_.healthPoint))
                     {
                        dispatch(new PopUpWindowEvent("showPopUpWindow",new ApologiesPopup(7)));
                     }
                     else
                     {
                        dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFortifyWindow(_loc22_,_loc7_)));
                     }
                  }
                  else
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new CannotFortifyPopup()));
                  }
               }
               else if(constructableActionEvent.actionType == ActionType.ENTER_BUILDING)
               {
                  _loc8_ = constructableActionEvent.windowSpecificAttributes;
                  if(!_loc7_.isHealthy(_loc22_.level,_loc22_.healthPoint))
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new ApologiesPopup(8)));
                  }
                  else if(_loc22_.buildingTypeId == 17)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new RecruitmentChamberWindow(_loc22_.instanceId,userInfo.serverSpeed,"pages" in _loc8_ ? _loc8_.pages : -1,"units" in _loc8_ ? _loc8_.units : -1,"windowEnumerations" in _loc8_ ? _loc8_.windowEnumerations : null)));
                  }
                  else if(_loc22_.buildingTypeId == 18)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new TrainingChamberWindow(_loc22_.instanceId)));
                  }
                  else if(_loc22_.buildingTypeId == 25)
                  {
                     dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileTuskHornWindow()));
                  }
                  else if(_loc22_.buildingTypeId == 44)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new BlacksmithWindow()));
                  }
                  else if(_loc22_.buildingTypeId == 27)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new ExecutionalGuillotineWindow()));
                  }
                  else if(_loc22_.buildingTypeId == 37)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new WatchPostWindow(_loc22_.instanceId,_loc22_.level)));
                  }
                  else if(_loc22_.buildingTypeId == 26)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new CityPlannerWindow("fullscreen" in _loc8_ ? _loc8_.fullscreen : false)));
                  }
                  else if(_loc22_.buildingTypeId == 20)
                  {
                     _loc6_ = -1;
                     _loc19_ = 0;
                     while(_loc19_ < city.buildings.length)
                     {
                        if(city.buildings[_loc19_].buildingTypeId == 21 && city.buildings[_loc19_].level > 0)
                        {
                           _loc6_ = city.buildings[_loc19_].instanceId;
                           break;
                        }
                        _loc19_++;
                     }
                     if(_loc6_ != -1)
                     {
                        streamlineLastBuildingActionTimer();
                        dispatch(new ConstructableActionEvent(constructableActionEvent.type,constructableActionEvent.actionType,_loc6_,constructableActionEvent.windowSpecificAttributes));
                     }
                     else
                     {
                        dispatch(new PopUpWindowEvent("showPopUpWindow",new HiringQuartersWindow(_loc22_.instanceId,_loc22_.level,"units" in _loc8_ ? _loc8_.units : 10,"windowEnumerations" in _loc8_ ? _loc8_.windowEnumerations : null)));
                     }
                  }
                  else if(_loc22_.buildingTypeId == 21)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new CentralHiringQuartersWindow(_loc22_.instanceId,"units" in _loc8_ ? _loc8_.units : 10,"windowEnumerations" in _loc8_ ? _loc8_.windowEnumerations : null)));
                  }
                  else if(_loc22_.buildingTypeId == 29)
                  {
                     _loc3_ = 0;
                     if(city.beast != null)
                     {
                        _loc3_++;
                     }
                     if(city.beastLevelBonusTuples != null)
                     {
                        for(var _loc14_ in city.beastLevelBonusTuples)
                        {
                           _loc3_++;
                        }
                     }
                     if(_loc3_ <= 0)
                     {
                        dispatch(new PopUpWindowEvent("showPopUpWindow",new BeastSelectWindow("beast" in _loc8_ ? _loc8_.beast : -1)));
                     }
                  }
                  else if(_loc22_.buildingTypeId == 30)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new BeastKeeperWindow()));
                  }
                  else if(_loc22_.buildingTypeId == 28)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new PigeonPostWindow()));
                  }
                  else if(_loc22_.buildingTypeId == 19)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new MercenaryBarracksWindow()));
                  }
                  else if(_loc22_.buildingTypeId == 43)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new AllianceBarracksWindow()));
                  }
                  else if(_loc22_.buildingTypeId == 38)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new FriendWatchPostWindow()));
                  }
                  else if(_loc22_.buildingTypeId == 23)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new CatapultRechargeWindow(_loc22_.level)));
                  }
                  else if(_loc22_.buildingTypeId == 42)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new AllianceWindow()));
                  }
                  else if(_loc22_.buildingTypeId == 45)
                  {
                     dispatch(new PopUpWindowEvent("showPopUpWindow",new BeastCannonRechargeWindow()));
                  }
                  else
                  {
                     eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay","Enter building for " + _loc22_.buildingTypeId + " has not implemented yet"));
                  }
               }
               else
               {
                  eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay","Action " + constructableActionEvent.actionType + " has not implemented yet"));
               }
            }
         }
      }
      
      private function showRearmWindow() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.buildingTypeId == 39 && _loc1_.healthPoint == 0)
            {
               _loc2_++;
            }
            else if(_loc1_.buildingTypeId == 40 && _loc1_.healthPoint == 0)
            {
               _loc3_++;
            }
         }
         dispatch(new PopUpWindowEvent("showPopUpWindow",new RearmTrapsWindow(domainInfo.getBuilding(40),domainInfo.getBuilding(39),_loc3_,_loc2_)));
      }
      
      private function openConstructionSiteWindow(param1:BuildingInfo, param2:BuildingTypeDIO) : void
      {
         var _loc3_:BuildingUpgradeJobType = BuildingUpgradeJobType.INVALID_JOB;
         var _loc5_:Boolean = false;
         for each(var _loc4_ in city.buildingUpgradeJobs)
         {
            if(_loc4_.instanceId == param1.instanceId)
            {
               _loc3_ = _loc4_.type;
               _loc5_ = true;
               break;
            }
         }
         if(_loc5_ && _loc4_)
         {
            if(_loc4_.type == BuildingUpgradeJobType.UPGRADE && _loc4_.targetLevel > 2 && param1.buildingTypeId == 10)
            {
               dispatch(new PopUpWindowEvent("showPopUpWindow",new CityCenterConstructionSiteWindow(param1,param2,_loc4_)));
            }
            else
            {
               dispatch(new PopUpWindowEvent("showPopUpWindow",new ConstructionSiteWindow(param1,param2,_loc4_)));
            }
         }
         else if(param1.incomplete)
         {
            streamlineLastBuildingActionTimer();
            dispatch(new ConstructableActionEvent("execute",ActionType.ACTIVATE,constructableActionEvent.instanceId,constructableActionEvent.windowSpecificAttributes));
         }
         else
         {
            streamlineLastBuildingActionTimer();
            dispatch(new ConstructableActionEvent("execute",param2.defaultActionType,constructableActionEvent.instanceId,constructableActionEvent.windowSpecificAttributes));
         }
      }
      
      private function streamlineLastBuildingActionTimer() : void
      {
         userInfo.lastBuildingActionTimer -= 100 + 1;
      }
   }
}

