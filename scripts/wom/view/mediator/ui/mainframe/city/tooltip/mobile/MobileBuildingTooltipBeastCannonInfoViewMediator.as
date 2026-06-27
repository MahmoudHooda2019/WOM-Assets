package wom.view.mediator.ui.mainframe.city.tooltip.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.GameTickEvent;
   import wom.model.game.CityStatusInfo;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipBeastCannonInfoView;
   
   public class MobileBuildingTooltipBeastCannonInfoViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBuildingTooltipBeastCannonInfoView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileBuildingTooltipBeastCannonInfoViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         updateView();
         addContextListener("tick",onTick);
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         if(view.ammoProgressBar.value != city.beastCannonInfo.ammoAmount)
         {
            view.ammoProgressBar.label = city.beastCannonInfo.ammoAmount + "/" + view.maxAmmo;
            view.ammoProgressBar.value = city.beastCannonInfo.ammoAmount;
         }
      }
   }
}

