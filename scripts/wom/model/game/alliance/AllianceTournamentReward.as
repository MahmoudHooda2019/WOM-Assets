package wom.model.game.alliance
{
   public class AllianceTournamentReward
   {
      
      public function AllianceTournamentReward()
      {
         super();
      }
      
      public static function getAllianceTournamentReward(param1:int) : int
      {
         if(param1 == 1)
         {
            return 500;
         }
         if(param1 == 2)
         {
            return 400;
         }
         if(param1 == 3)
         {
            return 300;
         }
         if(param1 > 3 && param1 < 11)
         {
            return 200;
         }
         if(param1 > 10 && param1 < 26)
         {
            return 150;
         }
         if(param1 > 25 && param1 < 51)
         {
            return 100;
         }
         return 0;
      }
   }
}

