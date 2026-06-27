package wom.controller.command.report
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.report.AttackLog;
   import wom.model.message.response.ReadAttackLogResponse;
   
   public class HandleReadAttackLogResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleReadAttackLogResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ReadAttackLogResponse = event.message as ReadAttackLogResponse;
         if(userInfo.attackLogs)
         {
            if(!_loc1_.markAllAsRead)
            {
               _loc2_ = 0;
               while(true)
               {
                  if(_loc2_ < userInfo.attackLogs.length)
                  {
                     var _loc3_:AttackLog = userInfo.attackLogs[_loc2_];
                     if(_loc3_.id == _loc1_.attackLogId)
                     {
                        break;
                     }
                     _loc2_++;
                     continue;
                  }
               }
               _loc3_.isRead = true;
               dispatch(new ModelUpdateEvent("attackLogsUpdated"));
               return;
            }
            for each(_loc3_ in userInfo.attackLogs)
            {
               _loc3_.isRead = true;
            }
            dispatch(new ModelUpdateEvent("attackLogsUpdated"));
         }
      }
   }
}

