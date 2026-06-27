package wom.controller.command.staff
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.HireStaffResponse;
   
   public class HandleHireStaffResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleHireStaffResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:HireStaffResponse = messageReceivedEvent.message as HireStaffResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
      }
   }
}

