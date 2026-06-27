package wom.controller.command.user
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.message.notification.GoldGiftReceivedEventNotification;
   import wom.view.screen.popups.help.GiftGoldThanksPopUp;
   
   public class HandleGoldGiftReceivedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleGoldGiftReceivedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GoldGiftReceivedEventNotification = messageReceivedEvent.message as GoldGiftReceivedEventNotification;
         if(_loc1_.goldGift != null)
         {
            dispatch(new PopUpWindowEvent("showPopUpWindow",new GiftGoldThanksPopUp(_loc1_.goldGift)));
         }
      }
   }
}

