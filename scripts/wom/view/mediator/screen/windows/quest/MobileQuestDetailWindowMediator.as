package wom.view.mediator.screen.windows.quest
{
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.QuestDetailTaskReadyEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.dto.TaskDTO;
   import wom.model.game.UserInfo;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.quest.QuestInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.SkipAllQuestTasksRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.quest.MobileQuestDetailTaskView;
   import wom.view.screen.windows.quest.MobileQuestDetailWindow;
   import wom.view.screen.windows.quest.MobileQuestWindow;
   
   public class MobileQuestDetailWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileQuestDetailWindow;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function MobileQuestDetailWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("questInfoUpdated",onQuestsUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.skipAllButton,"triggered",onSkipAllButtonClicked,Event);
         eventMap.mapStarlingListener(view.backButton,"triggered",onBackButtonClicked,Event);
         checkQuestComplete();
      }
      
      private function onSkipAllButtonClicked(param1:Event) : void
      {
         if(view.skipAllAvailable && view.skipAllCost > 0)
         {
            if(userInfo.numberOfGolds < view.skipAllCost)
            {
               view.addWindowEnumeration(new WindowEnumeration(21,{"id":view.questInfo.questId}));
               view.addWindowEnumeration(new WindowEnumeration(16,{"monetizationType":MonetizationType.NOT_ENOUGH_GOLD}));
               closeWindow();
            }
            else
            {
               soundPlayer.playSfxById("PurchaseSuccessful");
               dispatch(new OutgoingMessageEvent("outgoingMessage",new SkipAllQuestTasksRequest(view.questInfo.questId)));
               checkQuestComplete();
            }
         }
         else
         {
            closeWindow();
         }
      }
      
      private function onQuestsUpdated(param1:ModelUpdateEvent) : void
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = view.questInfo.questId;
         var _loc3_:Vector.<QuestInfo> = userInfo.quests;
         var _loc5_:Boolean = false;
         var _loc2_:QuestInfo = null;
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length && !_loc5_)
         {
            _loc4_ = _loc3_[_loc7_].questId;
            if(_loc4_ == _loc6_)
            {
               _loc5_ = true;
               _loc2_ = _loc3_[_loc7_];
            }
            _loc7_++;
         }
         if(_loc2_ != null)
         {
            updateWithQuestInfo(_loc2_);
            checkQuestComplete();
         }
      }
      
      public function updateWithQuestInfo(param1:QuestInfo) : void
      {
         var _loc5_:int = 0;
         var _loc3_:TaskDTO = null;
         var _loc4_:int = 0;
         var _loc2_:MobileQuestDetailTaskView = null;
         view.questInfo = param1;
         _loc5_ = 0;
         while(_loc5_ < param1.tasks.length)
         {
            _loc3_ = param1.tasks[_loc5_];
            _loc4_ = 0;
            while(_loc4_ < view.taskViews.length)
            {
               _loc2_ = view.taskViews[_loc4_];
               if(_loc2_.taskInfo.taskId == _loc3_.taskId)
               {
                  dispatch(new QuestDetailTaskReadyEvent("questDetailTaskReadyEvent",_loc3_));
               }
               _loc4_++;
            }
            _loc5_++;
         }
         view.calculateAndShowSkipAllCost();
      }
      
      private function checkQuestComplete() : void
      {
         if(view.checkQuestComplete())
         {
            closeWindow();
         }
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onBackButtonClicked(param1:Event) : void
      {
         closeWindow();
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileQuestWindow()));
      }
   }
}

