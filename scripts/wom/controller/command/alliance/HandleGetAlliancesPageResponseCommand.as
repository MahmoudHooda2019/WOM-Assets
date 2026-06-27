package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.response.alliance.GetAlliancesPageResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleGetAlliancesPageResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleGetAlliancesPageResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:int = 0;
         var _loc1_:AllianceDetailInfo = null;
         var _loc2_:GetAlliancesPageResponse = event.message as GetAlliancesPageResponse;
         if(_loc2_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc2_.resultCode,GenericActionPopUp);
            return;
         }
         allianceInfo.allianceRankingInfo = _loc2_.rankingInfo;
         _loc3_ = 0;
         while(_loc3_ < allianceInfo.allianceRankingInfo.alliances.length)
         {
            _loc1_ = allianceInfo.allianceRankingInfo.alliances[_loc3_];
            if(_loc1_.id in allianceInfo.requestedAllianceIds)
            {
               _loc1_.requestSent = true;
            }
            _loc3_++;
         }
         dispatch(new ModelUpdateEvent("allianceRankingInfoUpdated"));
      }
   }
}

