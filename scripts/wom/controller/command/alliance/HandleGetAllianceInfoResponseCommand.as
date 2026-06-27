package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.Profile;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.alliance.coa.CoatOfArmsInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.message.response.alliance.GetAllianceInfoResponse;
   import wom.model.resource.WomAssetRepository;
   
   public class HandleGetAllianceInfoResponseCommand extends PCommand
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
      
      public function HandleGetAllianceInfoResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GetAllianceInfoResponse = messageReceivedEvent.message as GetAllianceInfoResponse;
         allianceInfo.myAlliance = _loc1_.allianceDetails;
         updateMyAllianceSummaryCOA(_loc1_.allianceDetails.coatOfArmsInfo);
         getLeaderName(_loc1_);
         dispatch(new ModelUpdateEvent("allianceInfoUpdated"));
         coreManager.updateAllianceFlags();
      }
      
      private function updateMyAllianceSummaryCOA(param1:CoatOfArmsInfo) : void
      {
         var _loc2_:AllianceSummaryInfo = allianceInfo.myAllianceSummary;
         if(_loc2_)
         {
            allianceInfo.myAllianceSummary = new AllianceSummaryInfo(_loc2_.id,_loc2_.name,_loc2_.role,param1);
            if(userInfo.gameMode == GameModeType.NORMAL)
            {
               cityInfo.ownerAlliance = allianceInfo.myAllianceSummary;
            }
         }
      }
      
      private function getLeaderName(param1:GetAllianceInfoResponse) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Profile = param1.allianceDetails.leader;
         if(_loc2_ != null)
         {
            _loc3_ = new Vector.<ProfileIdPair>();
            _loc3_.push(new ProfileIdPair(_loc2_.platformId,_loc2_.avatar));
            dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc3_));
         }
      }
   }
}

