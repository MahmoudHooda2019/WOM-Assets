package wom.view.mediator.screen.windows.beast.cave
{
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.beast.BeastActionEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.beast.cave.MobileBeastPanel;
   
   public class MobileBeastPanelMediator extends MobileBaseWindowPanelMediator
   {
      
      [Inject]
      public var view:MobileBeastPanel;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileBeastPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         updateBeast();
         eventMap.mapStarlingListener(view.healButton,"triggered",onHealClicked,Event);
         addContextListener("beastUpdated",onBeastUpdated,ModelUpdateEvent);
         addContextListener("beastHealthUpdated",onBeastHealthUpdated,ModelUpdateEvent);
      }
      
      private function updateBeast() : void
      {
         if(city.beast != null)
         {
            view.updateBeast(city.beast,domainInfo.getBeast(city.beast.typeId));
         }
      }
      
      private function onBeastUpdated(param1:ModelUpdateEvent) : void
      {
         updateBeast();
      }
      
      private function onBeastHealthUpdated(param1:ModelUpdateEvent) : void
      {
         if(city.beast != null)
         {
            view.updateCurrentHealth(city.beast,domainInfo.getBeast(city.beast.typeId));
         }
      }
      
      private function onHealClicked(param1:Event) : void
      {
         if(userInfo.numberOfGolds < view.goldCostForHealing)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
            return;
         }
         dispatch(new BeastActionEvent("beastAction","heal"));
      }
   }
}

