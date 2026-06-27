package wom.controller.command.beast
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.FreezeBeastResponse;
   import wom.service.messaging.ErrorCodeRepository;
   
   public class HandleFreezeBeastResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleFreezeBeastResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:FreezeBeastResponse = messageReceivedEvent.message as FreezeBeastResponse;
         if(_loc1_.resultCode != 0)
         {
            if(!errorCodeRepository.dispatchError("FreezeBeastResponse",_loc1_.resultCode))
            {
               eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
            }
         }
      }
   }
}

