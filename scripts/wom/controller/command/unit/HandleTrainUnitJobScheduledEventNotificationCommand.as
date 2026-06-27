package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.GenerateUnitTypeInfosEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.notification.TrainUnitJobScheduledEventNotification;
   
   public class HandleTrainUnitJobScheduledEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleTrainUnitJobScheduledEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc5_:TrainUnitJobScheduledEventNotification = messageReceivedEvent.message as TrainUnitJobScheduledEventNotification;
         var _loc1_:UnitTypeDIO = domainInfo.getUnit(_loc5_.unitTrainJob.unitTypeId);
         var _loc3_:UnitTypeInfo = city.unitTypes[_loc5_.unitTrainJob.unitTypeId];
         var _loc4_:Number = _loc1_.trainingDurationPerLevelInSecs[_loc3_.currentLevel] * 1000 / userInfo.serverSpeed;
         var _loc6_:Boolean = false;
         for each(var _loc2_ in city.unitTrainJobs)
         {
            if(_loc2_.instanceId == _loc5_.unitTrainJob.instanceId)
            {
               _loc2_.unitTypeId = _loc5_.unitTrainJob.unitTypeId;
               _loc2_.durationRemaining = _loc5_.unitTrainJob.durationRemaining;
               _loc2_.originalDuration = _loc4_;
               _loc2_.jobCreationTime = new Date().getTime();
               _loc6_ = true;
               break;
            }
         }
         if(!_loc6_)
         {
            city.unitTrainJobs.push(new UnitTrainJob(_loc5_.unitTrainJob.unitTypeId,_loc5_.unitTrainJob.durationRemaining,_loc4_,new Date().getTime(),_loc5_.unitTrainJob.instanceId));
         }
         coreManager.manageTrainingChamberIndicators();
         coreManager.manageTrainingChamberAnimations();
         dispatch(new ModelUpdateEvent("trainUnitJobsUpdated"));
         dispatch(new GenerateUnitTypeInfosEvent("generateUnitTypeInfosEvent"));
      }
   }
}

