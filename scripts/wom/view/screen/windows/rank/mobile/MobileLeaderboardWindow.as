package wom.view.screen.windows.rank.mobile
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.view.screen.windows.alliance.mobile.MobileLeaderboardBrowseAllianceListPanel;
   import wom.view.screen.windows.league.mobile.MobileLeaguePanel;
   import wom.view.util.MobileButtonTabbedFullscreenWindow;
   
   public class MobileLeaderboardWindow extends MobileButtonTabbedFullscreenWindow
   {
      
      private var _leaguesButton:MPButton;
      
      private var _bpButton:MPButton;
      
      private var _xpButton:MPButton;
      
      private var _alliancesButton:MPButton;
      
      private var _lootersButton:MPButton;
      
      public function MobileLeaderboardWindow()
      {
         super(false);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = this;
         var _loc1_:String = "m.ui.windows.leaderboard.leagues.header";
         _leaguesButton = createTabButton(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc1_),null,true,42);
         var _temp_4:* = this;
         var _loc2_:String = "m.ui.windows.leaderboard.playerscores.header";
         _bpButton = createTabButton(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,true,42);
         var _temp_7:* = this;
         var _loc3_:String = "m.ui.windows.leaderboard.xpranking.header";
         _xpButton = createTabButton(_temp_7,peak.i18n.PText.INSTANCE.getText0(_loc3_),null,true,42);
         var _temp_10:* = this;
         var _loc4_:String = "m.ui.windows.leaderboard.alliance.header";
         _alliancesButton = createTabButton(_temp_10,peak.i18n.PText.INSTANCE.getText0(_loc4_),null,true,42);
         var _temp_13:* = this;
         var _loc5_:String = "m.ui.windows.leaderboard.weeklylooters.header";
         _lootersButton = createTabButton(_temp_13,peak.i18n.PText.INSTANCE.getText0(_loc5_),null,true,42);
         addTab(this,_leaguesButton,new MobileLeaguePanel(),_windowWidth - 998 >> 1,91);
         addTab(this,_xpButton,new MobileXPRankingPanel());
         addTab(this,_bpButton,new MobilePlayerScoresPanel());
         addTab(this,_alliancesButton,new MobileLeaderboardBrowseAllianceListPanel());
         addTab(this,_lootersButton,new MobileTopLootersPanel());
         drawLayout();
         activateTabByButton(_leaguesButton);
      }
      
      override protected function determineTabPosition(param1:Sprite, param2:Object = null, param3:Object = null) : void
      {
         super.determineTabPosition(param1,param2 != null ? param2 : _windowWidth - 998 >> 1,param3 != null ? param3 : 96);
      }
      
      private function drawLayout() : void
      {
         _leaguesButton.x = 8;
         _leaguesButton.y = 8;
         MobileAlignmentUtil.alignRightOf(_bpButton,_leaguesButton,7);
         MobileAlignmentUtil.alignRightOf(_xpButton,_bpButton,7);
         MobileAlignmentUtil.alignRightOf(_alliancesButton,_xpButton,7);
         MobileAlignmentUtil.alignRightOf(_lootersButton,_alliancesButton,7);
      }
      
      public function updateAllianceButtonEnabling(param1:Boolean) : void
      {
         _alliancesButton.isEnabled = param1;
      }
      
      public function get leaguesButton() : MPButton
      {
         return _leaguesButton;
      }
   }
}

