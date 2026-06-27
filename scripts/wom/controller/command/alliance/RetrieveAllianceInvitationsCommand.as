package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.alliance.RetrieveAllianceInvitationsEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceInvitationInfo;
   import wom.model.game.friend.InboxInfo;
   
   public class RetrieveAllianceInvitationsCommand extends PCommand
   {
      
      [Inject]
      public var event:RetrieveAllianceInvitationsEvent;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var inboxInfo:InboxInfo;
      
      public function RetrieveAllianceInvitationsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:Vector.<AllianceInvitationInfo> = event.invitations;
         if(_loc1_ != null)
         {
            for each(var _loc2_ in _loc1_)
            {
               if(!alreadyAddedInvitation(_loc2_))
               {
                  allianceInfo.invitations.push(_loc2_);
               }
            }
         }
         inboxInfo.addFromClient["alliance"] = allianceInfo.invitations.length;
         dispatch(new ModelUpdateEvent("inboxCountUpdated"));
      }
      
      private function alreadyAddedInvitation(param1:AllianceInvitationInfo) : Boolean
      {
         for each(var _loc2_ in allianceInfo.invitations)
         {
            if(_loc2_.allianceId == param1.allianceId)
            {
               return true;
            }
         }
         return false;
      }
   }
}

