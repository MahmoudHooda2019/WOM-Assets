package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ui.ActionSelectEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.enum.ActionType;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.resource.ResourceType;
   import wom.model.message.response.RearmTrapsResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.unit.NotEnoughResourcePopUp;
   
   public class HandleRearmTrapsResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      public function HandleRearmTrapsResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:RearmTrapsResponse = messageReceivedEvent.message as RearmTrapsResponse;
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
         else
         {
            for each(var _loc2_ in city.buildings)
            {
               if(_loc2_.isTrap && _loc2_.healthPoint == 0)
               {
                  _loc2_.healthPoint = -1;
                  (gameRootHolder.gameRoot.buildings[_loc2_.instanceId] as Building).viewManager.manageAll();
               }
            }
         }
      }
   }
}

