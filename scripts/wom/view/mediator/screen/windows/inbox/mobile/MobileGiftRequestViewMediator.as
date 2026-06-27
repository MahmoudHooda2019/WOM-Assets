package wom.view.mediator.screen.windows.inbox.mobile
{
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.friend.MobileRemoveRequestViewEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.mobile.MobileFacebookConnectionEvent;
   import wom.model.game.Profile;
   import wom.model.game.UserInfo;
   import wom.model.game.friend.request.GiftRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   import wom.view.screen.windows.inbox.mobile.MobileGiftRequestView;
   
   public class MobileGiftRequestViewMediator extends MobileBaseRequestViewMediator
   {
      
      [Inject]
      public var view:MobileGiftRequestView;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileGiftRequestViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         view.updateTextFields();
         updateOtherFriendNames();
      }
      
      override protected function onActionButtonClicked(param1:Event) : void
      {
         var _loc2_:Array = [];
         for each(var _loc3_ in view.requests)
         {
            _loc2_.push(_loc3_.id);
         }
         if((_loc3_ as GiftRequestInfo).thankYou)
         {
            dispatch(new MobileExternalInterfaceEvent("acceptRequest",{"ids":_loc2_}));
         }
         else
         {
            dispatch(new MobileFacebookConnectionEvent("acceptAndSendRequestOverFacebook",{"requests":baseView.requests}));
         }
         dispatch(new MobileRemoveRequestViewEvent("removeRequestView",view));
      }
      
      override protected function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         updateOtherFriendNames();
         super.onPlatformUsersUpdated(param1);
      }
      
      private function updateOtherFriendNames() : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         for(var _loc1_ in view.otherFriendProfiles)
         {
            _loc2_ = view.otherFriendProfiles[_loc1_];
            if(_loc2_ is Profile)
            {
               _loc3_ = facebookAPIManager.getUserNameByProfile(_loc2_ as Profile,false);
               if(_loc3_ != _loc1_)
               {
                  view.otherFriendProfiles[_loc1_] = _loc3_;
               }
            }
         }
         view.updateOtherFriendNames();
      }
   }
}

