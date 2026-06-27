package wom.model.game.friend.request
{
   import wom.model.game.Thorzain;
   import wom.model.game.alliance.AllianceInvitationInfo;
   
   public class AllianceInvitationRequestInfo extends RequestInfo
   {
      
      private var _invitation:AllianceInvitationInfo;
      
      public function AllianceInvitationRequestInfo(param1:AllianceInvitationInfo)
      {
         super(NaN,NaN,10,Thorzain.PROFILE,"sent");
         _invitation = param1;
      }
      
      public function get invitation() : AllianceInvitationInfo
      {
         return _invitation;
      }
   }
}

