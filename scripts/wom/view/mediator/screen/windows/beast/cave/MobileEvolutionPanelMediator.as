package wom.view.mediator.screen.windows.beast.cave
{
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.beast.BeastActionEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.screen.windows.beast.cave.MobileEvolutionPanel;
   
   public class MobileEvolutionPanelMediator extends MobileBaseWindowPanelMediator
   {
      
      [Inject]
      public var view:MobileEvolutionPanel;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileEvolutionPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         updateBeast();
         addContextListener("tick",onTick,GameTickEvent);
         eventMap.mapStarlingListener(view.instantEvolveButton,"triggered",onInstantEvolveClicked,Event);
         eventMap.mapStarlingListener(view.startFeedingButton,"triggered",onStartFeedingClicked,Event);
         addContextListener("beastUpdated",onBeastUpdated,ModelUpdateEvent);
      }
      
      private function updateBeast() : void
      {
         if(city.beast != null)
         {
            view.updateBeast(city.beast,domainInfo.getBeast(city.beast.typeId),domainInfo.getUnitMap());
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
            view.updateProgress(city.beast,domainInfo.getBeast(city.beast.typeId),true);
         }
      }
      
      private function onInstantEvolveClicked(param1:Event) : void
      {
         dispatch(new BeastActionEvent("beastAction","evolve"));
      }
      
      private function onStartFeedingClicked(param1:Event) : void
      {
         dispatch(new BeastActionEvent("beastAction","train"));
      }
   }
}

