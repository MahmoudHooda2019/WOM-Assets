package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.notification.UnitRecruitedEventNotification;
   import wom.view.screen.popups.unit.MobileRecruitmentCompletedPopUp;
   
   public class HandleUnitRecruitedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleUnitRecruitedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:UnitRecruitedEventNotification = messageReceivedEvent.message as UnitRecruitedEventNotification;
         if(city.activeRecruitJob && city.activeRecruitJob.unitTypeId == _loc2_.unitTypeId)
         {
            city.activeRecruitJob = null;
            dispatch(new ModelUpdateEvent("recruitJobInfoUpdated"));
         }
         for(var _loc1_ in city.unitTypes)
         {
            if(int(_loc1_) == _loc2_.unitTypeId)
            {
               (city.unitTypes[_loc1_] as UnitTypeInfo).recruited = true;
               (city.unitTypes[_loc1_] as UnitTypeInfo).recruitable = false;
               (city.unitTypes[_loc1_] as UnitTypeInfo).currentlyRecruiting = false;
               (city.unitTypes[_loc1_] as UnitTypeInfo).durationRemaining = 0;
               (city.unitTypes[_loc1_] as UnitTypeInfo).originalDuration = 0;
               (city.unitTypes[_loc1_] as UnitTypeInfo).jobCreationTime = 0;
               dispatch(new ModelUpdateEvent("unitTypesUpdated"));
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileRecruitmentCompletedPopUp(domainInfo.getUnit(_loc2_.unitTypeId))));
               break;
            }
         }
         coreManager.manageRecruitmentChamberIndicator();
      }
   }
}

