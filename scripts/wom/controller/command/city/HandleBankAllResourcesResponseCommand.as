package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.response.BankAllResourcesResponse;
   
   public class HandleBankAllResourcesResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function HandleBankAllResourcesResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:BankAllResourcesResponse = messageReceivedEvent.message as BankAllResourcesResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
      }
   }
}

