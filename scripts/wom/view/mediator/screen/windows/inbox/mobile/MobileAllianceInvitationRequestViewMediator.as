package wom.view.mediator.screen.windows.inbox.mobile
{
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.RemoveAllianceInvitationEvent;
   import wom.controller.event.friend.MobileRemoveRequestViewEvent;
   import wom.model.message.request.alliance.ReplyToAllianceInvitationRequest;
   import wom.view.screen.windows.inbox.mobile.MobileAllianceInvitationRequestView;
   
   public class MobileAllianceInvitationRequestViewMediator extends MobileBaseRequestViewMediator
   {
      
      [Inject]
      public var view:MobileAllianceInvitationRequestView;
      
      public function MobileAllianceInvitationRequestViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
      }
      
      override protected function onActionButtonClicked(param1:Event) : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new ReplyToAllianceInvitationRequest(view.invitation.allianceId,true)));
         dispatch(new MobileRemoveRequestViewEvent("removeRequestView",view));
      }
      
      override protected function onCloseButtonClicked(param1:Event) : void
      {
         var _loc2_:Number = view.invitation.allianceId;
         dispatch(new OutgoingMessageEvent("outgoingMessage",new ReplyToAllianceInvitationRequest(_loc2_,false)));
         dispatch(new RemoveAllianceInvitationEvent("removeAllianceInvitation",_loc2_));
         dispatch(new MobileRemoveRequestViewEvent("removeRequestView",view));
      }
   }
}

