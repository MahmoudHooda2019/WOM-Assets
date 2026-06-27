package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.response.GetCityPlansResponse;
   
   public class HandleGetCityPlansResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function HandleGetCityPlansResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GetCityPlansResponse = messageReceivedEvent.message as GetCityPlansResponse;
         if(_loc1_.resultCode == 0)
         {
            city.cityPlans = _loc1_.cityPlans;
            city.maxCityPlanSlots = _loc1_.maxSlots;
         }
      }
   }
}

