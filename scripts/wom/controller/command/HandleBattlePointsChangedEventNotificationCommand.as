package wom.controller.command
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.BattlePointsChangedEventNotification;
   import wom.model.resource.WomAssetRepository;
   
   public class HandleBattlePointsChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      public function HandleBattlePointsChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:BattlePointsChangedEventNotification = messageReceivedEvent.message as BattlePointsChangedEventNotification;
         userInfo.battlePoints = _loc1_.battlePoints;
         eventDispatcher.dispatchEvent(new ModelUpdateEvent("battlePointsUpdated"));
      }
   }
}

