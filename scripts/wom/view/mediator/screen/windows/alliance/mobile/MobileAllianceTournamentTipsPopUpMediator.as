package wom.view.mediator.screen.windows.alliance.mobile
{
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceTournamentTipsPopUp;
   
   public class MobileAllianceTournamentTipsPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileAllianceTournamentTipsPopUp;
      
      public function MobileAllianceTournamentTipsPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobilePopUpWindowEvent("closeSecondaryPopUpWindow",view));
      }
   }
}

