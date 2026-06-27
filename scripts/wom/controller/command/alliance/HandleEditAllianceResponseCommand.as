package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.MyAllianceEvent;
   import wom.model.message.request.alliance.GetAllianceInfoRequest;
   import wom.model.message.response.alliance.EditAllianceResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleEditAllianceResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleEditAllianceResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:EditAllianceResponse = messageReceivedEvent.message as EditAllianceResponse;
         if(_loc1_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc1_.resultCode,GenericActionPopUp);
            return;
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAllianceInfoRequest()));
         dispatch(new MyAllianceEvent("navigateMyAllianceGeneralInfo"));
      }
   }
}

