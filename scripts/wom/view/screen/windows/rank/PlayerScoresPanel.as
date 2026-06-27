package wom.view.screen.windows.rank
{
   import wom.model.game.rank.RankingSortCriteria;
   
   public class PlayerScoresPanel extends BaseRankingPanel
   {
      
      public function PlayerScoresPanel()
      {
         super();
         _criterion = RankingSortCriteria.BP;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
      }
      
      override public function updateCriterion() : void
      {
         _criterion = _allTimeRadio.selected ? RankingSortCriteria.BP : (_dailyRadio.selected ? RankingSortCriteria.DAILY_BP : (_weeklyRadio.selected ? RankingSortCriteria.WEEKLY_BP : RankingSortCriteria.INVALID_CRITERION));
      }
   }
}

