package wom.controller.command.beast
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.TrainBeastResponse;
   import wom.service.messaging.ErrorCodeRepository;
   
   public class HandleTrainBeastResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleTrainBeastResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:TrainBeastResponse = messageReceivedEvent.message as TrainBeastResponse;
         if(_loc1_.resultCode != 0)
         {
            if(!errorCodeRepository.dispatchError("TrainBeastResponse",_loc1_.resultCode))
            {
               eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
            }
         }
      }
   }
}

