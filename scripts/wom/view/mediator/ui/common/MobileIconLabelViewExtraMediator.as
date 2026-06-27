package wom.view.mediator.ui.common
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.common.MobileIconLabelViewExtra;
   
   public class MobileIconLabelViewExtraMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileIconLabelViewExtra;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileIconLabelViewExtraMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
      }
   }
}

