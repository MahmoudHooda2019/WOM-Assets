package wom.view.mediator.screen.windows.alliance.mobile
{
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.alliance.AllianceVisitEvent;
   import wom.controller.event.alliance.AllianceWindowTabChangeEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.visit.StartVisitEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.mediator.util.MobileButtonTabbedWindowMediator;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceTipsPopUp;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceWindow;
   
   public class MobileAllianceWindowMediator extends MobileButtonTabbedWindowMediator
   {
      
      [Inject]
      public var view:MobileAllianceWindow;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function MobileAllianceWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.helpButton,"triggered",onHintClicked,Event);
         addContextListener("changeAllianceTab",changeAllianceTab,AllianceWindowTabChangeEvent);
         addContextListener("allianceSummaryUpdated",allianceSummaryUpdated,ModelUpdateEvent);
         addContextListener("allianceVisit",onAllianceVisit,AllianceVisitEvent);
         view.updateTabsWithAllianceInfo(allianceInfo);
      }
      
      private function onHintClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileAllianceTipsPopUp()));
      }
      
      private function changeAllianceTab(param1:AllianceWindowTabChangeEvent) : void
      {
         if(param1.tabIndex != -1)
         {
            view.activateTabByIndex(param1.tabIndex);
         }
      }
      
      private function allianceSummaryUpdated(param1:ModelUpdateEvent) : void
      {
         view.updateTabsWithAllianceInfo(allianceInfo);
      }
      
      private function onAllianceVisit(param1:AllianceVisitEvent) : void
      {
         allianceInfo.windowLastState = new WindowEnumeration(0,{"womview":view});
         dispatch(new StartVisitEvent("startVisit",param1.profile,false,true));
      }
   }
}

