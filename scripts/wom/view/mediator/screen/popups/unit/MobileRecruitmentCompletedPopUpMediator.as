package wom.view.mediator.screen.popups.unit
{
   import starling.events.Event;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.viral.WallPostParams;
   
   public class MobileRecruitmentCompletedPopUpMediator extends MobileGenericUnitCompletionPopUpMediator
   {
      
      public function MobileRecruitmentCompletedPopUpMediator()
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
         dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(9,view.unitTypeDIO.id)));
      }
   }
}

