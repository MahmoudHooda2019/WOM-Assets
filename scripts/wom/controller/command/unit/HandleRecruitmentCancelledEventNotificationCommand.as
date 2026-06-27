package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.GenerateUnitTypeInfosEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   
   public class HandleRecruitmentCancelledEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleRecruitmentCancelledEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         city.activeRecruitJob = null;
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.buildingTypeId == 17)
            {
               coreManager.cancelRecruitment(_loc1_.instanceId);
               break;
            }
         }
         dispatch(new GenerateUnitTypeInfosEvent("generateUnitTypeInfosEvent"));
         dispatch(new ModelUpdateEvent("recruitJobInfoUpdated"));
      }
   }
}

