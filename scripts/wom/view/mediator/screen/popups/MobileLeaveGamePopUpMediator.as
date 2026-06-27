package wom.view.mediator.screen.popups
{
   import flash.desktop.NativeApplication;
   import starling.events.Event;
   import wom.controller.event.ui.MobileCloseGenericWindowEvent;
   import wom.view.screen.popups.MobileLeaveGamePopUp;
   
   public class MobileLeaveGamePopUpMediator extends MobileGenericActionPopUpMediator
   {
      
      [Inject]
      public var leaveGame:MobileLeaveGamePopUp;
      
      public function MobileLeaveGamePopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(leaveGame.leaveButton,"triggered",onLeaveGameClicked,Event);
      }
      
      private function onLeaveGameClicked(param1:Event) : void
      {
         NativeApplication.nativeApplication.exit();
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobileCloseGenericWindowEvent("mobileCloseGenericWindow",leaveGame));
      }
   }
}

