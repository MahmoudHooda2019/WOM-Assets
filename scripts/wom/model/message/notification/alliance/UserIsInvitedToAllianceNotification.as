package wom.model.message.notification.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.alliance.AllianceInvitationInfo;
   import wom.model.message.util.CoatOfArmsDeserializeUtil;
   
   public class UserIsInvitedToAllianceNotification extends AbstractIncomingMessage
   {
      
      private var _invitation:AllianceInvitationInfo;
      
      public function UserIsInvitedToAllianceNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _invitation = new AllianceInvitationInfo(param1.allianceId,param1.allianceName,CoatOfArmsDeserializeUtil.createCoatOfArmsInfo(param1.coa));
      }
      
      public function get invitation() : AllianceInvitationInfo
      {
         return _invitation;
      }
   }
}

