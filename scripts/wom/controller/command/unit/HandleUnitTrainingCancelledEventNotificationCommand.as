package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.GenerateUnitTypeInfosEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.message.notification.UnitTrainingCancelledEventNotification;
   
   public class HandleUnitTrainingCancelledEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleUnitTrainingCancelledEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:int = 0;
         var _loc1_:UnitTrainJob = null;
         var _loc2_:UnitTrainingCancelledEventNotification = messageReceivedEvent.message as UnitTrainingCancelledEventNotification;
         _loc3_ = 0;
         while(_loc3_ < city.unitTrainJobs.length)
         {
            _loc1_ = city.unitTrainJobs[_loc3_];
            if(_loc1_.unitTypeId == _loc2_.unitTypeId)
            {
               city.unitTrainJobs.splice(_loc3_,1);
               dispatch(new ModelUpdateEvent("trainUnitJobsUpdated"));
               dispatch(new GenerateUnitTypeInfosEvent("generateUnitTypeInfosEvent"));
               break;
            }
            _loc3_++;
         }
         coreManager.manageTrainingChamberIndicators();
         coreManager.manageTrainingChamberAnimations();
      }
   }
}

