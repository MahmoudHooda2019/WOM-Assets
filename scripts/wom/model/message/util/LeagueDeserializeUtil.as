package wom.model.message.util
{
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceRoleType;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.league.LeagueMemberInfo;
   
   public class LeagueDeserializeUtil
   {
      
      public function LeagueDeserializeUtil()
      {
         super();
      }
      
      public static function deserializeLeagueMember(param1:Object, param2:int) : LeagueMemberInfo
      {
         var _loc5_:Profile = null;
         var _loc3_:LeagueMemberInfo = null;
         var _loc4_:AllianceSummaryInfo = null;
         if(param1 && "userId" in param1 && "platformId" in param1 && "level" in param1 && "battlePoints" in param1 && "numberOfWinsAsAttacker" in param1 && "numberOfWinsAsDefender" in param1)
         {
            _loc5_ = new Profile(param1.userId,param1.platformId,param1.avatar);
            if("allianceId" in param1 && param1.allianceId != null && "allianceName" in param1 && param1.allianceName != null && "allianceCoa" in param1 && param1.allianceCoa != null)
            {
               _loc4_ = new AllianceSummaryInfo(param1.allianceId,param1.allianceName,AllianceRoleType.MEMBER,CoatOfArmsDeserializeUtil.createCoatOfArmsInfo(param1.allianceCoa));
            }
            _loc3_ = new LeagueMemberInfo(_loc5_,param2,param1.level,param1.battlePoints,param1.numberOfWinsAsAttacker,param1.numberOfWinsAsDefender,_loc4_);
         }
         return _loc3_;
      }
   }
}

