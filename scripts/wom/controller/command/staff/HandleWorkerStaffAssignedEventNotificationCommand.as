package wom.controller.command.staff
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.notification.WorkerStaffAssignedEventNotification;
   
   public class HandleWorkerStaffAssignedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleWorkerStaffAssignedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:WorkerStaffAssignedEventNotification = messageReceivedEvent.message as WorkerStaffAssignedEventNotification;
         city.workerStaffStatus = _loc1_.staffs;
         dispatch(new ModelUpdateEvent("workerStaffUpdated"));
      }
   }
}

