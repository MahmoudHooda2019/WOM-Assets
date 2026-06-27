package wom.controller.command.beast
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.HealBeastResponse;
   import wom.service.messaging.ErrorCodeRepository;
   
   public class HandleHealBeastResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleHealBeastResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:HealBeastResponse = messageReceivedEvent.message as HealBeastResponse;
         if(_loc1_.resultCode != 0)
         {
            if(!errorCodeRepository.dispatchError("HealBeastResponse",_loc1_.resultCode))
            {
               eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
            }
         }
      }
   }
}

