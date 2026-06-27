package wom.model.message.util
{
   import flash.utils.Dictionary;
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceMembershipType;
   import wom.model.game.alliance.AllianceRoleType;
   import wom.model.game.alliance.AllianceSummaryInfo;
   
   public class AllianceDeserializeUtil
   {
      
      public function AllianceDeserializeUtil()
      {
         super();
      }
      
      public static function deserializeAllianceSummary(param1:Object) : AllianceSummaryInfo
      {
         var _loc2_:AllianceSummaryInfo = null;
         if(param1 && "id" in param1 && "name" in param1 && "role" in param1)
         {
            _loc2_ = new AllianceSummaryInfo(param1.id,param1.name,AllianceRoleType.determineRoleType(param1.role),CoatOfArmsDeserializeUtil.createCoatOfArmsInfo(param1.coa));
         }
         return _loc2_;
      }
      
      public static function deserializeAllianceDetails(param1:Object) : AllianceDetailInfo
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:AllianceMembershipType = null;
         var _loc5_:Profile = null;
         var _loc6_:AllianceDetailInfo = null;
         if(param1 && "allianceId" in param1 && "name" in param1 && "ranking" in param1 && "memberCount" in param1 && "allianceBP" in param1 && "type" in param1 && "description" in param1)
         {
            _loc3_ = -1;
            _loc4_ = -1;
            if("minScore" in param1 && param1.minScore != null)
            {
               _loc3_ = int(param1.minScore);
            }
            if("minLevel" in param1 && param1.minLevel != null)
            {
               _loc4_ = int(param1.minLevel);
            }
            _loc2_ = AllianceMembershipType.determineMembershiptType(param1.type);
            _loc5_ = "leader" in param1 && param1.leader != null ? new Profile(param1.leader.gid,param1.leader.pid,param1.leader.a) : null;
            _loc6_ = new AllianceDetailInfo(param1.allianceId,param1.name,param1.ranking,param1.memberCount,_loc2_,param1.allianceBP,_loc3_,_loc4_,param1.description,CoatOfArmsDeserializeUtil.createCoatOfArmsInfo(param1.coa),_loc5_);
         }
         return _loc6_;
      }
      
      public static function deserializeRequestedAlliances(param1:Object) : Dictionary
      {
         var _loc2_:Dictionary = new Dictionary();
         if("requestedAlliances" in param1 && param1.requestedAlliances != null)
         {
            for each(var _loc3_ in param1.requestedAlliances)
            {
               _loc2_[_loc3_] = true;
            }
         }
         return _loc2_;
      }
   }
}

