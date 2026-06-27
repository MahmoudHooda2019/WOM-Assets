package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.SearchAllianceCandidateEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceMemberInfo;
   import wom.model.game.alliance.AllianceMembersRankingInfo;
   import wom.model.message.request.alliance.SearchAllianceCandidateRequest;
   
   public class SearchAllianceCandidateCommand extends PCommand
   {
      
      [Inject]
      public var event:SearchAllianceCandidateEvent;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function SearchAllianceCandidateCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc6_:* = undefined;
         var _loc5_:int = 0;
         var _loc2_:AllianceMemberInfo = null;
         var _loc3_:* = undefined;
         var _loc1_:String = event.guid;
         var _loc4_:Boolean = false;
         if(allianceInfo.myAllianceSummary && allianceInfo.myAllianceCandidates)
         {
            _loc6_ = allianceInfo.myAllianceCandidates.members;
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length && !_loc4_)
            {
               _loc2_ = _loc6_[_loc5_];
               if(_loc2_.profile.gameId == _loc1_)
               {
                  _loc3_ = new Vector.<AllianceMemberInfo>();
                  _loc3_.push(_loc2_);
                  allianceInfo.searchedAllianceCandidates = new AllianceMembersRankingInfo(allianceInfo.myAllianceSummary.id,allianceInfo.myAllianceSummary.name,_loc3_);
                  _loc4_ = true;
               }
               _loc5_++;
            }
         }
         if(_loc4_)
         {
            dispatch(new ModelUpdateEvent("searchedAllianceCandidatesUpdated"));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new SearchAllianceCandidateRequest(_loc1_)));
         }
      }
   }
}

