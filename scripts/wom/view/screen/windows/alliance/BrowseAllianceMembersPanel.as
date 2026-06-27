package wom.view.screen.windows.alliance
{
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.view.util.BaseWindowPanel;
   
   public class BrowseAllianceMembersPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 665;
      
      private static const HEIGHT:int = 443;
      
      private var _alliance:AllianceDetailInfo;
      
      private var _membersPanel:BrowseAllianceMembersListPanel;
      
      public function BrowseAllianceMembersPanel(param1:AllianceDetailInfo = null)
      {
         super(665,443);
         _alliance = param1;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _membersPanel = new BrowseAllianceMembersListPanel();
         addChild(_membersPanel);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_membersPanel,bg,2,46);
         super.drawLayout();
      }
      
      public function update(param1:AllianceDetailInfo) : void
      {
         _alliance = param1;
         drawLayout();
      }
      
      public function get alliance() : AllianceDetailInfo
      {
         return _alliance;
      }
      
      public function get membersPanel() : BrowseAllianceMembersListPanel
      {
         return _membersPanel;
      }
   }
}

