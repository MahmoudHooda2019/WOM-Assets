package wom.controller.command.store
{
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.BuyItemResponse;
   
   public class HandleBuyItemResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function HandleBuyItemResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:BuyItemResponse = messageReceivedEvent.message as BuyItemResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
      }
   }
}

