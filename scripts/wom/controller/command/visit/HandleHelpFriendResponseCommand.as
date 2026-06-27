package wom.controller.command.visit
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.UserInfo;
   import wom.model.game.VisitInfo;
   import wom.model.message.response.HelpFriendResponse;
   
   public class HandleHelpFriendResponseCommand extends PCommand
   {
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleHelpFriendResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:HelpFriendResponse = messageReceivedEvent.message as HelpFriendResponse;
         if(_loc1_.resultCode == 0)
         {
            userInfo.helpCountDictionary[_loc1_.helpedGameUid]++;
            if(!(visitInfo.landlord.gameId in userInfo.helpedBuildingsDictionary))
            {
               userInfo.helpedBuildingsDictionary[visitInfo.landlord.gameId] = new Dictionary();
            }
            userInfo.helpedBuildingsDictionary[visitInfo.landlord.gameId][_loc1_.instanceId] = true;
            dispatch(new ModelUpdateEvent("helpInfoUpdated"));
            visitInfo.remainingHelpCount--;
            coreManager.removeHelpableStatusOfBuilding(_loc1_.instanceId);
         }
         else
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
      }
   }
}

