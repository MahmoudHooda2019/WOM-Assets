package wom.model.message.response.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceMembershipType;
   import wom.model.game.alliance.AllianceRankingInfo;
   import wom.model.game.alliance.AllianceSortDirection;
   import wom.model.game.alliance.AllianceSortType;
   import wom.model.game.alliance.coa.CoatOfArmsInfo;
   import wom.model.message.util.CoatOfArmsDeserializeUtil;
   
   public class GetTournamentsPageResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _rankingInfo:AllianceRankingInfo;
      
      public function GetTournamentsPageResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc4_:Object = null;
         var _loc7_:* = undefined;
         var _loc3_:AllianceDetailInfo = null;
         var _loc2_:CoatOfArmsInfo = null;
         var _loc6_:AllianceMembershipType = null;
         var _loc5_:Profile = null;
         if(_resultCode == 0 && param1.alliancesPage != null)
         {
            _loc4_ = param1.alliancesPage;
            _loc7_ = new Vector.<AllianceDetailInfo>();
            for each(var _loc8_ in _loc4_.allianceInfos)
            {
               _loc2_ = CoatOfArmsDeserializeUtil.createCoatOfArmsInfo(_loc8_.coa);
               _loc6_ = AllianceMembershipType.determineMembershiptType(_loc8_.membershipType);
               _loc5_ = "leader" in _loc8_ && _loc8_.leader != null ? new Profile(_loc8_.leader.gid,_loc8_.leader.pid,_loc8_.leader.a) : null;
               _loc3_ = new AllianceDetailInfo(_loc8_.allianceId,_loc8_.name,_loc8_.rank,_loc8_.memberCount,_loc6_,_loc8_.tournamentPoints,-1,-1,_loc8_.description,_loc2_,_loc5_);
               _loc7_.push(_loc3_);
            }
            _rankingInfo = new AllianceRankingInfo(AllianceSortType.RANK,AllianceSortDirection.DESC,_loc4_.pageOrder,_loc4_.totalPageCount,_loc7_,_loc4_.lastPage);
         }
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get rankingInfo() : AllianceRankingInfo
      {
         return _rankingInfo;
      }
   }
}

