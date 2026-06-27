package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.TrainUnitResponse;
   
   public class HandleTrainUnitResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleTrainUnitResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:TrainUnitResponse = messageReceivedEvent.message as TrainUnitResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
      }
   }
}

