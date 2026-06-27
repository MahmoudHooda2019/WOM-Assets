package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.RecycleBuildingResponse;
   
   public class HandleRecycleBuildingResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleRecycleBuildingResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:RecycleBuildingResponse = messageReceivedEvent.message as RecycleBuildingResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
      }
   }
}

