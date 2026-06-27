package wom.view.mediator.screen.windows.tavern.unlock
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.screen.windows.tavern.unlock.MobileBaseTavernUnlockedCardView;
   
   public class MobileBaseTavernUnlockedCardViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var baseView:MobileBaseTavernUnlockedCardView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileBaseTavernUnlockedCardViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(baseView);
      }
   }
}

