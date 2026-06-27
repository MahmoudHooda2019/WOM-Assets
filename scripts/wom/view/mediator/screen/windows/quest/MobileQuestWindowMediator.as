package wom.view.mediator.screen.windows.quest
{
   import flash.geom.Point;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.model.game.UserInfo;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.quest.MobileQuestWindow;
   import wom.view.ui.mainframe.quest.QuestPreviewView;
   
   public class MobileQuestWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileQuestWindow;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileQuestWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("questInfoUpdated",onQuestInfoUpdated,ModelUpdateEvent);
         addContextListener("getQuestPreviewViewPosition",onQuestPreviewViewPositionRequested,TutorialReferencePositionEvent);
         addContextListener("mandatoryTutorialsCompletionChanged",onMandatoryTutorialsCompletionChanged,TutorialEvent);
         questInfoUpdated();
      }
      
      private function onMandatoryTutorialsCompletionChanged(param1:TutorialEvent) : void
      {
         if(userInfo.mandatoryTutorialCompleted)
         {
            questInfoUpdated();
         }
      }
      
      private function onQuestInfoUpdated(param1:ModelUpdateEvent) : void
      {
         questInfoUpdated();
      }
      
      private function questInfoUpdated() : void
      {
         if(userInfo.quests)
         {
            view.updateWithQuests(userInfo.quests,userInfo.autoClaimQuests ? 0 : (userInfo.mandatoryTutorialCompleted ? userInfo.quests.length : 1));
         }
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      private function onQuestPreviewViewPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         var _loc3_:int = 0;
         if("questId" in param1.additionalInfo)
         {
            _loc3_ = int(param1.additionalInfo["questId"]);
            for each(var _loc2_ in view.questViews)
            {
               if(_loc2_.questInfo.questId == _loc3_)
               {
                  dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,_loc2_.localToGlobal(new Point(0,0)),param1.additionalInfo));
               }
            }
         }
      }
   }
}

