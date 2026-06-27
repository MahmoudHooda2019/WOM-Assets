package wom.controller.command.defense
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.defense.NPCAttackStatus;
   import wom.model.message.notification.NPCAttackTimeUpdatedEventNotification;
   
   public class HandleNPCAttackTimeUpdatedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleNPCAttackTimeUpdatedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:NPCAttackTimeUpdatedEventNotification = messageReceivedEvent.message as NPCAttackTimeUpdatedEventNotification;
         if(userInfo.mandatoryTutorialCompleted)
         {
            userInfo.canReceiveNPCAttacks = true;
         }
         userInfo.remainingDurationToNextNPCAttack = _loc1_.remainingTime;
         userInfo.npcDurationSaveTime = new Date().getTime();
         userInfo.npcAttackDelayed = _loc1_.delayed;
         if(userInfo.remainingDurationToNextNPCAttack <= 300000)
         {
            if(userInfo.remainingDurationToNextNPCAttack > 0 && userInfo.npcAttackDelayed)
            {
               userInfo.npcAttackStatus = NPCAttackStatus.DELAY;
            }
         }
         else
         {
            userInfo.npcAttackStatus = NPCAttackStatus.WAIT;
         }
         dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
      }
   }
}

