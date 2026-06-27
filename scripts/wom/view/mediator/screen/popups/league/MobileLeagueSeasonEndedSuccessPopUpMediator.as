package wom.view.mediator.screen.popups.league
{
   import starling.events.Event;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.viral.WallPostParams;
   
   public class MobileLeagueSeasonEndedSuccessPopUpMediator extends MobileLeagueSeasonEndedPopUpMediator
   {
      
      public function MobileLeagueSeasonEndedSuccessPopUpMediator()
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
         dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(18,view.leagueLevelId,view.position)));
      }
   }
}

