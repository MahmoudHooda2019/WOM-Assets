package wom.controller.command.tutorial
{
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import wom.controller.PCommand;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.model.game.UserInfo;
   
   public class SkipTutorialCommand extends PCommand
   {
      
      [Inject]
      public var event:TutorialEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function SkipTutorialCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"Skip tutorial with id: " + event.tutorialId);
      }
   }
}

