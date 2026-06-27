package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.alliance.RequestedAllianceUpdateEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.response.alliance.GetRequestedAlliancesResponse;
   import wom.model.resource.WomAssetRepository;
   
   public class HandleGetRequestedAlliancesResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleGetRequestedAlliancesResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GetRequestedAlliancesResponse = messageReceivedEvent.message as GetRequestedAlliancesResponse;
         allianceInfo.requestedAllianceIds = _loc1_.requestedAllianceIds;
         AllianceOperationsUtil.updateAllAllianceRequestInfos(_loc1_.requestedAllianceIds,allianceInfo);
         dispatch(new RequestedAllianceUpdateEvent("allianceIdRequested"));
      }
   }
}

