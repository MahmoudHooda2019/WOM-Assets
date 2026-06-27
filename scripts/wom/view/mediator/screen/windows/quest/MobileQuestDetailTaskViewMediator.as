package wom.view.mediator.screen.windows.quest
{
   import flash.geom.Point;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.resource.SoundPlayer;
   import peak.util.BiMap;
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.ui.QuestDetailTaskReadyEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.TaskDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.SkipQuestTaskRequest;
   import wom.view.screen.windows.quest.MobileQuestDetailTaskView;
   
   public class MobileQuestDetailTaskViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileQuestDetailTaskView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function MobileQuestDetailTaskViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("questDetailTaskReadyEvent",onQuestDetailTaskReady,QuestDetailTaskReadyEvent);
         addContextListener("getMandatoryActionButtonPosition",onMandatoryActionButtonPositionRequested,TutorialReferencePositionEvent);
         eventMap.mapStarlingListener(view.skipButton,"triggered",onSkipButtonClicked,Event);
         eventMap.mapStarlingListener(view.directionButton,"triggered",onDirectionButtonClicked,Event);
         eventMap.mapStarlingListener(view.hintButton,"triggered",onHintClicked,Event);
         updateWithTaskInfo(view.taskInfo);
      }
      
      private function onMandatoryActionButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         var _loc2_:int = 0;
         if(view.directionButton && view.directionButton.visible && "taskId" in param1.additionalInfo)
         {
            _loc2_ = int(param1.additionalInfo["taskId"]);
            if(view.taskInfo.taskId == _loc2_)
            {
               if(view.hintButton)
               {
                  view.hintButton.visible = false;
               }
               dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,view.bg.localToGlobal(new Point()),param1.additionalInfo));
            }
         }
      }
      
      private function onHintClicked(param1:Event) : void
      {
         if(view.isHintVisible())
         {
            view.toggleHint(false);
         }
         else
         {
            view.toggleHint(true);
         }
      }
      
      private function onQuestDetailTaskReady(param1:QuestDetailTaskReadyEvent) : void
      {
         if(view.taskInfo.taskId == param1.taskDTO.taskId)
         {
            updateWithTaskInfo(param1.taskDTO);
         }
      }
      
      protected function updateWithTaskInfo(param1:TaskDTO) : void
      {
         view.updateWithTaskInfo(param1,param1.highlight != null && checkBuildingExist(param1.highlight));
      }
      
      private function onSkipButtonClicked(param1:Event) : void
      {
         if(userInfo.numberOfGolds < view.taskInfo.skipCost)
         {
            dispatch(new MobileCloseContainerOfDisplayObjectEvent("addWindowEnumeration",view,false,new <WindowEnumeration>[new WindowEnumeration(21,{"id":view.taskInfo.questId})]));
            dispatch(new MobileCloseContainerOfDisplayObjectEvent("addWindowEnumeration",view,false,new <WindowEnumeration>[new WindowEnumeration(16,{"monetizationType":MonetizationType.NOT_ENOUGH_GOLD})]));
            dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view));
         }
         else
         {
            soundPlayer.playSfxById("PurchaseSuccessful");
            dispatch(new OutgoingMessageEvent("outgoingMessage",new SkipQuestTaskRequest(view.taskInfo.taskId)));
         }
      }
      
      private function onDirectionButtonClicked(param1:Event) : void
      {
         if(view.taskInfo.highlight != null)
         {
            dispatch(new MobileCloseContainerOfDisplayObjectEvent("addWindowEnumeration",view,false,new <WindowEnumeration>[view.taskInfo.highlight]));
            dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view));
         }
      }
      
      private function checkBuildingExist(param1:WindowEnumeration) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:BuildingInfo = null;
         var _loc6_:BuildingTypeDIO = null;
         var _loc3_:BiMap = WindowEnumeration.getBuildingTypeIdMap();
         if(_loc3_.hasKey(param1.type))
         {
            _loc4_ = _loc3_.getValue(param1.type);
            if(_loc4_ == 20)
            {
               _loc5_ = getBuildingInfo(21);
            }
            if(_loc5_ == null)
            {
               _loc5_ = getBuildingInfo(_loc4_);
            }
            if(_loc5_ == null || _loc5_.incomplete || _loc5_.level < 1)
            {
               return false;
            }
            for each(var _loc2_ in city.buildingUpgradeJobs)
            {
               if(_loc2_.instanceId == _loc5_.instanceId)
               {
                  return false;
               }
            }
            for each(var _loc7_ in city.buildingRepairJobs)
            {
               if(_loc7_.instanceId == _loc5_.instanceId)
               {
                  return false;
               }
            }
            _loc6_ = domainInfo.getBuilding(_loc5_.buildingTypeId);
            if(!_loc6_.isHealthy(_loc5_.level,_loc5_.healthPoint))
            {
               return false;
            }
         }
         return true;
      }
      
      private function getBuildingInfo(param1:int) : BuildingInfo
      {
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.buildingTypeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

