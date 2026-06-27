package wom.controller.command.store
{
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.UseEventItemResponse;
   
   public class HandleUseEventItemReponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function HandleUseEventItemReponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:UseEventItemResponse = messageReceivedEvent.message as UseEventItemResponse;
      }
   }
}

