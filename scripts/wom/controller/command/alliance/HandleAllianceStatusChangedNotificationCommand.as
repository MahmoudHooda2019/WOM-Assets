package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.AllianceWindowTabChangeEvent;
   import wom.controller.event.alliance.BrowseAllianceEvent;
   import wom.controller.event.chat.ChatClientEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceSortDirection;
   import wom.model.game.alliance.AllianceSortType;
   import wom.model.game.attack.GameModeType;
   import wom.model.message.notification.alliance.AllianceStatusChangedNotification;
   import wom.model.message.request.alliance.GetAlliancesPageRequest;
   import wom.model.resource.WomAssetRepository;
   
   public class HandleAllianceStatusChangedNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleAllianceStatusChangedNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:AllianceStatusChangedNotification = messageReceivedEvent.message as AllianceStatusChangedNotification;
         var _loc2_:Boolean = allianceInfo.myAllianceSummary != null && _loc1_.allianceSummary == null;
         allianceInfo.myAllianceSummary = _loc1_.allianceSummary;
         allianceInfo.allianceSig = _loc1_.allianceSig;
         if(userInfo.gameMode == GameModeType.NORMAL)
         {
            cityInfo.ownerAlliance = allianceInfo.myAllianceSummary;
         }
         dispatch(new ModelUpdateEvent("allianceSummaryUpdated"));
         dispatch(new ChatClientEvent("chatConnectionEstablished"));
         if(_loc2_)
         {
            allianceInfo.myAlliance = null;
            allianceInfo.myAllianceCandidates = null;
            dispatch(new ModelUpdateEvent("myAllianceCandidatesUpdated"));
            allianceInfo.myAllianceMembersRankingInfo = null;
            dispatch(new ModelUpdateEvent("myAllianceMembersRankingInfoUpdated"));
            allianceInfo.requestedAllianceIds = _loc1_.requestedAllianceIds;
            dispatch(new ModelUpdateEvent("allianceInfoUpdated"));
            dispatch(new AllianceWindowTabChangeEvent("changeAllianceTab",0));
            dispatch(new BrowseAllianceEvent("backToAlliances",null));
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAlliancesPageRequest(AllianceSortType.RANK,AllianceSortDirection.ASC,1,false,false,-1,50)));
         }
         coreManager.updateAllianceFlags();
      }
   }
}

