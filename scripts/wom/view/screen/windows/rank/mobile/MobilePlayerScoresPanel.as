package wom.view.screen.windows.rank.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import wom.model.game.rank.RankingSortCriteria;
   
   public class MobilePlayerScoresPanel extends MobileBaseRankingPanel
   {
      
      public function MobilePlayerScoresPanel()
      {
         super();
         _criterion = RankingSortCriteria.BP;
      }
      
      override public function updateCriterion() : void
      {
         if(_tabBar && _tabBar.selectedIndex != -1)
         {
            _criterion = _tabBar.selectedIndex == 1 ? RankingSortCriteria.WEEKLY_BP : (_tabBar.selectedIndex == 2 ? RankingSortCriteria.DAILY_BP : RankingSortCriteria.BP);
         }
         else
         {
            _criterion = RankingSortCriteria.BP;
         }
      }
      
      override protected function rankingViewRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileRankingViewRenderer = new MobileRankingViewRenderer(assetRepository,_ownGameId,1);
         _loc1_.width = _rankingList.width;
         _loc1_.height = 101;
         return _loc1_;
      }
   }
}

