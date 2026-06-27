package wom.model.message.response.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceMemberInfo;
   import wom.model.game.alliance.AllianceMembersRankingInfo;
   
   public class GetAllianceMembersResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _membersRankingInfo:AllianceMembersRankingInfo;
      
      public function GetAllianceMembersResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:AllianceMemberInfo = null;
         _resultCode = param1.resultCode;
         if(_resultCode == 0)
         {
            _loc4_ = new Vector.<AllianceMemberInfo>();
            for each(var _loc3_ in param1.members)
            {
               _loc2_ = new AllianceMemberInfo(new Profile(_loc3_.memberGuid,_loc3_.memberPid,_loc3_.avatar),_loc3_.level,_loc3_.score,_loc3_.leader);
               _loc4_.push(_loc2_);
            }
            _membersRankingInfo = new AllianceMembersRankingInfo(param1.allianceId,param1.allianceName,_loc4_);
         }
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get membersRankingInfo() : AllianceMembersRankingInfo
      {
         return _membersRankingInfo;
      }
   }
}

