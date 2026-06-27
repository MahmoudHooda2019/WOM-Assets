package wom.view.screen.windows.alliance.mobile
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.alliance.AllianceMemberListColumnType;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileListHeaderView;
   
   public class MobileMyAllianceMembersPanel extends MobileAllianceMembersPanel
   {
      
      public static const HEADER_WIDTH_KEY_CONTRIBUTION_POINTS:String = "contribution_points";
      
      private var _headerContributionPoints:MobileListHeaderView;
      
      public function MobileMyAllianceMembersPanel(param1:int, param2:Boolean = false)
      {
         super(param1,param2);
      }
      
      override protected function initHeaderWidths() : void
      {
         headerWidths["level"] = 90;
         headerWidths["name"] = 181;
         headerWidths["contribution_points"] = 120;
         headerWidths["battle_points"] = 100;
         headerWidths["actions"] = 474;
      }
      
      override protected function createHeaders() : void
      {
         super.createHeaders();
         var _temp_2:* = §§findproperty(MobileListHeaderView);
         var _temp_1:* = true;
         var _loc1_:String = "m.ui.windows.alliance.members.filter.contributionpoints";
         _headerContributionPoints = new MobileListHeaderView(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc1_),headerWidths["contribution_points"],AllianceMemberListColumnType.CONTRIBUTION_POINTS,0,null,1,getCaptionTextFormat(17,"center"));
         addChild(_headerContributionPoints);
         headers.push(_headerContributionPoints);
         var _temp_4:* = _headerBattlePoints;
         var _loc2_:String = "m.ui.windows.alliance.members.filter.tournamentcontribution";
         _temp_4.updateListHeaderViewText(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         _headerBattlePoints.columnType = AllianceMemberListColumnType.TOURNAMENT_CONTRIBUTION_POINTS;
      }
      
      override protected function initSort() : void
      {
         members.sort(AllianceMemberListColumnType.CONTRIBUTION_POINTS_LEADER_FIRST.dscComperator);
      }
      
      override protected function alignHeaders() : void
      {
         super.alignHeaders();
         var _loc1_:int = 0;
         MobileAlignmentUtil.alignRightOf(_headerContributionPoints,_headerName,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerBattlePoints,_headerContributionPoints,_loc1_);
         MobileAlignmentUtil.alignRightOf(headerActions,_headerBattlePoints,_loc1_);
         MobileAlignmentUtil.alignRightOf(rightRoundHeaderFill,headerActions,_loc1_ + rightRoundHeaderFill.width);
      }
      
      public function get headerContributionPoints() : MobileListHeaderView
      {
         return _headerContributionPoints;
      }
   }
}

