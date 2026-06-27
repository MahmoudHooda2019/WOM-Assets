package wom.view.mediator.screen.popups.unit
{
   import starling.events.Event;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.viral.WallPostParams;
   import wom.view.screen.popups.unit.MobileTrainingCompletedPopUp;
   
   public class MobileTrainingCompletedPopUpMediator extends MobileGenericUnitCompletionPopUpMediator
   {
      
      public function MobileTrainingCompletedPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
      }
      
      override protected function onWarnYourFriendsButtonClicked(param1:Event) : void
      {
         super.onWarnYourFriendsButtonClicked(param1);
         dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(15,view.unitTypeDIO.id,(view as MobileTrainingCompletedPopUp).level)));
      }
   }
}

