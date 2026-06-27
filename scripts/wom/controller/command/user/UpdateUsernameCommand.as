package wom.controller.command.user
{
   import peak.network.ServerConnection;
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.service.facebook.FacebookAPIManager;
   
   public class UpdateUsernameCommand extends PCommand
   {
      
      [Inject]
      public var event:ModelUpdateEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var facebookApiManager:FacebookAPIManager;
      
      [Inject(name="chatServer")]
      public var serverConnection:ServerConnection;
      
      public function UpdateUsernameCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(!serverConnection.connected && userInfo.profile && facebookApiManager.getUserNameByProfile(userInfo.profile,false,true) != userInfo.profile.gameId)
         {
            dispatch(new ModelUpdateEvent("friendsUpdated"));
         }
      }
   }
}

