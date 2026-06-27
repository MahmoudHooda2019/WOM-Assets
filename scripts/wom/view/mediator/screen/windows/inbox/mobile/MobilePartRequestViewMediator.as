package wom.view.mediator.screen.windows.inbox.mobile
{
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.Profile;
   import wom.view.screen.windows.inbox.mobile.MobilePartRequestView;
   
   public class MobilePartRequestViewMediator extends MobileBaseRequestViewMediator
   {
      
      [Inject]
      public var view:MobilePartRequestView;
      
      public function MobilePartRequestViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         updateOtherFriendNames();
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

