package wom.view.mediator.screen.windows.beast.cave
{
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.beast.BeastActionEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.store.StoreUtil;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.screen.windows.beast.cave.MobileDailyFeedPanel;
   
   public class MobileDailyFeedPanelMediator extends MobileBaseWindowPanelMediator
   {
      
      [Inject]
      public var view:MobileDailyFeedPanel;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileDailyFeedPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         updateBeast();
         updateGameTickListening();
         eventMap.mapStarlingListener(view.feedUseResourcesButton,"triggered",onFeedUseResourcesClicked,Event);
         eventMap.mapStarlingListener(view.instantFeedButton,"triggered",onInstantFeedClicked,Event);
         addContextListener("beastUpdated",onBeastUpdated,ModelUpdateEvent);
      }
      
      private function updateGameTickListening() : void
      {
         if(city.beast && city.beast.jobScheduler && (city.beast.jobScheduler.preTrainingJob || city.beast.jobScheduler.waitTrainingJob))
         {
            addContextListener("tick",onTick,GameTickEvent);
         }
         else
         {
            removeContextListener("tick",onTick,GameTickEvent);
         }
      }
      
      private function updateBeast() : void
      {
         if(city.beast != null)
         {
            view.updateBeast(city.beast,domainInfo.getBeast(city.beast.typeId),domainInfo.getUnitMap());
            updateGameTickListening();
         }
      }
      
      private function onBeastUpdated(param1:ModelUpdateEvent) : void
      {
         updateBeast();
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         if(city.beast != null)
         {
            view.updateProgressBar(city.beast,true);
         }
      }
      
      private function onFeedUseResourcesClicked(param1:Event) : void
      {
         dispatch(new BeastActionEvent("beastAction","train"));
      }
      
      private function onInstantFeedClicked(param1:Event) : void
      {
         dispatch(new BeastActionEvent("beastAction","evolve"));
      }
      
      private function isBeastFullyHealthy() : Boolean
      {
         var _loc6_:BeastTypeDIO = domainInfo.getBeast(city.beast.typeId);
         var _loc3_:BeastInfo = city.beast;
         var _loc4_:Number = _loc6_.healingCostTimesPerLevel[_loc3_.level - 1];
         var _loc5_:int = int(_loc3_.bonusStage > 0 ? _loc6_.healthPointsPerStage[_loc3_.bonusStage - 1] : _loc6_.healthPointsPerLevel[_loc3_.level - 1]);
         var _loc2_:int = Math.ceil((_loc5_ - _loc3_.healthPoints) * _loc4_ / _loc5_);
         var _loc1_:int = StoreUtil.mercenaryTrainAndRecruitPrice(0,_loc2_);
         return _loc1_ > 0;
      }
      
      private function isPreTrainingTimeCompleted() : Boolean
      {
         return view.remainingDurationForTraining <= 0;
      }
   }
}

