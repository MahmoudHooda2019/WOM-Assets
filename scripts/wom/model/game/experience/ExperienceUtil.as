package wom.model.game.experience
{
   public class ExperienceUtil
   {
      
      public static const EXPERIENCE_BARRIER:int = 7500;
      
      public static const LEVEL_BARRIER:int = 5;
      
      public static const EXPERIENCE_CONSTANT:Number = 1.4;
      
      public function ExperienceUtil()
      {
         super();
      }
      
      public static function calculateLevelOfExperience(param1:Number) : int
      {
         if(param1 >= 7500)
         {
            return Math.log(param1 / 7500) / Math.log(1.4) + 5 << 0;
         }
         if(5000 <= param1 && param1 < 7500)
         {
            return 4;
         }
         if(3500 <= param1 && param1 < 5000)
         {
            return 3;
         }
         if(900 <= param1 && param1 < 3500)
         {
            return 2;
         }
         return 1;
      }
      
      public static function calculateExperienceOfLevel(param1:int) : Number
      {
         if(param1 >= 5)
         {
            return 7500 * Math.pow(1.4,param1 - 5);
         }
         if(param1 == 4)
         {
            return 5000;
         }
         if(param1 == 3)
         {
            return 3500;
         }
         if(param1 == 2)
         {
            return 900;
         }
         return 0;
      }
   }
}

