package wom.controller.command.alliance
{
   import peak.i18n.PText;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.message.request.alliance.GetAllianceCandidatesRequest;
   import wom.model.message.response.alliance.InviteToAllianceResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   
   public class HandleInviteToAllianceResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleInviteToAllianceResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:InviteToAllianceResponse = messageReceivedEvent.message as InviteToAllianceResponse;
         if(_loc1_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc1_.resultCode,GenericActionPopUp);
            return;
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAllianceCandidatesRequest()));
         var _temp_3:* = §§findproperty(MobileClementineChangableActionPopUp);
         var _temp_2:* = 1;
         var _loc3_:String = "ui.windows.alliance.candidates.inviteresponse.header";
         var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         var _loc4_:String = "ui.windows.alliance.candidates.inviteresponse.desc";
         var _loc2_:MobileClementineChangableActionPopUp = new MobileClementineChangableActionPopUp(_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc4_));
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",_loc2_));
      }
   }
}

