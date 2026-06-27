package wom.view.mediator.screen.popups.league
{
   import starling.events.Event;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.viral.WallPostParams;
   import wom.view.screen.popups.league.MobileLeagueStatusPlacedPopUp;
   
   public class MobileLeagueStatusPlacedPopUpMediator extends MobileLeagueStatusChangedPopUpMediator
   {
      
      public function MobileLeagueStatusPlacedPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
      }
      
      override protected function onOkButtonClicked(param1:Event) : void
      {
         super.onOkButtonClicked(param1);
         dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(17,(view as MobileLeagueStatusPlacedPopUp).leagueLevelDIO.id)));
      }
   }
}

