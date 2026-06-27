package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.notification.BuildingDamagedEventNotification;
   
   public class HandleBuildingDamagedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function HandleBuildingDamagedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BuildingDamagedEventNotification = messageReceivedEvent.message as BuildingDamagedEventNotification;
         _loc2_ = 0;
         while(_loc2_ < city.buildings.length)
         {
            if(city.buildings[_loc2_].instanceId == _loc1_.instanceId)
            {
               city.buildings[_loc2_].healthPoint = _loc1_.healthPoints;
               coreManager.notifyHealthPointChangeOfABuilding(_loc1_.instanceId);
               break;
            }
            _loc2_++;
         }
      }
   }
}

