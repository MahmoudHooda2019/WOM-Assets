package wom.view.mediator.ui.common
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.common.MobileIconLabelView;
   
   public class MobileIconLabelViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileIconLabelView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileIconLabelViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
      }
   }
}

