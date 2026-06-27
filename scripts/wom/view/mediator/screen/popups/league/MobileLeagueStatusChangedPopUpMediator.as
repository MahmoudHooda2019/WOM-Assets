package wom.view.mediator.screen.popups.league
{
   import wom.controller.event.ModelUpdateEvent;
   
   public class MobileLeagueStatusChangedPopUpMediator extends MobileLeagueStatusDroppedPopUpMediator
   {
      
      public function MobileLeagueStatusChangedPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("leagueInfoViewUpdated",onLeagueInfoViewUpdated,ModelUpdateEvent);
      }
      
      private function onLeagueInfoViewUpdated(param1:ModelUpdateEvent) : void
      {
         view.drawLayout();
      }
   }
}

