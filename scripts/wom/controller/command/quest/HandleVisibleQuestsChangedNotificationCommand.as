package wom.controller.command.quest
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.dto.QuestDTO;
   import wom.model.dto.QuestRewardDTO;
   import wom.model.dto.TaskDTO;
   import wom.model.game.UserInfo;
   import wom.model.game.quest.QuestInfo;
   import wom.model.game.quest.QuestRewardType;
   import wom.model.game.resource.ResourceType;
   import wom.model.message.notification.VisibleQuestsChangedNotification;
   
   public class HandleVisibleQuestsChangedNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function HandleVisibleQuestsChangedNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:String = null;
         var _loc5_:Boolean = false;
         var _loc1_:Boolean = false;
         var _loc10_:VisibleQuestsChangedNotification = messageReceivedEvent.message as VisibleQuestsChangedNotification;
         var _loc12_:Boolean = false;
         var _loc6_:Vector.<QuestInfo> = userInfo.quests;
         var _loc9_:Vector.<QuestInfo> = new Vector.<QuestInfo>();
         for each(var _loc11_ in _loc10_.visibleQuests)
         {
            if(_loc11_.completed)
            {
               _loc12_ = true;
            }
            for each(var _loc3_ in _loc11_.rewards)
            {
               switch(_loc3_.rewardType)
               {
                  case QuestRewardType.QRT_UNIT:
                     _loc2_ = domainInfo.getUnit(_loc3_.subTypeId).assetName;
                     _loc2_ += "Portrait";
                     _loc3_.visualId = _loc2_;
                     break;
                  case QuestRewardType.QRT_RESOURCE:
                     _loc3_.visualId = ResourceType.determineResourceType(_loc3_.subTypeId).iconAssetName;
                     break;
                  case QuestRewardType.QRT_GOLD:
                     _loc3_.visualId = "IconGoldM";
                     break;
                  case QuestRewardType.QRT_XP:
                     _loc3_.visualId = "IconLevelM";
               }
            }
            _loc5_ = true;
            _loc1_ = false;
            for each(var _loc7_ in _loc6_)
            {
               if(_loc7_.questId == _loc11_.questId)
               {
                  _loc5_ = false;
                  for each(var _loc8_ in _loc7_.tasks)
                  {
                     for each(var _loc4_ in _loc11_.tasks)
                     {
                        if(!_loc11_.completed && _loc4_.taskId == _loc8_.taskId && _loc4_.completed != _loc8_.completed)
                        {
                           _loc1_ = true;
                        }
                     }
                  }
               }
            }
            _loc9_.push(new QuestInfo(_loc11_.questId,_loc11_.order,_loc11_.family,_loc11_.rewards,_loc11_.visualId,_loc11_.completed,_loc11_.tasks,_loc5_,_loc1_));
         }
         userInfo.quests = _loc9_;
         dispatch(new ModelUpdateEvent("questInfoUpdated"));
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
   }
}

