package wom.controller.command.bootstrap
{
   import wom.controller.PCommand;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.friend.FriendInfo;
   import wom.service.facebook.FacebookAPIManager;
   
   public class BootstrapFacebookCacheCommand extends PCommand
   {
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function BootstrapFacebookCacheCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         for each(var _loc1_ in documentConfiguration.friends)
         {
            facebookAPIManager.setUserInfo(_loc1_.profile,_loc1_.name);
         }
      }
   }
}

