package wom.view.mediator.ui.mainframe.city.mobile
{
   import starling.events.Event;
   import wom.controller.event.mobile.MobileSelectEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.FortificationInfoDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.model.game.store.StoreUtil;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.popups.resource.MobileBoostConfirmationPopUp;
   import wom.view.screen.windows.cancelconstruction.MobileCancelConstructionWindow;
   import wom.view.screen.windows.constructionsite.MobileCityCenterConstructionSiteWindow;
   import wom.view.ui.mainframe.city.mobile.MCOVUpgradeView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipProgressInfoView;
   
   public class MCOVUpgradeViewMediator extends MCOVConstructViewMediator
   {
      
      [Inject]
      public var upgradeView:MCOVUpgradeView;
      
      protected var upgradeJob:BuildingUpgradeJob;
      
      public function MCOVUpgradeViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         updateConstructionInfo();
         eventMap.mapStarlingListener(upgradeView.abandonButton,"triggered",onAbandonButtonClicked);
         eventMap.mapStarlingListener(upgradeView.askFriendsButton,"triggered",onAskFriendsButtonClicked);
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         retrieveJob();
      }
      
      private function retrieveJob() : void
      {
         var _loc2_:Boolean = false;
         for each(var _loc1_ in city.buildingUpgradeJobs)
         {
            if(buildingInfo.instanceId == _loc1_.instanceId)
            {
               _loc2_ = true;
               upgradeJob = _loc1_;
               break;
            }
         }
         if(!_loc2_)
         {
            upgradeJob = null;
         }
      }
      
      private function onAskFriendsButtonClicked() : void
      {
         if(upgradeJob)
         {
            if(upgradeJob.type == BuildingUpgradeJobType.UPGRADE && upgradeJob.targetLevel > 2 && buildingInfo.buildingTypeId == 10)
            {
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileCityCenterConstructionSiteWindow(buildingInfo,buildingTypeDIO,upgradeJob)));
            }
         }
         cancelSelection();
      }
      
      override protected function onFinishNowButtonClicked(param1:Event) : void
      {
         var _loc2_:int = calculateInstancePrice();
         if(_loc2_ > userInfo.numberOfGolds)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
         }
         else if(_loc2_ == 0)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBoostConfirmationPopUp(2003,upgradeJob,buildingInfo.instanceId,_loc2_)));
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBoostConfirmationPopUp(2007,upgradeJob,buildingInfo.instanceId,_loc2_)));
         }
      }
      
      override protected function updateConstructionInfo() : void
      {
         super.updateConstructionInfo();
         retrieveJob();
         var _loc1_:Boolean = upgradeJob && (upgradeJob.type == BuildingUpgradeJobType.UPGRADE && upgradeJob.targetLevel > 2) && buildingInfo.buildingTypeId == 10 && buildingInfo.staffs != null && buildingInfo.staffs.length < 4;
         upgradeView.updateButtonStatus(_loc1_);
         if(!upgradeJob || upgradeJob.durationRemaining + upgradeJob.jobCreationTime - new Date().getTime() <= 0)
         {
            cancelSelection();
            dispatch(new MobileSelectEvent(buildingInfo.instanceId));
         }
      }
      
      private function onAbandonButtonClicked(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc8_:FortificationInfoDIO = null;
         var _loc6_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = false;
         for each(var _loc5_ in city.buildingUpgradeJobs)
         {
            if(_loc5_.instanceId == buildingInfo.instanceId)
            {
               if(_loc5_.type == BuildingUpgradeJobType.FORTIFY)
               {
                  _loc3_ = true;
                  break;
               }
               if(_loc5_.type == BuildingUpgradeJobType.UPGRADE)
               {
                  _loc4_ = true;
                  break;
               }
            }
         }
         if(_loc4_)
         {
            _loc2_ = buildingTypeDIO.resourceCosts[buildingInfo.level == 0 ? 0 : buildingInfo.level];
         }
         else if(_loc3_)
         {
            _loc8_ = buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.FORTIFICATION_INFO.id] as FortificationInfoDIO;
            _loc2_ = _loc8_.resourceCosts[buildingInfo.fortificationLevel == 0 ? 0 : buildingInfo.fortificationLevel - 1];
         }
         else
         {
            _loc2_ = buildingTypeDIO.resourceCosts[buildingInfo.level == 0 ? 0 : buildingInfo.level - 1];
         }
         for each(var _loc7_ in _loc2_)
         {
            if(city.resourceAmounts[_loc7_.resourceType] + _loc7_.resourceAmount > city.totalResourceCapacity >> 2)
            {
               _loc6_ = true;
               break;
            }
         }
         cancelSelection();
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileCancelConstructionWindow(buildingInfo,buildingTypeDIO,_loc4_ ? BuildingUpgradeJobType.UPGRADE : BuildingUpgradeJobType.FORTIFY,_loc6_)));
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         upgradeView.addInfoView(new MobileBuildingTooltipProgressInfoView(4,buildingInfo));
      }
      
      override protected function calculateInstancePrice() : int
      {
         return StoreUtil.buildingPrice(0,(upgradeJob.durationRemaining + upgradeJob.jobCreationTime - new Date().getTime()) / 1000);
      }
   }
}

