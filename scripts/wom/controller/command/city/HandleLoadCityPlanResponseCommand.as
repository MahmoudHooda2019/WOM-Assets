package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.component.WomPlannerRootV2;
   import wom.model.message.response.LoadCityPlanResponse;
   
   public class HandleLoadCityPlanResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var plannerRoot:WomPlannerRootV2;
      
      public function HandleLoadCityPlanResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:LoadCityPlanResponse = messageReceivedEvent.message as LoadCityPlanResponse;
         if(_loc1_.resultCode == 0)
         {
            plannerRoot.displayPlannerSnapShot(_loc1_.plan);
         }
      }
   }
}

