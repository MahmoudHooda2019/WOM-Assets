package wom.view.mediator.ui.common
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.common.MobileCondenseButtonView;
   
   public class MobileCondenseButtonViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCondenseButtonView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileCondenseButtonViewMediator()
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

