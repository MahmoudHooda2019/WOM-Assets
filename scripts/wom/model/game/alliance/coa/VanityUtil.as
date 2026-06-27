package wom.model.game.alliance.coa
{
   public class VanityUtil
   {
      
      public static const PATTERN_ID_MIN:int = 0;
      
      public static const PATTERN_ID_MAX:int = 12;
      
      public static const PATTERN_ID_DEFAULT:int = 1;
      
      public function VanityUtil()
      {
         super();
      }
      
      public static function determinePatternId(param1:int) : int
      {
         return param1 >= 0 && param1 <= 12 ? param1 : 1;
      }
      
      public static function extractRed(param1:uint) : uint
      {
         return param1 >> 16 & 0xFF;
      }
      
      public static function extractGreen(param1:uint) : uint
      {
         return param1 >> 8 & 0xFF;
      }
      
      public static function extractBlue(param1:uint) : uint
      {
         return param1 & 0xFF;
      }
      
      public static function combineRGB(param1:uint, param2:uint, param3:uint) : uint
      {
         return param1 << 16 | param2 << 8 | param3;
      }
   }
}

