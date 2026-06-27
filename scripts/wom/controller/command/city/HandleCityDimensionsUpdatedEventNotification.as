package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.notification.CityDimensionsUpdatedEventNotification;
   
   public class HandleCityDimensionsUpdatedEventNotification extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function HandleCityDimensionsUpdatedEventNotification()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:CityDimensionsUpdatedEventNotification = messageReceivedEvent.message as CityDimensionsUpdatedEventNotification;
         city.dimensions = _loc1_.dimensions;
         coreManager.updateGrids(city.dimensions);
         coreManager.destroyAllDoodads();
         coreManager.addTerrain(domainInfo.getTerrainLayout()["doodads"]);
         dispatch(new ModelUpdateEvent("cityDimensionsUpdated"));
      }
   }
}

