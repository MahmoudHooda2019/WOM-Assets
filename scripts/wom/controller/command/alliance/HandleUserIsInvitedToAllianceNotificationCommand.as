package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.alliance.RetrieveAllianceInvitationsEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceInvitationInfo;
   import wom.model.message.notification.alliance.UserIsInvitedToAllianceNotification;
   
   public class HandleUserIsInvitedToAllianceNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleUserIsInvitedToAllianceNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:UserIsInvitedToAllianceNotification = messageReceivedEvent.message as UserIsInvitedToAllianceNotification;
         var _loc1_:Vector.<AllianceInvitationInfo> = new Vector.<AllianceInvitationInfo>();
         _loc1_.push(_loc2_.invitation);
         dispatch(new RetrieveAllianceInvitationsEvent("retrieveAllianceInvitations",_loc1_));
      }
   }
}

