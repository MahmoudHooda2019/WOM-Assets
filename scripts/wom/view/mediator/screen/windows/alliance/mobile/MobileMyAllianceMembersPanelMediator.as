package wom.view.mediator.screen.windows.alliance.mobile
{
   import starling.events.TouchEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.view.screen.windows.alliance.mobile.MobileMyAllianceMembersPanel;
   
   public class MobileMyAllianceMembersPanelMediator extends MobileAllianceMembersPanelMediator
   {
      
      [Inject]
      public var myAllianceMembersPanel:MobileMyAllianceMembersPanel;
      
      public function MobileMyAllianceMembersPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         if(view.membersList.dataProvider == null || view.membersList.dataProvider.length <= 0)
         {
            myAllianceMembersRankingInfoUpdated();
         }
         eventMap.mapStarlingListener(myAllianceMembersPanel.headerContributionPoints,"touch",onHeaderClicked,TouchEvent);
      }
      
      override protected function mapAllianceMemberListeners() : void
      {
         addContextListener("myAllianceMembersRankingInfoUpdated",onMyAllianceMembersRankingInfoUpdated,ModelUpdateEvent);
      }
      
      private function onMyAllianceMembersRankingInfoUpdated(param1:ModelUpdateEvent) : void
      {
         if(!view.fromBrowseTab)
         {
            myAllianceMembersRankingInfoUpdated();
         }
      }
      
      private function myAllianceMembersRankingInfoUpdated() : void
      {
         if(allianceInfo.myAllianceMembersRankingInfo != null)
         {
            view.updateWithMembers(allianceInfo.myAllianceMembersRankingInfo.members);
         }
      }
   }
}

