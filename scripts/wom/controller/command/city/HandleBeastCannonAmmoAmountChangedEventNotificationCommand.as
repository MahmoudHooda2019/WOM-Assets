package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.notification.BeastCannonAmmoAmountChanedEventNotification;
   
   public class HandleBeastCannonAmmoAmountChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      public function HandleBeastCannonAmmoAmountChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:BeastCannonAmmoAmountChanedEventNotification = messageReceivedEvent.message as BeastCannonAmmoAmountChanedEventNotification;
         if(cityInfo.beastCannonInfo != null)
         {
            cityInfo.beastCannonInfo.ammoAmount = _loc1_.ammoAmount;
            cityInfo.beastCannonInfo.remainingTimeToRecharge = _loc1_.remainingDurationToFullAmmo;
         }
      }
   }
}

