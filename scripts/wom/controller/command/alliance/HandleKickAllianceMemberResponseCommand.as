package wom.controller.command.alliance
{
   import peak.i18n.PText;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.message.request.alliance.GetAllianceMemberConstributionsRequest;
   import wom.model.message.response.alliance.KickAllianceMemberResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.ClementineChangableActionPopUp;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleKickAllianceMemberResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleKickAllianceMemberResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:KickAllianceMemberResponse = messageReceivedEvent.message as KickAllianceMemberResponse;
         if(_loc1_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc1_.resultCode,GenericActionPopUp);
            return;
         }
         var _temp_3:* = §§findproperty(ClementineChangableActionPopUp);
         var _temp_2:* = 1;
         var _loc3_:String = "ui.windows.alliance.myalliance.kickout.response.header";
         var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         var _loc4_:String = "ui.windows.alliance.myalliance.kickout.response.desc";
         var _loc2_:ClementineChangableActionPopUp = new ClementineChangableActionPopUp(_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc4_),null);
         dispatch(new PopUpWindowEvent("showSecondaryPopUpWindow",_loc2_));
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAllianceMemberConstributionsRequest()));
      }
   }
}

