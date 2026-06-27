package wom.view.screen.windows.alliance
{
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.AllianceMemberListColumnType;
   import wom.view.ui.common.ListHeaderView;
   
   public class MyAllianceMembersPanel extends AllianceMembersPanel
   {
      
      public static const HEADER_WIDTH_KEY_CONTRIBUTION_POINTS:String = "contribution_points";
      
      private var _headerContributionPoints:ListHeaderView;
      
      public function MyAllianceMembersPanel()
      {
         super();
      }
      
      override protected function initHeaderWidths() : void
      {
         headerWidths["level"] = 70;
         headerWidths["name"] = 165;
         headerWidths["contribution_points"] = 102;
         headerWidths["battle_points"] = 104;
         headerWidths["actions"] = 210;
      }
      
      override protected function createHeaders() : void
      {
         super.createHeaders();
         var _temp_2:* = §§findproperty(ListHeaderView);
         var _temp_1:* = true;
         var _loc1_:String = "ui.windows.alliance.members.filter.contributionpoints";
         _headerContributionPoints = new ListHeaderView(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc1_),headerWidths["contribution_points"],22,AllianceMemberListColumnType.CONTRIBUTION_POINTS);
         addChild(_headerContributionPoints);
         headers.push(_headerContributionPoints);
         var _temp_4:* = _headerBattlePoints;
         var _loc2_:String = "ui.windows.alliance.members.filter.tournamentcontribution";
         _temp_4.updateListHeaderViewText(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         _headerBattlePoints.columnType = AllianceMemberListColumnType.TOURNAMENT_CONTRIBUTION_POINTS;
      }
      
      override protected function initSort() : void
      {
         members.sort(AllianceMemberListColumnType.CONTRIBUTION_POINTS_LEADER_FIRST.dscComperator);
      }
      
      override protected function alignHeaders() : void
      {
         var _loc1_:int = 1;
         AlignmentUtil.alignAccordingToPositionOf(headerLevel,bg,3,4);
         AlignmentUtil.alignRightOf(headerName,headerLevel,_loc1_);
         AlignmentUtil.alignRightOf(_headerContributionPoints,headerName,_loc1_);
         AlignmentUtil.alignRightOf(headerBattlePoints,_headerContributionPoints,_loc1_);
         AlignmentUtil.alignRightOf(headerActions,headerBattlePoints,_loc1_);
      }
      
      public function get headerContributionPoints() : ListHeaderView
      {
         return _headerContributionPoints;
      }
   }
}

