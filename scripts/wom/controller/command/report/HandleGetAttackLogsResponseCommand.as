package wom.controller.command.report
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.game.report.MobileAttackLog;
   import wom.model.message.response.GetAttackLogsResponse;
   import wom.service.facebook.FacebookAPIManager;
   
   public class HandleGetAttackLogsResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      public function HandleGetAttackLogsResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GetAttackLogsResponse = event.message as GetAttackLogsResponse;
         userInfo.attackLogs = _loc1_.attackLogs;
         updateNames();
         dispatch(new ModelUpdateEvent("attackLogsUpdated"));
      }
      
      private function updateNames() : void
      {
         var _loc2_:Vector.<ProfileIdPair> = new Vector.<ProfileIdPair>();
         for each(var _loc1_ in userInfo.attackLogs)
         {
            _loc2_.push(new ProfileIdPair(_loc1_.attacker.platformId,_loc1_.attacker.avatar));
            _loc2_.push(new ProfileIdPair(_loc1_.defender.platformId,_loc1_.defender.avatar));
         }
         if(_loc2_.length > 0)
         {
            dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc2_));
         }
      }
   }
}

