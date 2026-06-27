package wom.view.mediator.screen.windows.alliance.mobile
{
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceTipsPopUp;
   
   public class MobileAllianceTipsPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileAllianceTipsPopUp;
      
      public function MobileAllianceTipsPopUpMediator()
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

