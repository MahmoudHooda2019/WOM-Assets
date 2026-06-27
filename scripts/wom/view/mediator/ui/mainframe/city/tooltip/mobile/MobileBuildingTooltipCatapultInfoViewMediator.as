package wom.view.mediator.ui.mainframe.city.tooltip.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.GameTickEvent;
   import wom.model.game.UserInfo;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipCatapultInfoView;
   
   public class MobileBuildingTooltipCatapultInfoViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBuildingTooltipCatapultInfoView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileBuildingTooltipCatapultInfoViewMediator()
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
         view.updateWithData(userInfo.catapultActivationRemainingTimes,view.buildingLevel);
      }
   }
}

