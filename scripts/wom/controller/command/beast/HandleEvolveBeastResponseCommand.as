package wom.controller.command.beast
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.EvolveBeastResponse;
   import wom.service.messaging.ErrorCodeRepository;
   
   public class HandleEvolveBeastResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleEvolveBeastResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:EvolveBeastResponse = messageReceivedEvent.message as EvolveBeastResponse;
         if(_loc1_.resultCode != 0)
         {
            if(!errorCodeRepository.dispatchError("EvolveBeastResponse",_loc1_.resultCode))
            {
               eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
            }
         }
      }
   }
}

