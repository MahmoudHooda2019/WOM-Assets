package wom.view.mediator.ui.mainframe.city.tooltip.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipDefenseInfoView;
   
   public class MobileBuildingTooltipDefenseInfoViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBuildingTooltipDefenseInfoView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileBuildingTooltipDefenseInfoViewMediator()
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

