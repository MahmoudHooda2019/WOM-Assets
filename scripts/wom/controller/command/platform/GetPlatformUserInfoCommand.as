package wom.controller.command.platform
{
   import peak.config.DocumentConfiguration;
   import wom.controller.PCommand;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.service.facebook.FacebookAPIManager;
   
   public class GetPlatformUserInfoCommand extends PCommand
   {
      
      [Inject]
      public var event:PlatformUserEvent;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var documentConfiguration:DocumentConfiguration;
      
      public function GetPlatformUserInfoCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         facebookAPIManager.getUserInfo(documentConfiguration.getParameter("access_token"),event.profileIdPairs);
      }
   }
}

