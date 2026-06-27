package wom.view.mediator.screen.windows.inbox.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.friend.MobileRemoveRequestViewEvent;
   import wom.controller.event.inbox.InboxEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.mobile.MobileFacebookConnectionEvent;
   import wom.model.game.friend.request.RequestInfo;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.windows.inbox.mobile.MobileBaseRequestView;
   
   public class MobileBaseRequestViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var baseView:MobileBaseRequestView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      public function MobileBaseRequestViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(baseView);
         eventMap.mapStarlingListener(baseView.actionButton,"triggered",onActionButtonClicked,Event);
         eventMap.mapStarlingListener(baseView.closeButton,"triggered",onCloseButtonClicked,Event);
         addContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         addViewListener("requestsLayoutUpdated",onRequestLayoutUpdated,Event);
         updateFriendNameTextField();
      }
      
      private function onRequestLayoutUpdated(param1:Event) : void
      {
         dispatch(new InboxEvent("requestsLayoutUpdated"));
      }
      
      protected function onActionButtonClicked(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:Array = [];
         for each(_loc3_ in baseView.requests)
         {
            _loc2_.push(_loc3_.id);
         }
         if(_loc3_.type == 1 || _loc3_.type == 11 || _loc3_.type == 9 || _loc3_.type == 13 || _loc3_.type == 14 || _loc3_.type == 15)
         {
            dispatch(new MobileExternalInterfaceEvent("acceptRequest",{"ids":_loc2_}));
         }
         else if(_loc3_.type == 2)
         {
            if(_loc3_.state == "sent")
            {
               dispatch(new MobileFacebookConnectionEvent("approveRequestOverFacebook",{"requests":baseView.requests}));
               dispatch(new MobileExternalInterfaceEvent("approveRequest",{"ids":_loc2_}));
            }
            else if(_loc3_.state == "approved")
            {
               dispatch(new MobileExternalInterfaceEvent("acceptRequest",{"ids":_loc2_}));
            }
         }
         dispatch(new MobileRemoveRequestViewEvent("removeRequestView",baseView));
      }
      
      protected function onCloseButtonClicked(param1:Event) : void
      {
         var _loc2_:Array = [];
         for each(var _loc3_ in baseView.requests)
         {
            _loc2_.push(_loc3_.id);
         }
         dispatch(new MobileExternalInterfaceEvent("rejectRequest",{"ids":_loc2_}));
         dispatch(new MobileRemoveRequestViewEvent("removeRequestView",baseView));
      }
      
      protected function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         updateFriendNameTextField();
      }
      
      private function updateFriendNameTextField() : void
      {
         baseView.updateFriendNameTextField(facebookAPIManager.getUserNameByProfile(baseView.firstRequestProfile,false));
      }
   }
}

