package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.FortifyBuildingResponse;
   import wom.service.messaging.ErrorCodeRepository;
   
   public class HandleFortifyBuildingResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleFortifyBuildingResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:FortifyBuildingResponse = messageReceivedEvent.message as FortifyBuildingResponse;
         if(_loc1_.resultCode != 0)
         {
            if(!errorCodeRepository.dispatchError("FortifyBuildingResponse",_loc1_.resultCode))
            {
               eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
            }
         }
      }
   }
}

