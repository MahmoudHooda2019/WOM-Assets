package wom.view.screen.windows.rank.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import wom.model.game.rank.RankingSortCriteria;
   
   public class MobileXPRankingPanel extends MobileBaseRankingPanel
   {
      
      public function MobileXPRankingPanel()
      {
         super();
         _criterion = RankingSortCriteria.XP;
      }
      
      override protected function rankingViewRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileRankingViewRenderer = new MobileRankingViewRenderer(assetRepository,_ownGameId,2);
         _loc1_.width = _rankingList.width;
         _loc1_.height = 101;
         return _loc1_;
      }
      
      override public function updateCriterion() : void
      {
         if(_tabBar && _tabBar.selectedIndex != -1)
         {
            _criterion = _tabBar.selectedIndex == 1 ? RankingSortCriteria.WEEKLY_XP : (_tabBar.selectedIndex == 2 ? RankingSortCriteria.DAILY_XP : RankingSortCriteria.XP);
         }
         else
         {
            _criterion = RankingSortCriteria.XP;
         }
      }
   }
}

