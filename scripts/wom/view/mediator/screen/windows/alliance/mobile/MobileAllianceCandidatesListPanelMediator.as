package wom.view.mediator.screen.windows.alliance.mobile
{
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.game.alliance.AllianceRoleType;
   import wom.model.message.request.alliance.GetAllianceCandidatesRequest;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceCandidatesListPanel;
   
   public class MobileAllianceCandidatesListPanelMediator extends MobileAllianceMembersPanelMediator
   {
      
      [Inject]
      public var candidatesListPanel:MobileAllianceCandidatesListPanel;
      
      public function MobileAllianceCandidatesListPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("allianceSummaryUpdated",onAllianceSummaryUpdated,ModelUpdateEvent);
         if(view.membersList.dataProvider == null || view.membersList.dataProvider.length <= 0)
         {
            getCandidates();
         }
      }
      
      override protected function mapAllianceMemberListeners() : void
      {
         if(candidatesListPanel.isSearchedCandidatesPanel)
         {
            addContextListener("searchedAllianceCandidatesUpdated",onSearchedCandidatesUpdated,ModelUpdateEvent);
         }
         else
         {
            addContextListener("myAllianceCandidatesUpdated",onCandidatesUpdated,ModelUpdateEvent);
         }
      }
      
      private function getCandidates() : void
      {
         if(!candidatesListPanel.isSearchedCandidatesPanel && allianceInfo.myAllianceSummary && allianceInfo.myAllianceSummary.role == AllianceRoleType.LEADER)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAllianceCandidatesRequest()));
         }
      }
      
      private function onAllianceSummaryUpdated(param1:ModelUpdateEvent) : void
      {
         getCandidates();
      }
      
      private function onCandidatesUpdated(param1:ModelUpdateEvent) : void
      {
         if(allianceInfo.myAllianceCandidates)
         {
            view.updateWithMembers(allianceInfo.myAllianceCandidates.members);
         }
      }
      
      private function onSearchedCandidatesUpdated(param1:ModelUpdateEvent) : void
      {
         if(allianceInfo.searchedAllianceCandidates)
         {
            view.updateWithMembers(allianceInfo.searchedAllianceCandidates.members);
         }
      }
   }
}

