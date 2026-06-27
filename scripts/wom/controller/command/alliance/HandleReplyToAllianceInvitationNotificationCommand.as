package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceMemberInfo;
   import wom.model.message.notification.alliance.ReplyToAllianceInvitationNotification;
   
   public class HandleReplyToAllianceInvitationNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleReplyToAllianceInvitationNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:ReplyToAllianceInvitationNotification = messageReceivedEvent.message as ReplyToAllianceInvitationNotification;
         if(allianceInfo.myAllianceCandidates != null)
         {
            _loc3_ = allianceInfo.myAllianceCandidates.members;
            if(_loc3_ != null && _loc3_.length > 0)
            {
               for each(var _loc2_ in _loc3_)
               {
                  if(_loc2_.profile.gameId == _loc1_.userId)
                  {
                     if(_loc1_.accepted)
                     {
                        _loc2_.type = 7;
                     }
                     else
                     {
                        _loc2_.type = 6;
                     }
                     dispatch(new ModelUpdateEvent("myAllianceCandidatesUpdated"));
                     break;
                  }
               }
            }
         }
      }
   }
}

