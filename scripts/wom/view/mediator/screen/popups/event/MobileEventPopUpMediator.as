package wom.view.mediator.screen.popups.event
{
   import peak.config.DocumentConfiguration;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.event.MobileEventPopUp;
   
   public class MobileEventPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileEventPopUp;
      
      [Inject]
      public var documentConfiguration:DocumentConfiguration;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileEventPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.tabBar,"change",onTabChanged,Event);
         addContextListener("eventPointsUpdated",onEventPointsUpdated,ModelUpdateEvent);
         view.updateEP(userInfo.eventPoints);
         addContextListener("tick",onTick);
      }
      
      private function onTabChanged(param1:Event) : void
      {
         if(view.tabBar.selectedIndex != -1)
         {
            view.activateTabByIndex(view.tabBar.selectedIndex);
         }
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         if(userInfo.eventEndTime <= 0)
         {
            removeContextListener("tick",onTick);
            closeWindow();
         }
      }
      
      private function onEventPointsUpdated(param1:ModelUpdateEvent) : void
      {
         view.updateEP(userInfo.eventPoints);
      }
   }
}

