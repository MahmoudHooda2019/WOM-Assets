package wom.view.mediator.ui.tutorial.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.tutorial.mobile.MobileDeployHandView;
   
   public class MobileDeployHandViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileDeployHandView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileDeployHandViewMediator()
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

