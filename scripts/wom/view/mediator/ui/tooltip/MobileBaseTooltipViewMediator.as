package wom.view.mediator.ui.tooltip
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.tooltip.MobileBaseTooltipView;
   
   public class MobileBaseTooltipViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var baseView:MobileBaseTooltipView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileBaseTooltipViewMediator()
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

