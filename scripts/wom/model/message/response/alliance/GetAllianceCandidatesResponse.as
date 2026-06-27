package wom.model.message.response.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceMemberInfo;
   import wom.view.screen.windows.alliance.AllianceMemberView;
   
   public class GetAllianceCandidatesResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _candidates:Vector.<AllianceMemberInfo>;
      
      public function GetAllianceCandidatesResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc3_:AllianceMemberInfo = null;
         _resultCode = param1.resultCode;
         if(_resultCode == 0)
         {
            _candidates = new Vector.<AllianceMemberInfo>();
            for each(var _loc2_ in param1.candidates)
            {
               _loc3_ = new AllianceMemberInfo(new Profile(_loc2_.candidate.gid,_loc2_.candidate.pid,_loc2_.candidate.a),_loc2_.level,_loc2_.battlePoint,false,AllianceMemberView.determineRowType(_loc2_.type));
               _candidates.push(_loc3_);
            }
         }
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get candidates() : Vector.<AllianceMemberInfo>
      {
         return _candidates;
      }
   }
}

