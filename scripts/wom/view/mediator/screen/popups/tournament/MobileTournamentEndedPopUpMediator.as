package wom.view.mediator.screen.popups.tournament
{
   import starling.events.Event;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.tournament.MobileTournamentEndedPopUp;
   
   public class MobileTournamentEndedPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileTournamentEndedPopUp;
      
      public function MobileTournamentEndedPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.okButton,"triggered",onOkButtonClicked,Event);
      }
      
      protected function onOkButtonClicked(param1:Event) : void
      {
         closeWindow();
      }
   }
}

