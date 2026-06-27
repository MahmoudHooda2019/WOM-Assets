package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.notification.CityBuildingMovedEventNotification;
   
   public class HandleCityBuildingMovedEventNotification extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleCityBuildingMovedEventNotification()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:CityBuildingMovedEventNotification = messageReceivedEvent.message as CityBuildingMovedEventNotification;
         _loc4_ = 0;
         while(_loc4_ < city.buildings.length)
         {
            if(city.buildings[_loc4_].instanceId == _loc1_.instanceId)
            {
               _loc3_ = city.buildings[_loc4_].position.x;
               _loc2_ = city.buildings[_loc4_].position.y;
               city.buildings[_loc4_].position.x = _loc1_.position.x;
               city.buildings[_loc4_].position.y = _loc1_.position.y;
               coreManager.moveBuilding(_loc1_.instanceId,_loc1_.position,_loc3_,_loc2_);
               break;
            }
            _loc4_++;
         }
      }
   }
}

