package wom.controller.command.alliance
{
   import peak.i18n.PText;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.alliance.RequestedAllianceUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.response.alliance.JoinAllianceResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   
   public class HandleJoinAllianceResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleJoinAllianceResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:JoinAllianceResponse = event.message as JoinAllianceResponse;
         if(_loc1_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc1_.resultCode,GenericActionPopUp);
            return;
         }
         allianceInfo.requestedAllianceIds[_loc1_.allianceId] = true;
         AllianceOperationsUtil.updateAllianceRequestInfo(_loc1_.allianceId,allianceInfo);
         dispatch(new RequestedAllianceUpdateEvent("allianceIdRequested",_loc1_.allianceId));
         var _temp_3:* = §§findproperty(MobileClementineChangableActionPopUp);
         var _temp_2:* = 1;
         var _loc3_:String = "ui.windows.alliance.browse.joinresponse.header";
         var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         var _loc4_:String = "ui.windows.alliance.browse.joinresponse.desc";
         var _loc2_:MobileClementineChangableActionPopUp = new MobileClementineChangableActionPopUp(_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc4_),null);
         dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",_loc2_));
      }
   }
}

