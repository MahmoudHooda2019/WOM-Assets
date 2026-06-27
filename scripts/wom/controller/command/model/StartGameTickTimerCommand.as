package wom.controller.command.model
{
   import wom.controller.PCommand;
   import wom.controller.event.GameTickEvent;
   import wom.model.GameTickTimer;
   
   public class StartGameTickTimerCommand extends PCommand
   {
      
      [Inject]
      public var gameTickEvent:GameTickEvent;
      
      [Inject]
      public var gameTickTimer:GameTickTimer;
      
      public function StartGameTickTimerCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         gameTickTimer.start();
      }
   }
}

