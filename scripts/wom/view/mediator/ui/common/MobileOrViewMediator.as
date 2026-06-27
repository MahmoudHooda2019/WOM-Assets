package wom.view.mediator.ui.common
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.common.MobileOrView;
   
   public class MobileOrViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileOrView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileOrViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
      }
   }
}

