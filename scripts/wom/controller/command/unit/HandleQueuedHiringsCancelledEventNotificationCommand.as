package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.message.notification.QueuedHiringsCancelledEventNotification;
   
   public class HandleQueuedHiringsCancelledEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleQueuedHiringsCancelledEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:QueuedHiringsCancelledEventNotification = messageReceivedEvent.message as QueuedHiringsCancelledEventNotification;
         if(_loc1_.usesCentralQueue)
         {
            for each(var _loc2_ in city.hiringInfoDictionary)
            {
            }
         }
      }
   }
}

