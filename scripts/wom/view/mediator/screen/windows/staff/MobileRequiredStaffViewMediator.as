package wom.view.mediator.screen.windows.staff
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.TouchEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.friend.GetSelectFriendsWindowEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.friend.FriendInfo;
   import wom.model.game.staff.StaffInfo;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.popups.facebook.MobileFBGetGoldPopUp;
   import wom.view.screen.windows.staff.MobileRequiredStaffView;
   
   public class MobileRequiredStaffViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileRequiredStaffView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      public function MobileRequiredStaffViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         if(view.worker)
         {
            updateWorkerData(null);
         }
         injector.injectInto(view);
         addViewListener("touch",onViewTouched,TouchEvent);
         if(view.worker)
         {
            addContextListener("workerStaffUpdated",updateWorkerData);
         }
         updateFriend();
      }
      
      private function updateWorkerData(param1:ModelUpdateEvent) : void
      {
         view.customInfo = domainInfo.getWorker().staffGoldReductionsPerInstance[city.numberOfWorkers][view.instanceId];
         if(view.instanceId < city.workerStaffStatus.length)
         {
            view.staffInfo = new StaffInfo(view.instanceId,city.workerStaffStatus[view.instanceId]);
         }
      }
      
      private function onViewTouched(param1:TouchEvent) : void
      {
         if(param1.getTouch(view,"ended"))
         {
            dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view));
            if(mobileConnectionServiceInfo.isConnectedWithFacebook())
            {
               dispatch(new GetSelectFriendsWindowEvent("getSelectFriendsWindow",view.worker ? 11 : 1,0));
            }
            else
            {
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFBGetGoldPopUp()));
            }
         }
      }
      
      private function updateFriend() : void
      {
         if(view.staff != null)
         {
            for each(var _loc1_ in documentConfiguration.friends)
            {
               if(_loc1_.profile.platformId && _loc1_.profile.platformId == view.staff.profile.platformId)
               {
                  view.updateFriend(_loc1_,facebookAPIManager.getUserNameByProfile(_loc1_.profile,true));
                  break;
               }
            }
         }
      }
   }
}

