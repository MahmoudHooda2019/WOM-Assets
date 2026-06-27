package wom.view.screen.windows.rank
{
   import wom.model.game.rank.RankingSortCriteria;
   
   public class TopLootersPanel extends BaseRankingPanel
   {
      
      public function TopLootersPanel()
      {
         super();
         _criterion = RankingSortCriteria.LOOT;
      }
      
      override public function updateCriterion() : void
      {
         _criterion = _allTimeRadio.selected ? RankingSortCriteria.LOOT : (_dailyRadio.selected ? RankingSortCriteria.DAILY_LOOT : (_weeklyRadio.selected ? RankingSortCriteria.WEEKLY_LOOT : RankingSortCriteria.INVALID_CRITERION));
      }
   }
}

