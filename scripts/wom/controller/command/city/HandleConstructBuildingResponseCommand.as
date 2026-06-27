package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ui.ActionSelectEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.component.enum.ActionType;
   import wom.model.game.resource.ResourceType;
   import wom.model.message.response.ConstructBuildingResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.unit.NotEnoughResourcePopUp;
   
   public class HandleConstructBuildingResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleConstructBuildingResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ConstructBuildingResponse = messageReceivedEvent.message as ConstructBuildingResponse;
         if(!_loc1_.success)
         {
            dispatch(new ActionSelectEvent("actionSelect",ActionType.ARROW));
            if(_loc1_.resultCode == 13)
            {
               dispatch(new PopUpWindowEvent("showSecondaryPopUpWindow",new NotEnoughResourcePopUp(-1,ResourceType.UNKNOWN)));
            }
            else if(!errorCodeRepository.dispatchError("ConstructBuildingResponse",_loc1_.resultCode))
            {
               eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
            }
         }
      }
   }
}

