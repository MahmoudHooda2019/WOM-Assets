package wom.view.mediator.ui.common
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.common.MobileInboxMenuButtonView;
   
   public class MobileInboxMenuButtonViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileInboxMenuButtonView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileInboxMenuButtonViewMediator()
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

