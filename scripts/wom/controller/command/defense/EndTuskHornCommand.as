package wom.controller.command.defense
{
   import wom.controller.PCommand;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.defense.EndTuskHornEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.WomScreenType;
   import wom.model.message.request.EndTuskHornAttackRequest;
   import wom.model.message.request.StatusRequest;
   
   public class EndTuskHornCommand extends PCommand
   {
      
      [Inject]
      public var event:EndTuskHornEvent;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function EndTuskHornCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         attackInfo.attackEnded = true;
         dispatch(new OutgoingMessageEvent("outgoingMessage",new EndTuskHornAttackRequest()));
         dispatch(new ActivateScreenEvent("activate",WomScreenType.LOADING));
         dispatch(new OutgoingMessageEvent("outgoingMessage",new StatusRequest()));
      }
   }
}

