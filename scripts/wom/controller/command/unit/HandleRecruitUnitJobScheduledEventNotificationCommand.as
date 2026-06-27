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
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.UnitRecruitJob;
   import wom.model.message.notification.RecruitUnitJobScheduledEventNotification;
   
   public class HandleRecruitUnitJobScheduledEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleRecruitUnitJobScheduledEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:RecruitUnitJobScheduledEventNotification = messageReceivedEvent.message as RecruitUnitJobScheduledEventNotification;
         var _loc1_:UnitTypeDIO = domainInfo.getUnit(_loc3_.unitRecruitJob.unitTypeId);
         city.activeRecruitJob = new UnitRecruitJob(_loc3_.unitRecruitJob.unitTypeId,_loc3_.unitRecruitJob.durationRemaining,_loc1_.unlockDurationInSecs * 1000 / userInfo.serverSpeed,new Date().getTime());
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.buildingTypeId == 17)
            {
               coreManager.startRecruitment(_loc2_.instanceId,city.activeRecruitJob);
               break;
            }
         }
         dispatch(new GenerateUnitTypeInfosEvent("generateUnitTypeInfosEvent"));
         dispatch(new ModelUpdateEvent("recruitJobInfoUpdated"));
      }
   }
}

