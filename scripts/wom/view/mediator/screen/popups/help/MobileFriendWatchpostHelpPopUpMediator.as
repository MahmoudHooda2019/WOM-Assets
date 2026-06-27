package wom.view.mediator.screen.popups.help
{
   import starling.events.Event;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.viral.WallPostParams;
   import wom.view.screen.popups.friendwatchpost.MobileFriendWatchpostHelpPopUp;
   
   public class MobileFriendWatchpostHelpPopUpMediator extends MobileHelpedFriendPopUpMediator
   {
      
      [Inject]
      public var view:MobileFriendWatchpostHelpPopUp;
      
      public function MobileFriendWatchpostHelpPopUpMediator()
      {
         super();
      }
      
      override protected function onSayThanksButtonClicked(param1:Event) : void
      {
         closeWindow();
         dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(4,view.helps.helpedFriends.length)));
      }
   }
}

