package wom.model.message.response.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceMemberInfo;
   
   public class SearchAllianceCandidateResponse extends AbstractIncomingMessage
   {
      
      private var _candidates:Vector.<AllianceMemberInfo>;
      
      private var _resultCode:int;
      
      public function SearchAllianceCandidateResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:AllianceMemberInfo = null;
         _resultCode = param1.resultCode;
         _candidates = new Vector.<AllianceMemberInfo>();
         if(_resultCode == 0 && "user" in param1 && param1.user != null)
         {
            _loc2_ = param1.user;
            _loc3_ = new AllianceMemberInfo(new Profile(_loc2_.candidate.gid,_loc2_.candidate.pid,_loc2_.candidate.a),_loc2_.level,_loc2_.battlePoint,false,4);
            _candidates.push(_loc3_);
         }
      }
      
      public function get candidates() : Vector.<AllianceMemberInfo>
      {
         return _candidates;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
   }
}

