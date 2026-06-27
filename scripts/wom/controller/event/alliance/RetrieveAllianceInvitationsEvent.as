package wom.controller.event.alliance
{
   import flash.events.Event;
   import wom.model.game.alliance.AllianceInvitationInfo;
   
   public class RetrieveAllianceInvitationsEvent extends Event
   {
      
      public static const RETRIEVE:String = "retrieveAllianceInvitations";
      
      private var _invitations:Vector.<AllianceInvitationInfo>;
      
      public function RetrieveAllianceInvitationsEvent(param1:String, param2:Vector.<AllianceInvitationInfo>)
      {
         super(param1);
         _invitations = param2;
      }
      
      override public function clone() : Event
      {
         return new RetrieveAllianceInvitationsEvent(type,_invitations);
      }
      
      public function get invitations() : Vector.<AllianceInvitationInfo>
      {
         return _invitations;
      }
   }
}

