package wom.view.mediator.ui.mainframe.city.mobile
{
   import wom.view.ui.mainframe.city.mobile.MCOVCatapultView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipCatapultInfoView;
   
   public class MCOVCatapultViewMediator extends MCOVEnterViewMediator
   {
      
      [Inject]
      public var catapultView:MCOVCatapultView;
      
      public function MCOVCatapultViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         catapultView.addInfoView(new MobileBuildingTooltipCatapultInfoView(buildingInfo.level));
      }
   }
}

