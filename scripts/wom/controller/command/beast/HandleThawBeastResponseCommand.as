package wom.controller.command.beast
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.ThawBeastResponse;
   import wom.service.messaging.ErrorCodeRepository;
   
   public class HandleThawBeastResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleThawBeastResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ThawBeastResponse = messageReceivedEvent.message as ThawBeastResponse;
         if(_loc1_.resultCode != 0)
         {
            if(!errorCodeRepository.dispatchError("ThawBeastResponse",_loc1_.resultCode))
            {
               eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
            }
         }
      }
   }
}

