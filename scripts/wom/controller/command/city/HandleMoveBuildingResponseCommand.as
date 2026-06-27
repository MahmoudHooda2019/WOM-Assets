package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.response.MoveBuildingResponse;
   
   public class HandleMoveBuildingResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleMoveBuildingResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:MoveBuildingResponse = messageReceivedEvent.message as MoveBuildingResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
      }
   }
}

