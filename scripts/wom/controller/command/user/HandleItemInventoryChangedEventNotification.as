package wom.controller.command.user
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.unit.CalculateUnitStatsEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.ItemInventoryChangedEventNotification;
   
   public class HandleItemInventoryChangedEventNotification extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function HandleItemInventoryChangedEventNotification()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ItemInventoryChangedEventNotification = messageReceivedEvent.message as ItemInventoryChangedEventNotification;
         userInfo.stockpileBoostCount = _loc1_.stockpileBoostCount;
         userInfo.storeItemCooldownDurations = _loc1_.storeItemCooldownDurations;
         userInfo.storeItemEffects = _loc1_.storeItemEffects;
         dispatch(new CalculateUnitStatsEvent("calculate"));
         dispatch(new ModelUpdateEvent("stockpileBoostCountChanged"));
         dispatch(new ModelUpdateEvent("storeItemCooldownDurationsUpdated"));
         dispatch(new ModelUpdateEvent("storeItemEffectsUpdated"));
      }
   }
}

