package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.response.alliance.CancelAllianceInvitationResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleCancelAllianceInvitationResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleCancelAllianceInvitationResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:CancelAllianceInvitationResponse = messageReceivedEvent.message as CancelAllianceInvitationResponse;
         if(_loc1_.resultCode == 0)
         {
            if(AllianceOperationsUtil.removeCandidate(_loc1_.userId,allianceInfo))
            {
               dispatch(new ModelUpdateEvent("myAllianceCandidatesUpdated"));
            }
         }
         else
         {
            errorCodeRepository.dispatchError("Alliance",_loc1_.resultCode,GenericActionPopUp);
         }
      }
   }
}

