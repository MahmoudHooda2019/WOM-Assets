package wom.model.game.alliance
{
   import flash.utils.Dictionary;
   import wom.model.game.window.WindowEnumeration;
   
   public class AllianceInfo
   {
      
      private var _myAllianceSummary:AllianceSummaryInfo;
      
      private var _myAlliance:AllianceDetailInfo;
      
      private var _allianceRankingInfo:AllianceRankingInfo;
      
      private var _membersRankingInfo:AllianceMembersRankingInfo;
      
      private var _myAllianceMembersRankingInfo:AllianceMembersRankingInfo;
      
      private var _myAllianceCandidates:AllianceMembersRankingInfo;
      
      private var _searchedAllianceCandidates:AllianceMembersRankingInfo;
      
      private var _requestedAllianceIds:Dictionary;
      
      private var _searchedAllianceRankingInfo:AllianceRankingInfo;
      
      private var _invitations:Vector.<AllianceInvitationInfo>;
      
      private var _windowLastState:WindowEnumeration;
      
      private var _allianceSig:String;
      
      private var _tournamentsRankingInfo:AllianceRankingInfo;
      
      private var _myAllianceTournamentPoints:Number;
      
      public function AllianceInfo()
      {
         super();
         _myAllianceSummary = null;
         _myAlliance = null;
         _allianceRankingInfo = null;
         _membersRankingInfo = null;
         _myAllianceMembersRankingInfo = null;
         _myAllianceCandidates = null;
         _searchedAllianceCandidates = null;
         _requestedAllianceIds = new Dictionary();
         _searchedAllianceRankingInfo = null;
         _invitations = new Vector.<AllianceInvitationInfo>();
         _windowLastState = null;
         _allianceSig = null;
         _tournamentsRankingInfo = null;
         _myAllianceTournamentPoints = 0;
      }
      
      public function get myAllianceSummary() : AllianceSummaryInfo
      {
         return _myAllianceSummary;
      }
      
      public function set myAllianceSummary(param1:AllianceSummaryInfo) : void
      {
         _myAllianceSummary = param1;
      }
      
      public function get myAlliance() : AllianceDetailInfo
      {
         return _myAlliance;
      }
      
      public function set myAlliance(param1:AllianceDetailInfo) : void
      {
         _myAlliance = param1;
      }
      
      public function get allianceRankingInfo() : AllianceRankingInfo
      {
         return _allianceRankingInfo;
      }
      
      public function set allianceRankingInfo(param1:AllianceRankingInfo) : void
      {
         _allianceRankingInfo = param1;
      }
      
      public function get membersRankingInfo() : AllianceMembersRankingInfo
      {
         return _membersRankingInfo;
      }
      
      public function set membersRankingInfo(param1:AllianceMembersRankingInfo) : void
      {
         _membersRankingInfo = param1;
      }
      
      public function get myAllianceMembersRankingInfo() : AllianceMembersRankingInfo
      {
         return _myAllianceMembersRankingInfo;
      }
      
      public function set myAllianceMembersRankingInfo(param1:AllianceMembersRankingInfo) : void
      {
         _myAllianceMembersRankingInfo = param1;
      }
      
      public function get myAllianceCandidates() : AllianceMembersRankingInfo
      {
         return _myAllianceCandidates;
      }
      
      public function set myAllianceCandidates(param1:AllianceMembersRankingInfo) : void
      {
         _myAllianceCandidates = param1;
      }
      
      public function get requestedAllianceIds() : Dictionary
      {
         return _requestedAllianceIds;
      }
      
      public function set requestedAllianceIds(param1:Dictionary) : void
      {
         _requestedAllianceIds = param1;
      }
      
      public function get searchedAllianceRankingInfo() : AllianceRankingInfo
      {
         return _searchedAllianceRankingInfo;
      }
      
      public function set searchedAllianceRankingInfo(param1:AllianceRankingInfo) : void
      {
         _searchedAllianceRankingInfo = param1;
      }
      
      public function get invitations() : Vector.<AllianceInvitationInfo>
      {
         return _invitations;
      }
      
      public function set invitations(param1:Vector.<AllianceInvitationInfo>) : void
      {
         if(param1 != null)
         {
            _invitations = param1;
         }
         else
         {
            _invitations.length = 0;
         }
      }
      
      public function get searchedAllianceCandidates() : AllianceMembersRankingInfo
      {
         return _searchedAllianceCandidates;
      }
      
      public function set searchedAllianceCandidates(param1:AllianceMembersRankingInfo) : void
      {
         _searchedAllianceCandidates = param1;
      }
      
      public function get windowLastState() : WindowEnumeration
      {
         return _windowLastState;
      }
      
      public function set windowLastState(param1:WindowEnumeration) : void
      {
         _windowLastState = param1;
      }
      
      public function get allianceSig() : String
      {
         return _allianceSig;
      }
      
      public function set allianceSig(param1:String) : void
      {
         _allianceSig = param1;
      }
      
      public function get tournamentsRankingInfo() : AllianceRankingInfo
      {
         return _tournamentsRankingInfo;
      }
      
      public function set tournamentsRankingInfo(param1:AllianceRankingInfo) : void
      {
         _tournamentsRankingInfo = param1;
      }
      
      public function get myAllianceTournamentPoints() : Number
      {
         return _myAllianceTournamentPoints;
      }
      
      public function set myAllianceTournamentPoints(param1:Number) : void
      {
         _myAllianceTournamentPoints = param1;
      }
   }
}

