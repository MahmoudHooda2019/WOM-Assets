package wom.controller.command
{
   import flash.external.ExternalInterface;
   import wom.controller.PCommand;
   import wom.controller.event.MaintenanceEvent;
   
   public class MaintenanceCommand extends PCommand
   {
      
      [Inject]
      public var event:MaintenanceEvent;
      
      public function MaintenanceCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("WOM.maintenance.announce",event.maintenanceMode,event.maintenanceTime);
         }
      }
   }
}

