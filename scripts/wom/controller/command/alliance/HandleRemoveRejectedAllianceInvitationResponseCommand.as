package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.response.alliance.RemoveRejectedAllianceInvitationResponse;
   
   public class HandleRemoveRejectedAllianceInvitationResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleRemoveRejectedAllianceInvitationResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:RemoveRejectedAllianceInvitationResponse = messageReceivedEvent.message as RemoveRejectedAllianceInvitationResponse;
         if(_loc1_.resultCode == 0)
         {
            if(AllianceOperationsUtil.removeCandidate(_loc1_.userId,allianceInfo))
            {
               dispatch(new ModelUpdateEvent("myAllianceCandidatesUpdated"));
            }
         }
      }
   }
}

