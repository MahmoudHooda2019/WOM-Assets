package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.GenerateUnitTypeInfosEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.notification.UnitLevelIncreasedEventNotification;
   import wom.view.screen.popups.unit.MobileTrainingCompletedPopUp;
   
   public class HandleUnitLevelIncreasedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleUnitLevelIncreasedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc5_:int = 0;
         var _loc4_:UnitLevelIncreasedEventNotification = messageReceivedEvent.message as UnitLevelIncreasedEventNotification;
         var _loc1_:Vector.<UnitTrainJob> = city.unitTrainJobs;
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            if(_loc1_[_loc5_].unitTypeId == _loc4_.unitTypeId)
            {
               _loc1_.splice(_loc5_,1);
               dispatch(new ModelUpdateEvent("trainUnitJobsUpdated"));
               break;
            }
            _loc5_++;
         }
         for(var _loc3_ in city.unitTypes)
         {
            if(int(_loc3_) == _loc4_.unitTypeId)
            {
               (city.unitTypes[_loc3_] as UnitTypeInfo).currentLevel = _loc4_.level;
               (city.unitTypes[_loc3_] as UnitTypeInfo).currentlyTraining = false;
               (city.unitTypes[_loc3_] as UnitTypeInfo).durationRemaining = 0;
               (city.unitTypes[_loc3_] as UnitTypeInfo).originalDuration = 0;
               (city.unitTypes[_loc3_] as UnitTypeInfo).jobCreationTime = 0;
               for each(var _loc2_ in city.units)
               {
                  if(_loc2_.typeId == _loc4_.unitTypeId)
                  {
                     _loc2_.healthPoints = domainInfo.getUnit(_loc4_.unitTypeId).healthPointsPerLevel[_loc4_.level - 1];
                  }
               }
               dispatch(new ModelUpdateEvent("unitTypesUpdated"));
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileTrainingCompletedPopUp(domainInfo.getUnit(_loc4_.unitTypeId),_loc4_.level)));
               dispatch(new GenerateUnitTypeInfosEvent("generateUnitTypeInfosEvent"));
               break;
            }
         }
         coreManager.manageTrainingChamberAnimations();
         coreManager.manageTrainingChamberIndicators();
      }
   }
}

