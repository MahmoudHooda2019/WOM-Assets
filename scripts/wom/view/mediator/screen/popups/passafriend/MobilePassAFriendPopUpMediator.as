package wom.view.mediator.screen.popups.passafriend
{
   import com.greensock.TweenLite;
   import starling.events.Event;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.viral.WallPostParams;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.passafriend.MobilePassAFriendPopUp;
   
   public class MobilePassAFriendPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobilePassAFriendPopUp;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      public function MobilePassAFriendPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         view.lightView.rotate(5);
         eventMap.mapStarlingListener(view.bragToYourFriendsButton,"triggered",onBragToYourFriendsButtonClicked,Event);
         TweenLite.to(view.myAvatar,1,{"y":view.speechBubble.y + 10});
         TweenLite.to(view.friendAvatar,1,{"y":view.speechBubble.y + (view.speechBubble.height - view.friendAvatar.height - 5)});
      }
      
      override public function onRemove() : void
      {
         super.onRemove();
         TweenLite.killTweensOf(view.myAvatar);
         TweenLite.killTweensOf(view.friendAvatar);
      }
      
      private function onBragToYourFriendsButtonClicked(param1:Event) : void
      {
         if(view.friendProfile && view.friendProfile.platformId)
         {
            dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(19,view.friendProfile.platformId)));
         }
         closeWindow();
      }
   }
}

