package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.notification.BuildingHelpedNotification;
   
   public class HandleBuildingHelpedNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleBuildingHelpedNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:BuildingHelpedNotification = messageReceivedEvent.message as BuildingHelpedNotification;
         coreManager.raiseRP(_loc1_.instanceId);
      }
   }
}

