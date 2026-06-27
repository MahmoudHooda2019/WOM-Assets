package wom.util
{
   public class MathContext
   {
      
      public static const NOTATION_PLAIN:int = 0;
      
      public static const NOTATION_SCIENTIFIC:int = 1;
      
      public static const NOTATION_ENGINEERING:int = 2;
      
      public static const ROUND_CEILING:int = 2;
      
      public static const ROUND_DOWN:int = 1;
      
      public static const ROUND_FLOOR:int = 3;
      
      public static const ROUND_HALF_DOWN:int = 5;
      
      public static const ROUND_HALF_EVEN:int = 6;
      
      public static const ROUND_HALF_UP:int = 4;
      
      public static const ROUND_UNNECESSARY:int = 7;
      
      public static const ROUND_UP:int = 0;
      
      private static const DEFAULT_FORM:int = 1;
      
      private static const DEFAULT_DIGITS:int = 9;
      
      private static const DEFAULT_LOSTDIGITS:Boolean = false;
      
      private static const DEFAULT_ROUNDINGMODE:int = 4;
      
      private static const MIN_DIGITS:int = 0;
      
      private static const MAX_DIGITS:int = 999999999;
      
      private static const ROUNDS:Array = [4,7,2,1,3,5,6,0];
      
      private static const ROUNDWORDS:Array = ["ROUND_HALF_UP","ROUND_UNNECESSARY","ROUND_CEILING","ROUND_DOWN","ROUND_FLOOR","ROUND_HALF_DOWN","ROUND_HALF_EVEN","ROUND_UP"];
      
      public static const DEFAULT:MathContext = new MathContext(9,1,false,4);
      
      public static const PLAIN:MathContext = new MathContext(0,0);
      
      internal var digits:int;
      
      internal var form:int;
      
      internal var lostDigits:Boolean;
      
      internal var roundingMode:int;
      
      public function MathContext(param1:int, param2:int = 1, param3:Boolean = false, param4:int = 4)
      {
         super();
         if(param1 != 9)
         {
            if(param1 < 0)
            {
               throw new Error("Digits too small: " + param1);
            }
            if(param1 > 999999999)
            {
               throw new Error("Digits too large: " + param1);
            }
         }
         if(param2 != 1)
         {
            if(param2 != 2)
            {
               if(param2 != 0)
               {
                  throw new Error("Bad form value: " + param2);
               }
            }
         }
         if(!isValidRound(param4))
         {
            throw new Error("Bad roundingMode value: " + param4);
         }
         digits = param1;
         form = param2;
         lostDigits = param3;
         roundingMode = param4;
      }
      
      private static function isValidRound(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(ROUNDS.length);
         _loc3_ = 0;
         while(_loc2_ > 0)
         {
            if(param1 == ROUNDS[_loc3_])
            {
               return true;
            }
            _loc2_--;
            _loc3_++;
         }
         return false;
      }
      
      public function getDigits() : int
      {
         return digits;
      }
      
      public function getForm() : int
      {
         return form;
      }
      
      public function getLostDigits() : Boolean
      {
         return lostDigits;
      }
      
      public function getRoundingMode() : int
      {
         return roundingMode;
      }
      
      public function toString() : String
      {
         var _loc4_:String = null;
         var _loc2_:int = 0;
         var _loc1_:String = null;
         if(form == 1)
         {
            _loc4_ = "SCIENTIFIC";
         }
         else if(form == 2)
         {
            _loc4_ = "ENGINEERING";
         }
         else
         {
            _loc4_ = "PLAIN";
         }
         var _loc3_:int = int(ROUNDS.length);
         _loc2_ = 0;
         while(_loc3_ > 0)
         {
            if(roundingMode == ROUNDS[_loc2_])
            {
               _loc1_ = ROUNDWORDS[_loc2_];
               break;
            }
            _loc3_--;
            _loc2_++;
         }
         return "digits=" + digits + " " + "form=" + _loc4_ + " " + "lostDigits=" + (lostDigits ? "1" : "0") + " " + "roundingMode=" + _loc1_;
      }
   }
}

