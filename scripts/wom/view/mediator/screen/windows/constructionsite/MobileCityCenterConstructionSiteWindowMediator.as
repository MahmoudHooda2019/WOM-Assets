package wom.view.mediator.screen.windows.constructionsite
{
   import peak.logging.log;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.friend.GetSelectFriendsWindowEvent;
   import wom.controller.event.staff.GetStaffsEvent;
   import wom.controller.event.staff.StaffsReadyEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.FortificationInfoDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.model.message.request.BuyItemRequest;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.facebook.MobileFBGetGoldPopUp;
   import wom.view.screen.windows.cancelconstruction.MobileCancelConstructionWindow;
   import wom.view.screen.windows.constructionsite.MobileCityCenterConstructionSiteWindow;
   
   public class MobileCityCenterConstructionSiteWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileCityCenterConstructionSiteWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      public function MobileCityCenterConstructionSiteWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         addContextListener("staffsReady",onStaffsReady,StaffsReadyEvent);
         addContextListener("tick",onTick,GameTickEvent);
         addContextListener("jobsInfoUpdated",onJobsUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.askFriendsButton,"triggered",onAskFriendsClicked,Event);
         eventMap.mapStarlingListener(view.abandonButton,"triggered",onAbandonClicked,Event);
         eventMap.mapStarlingListener(view.finishNowButton,"triggered",onFinishNowClicked,Event);
         dispatch(new GetStaffsEvent("getStaffs"));
      }
      
      private function onStaffsReady(param1:StaffsReadyEvent) : void
      {
         var _loc2_:BuildingTypeDIO = domainInfo.getBuilding(param1.buildingInfo.buildingTypeId);
         view.updateWithStaffList(param1.buildingInfo,param1.staffPrerequisites,param1.staffs,_loc2_.buildingSpecificInfo[BuildingSpecificInfoType.STAFF_TIME_REDUCTION_PER_LEVEL.id]);
      }
      
      private function onAskFriendsClicked(param1:Event) : void
      {
         closeWindow();
         if(mobileConnectionServiceInfo.isConnectedWithFacebook())
         {
            dispatch(new GetSelectFriendsWindowEvent("getSelectFriendsWindow",1,0));
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFBGetGoldPopUp()));
         }
      }
      
      private function onAbandonClicked(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc8_:FortificationInfoDIO = null;
         var _loc6_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = false;
         for each(var _loc5_ in city.buildingUpgradeJobs)
         {
            if(_loc5_.instanceId == view.buildingInfo.instanceId)
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
            _loc2_ = view.buildingTypeDIO.resourceCosts[view.buildingInfo.level == 0 ? 0 : view.buildingInfo.level];
         }
         else if(_loc3_)
         {
            _loc8_ = view.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.FORTIFICATION_INFO.id] as FortificationInfoDIO;
            _loc2_ = _loc8_.resourceCosts[view.buildingInfo.fortificationLevel == 0 ? 0 : view.buildingInfo.fortificationLevel - 1];
         }
         else
         {
            _loc2_ = view.buildingTypeDIO.resourceCosts[view.buildingInfo.level == 0 ? 0 : view.buildingInfo.level - 1];
         }
         for each(var _loc7_ in _loc2_)
         {
            if(city.resourceAmounts[_loc7_.resourceType] + _loc7_.resourceAmount > city.totalResourceCapacity >> 2)
            {
               _loc6_ = true;
               break;
            }
         }
         closeWindow();
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileCancelConstructionWindow(view.buildingInfo,view.buildingTypeDIO,_loc4_ ? BuildingUpgradeJobType.UPGRADE : BuildingUpgradeJobType.FORTIFY,_loc6_)));
      }
      
      private function onFinishNowClicked(param1:Event) : void
      {
         if(view.remainingTime < 300000)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2003,view.buildingInfo.instanceId)));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2007,view.buildingInfo.instanceId)));
         }
         closeWindow();
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         if(view.remainingTime <= 0)
         {
            closeWindow();
         }
         else
         {
            view.updateView();
         }
      }
      
      private function onJobsUpdated(param1:ModelUpdateEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BuildingUpgradeJob = null;
         log(WomLoggerContexts.GAME,"Jobs updated");
         _loc3_ = 0;
         while(_loc3_ < city.buildingUpgradeJobs.length)
         {
            _loc2_ = city.buildingUpgradeJobs[_loc3_];
            if(view.job.instanceId == _loc2_.instanceId)
            {
               view.updateUpgradeJob(_loc2_);
            }
            _loc3_++;
         }
      }
   }
}

