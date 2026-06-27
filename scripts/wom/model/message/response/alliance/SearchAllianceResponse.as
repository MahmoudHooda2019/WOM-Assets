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
   
   public class SearchAllianceResponse extends AbstractIncomingMessage
   {
      
      private var _rankingInfo:AllianceRankingInfo;
      
      public function SearchAllianceResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc3_:AllianceDetailInfo = null;
         var _loc2_:CoatOfArmsInfo = null;
         var _loc7_:AllianceMembershipType = null;
         var _loc8_:Vector.<AllianceDetailInfo> = new Vector.<AllianceDetailInfo>();
         var _loc4_:int = -1;
         var _loc5_:int = -1;
         var _loc6_:Profile = null;
         for each(var _loc9_ in param1.allianceInfos)
         {
            _loc2_ = CoatOfArmsDeserializeUtil.createCoatOfArmsInfo(_loc9_.coa);
            _loc7_ = AllianceMembershipType.determineMembershiptType(_loc9_.membershipType);
            _loc4_ = int(_loc9_.minScore == null ? -1 : _loc9_.minScore);
            _loc5_ = int(_loc9_.minLevel == null ? -1 : _loc9_.minLevel);
            _loc6_ = "leader" in _loc9_ && _loc9_.leader != null ? new Profile(_loc9_.leader.gid,_loc9_.leader.pid,_loc9_.leader.a) : null;
            _loc3_ = new AllianceDetailInfo(_loc9_.allianceId,_loc9_.name,_loc9_.rank,_loc9_.memberCount,_loc7_,_loc9_.allianceBP,_loc9_.minScore,_loc9_.minLevel,_loc9_.description,_loc2_,_loc6_);
            _loc8_.push(_loc3_);
         }
         _rankingInfo = new AllianceRankingInfo(AllianceSortType.RANK,AllianceSortDirection.ASC,1,1,_loc8_,true);
      }
      
      public function get rankingInfo() : AllianceRankingInfo
      {
         return _rankingInfo;
      }
   }
}

