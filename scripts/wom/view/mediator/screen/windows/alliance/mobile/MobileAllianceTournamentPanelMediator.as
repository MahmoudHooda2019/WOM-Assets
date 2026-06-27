package wom.view.mediator.screen.windows.alliance.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.model.game.alliance.AllianceInfo;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceTournamentPanel;
   
   public class MobileAllianceTournamentPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileAllianceTournamentPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function MobileAllianceTournamentPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
      }
   }
}

