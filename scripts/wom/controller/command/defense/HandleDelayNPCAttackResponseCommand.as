package wom.controller.command.defense
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.defense.NPCAttackStatus;
   import wom.model.message.request.StartNPCAttackRequest;
   import wom.model.message.response.DelayNPCAttackResponse;
   
   public class HandleDelayNPCAttackResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleDelayNPCAttackResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:DelayNPCAttackResponse = messageReceivedEvent.message as DelayNPCAttackResponse;
         userInfo.npcAttackDelayed = true;
         if(_loc1_.resultCode == 0)
         {
            userInfo.npcAttackStatus = NPCAttackStatus.DELAY;
         }
         else
         {
            userInfo.npcAttackStatus = NPCAttackStatus.INIT_ATTACK;
            dispatch(new OutgoingMessageEvent("outgoingMessage",new StartNPCAttackRequest()));
         }
         dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
      }
   }
}

