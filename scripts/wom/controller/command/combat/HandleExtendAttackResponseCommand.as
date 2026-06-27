package wom.controller.command.combat
{
   import flash.utils.getTimer;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.AttackInfo;
   import wom.model.message.response.ExtendBattleDurationResponse;
   
   public class HandleExtendAttackResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      public function HandleExtendAttackResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ExtendBattleDurationResponse = event.message as ExtendBattleDurationResponse;
         if(_loc1_.resultCode == 0)
         {
            attackInfo.attackEndTime = getTimer() + _loc1_.remainingTime;
         }
         attackInfo.attackEndTimeExtended = true;
         dispatch(new ModelUpdateEvent("attackInfoUpdated"));
      }
   }
}

