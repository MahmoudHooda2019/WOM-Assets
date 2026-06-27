package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.Profile;
   import wom.model.game.rank.MobileRankingRow;
   import wom.model.game.rank.RankedEntityType;
   import wom.model.game.rank.RankingInfo;
   import wom.model.game.rank.RankingRow;
   import wom.model.game.rank.RankingSortCriteria;
   import wom.model.message.util.AllianceDeserializeUtil;
   
   public class GetRankingPageResponse extends AbstractIncomingMessage
   {
      
      private var _success:Boolean;
      
      private var _rankingInfo:RankingInfo;
      
      public function GetRankingPageResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc2_:* = undefined;
         _success = param1.resultCode == 0;
         if(_success)
         {
            _loc3_ = param1.rankingPage;
            _loc4_ = int(_loc3_.firstRankInPage);
            _loc2_ = new Vector.<RankingRow>();
            for each(var _loc5_ in _loc3_.rankingInfos)
            {
               _loc2_.push(new MobileRankingRow(_loc4_++,new Profile(_loc5_.id,_loc5_.platformId,_loc5_.avatar),_loc5_.level,_loc5_.xp,AllianceDeserializeUtil.deserializeAllianceSummary(_loc5_.alliance)));
            }
            _rankingInfo = new RankingInfo(_loc3_.pageOrder,_loc3_.totalPageCount,_loc3_.rank,_loc4_,_loc3_.isLastPage,_loc2_,RankedEntityType.determineRankedEntityType(_loc3_.rankedEntityType),_loc3_.rankedEntityName,RankingSortCriteria.determineRankingSortCriteria(param1.sortCriterion));
         }
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
      
      public function get rankingInfo() : RankingInfo
      {
         return _rankingInfo;
      }
   }
}

