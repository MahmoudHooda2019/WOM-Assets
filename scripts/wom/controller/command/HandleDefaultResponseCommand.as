package wom.controller.command
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.DefaultResponse;
   
   public class HandleDefaultResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleDefaultResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:DefaultResponse = messageReceivedEvent.message as DefaultResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
      }
   }
}

