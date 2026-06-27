package wom.view.screen.windows.rank
{
   import wom.model.game.rank.RankingSortCriteria;
   
   public class PlayerXPRankingPanel extends BaseRankingPanel
   {
      
      public function PlayerXPRankingPanel()
      {
         super();
         _criterion = RankingSortCriteria.XP;
      }
      
      override public function updateCriterion() : void
      {
         _criterion = _allTimeRadio.selected ? RankingSortCriteria.XP : (_dailyRadio.selected ? RankingSortCriteria.DAILY_XP : (_weeklyRadio.selected ? RankingSortCriteria.WEEKLY_XP : RankingSortCriteria.INVALID_CRITERION));
      }
   }
}

