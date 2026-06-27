package wom.controller.command.combat
{
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.message.request.StartSpyingRequest;
   
   public class StartSpyingCommand extends StartAttackCommand
   {
      
      public function StartSpyingCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(checkAttackConstraints())
         {
            return;
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new StartSpyingRequest(event.profile)));
      }
   }
}

