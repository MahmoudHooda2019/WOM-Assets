package wom.view.mediator.ui.mainframe.city.mobile
{
   import wom.view.ui.mainframe.city.mobile.MCOVCityPlannerView;
   
   public class MCOVCityPlannerViewMediator extends MCOVEnterViewMediator
   {
      
      [Inject]
      public var cityPlannerView:MCOVCityPlannerView;
      
      public function MCOVCityPlannerViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
      }
   }
}

