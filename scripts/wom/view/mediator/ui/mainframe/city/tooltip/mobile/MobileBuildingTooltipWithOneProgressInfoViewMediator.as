package wom.view.mediator.ui.mainframe.city.tooltip.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipWithOneProgressInfoView;
   
   public class MobileBuildingTooltipWithOneProgressInfoViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBuildingTooltipWithOneProgressInfoView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileBuildingTooltipWithOneProgressInfoViewMediator()
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

