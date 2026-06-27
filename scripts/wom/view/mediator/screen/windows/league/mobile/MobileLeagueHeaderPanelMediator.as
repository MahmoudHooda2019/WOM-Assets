package wom.view.mediator.screen.windows.league.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.game.league.LeagueInfo;
   import wom.model.game.league.LeagueManager;
   import wom.view.screen.windows.league.mobile.MobileLeagueHeaderPanel;
   
   public class MobileLeagueHeaderPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileLeagueHeaderPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileLeagueHeaderPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("leagueStatusUpdated",onLeagueStatusUpdated,ModelUpdateEvent);
         addContextListener("leagueInfoViewUpdated",onLeagueInfoViewUpdated,ModelUpdateEvent);
         leagueStatusUpdated();
      }
      
      private function leagueStatusUpdated() : void
      {
         var _loc1_:LeagueInfo = leagueManager.myLeague;
         removeContextListener("tick",onTick,GameTickEvent);
         if(_loc1_ != null)
         {
            view.update(_loc1_.levelDIO,_loc1_.season.remainingSeasonDuration);
            addContextListener("tick",onTick,GameTickEvent);
         }
         else
         {
            view.update(domainInfo.getLeagueLevel(0),NaN);
         }
      }
      
      private function onLeagueStatusUpdated(param1:ModelUpdateEvent) : void
      {
         leagueStatusUpdated();
      }
      
      private function onLeagueInfoViewUpdated(param1:ModelUpdateEvent) : void
      {
         view.drawLayout();
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         var _loc2_:LeagueInfo = leagueManager.myLeague;
         if(_loc2_ != null)
         {
            view.updateRemainingSeasonDuration(_loc2_.season.remainingSeasonDuration);
         }
      }
   }
}

