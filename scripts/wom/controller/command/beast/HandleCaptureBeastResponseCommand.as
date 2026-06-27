package wom.controller.command.beast
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.response.CaptureBeastResponse;
   
   public class HandleCaptureBeastResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function HandleCaptureBeastResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:CaptureBeastResponse = messageReceivedEvent.message as CaptureBeastResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
      }
   }
}

