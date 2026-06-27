package wom.view.mediator.screen.windows.store
{
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.friend.GetSelectFriendsWindowEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.message.request.HireWorkerRequest;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.facebook.MobileFBGetGoldPopUp;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.store.MobileHireWorkerWindow;
   
   public class MobileHireWorkerWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileHireWorkerWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      public function MobileHireWorkerWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("workerStaffUpdated",onWorkerStaffUpdated);
         eventMap.mapStarlingListener(view.askForHelpButton,"triggered",onAskForHelpButtonClicked,Event);
         eventMap.mapStarlingListener(view.hireInstantButton,"triggered",onHireInstantButtonClicked,Event);
         updateView();
      }
      
      private function onWorkerStaffUpdated(param1:ModelUpdateEvent) : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         view.hireInstantRequiredGold = domainInfo.getWorker().calculateGoldToBuy(city.numberOfWorkers,city.workerStaffStatus.length);
         view.askForHelpButton.isEnabled = city.workerStaffStatus.length < 4;
      }
      
      private function onAskForHelpButtonClicked(param1:Event) : void
      {
         closeWindow();
         if(mobileConnectionServiceInfo.isConnectedWithFacebook())
         {
            dispatch(new GetSelectFriendsWindowEvent("getSelectFriendsWindow",11,0));
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFBGetGoldPopUp()));
         }
      }
      
      private function onHireInstantButtonClicked(param1:Event) : void
      {
         if(userInfo.numberOfGolds < view.hireInstantRequiredGold)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
            return;
         }
         closeWindow();
         dispatch(new OutgoingMessageEvent("outgoingMessage",new HireWorkerRequest()));
      }
   }
}

