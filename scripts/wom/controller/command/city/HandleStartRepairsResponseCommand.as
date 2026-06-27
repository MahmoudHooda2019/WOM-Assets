package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.StartRepairsResponse;
   
   public class HandleStartRepairsResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleStartRepairsResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:StartRepairsResponse = messageReceivedEvent.message as StartRepairsResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
      }
   }
}

