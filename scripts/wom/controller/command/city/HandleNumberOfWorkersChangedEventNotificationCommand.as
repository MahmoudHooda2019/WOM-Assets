package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.notification.NumberOfWorkersChangedEventNotification;
   
   public class HandleNumberOfWorkersChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleNumberOfWorkersChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:NumberOfWorkersChangedEventNotification = messageReceivedEvent.message as NumberOfWorkersChangedEventNotification;
         city.numberOfWorkers = _loc1_.numberOfWorkers;
         coreManager.setWorkerCount(city.numberOfWorkers);
         dispatch(new ModelUpdateEvent("workerCountUpdated"));
      }
   }
}

