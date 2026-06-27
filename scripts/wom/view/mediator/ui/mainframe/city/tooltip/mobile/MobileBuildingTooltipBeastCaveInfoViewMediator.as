package wom.view.mediator.ui.mainframe.city.tooltip.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipBeastCaveInfoView;
   
   public class MobileBuildingTooltipBeastCaveInfoViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBuildingTooltipBeastCaveInfoView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileBuildingTooltipBeastCaveInfoViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         view.updateBeastInfo(city.beast);
      }
   }
}

