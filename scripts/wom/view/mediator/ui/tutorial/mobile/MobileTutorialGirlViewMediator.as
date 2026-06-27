package wom.view.mediator.ui.tutorial.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.tutorial.mobile.MobileTutorialGirlView;
   
   public class MobileTutorialGirlViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileTutorialGirlView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileTutorialGirlViewMediator()
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

