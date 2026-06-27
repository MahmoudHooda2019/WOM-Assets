package wom.model.message.response.league
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.league.LeagueMemberInfo;
   import wom.model.message.util.LeagueDeserializeUtil;
   
   public class GetLeagueMembersResponse extends AbstractIncomingMessage
   {
      
      private var _members:Vector.<LeagueMemberInfo>;
      
      public function GetLeagueMembersResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:LeagueMemberInfo = null;
         var _loc3_:int = 0;
         _members = new Vector.<LeagueMemberInfo>();
         if("members" in param1 && param1.members != null)
         {
            _loc3_ = 1;
            for each(var _loc4_ in param1.members)
            {
               _loc2_ = LeagueDeserializeUtil.deserializeLeagueMember(_loc4_,_loc3_);
               if(_loc2_ != null)
               {
                  _members.push(_loc2_);
                  _loc3_++;
               }
            }
         }
      }
      
      public function get members() : Vector.<LeagueMemberInfo>
      {
         return _members;
      }
   }
}

