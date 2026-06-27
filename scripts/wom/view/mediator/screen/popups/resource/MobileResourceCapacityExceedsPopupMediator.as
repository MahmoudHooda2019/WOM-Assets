package wom.view.mediator.screen.popups.resource
{
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.resource.MobileResourceCapacityExceedsPopup;
   
   public class MobileResourceCapacityExceedsPopupMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileResourceCapacityExceedsPopup;
      
      public function MobileResourceCapacityExceedsPopupMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.reconsiderButton,"triggered",onCancelButtonClicked,Event);
         eventMap.mapStarlingListener(view.confirmButton,"triggered",onConfirmButtonClicked,Event);
      }
      
      private function onConfirmButtonClicked() : void
      {
         dispatch(view.confirmEvent);
         dispatch(new ModelUpdateEvent("askForOverflowInfoUpdated"));
         closeWindow();
      }
      
      private function onCancelButtonClicked(param1:Event) : void
      {
         closeWindow();
      }
      
      override protected function closeWindow() : void
      {
         if(view.type == "blacksmith")
         {
            super.closeWindow();
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent(view.closeWindowEventType,view));
         }
      }
   }
}

