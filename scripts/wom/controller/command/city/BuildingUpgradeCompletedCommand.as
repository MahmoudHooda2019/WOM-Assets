package wom.controller.command.city
{
   import flash.external.ExternalInterface;
   import wom.controller.PCommand;
   import wom.controller.event.model.BuildingUpgradeCompletedEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.building.BuildingInfo;
   
   public class BuildingUpgradeCompletedCommand extends PCommand
   {
      
      [Inject]
      public var event:BuildingUpgradeCompletedEvent;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function BuildingUpgradeCompletedCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:BuildingInfo = event.buildingInfo;
         if(_loc1_ != null && _loc1_.buildingTypeId == 10 && ExternalInterface.available)
         {
            ExternalInterface.call("gameClient.startnow.check");
            if(documentConfiguration.promo)
            {
               documentConfiguration.promo = false;
               ExternalInterface.call("WOM.gold.showPromo");
            }
         }
      }
   }
}

