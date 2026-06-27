package wom.controller.command.tutorial
{
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import wom.controller.PCommand;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.model.game.UserInfo;
   
   public class DisableTutorialsCommand extends PCommand
   {
      
      [Inject]
      public var event:TutorialEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function DisableTutorialsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"Tutorials are being disabled");
         userInfo.tutorialsInfo.enabled = false;
         dispatch(new TutorialEvent("saveTutorialsToServer"));
         dispatch(new TutorialEvent("tutorialsUpdated"));
      }
   }
}

