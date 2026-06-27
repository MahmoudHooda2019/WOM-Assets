package wom.view.mediator.screen.windows.league.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.league.LeagueManager;
   import wom.view.screen.windows.league.mobile.MobileLeaguePanel;
   
   public class MobileLeaguePanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileLeaguePanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      public function MobileLeaguePanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("leagueStatusUpdated",onLeagueStatusUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.helpButton,"triggered",onHintMouseTapped,Event);
         leagueStatusUpdated();
      }
      
      private function leagueStatusUpdated() : void
      {
         view.togglePanels(leagueManager.myLeague != null);
      }
      
      private function onLeagueStatusUpdated(param1:ModelUpdateEvent) : void
      {
         leagueStatusUpdated();
      }
      
      private function onHintMouseTapped(param1:Event) : void
      {
         view.toggleHint(!view.hintVisible);
      }
   }
}

