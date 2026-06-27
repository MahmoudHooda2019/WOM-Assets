package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.response.SetCityPlanSlotsResponse;
   
   public class HandleSetCityPlanSlotsResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function HandleSetCityPlanSlotsResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:SetCityPlanSlotsResponse = messageReceivedEvent.message as SetCityPlanSlotsResponse;
         if(_loc1_.resultCode == 0)
         {
            city.maxCityPlanSlots++;
            dispatch(new ModelUpdateEvent("cityPlannerMaxSlotsChanged"));
         }
      }
   }
}

