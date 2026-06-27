package wom.controller.command
{
   import wom.controller.PCommand;
   import wom.controller.event.MaintenanceEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.message.notification.MaintenanceNotification;
   
   public class HandleMaintenanceNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleMaintenanceNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:MaintenanceNotification = messageReceivedEvent.message as MaintenanceNotification;
         dispatch(new MaintenanceEvent("maintenance",_loc1_.maintenanceTime,_loc1_.maintenanceMode));
      }
   }
}

