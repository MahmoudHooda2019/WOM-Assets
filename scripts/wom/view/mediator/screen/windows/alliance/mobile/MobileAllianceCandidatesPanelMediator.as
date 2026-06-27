package wom.view.mediator.screen.windows.alliance.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.SearchAllianceCandidateEvent;
   import wom.model.message.request.alliance.GetAllianceCandidatesRequest;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceCandidatesPanel;
   
   public class MobileAllianceCandidatesPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileAllianceCandidatesPanel;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileAllianceCandidatesPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("searchedAllianceCandidatesUpdated",onSearchedCandidatesUpdated,ModelUpdateEvent);
         addContextListener("myAllianceCandidatesUpdated",onCandidatesUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.searchButton,"triggered",onSearchButtonClicked,Event);
         eventMap.mapStarlingListener(view.cancelSearchButton,"triggered",onSearchCancelButtonClicked,Event);
      }
      
      private function onSearchButtonClicked(param1:Event) : void
      {
         var _loc2_:String = view.searchTextInput.text;
         if(_loc2_ && _loc2_ != "" && !isNaN(Number(_loc2_)))
         {
            dispatch(new SearchAllianceCandidateEvent("searchUser",_loc2_));
         }
      }
      
      private function onSearchCancelButtonClicked(param1:Event) : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAllianceCandidatesRequest()));
         view.activateCandidatesListPanel();
      }
      
      private function onSearchedCandidatesUpdated(param1:ModelUpdateEvent) : void
      {
         view.activateSearchedCandidatesPanel();
      }
      
      private function onCandidatesUpdated(param1:ModelUpdateEvent) : void
      {
         view.activateCandidatesListPanel();
      }
   }
}

