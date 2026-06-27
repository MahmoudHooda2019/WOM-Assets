package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ui.CatapultRechargeEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.attack.CatapultTimeDTO;
   import wom.model.message.response.RechargeCatapultResponse;
   
   public class HandleRechargeCatapultResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleRechargeCatapultResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:RechargeCatapultResponse = messageReceivedEvent.message as RechargeCatapultResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
         else
         {
            userInfo.catapultActivationRemainingTimes[_loc1_.catapultId] = new CatapultTimeDTO(_loc1_.catapultId,0);
            dispatch(new CatapultRechargeEvent("catapultRecharged",_loc1_.catapultId));
         }
      }
   }
}

