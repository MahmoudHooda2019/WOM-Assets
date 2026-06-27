package wom.view.mediator.screen.windows.alliance.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.BrowseAllianceEvent;
   import wom.controller.event.alliance.MyAllianceEvent;
   import wom.model.message.request.alliance.GetAllianceMemberConstributionsRequest;
   import wom.view.screen.windows.alliance.mobile.MobileAlliancePanel;
   
   public class MobileAlliancePanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileAlliancePanel;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileAlliancePanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.tabBar,"change",onTabChanged,Event);
         eventMap.mapStarlingListener(view.backToAlliancesButton,"triggered",onBackToAlliances,Event);
         addContextListener("navigateMyAllianceGeneralInfo",onGeneralInfoEvent,MyAllianceEvent);
         addContextListener("navigateMyAllianceMembers",onMembersEvent,MyAllianceEvent);
         addContextListener("editAlliance",onEditEvent,MyAllianceEvent);
      }
      
      private function onBackToAlliances(param1:Event) : void
      {
         dispatch(new BrowseAllianceEvent("backToAlliances",null));
      }
      
      protected function onTabChanged(param1:Event) : void
      {
         switch(view.tabBar.selectedIndex)
         {
            case 0:
               onGeneralInfoTabClicked(param1);
               break;
            case 1:
               onMyAllianceMembersTabClicked(param1);
         }
      }
      
      private function onGeneralInfoTabClicked(param1:Event) : void
      {
         view.activateGeneralInfoTab();
      }
      
      private function onMyAllianceMembersTabClicked(param1:Event) : void
      {
         view.activateAllianceMembersTab();
         if(!view.fromBrowseTab)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAllianceMemberConstributionsRequest()));
         }
      }
      
      private function onGeneralInfoEvent(param1:MyAllianceEvent) : void
      {
         if(view.tabBar)
         {
            view.tabBar.selectedIndex = 0;
         }
         onGeneralInfoTabClicked(null);
      }
      
      private function onMembersEvent(param1:MyAllianceEvent) : void
      {
         if(view.tabBar)
         {
            view.tabBar.selectedIndex = 1;
         }
         onMyAllianceMembersTabClicked(null);
      }
      
      private function onEditEvent(param1:MyAllianceEvent) : void
      {
         editButtonClicked();
      }
      
      private function editButtonClicked() : void
      {
         if(view.tabBar)
         {
            view.tabBar.selectedIndex = 0;
         }
         view.updateVisibilityOfEditPanel(true);
      }
   }
}

