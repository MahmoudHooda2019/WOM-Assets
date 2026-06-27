package wom.controller.command.alliance
{
   import flash.utils.Dictionary;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceMemberInfo;
   
   public class AllianceOperationsUtil
   {
      
      public function AllianceOperationsUtil()
      {
         super();
      }
      
      public static function removeCandidate(param1:Number, param2:AllianceInfo) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc5_:* = undefined;
         var _loc4_:int = 0;
         if(param2.myAllianceSummary && param2.myAllianceCandidates)
         {
            _loc3_ = false;
            _loc5_ = param2.myAllianceCandidates.members;
            _loc4_ = 0;
            while(_loc4_ < _loc5_.length && !_loc3_)
            {
               if(_loc5_[_loc4_].profile.gameId == String(param1))
               {
                  _loc3_ = true;
                  _loc5_.splice(_loc4_,1);
               }
               _loc4_++;
            }
            return _loc3_;
         }
         return false;
      }
      
      public static function updateAllianceRequestInfo(param1:Number, param2:AllianceInfo) : void
      {
         if(param2.allianceRankingInfo)
         {
            for each(var _loc3_ in param2.allianceRankingInfo.alliances)
            {
               if(_loc3_.id == param1)
               {
                  _loc3_.requestSent = true;
               }
            }
         }
      }
      
      public static function updateAllAllianceRequestInfos(param1:Dictionary, param2:AllianceInfo) : void
      {
         if(param2.allianceRankingInfo && param1)
         {
            for each(var _loc3_ in param2.allianceRankingInfo.alliances)
            {
               _loc3_.requestSent = param1[_loc3_.id];
            }
         }
      }
   }
}

