package wom.controller.command.model
{
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.WorkerUpdateEvent;
   import wom.model.component.attribute.data.WorkerStatus;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.WomGameRootHolder;
   
   public class WorkerUpdateCommand extends PCommand
   {
      
      [Inject]
      public var event:WorkerUpdateEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      public function WorkerUpdateCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in gameRootHolder.gameRoot.workers)
         {
            if((_loc2_.componentManager["WorkerStatus"] as WorkerStatus).busy)
            {
               _loc1_++;
            }
         }
         city.numberOfWorkingWorkers = _loc1_;
         dispatch(new ModelUpdateEvent("workerCountUpdated"));
      }
   }
}

