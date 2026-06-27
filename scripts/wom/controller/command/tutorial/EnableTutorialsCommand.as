package wom.controller.command.tutorial
{
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import wom.controller.PCommand;
   import wom.controller.event.PreloadAssetsEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.model.game.UserInfo;
   import wom.model.resource.asset.AssetCategoryType;
   
   public class EnableTutorialsCommand extends PCommand
   {
      
      [Inject]
      public var event:TutorialEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function EnableTutorialsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"Tutorials are being enabled");
         dispatch(new PreloadAssetsEvent("createWindow",AssetCategoryType.TUTORIAL_ALL));
         dispatch(new TutorialEvent("tutorialsUpdated"));
      }
   }
}

