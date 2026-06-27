package wom.controller.command.user
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.response.UpdatePigeonPostSubscriptionsMessageResponse;
   
   public class HandleUpdatePigeonPostSubscriptionsMessageResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleUpdatePigeonPostSubscriptionsMessageResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:UpdatePigeonPostSubscriptionsMessageResponse = messageReceivedEvent.message as UpdatePigeonPostSubscriptionsMessageResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
      }
   }
}

