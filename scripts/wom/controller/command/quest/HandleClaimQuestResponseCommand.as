package wom.controller.command.quest
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.response.ClaimQuestResponse;
   
   public class HandleClaimQuestResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleClaimQuestResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ClaimQuestResponse = messageReceivedEvent.message as ClaimQuestResponse;
         if(!_loc1_.result)
         {
            _loc2_ = 0;
            while(_loc2_ < userInfo.quests.length)
            {
               if(userInfo.quests[_loc2_].questId == _loc1_.questId)
               {
                  userInfo.quests[_loc2_].claiming = false;
                  break;
               }
               _loc2_++;
            }
         }
         userInfo.claimedQuestIds[_loc1_.questId] = true;
         if(_loc1_.questId == 70)
         {
            userInfo.autoClaimQuests = false;
            dispatch(new ModelUpdateEvent("questInfoUpdated"));
         }
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
   }
}

