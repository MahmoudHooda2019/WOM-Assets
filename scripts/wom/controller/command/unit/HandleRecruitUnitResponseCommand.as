package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.RecruitUnitResponse;
   
   public class HandleRecruitUnitResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleRecruitUnitResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:RecruitUnitResponse = messageReceivedEvent.message as RecruitUnitResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
      }
   }
}

