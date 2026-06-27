package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ui.CityPlannerEvent;
   import wom.model.dto.CityPlanInfoDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.response.SaveCityPlanResponse;
   
   public class HandleSaveCityPlanResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function HandleSaveCityPlanResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:SaveCityPlanResponse = messageReceivedEvent.message as SaveCityPlanResponse;
         city.cityPlans[_loc1_.slot] = new CityPlanInfoDTO(_loc1_.slot,_loc1_.name);
         dispatch(new CityPlannerEvent("saveLayoutSuccess"));
      }
   }
}

