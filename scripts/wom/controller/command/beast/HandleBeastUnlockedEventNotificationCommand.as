package wom.controller.command.beast
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.message.notification.BeastUnlockedEventNotification;
   import wom.view.screen.popups.MobileBeastUnleashedPopUp;
   
   public class HandleBeastUnlockedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function HandleBeastUnlockedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:BeastUnlockedEventNotification = messageReceivedEvent.message as BeastUnlockedEventNotification;
         var _loc2_:BeastTypeDIO = domainInfo.getBeast(_loc1_.beastId);
         if(_loc2_ != null)
         {
            _loc2_.unlocked = true;
            dispatch(new ModelUpdateEvent("beastUpdated"));
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBeastUnleashedPopUp(_loc2_)));
         }
      }
   }
}

