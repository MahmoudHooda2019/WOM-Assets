package wom.view.mediator.screen.popups.unit
{
   import starling.events.Event;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.unit.MobileGenericStopPopUp;
   
   public class MobileGenericStopPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileGenericStopPopUp;
      
      public function MobileGenericStopPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.actionButton,"triggered",onStopButtonClicked,Event);
      }
      
      protected function onStopButtonClicked(param1:Event) : void
      {
         closeWindow();
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobilePopUpWindowEvent("closeSecondaryPopUpWindow",view));
      }
   }
}

