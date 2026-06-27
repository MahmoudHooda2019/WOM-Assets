package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.DecorationInfo;
   import wom.model.message.response.BuyDecorationResponse;
   
   public class HandleBuyDecorationResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleBuyDecorationResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:BuyDecorationResponse = messageReceivedEvent.message as BuyDecorationResponse;
         var _loc2_:DecorationInfo = new DecorationInfo(_loc1_.instanceId,_loc1_.decorationTypeId,_loc1_.subType,_loc1_.position);
         cityInfo.decorations.push(_loc2_);
         coreManager.addDecoration(_loc2_);
      }
   }
}

