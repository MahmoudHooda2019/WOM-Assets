package wom.view.mediator.ui.mainframe.city.tooltip.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileTooltipInfoView;
   
   public class MobileTooltipInfoViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileTooltipInfoView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileTooltipInfoViewMediator()
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

