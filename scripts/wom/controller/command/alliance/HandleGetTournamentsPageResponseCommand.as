package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.response.alliance.GetTournamentsPageResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleGetTournamentsPageResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleGetTournamentsPageResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GetTournamentsPageResponse = event.message as GetTournamentsPageResponse;
         if(_loc1_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc1_.resultCode,GenericActionPopUp);
            return;
         }
         allianceInfo.tournamentsRankingInfo = _loc1_.rankingInfo;
         dispatch(new ModelUpdateEvent("tournamentsInfoUpdated"));
      }
   }
}

