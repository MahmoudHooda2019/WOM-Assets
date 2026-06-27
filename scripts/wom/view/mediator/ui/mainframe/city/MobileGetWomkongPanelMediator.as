package wom.view.mediator.ui.mainframe.city
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.view.screen.windows.tavern.MobileTavernWindow;
   import wom.view.ui.mainframe.city.MobileGetWomkongPanel;
   
   public class MobileGetWomkongPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileGetWomkongPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileGetWomkongPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         view.updateWomkongUnlockStatus(domainInfo.getBeast(33).unlocked);
         eventMap.mapStarlingListener(view.getWomkongButton,"triggered",onViewClicked,Event);
         addContextListener("beastUpdated",onUnlockedBeastsUpdated,ModelUpdateEvent);
      }
      
      private function onUnlockedBeastsUpdated(param1:ModelUpdateEvent) : void
      {
         view.updateWomkongUnlockStatus(domainInfo.getBeast(33).unlocked);
      }
      
      private function onViewClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileTavernWindow()));
      }
   }
}

