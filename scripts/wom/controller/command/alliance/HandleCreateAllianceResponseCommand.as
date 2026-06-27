package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.AllianceWindowTabChangeEvent;
   import wom.controller.event.alliance.BrowseAllianceEvent;
   import wom.controller.event.alliance.MyAllianceEvent;
   import wom.controller.event.chat.ChatClientEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceSortDirection;
   import wom.model.game.alliance.AllianceSortType;
   import wom.model.message.request.alliance.GetAlliancesPageRequest;
   import wom.model.message.response.alliance.CreateAllianceResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleCreateAllianceResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleCreateAllianceResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:CreateAllianceResponse = messageReceivedEvent.message as CreateAllianceResponse;
         if(_loc1_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc1_.resultCode,GenericActionPopUp);
            return;
         }
         allianceInfo.allianceSig = _loc1_.allianceSig;
         dispatch(new ChatClientEvent("chatConnectionEstablished"));
         allianceInfo.myAllianceSummary = _loc1_.allianceSummary;
         dispatch(new ModelUpdateEvent("allianceSummaryUpdated"));
         dispatch(new AllianceWindowTabChangeEvent("changeAllianceTab",2));
         dispatch(new MyAllianceEvent("navigateMyAllianceGeneralInfo"));
         dispatch(new BrowseAllianceEvent("backToAlliances",null));
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAlliancesPageRequest(AllianceSortType.RANK,AllianceSortDirection.ASC,1,false,false,-1,50)));
         coreManager.updateAllianceFlags();
      }
   }
}

