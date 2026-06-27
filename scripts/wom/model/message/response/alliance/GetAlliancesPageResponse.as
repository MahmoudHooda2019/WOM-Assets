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
   
   public class GetAlliancesPageResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _rankingInfo:AllianceRankingInfo;
      
      public function GetAlliancesPageResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc5_:Object = null;
         var _loc11_:* = undefined;
         var _loc3_:AllianceDetailInfo = null;
         var _loc2_:CoatOfArmsInfo = null;
         var _loc10_:AllianceMembershipType = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Profile = null;
         var _loc9_:AllianceSortType = null;
         var _loc8_:int = 0;
         _resultCode = param1.resultCode;
         if(_resultCode == 0)
         {
            _loc5_ = param1.alliancesPage;
            _loc11_ = new Vector.<AllianceDetailInfo>();
            _loc4_ = -1;
            _loc6_ = -1;
            _loc7_ = null;
            _loc9_ = AllianceSortType.determineSortType(param1.sortType);
            _loc8_ = -1;
            for each(var _loc12_ in _loc5_.allianceInfos)
            {
               _loc2_ = CoatOfArmsDeserializeUtil.createCoatOfArmsInfo(_loc12_.coa);
               _loc10_ = AllianceMembershipType.determineMembershiptType(_loc12_.membershipType);
               _loc4_ = int(_loc12_.minScore == null ? -1 : _loc12_.minScore);
               _loc6_ = int(_loc12_.minLevel == null ? -1 : _loc12_.minLevel);
               _loc7_ = "leader" in _loc12_ && _loc12_.leader != null ? new Profile(_loc12_.leader.gid,_loc12_.leader.pid,_loc12_.leader.a) : null;
               _loc8_ = int(_loc9_ == AllianceSortType.WEEKLY_BP ? _loc12_.weeklyBP : (_loc9_ == AllianceSortType.DAILY_BP ? _loc12_.dailyBP : _loc12_.allianceBP));
               _loc3_ = new AllianceDetailInfo(_loc12_.allianceId,_loc12_.name,_loc12_.rank,_loc12_.memberCount,_loc10_,_loc8_,_loc4_,_loc6_,_loc12_.description,_loc2_,_loc7_);
               _loc11_.push(_loc3_);
            }
            _rankingInfo = new AllianceRankingInfo(_loc9_,AllianceSortDirection.determineDirection(param1.sortDirection),_loc5_.pageOrder,_loc5_.totalPageCount,_loc11_,_loc5_.lastPage);
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

