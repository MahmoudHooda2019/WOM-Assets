package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.request.alliance.GetAllianceMemberConstributionsRequest;
   import wom.model.message.response.alliance.ReplyToJoinAllianceRequestResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleReplyToJoinAllianceRequestResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleReplyToJoinAllianceRequestResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ReplyToJoinAllianceRequestResponse = messageReceivedEvent.message as ReplyToJoinAllianceRequestResponse;
         removeCandidate(_loc1_);
         if(_loc1_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc1_.resultCode,GenericActionPopUp);
            return;
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAllianceMemberConstributionsRequest()));
      }
      
      protected function removeCandidate(param1:ReplyToJoinAllianceRequestResponse) : void
      {
         if(AllianceOperationsUtil.removeCandidate(param1.requestingUserId,allianceInfo))
         {
            dispatch(new ModelUpdateEvent("myAllianceCandidatesUpdated"));
         }
      }
   }
}

