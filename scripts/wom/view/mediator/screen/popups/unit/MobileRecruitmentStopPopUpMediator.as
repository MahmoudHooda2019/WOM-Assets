package wom.view.mediator.screen.popups.unit
{
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.message.request.CancelRecruitmentRequest;
   
   public class MobileRecruitmentStopPopUpMediator extends MobileGenericStopPopUpMediator
   {
      
      public function MobileRecruitmentStopPopUpMediator()
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
         dispatch(new OutgoingMessageEvent("outgoingMessage",new CancelRecruitmentRequest()));
      }
   }
}

