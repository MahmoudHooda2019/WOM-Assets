package wom.view.mediator.screen.popups.unit
{
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.message.request.CancelUnitTrainingRequest;
   import wom.view.screen.popups.unit.MobileTrainingStopPopUp;
   
   public class MobileTrainingStopPopUpMediator extends MobileGenericStopPopUpMediator
   {
      
      public function MobileTrainingStopPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
      }
      
      override protected function onStopButtonClicked(param1:Event) : void
      {
         super.onStopButtonClicked(param1);
         dispatch(new OutgoingMessageEvent("outgoingMessage",new CancelUnitTrainingRequest((view as MobileTrainingStopPopUp).buildingInstanceId)));
      }
   }
}

