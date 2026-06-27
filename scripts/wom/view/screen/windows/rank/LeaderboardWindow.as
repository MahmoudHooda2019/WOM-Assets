package wom.view.screen.windows.rank
{
   import fl.data.DataProvider;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import wom.view.component.WomTabBar;
   import wom.view.screen.windows.alliance.LeaderboardBrowseAllianceListPanel;
   import wom.view.screen.windows.league.LeaguePanel;
   import wom.view.util.GenericWindow;
   
   public class LeaderboardWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 645;
      
      private static const WINDOW_HEIGHT:int = 546;
      
      private var _tabBar:WomTabBar;
      
      private var _tabPanels:Dictionary;
      
      private var _activePanel:Sprite;
      
      private var _initialTabIndex:int;
      
      public function LeaderboardWindow(param1:int = 0, param2:int = 645, param3:int = 546)
      {
         super(param2,param3);
         _tabPanels = new Dictionary();
         _initialTabIndex = param1;
      }
      
      private function addTab(param1:int, param2:Sprite) : void
      {
         _tabPanels[param1] = param2;
         param2.x = 21;
         param2.y = 80;
         param2.visible = false;
         addChild(param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.leaderboard.title";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         addTab(0,new LeaguePanel());
         addTab(1,new PlayerScoresPanel());
         addTab(2,new PlayerXPRankingPanel());
         addTab(3,new TopLootersPanel());
         addTab(4,new LeaderboardBrowseAllianceListPanel());
         _tabBar = new WomTabBar(110);
         _tabBar.x = 28;
         _tabBar.y = 37;
         var _temp_8:* = _tabBar;
         var _temp_7:* = §§findproperty(DataProvider);
         var _loc2_:String = "ui.windows.leaderboard.leagues.header";
         var _temp_6:* = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         var _loc3_:String = "ui.windows.leaderboard.playerscores.header";
         var _temp_5:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         var _loc4_:String = "ui.windows.leaderboard.xpranking.header";
         var _temp_4:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc5_:String = "ui.windows.leaderboard.weeklylooters.header";
         var _temp_3:* = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         var _loc6_:String = "ui.windows.leaderboard.alliance.header";
         _temp_8.dataProvider = new DataProvider([_temp_6,_temp_5,_temp_4,_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc6_)]);
         addChild(_tabBar);
         drawLayout();
      }
      
      public function activateTabByIndex(param1:int) : void
      {
         _tabBar.selectedIndex = param1;
         activatePanel(_tabPanels[param1]);
      }
      
      public function activatePanel(param1:Sprite) : void
      {
         if(_activePanel != null)
         {
            _activePanel.visible = false;
         }
         _activePanel = param1;
         _activePanel.visible = true;
      }
      
      public function drawLayout() : void
      {
      }
      
      public function get tabBar() : WomTabBar
      {
         return _tabBar;
      }
      
      public function get initialTabIndex() : int
      {
         return _initialTabIndex;
      }
   }
}

