package wom.view.mediator.screen.popups.tournament
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.screen.popups.tournament.MobileTournamentRewardView;
   
   public class MobileTournamentRewardViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileTournamentRewardView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileTournamentRewardViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
      }
   }
}

