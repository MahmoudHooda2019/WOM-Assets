package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.alliance.RemoveAllianceInvitationEvent;
   import wom.controller.event.alliance.RetrieveAllianceInvitationsEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.response.alliance.ReplyToAllianceInvitationResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleReplyToAllianceInvitationResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleReplyToAllianceInvitationResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ReplyToAllianceInvitationResponse = messageReceivedEvent.message as ReplyToAllianceInvitationResponse;
         if(_loc1_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc1_.resultCode,GenericActionPopUp);
            return;
         }
         dispatch(new RemoveAllianceInvitationEvent("removeAllianceInvitation",_loc1_.allianceId));
         dispatch(new RetrieveAllianceInvitationsEvent("retrieveAllianceInvitations",null));
      }
   }
}

