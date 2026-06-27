package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.message.response.BankResourcesResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.apologies.ActionNotPossiblePopUp;
   
   public class HandleBankResourcesResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleBankResourcesResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:BankResourcesResponse = messageReceivedEvent.message as BankResourcesResponse;
         if(_loc1_.resultCode != 0)
         {
            if(_loc1_.resultCode == 22)
            {
               dispatch(new PopUpWindowEvent("showSecondaryPopUpWindow",new ActionNotPossiblePopUp(79)));
            }
            else if(!errorCodeRepository.dispatchError("BankResourcesResponse",_loc1_.resultCode))
            {
               eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
            }
         }
      }
   }
}

