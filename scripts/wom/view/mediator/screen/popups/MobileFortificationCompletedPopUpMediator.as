package wom.view.mediator.screen.popups
{
   import starling.events.Event;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.viral.WallPostParams;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileFortificationCompletedPopUp;
   
   public class MobileFortificationCompletedPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileFortificationCompletedPopUp;
      
      public function MobileFortificationCompletedPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.bragToYourFriendsButton,"triggered",onBragToYourFriendsButtonClicked,Event);
      }
      
      private function onBragToYourFriendsButtonClicked(param1:Event) : void
      {
         closeWindow();
         dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(2,view.buildingTypeDIO.id,view.fortificationLevel)));
      }
   }
}

