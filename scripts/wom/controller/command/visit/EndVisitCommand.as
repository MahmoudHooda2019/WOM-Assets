package wom.controller.command.visit
{
   import wom.controller.PCommand;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.visit.EndVisitEvent;
   import wom.model.game.VisitInfo;
   import wom.model.game.WomScreenType;
   import wom.model.message.request.EndVisitingCityRequest;
   import wom.model.message.request.StatusRequest;
   
   public class EndVisitCommand extends PCommand
   {
      
      [Inject]
      public var event:EndVisitEvent;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      public function EndVisitCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new EndVisitingCityRequest(visitInfo.landlord)));
         dispatch(new ActivateScreenEvent("activate",WomScreenType.LOADING));
         visitInfo.reset();
         dispatch(new OutgoingMessageEvent("outgoingMessage",new StatusRequest()));
      }
   }
}

