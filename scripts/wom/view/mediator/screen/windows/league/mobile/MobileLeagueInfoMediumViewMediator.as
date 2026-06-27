package wom.view.mediator.screen.windows.league.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.screen.windows.league.mobile.MobileLeagueInfoMediumView;
   
   public class MobileLeagueInfoMediumViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileLeagueInfoMediumView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileLeagueInfoMediumViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
      }
   }
}

