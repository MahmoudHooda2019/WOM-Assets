package wom.controller.command.combat
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.defense.NPCAttackStatus;
   
   public class HandleSkipNPCAttackResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleSkipNPCAttackResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         userInfo.npcAttackStatus = NPCAttackStatus.WAIT;
      }
   }
}

