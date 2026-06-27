package peak.util
{
   public class DateTimeUtil
   {
      
      public static const WEEKS:uint = 4;
      
      public static const DAYS:uint = 7;
      
      public static const HOURS:uint = 24;
      
      public static const MINUTES:uint = 60;
      
      public static const SECONDS:uint = 60;
      
      public static const MILLISECONDS:uint = 1000;
      
      public static const ONE_DAY_IN_MILLIS:uint = 86400000;
      
      private static var _serverTimeZoneInMillis:Number = 0;
      
      public function DateTimeUtil()
      {
         super();
      }
      
      public static function getFormattedTime(param1:Number, param2:String = ":") : String
      {
         var _loc5_:int = param1 / (1000 * 60 * 60);
         var _loc3_:int = param1 / (1000 * 60) % 60;
         var _loc4_:int = param1 / 1000 % 60;
         return leftPadOrCrop(_loc5_,2) + param2 + leftPadOrCrop(_loc3_,2) + param2 + leftPadOrCrop(_loc4_,2);
      }
      
      public static function getDaysFrom(param1:Number) : String
      {
         var _loc2_:Number = param1 / (1000 * 60 * 60);
         if(param1 == 0)
         {
            return "0";
         }
         return Math.ceil(_loc2_ / 24).toString();
      }
      
      public static function getWeeksFromDurationWithCeil(param1:Number) : String
      {
         return Math.ceil(param1 / (1000 * 60 * 60 * 24 * 7)).toString();
      }
      
      public static function getDaysFromDurationWithCeil(param1:Number) : String
      {
         return Math.ceil(param1 / (1000 * 60 * 60 * 24)).toString();
      }
      
      public static function getFormattedTimeWithoutCroppingHours(param1:Number, param2:String = ":") : String
      {
         var _loc5_:int = param1 / (1000 * 60 * 60);
         var _loc3_:int = param1 / (1000 * 60) % 60;
         var _loc4_:int = param1 / 1000 % 60;
         return leftPad(_loc5_,2) + param2 + leftPadOrCrop(_loc3_,2) + param2 + leftPadOrCrop(_loc4_,2);
      }
      
      public static function getUserFriendlyTime(param1:Number, param2:String = " ", param3:String = "d", param4:String = "h", param5:String = "m", param6:String = "s") : String
      {
         var _loc13_:int = param1 / (1000 * 60 * 60 * 24);
         var _loc9_:int = param1 / (1000 * 60 * 60) % 24;
         var _loc8_:int = param1 / (1000 * 60) % 60;
         var _loc14_:int = param1 / 1000 % 60;
         var _loc11_:String = _loc13_ > 0 ? _loc13_ + param3 : "";
         var _loc17_:String = _loc9_ > 0 ? _loc9_ + param4 : "";
         var _loc12_:String = _loc8_ > 0 ? _loc8_ + param5 : "";
         var _loc10_:String = _loc14_ > 0 ? _loc14_ + param6 : "";
         var _loc16_:String = _loc11_ != "" && (_loc17_ != "" || _loc12_ != "" || _loc10_ != "") ? param2 : "";
         var _loc15_:String = _loc17_ != "" && (_loc12_ != "" || _loc10_ != "") ? param2 : "";
         var _loc7_:String = _loc12_ != "" && _loc10_ != "" ? param2 : "";
         return _loc11_ + _loc16_ + _loc17_ + _loc15_ + _loc12_ + _loc7_ + _loc10_;
      }
      
      public static function getUserFriendlyTimeWithoutSeconds(param1:Number, param2:String = " ", param3:String = "d", param4:String = "h", param5:String = "m") : String
      {
         var _loc8_:int = param1 / (1000 * 60 * 60 * 24);
         var _loc9_:int = param1 / (1000 * 60 * 60) % 24;
         var _loc7_:int = param1 / (1000 * 60) % 60;
         var _loc11_:String = _loc8_ > 0 ? _loc8_ + param3 : "";
         var _loc14_:String = _loc9_ > 0 ? _loc9_ + param4 : "";
         var _loc13_:String = _loc7_ > 0 ? _loc7_ + param5 : "";
         var _loc12_:String = _loc11_ != "" && (_loc14_ != "" || _loc13_ != "") ? param2 : "";
         var _loc10_:String = _loc14_ != "" && _loc13_ != "" ? param2 : "";
         var _loc6_:String = _loc13_ != "" ? param2 : "";
         return _loc11_ + _loc12_ + _loc14_ + _loc10_ + _loc13_ + _loc6_;
      }
      
      public static function getSimpleUserFriendlyTimeObject(param1:Number) : Object
      {
         var _loc3_:int = getMinutes(param1);
         if(_loc3_ < 60)
         {
            return {
               "key":"i",
               "val":_loc3_
            };
         }
         var _loc5_:int = getHours(param1);
         if(_loc5_ < 24)
         {
            return {
               "key":"h",
               "val":_loc5_
            };
         }
         var _loc4_:int = getDays(param1);
         if(_loc4_ < 2 * 7)
         {
            return {
               "key":"d",
               "val":_loc4_
            };
         }
         var _loc6_:int = getWeeks(param1);
         if(_loc6_ < 4)
         {
            return {
               "key":"w",
               "val":_loc6_
            };
         }
         var _loc2_:int = getMonths(param1);
         return {
            "key":"m",
            "val":_loc2_
         };
      }
      
      public static function getSeconds(param1:Number) : int
      {
         return param1 / 1000 >> 0;
      }
      
      public static function getMinutes(param1:Number) : int
      {
         return param1 / (1000 * 60) >> 0;
      }
      
      private static function getHours(param1:Number) : int
      {
         return getMinutes(param1) / 60 >> 0;
      }
      
      private static function getDays(param1:Number) : int
      {
         return getHours(param1) / 24 >> 0;
      }
      
      private static function getWeeks(param1:Number) : int
      {
         return getDays(param1) / 7 >> 0;
      }
      
      private static function getMonths(param1:Number) : int
      {
         return getWeeks(param1) / 4 >> 0;
      }
      
      public static function getUserFriendlyTimeFromSeconds(param1:Number, param2:String = " ", param3:String = "d", param4:String = "h", param5:String = "m", param6:String = "s") : String
      {
         return getUserFriendlyTime(param1 * 1000,param2,param3,param4,param5,param6);
      }
      
      public static function getFormattedTimeFromDate(param1:Date, param2:String = ":") : String
      {
         return leftPadOrCrop(param1.getHours(),2) + param2 + leftPadOrCrop(param1.getMinutes(),2) + param2 + leftPadOrCrop(param1.getSeconds(),2);
      }
      
      public static function getUTCFormattedTimeFromDate(param1:Date, param2:String = ":") : String
      {
         return leftPadOrCrop(param1.getUTCHours(),2) + param2 + leftPadOrCrop(param1.getUTCMinutes(),2) + param2 + leftPadOrCrop(param1.getUTCSeconds(),2);
      }
      
      public static function getFormattedTimeWithMillisecondsFromDate(param1:Date, param2:String = ":", param3:String = ".") : String
      {
         return getFormattedTimeFromDate(param1,param2) + param3 + leftPadOrCrop(param1.getMilliseconds(),3);
      }
      
      public static function getUTCFormattedTimeWithMillisecondsFromDate(param1:Date, param2:String = ":", param3:String = ".") : String
      {
         return getUTCFormattedTimeFromDate(param1,param2) + param3 + leftPadOrCrop(param1.getUTCMilliseconds(),3);
      }
      
      public static function getFormattedTimeAndDateWithMillisecondsFromDate(param1:Date, param2:String = ":", param3:String = ":", param4:String = ":", param5:String = ".") : String
      {
         return leftPadOrCrop(param1.getDate(),2) + param2 + leftPadOrCrop(param1.getMonth() + 1,2) + param2 + leftPadOrCrop(param1.getFullYear(),2) + param4 + getFormattedTimeWithMillisecondsFromDate(param1,param3,param5);
      }
      
      public static function getUTCFormattedTimeAndDateWithMillisecondsFromDate(param1:Date, param2:String = ":", param3:String = ":", param4:String = ":", param5:String = ".") : String
      {
         return leftPadOrCrop(param1.getUTCDate(),2) + param2 + leftPadOrCrop(param1.getUTCMonth() + 1,2) + param2 + leftPadOrCrop(param1.getUTCFullYear(),2) + param4 + getUTCFormattedTimeWithMillisecondsFromDate(param1,param3,param5);
      }
      
      public static function getFormattedTimeAndDateFromDate(param1:Date, param2:String = ".", param3:String = ":", param4:String = ":") : String
      {
         return leftPadOrCrop(param1.getDate(),2) + param2 + leftPadOrCrop(param1.getMonth() + 1,2) + param2 + leftPadOrCrop(param1.getFullYear(),2) + param4 + getFormattedTimeFromDate(param1,param3);
      }
      
      public static function getFormattedTimeAndDateFromMilliseconds(param1:Number, param2:String = ".", param3:String = ":", param4:String = ":") : String
      {
         var _loc5_:Date = new Date();
         _loc5_.setTime(param1);
         return getFormattedTimeAndDateFromDate(_loc5_,param2,param3,param4);
      }
      
      public static function getFormattedDateAndTimeDescendingOrderFromDate(param1:Date, param2:String = ".", param3:String = ":", param4:String = ":") : String
      {
         return leftPadOrCrop(param1.getFullYear(),2) + param2 + leftPadOrCrop(param1.getMonth() + 1,2) + param2 + leftPadOrCrop(param1.getDate(),2) + param4 + getFormattedTimeFromDate(param1,param3);
      }
      
      public static function getUTCFormattedDateAndTimeDescendingOrderFromDate(param1:Date, param2:String = ".", param3:String = ":", param4:String = ":") : String
      {
         return leftPadOrCrop(param1.getUTCFullYear(),2) + param2 + leftPadOrCrop(param1.getUTCMonth() + 1,2) + param2 + leftPadOrCrop(param1.getUTCDate(),2) + param4 + getUTCFormattedTimeFromDate(param1,param3);
      }
      
      public static function getFormattedDateFromDate(param1:Date, param2:String = ".", param3:int = 2) : String
      {
         return leftPadOrCrop(param1.getDate(),2) + param2 + leftPadOrCrop(param1.getMonth() + 1,2) + param2 + leftPadOrCrop(param1.getFullYear(),param3);
      }
      
      public static function getFormattedDateFromMilliseconds(param1:Number, param2:String = ".", param3:int = 2) : String
      {
         var _loc4_:Date = new Date();
         _loc4_.setTime(param1);
         return getFormattedDateFromDate(_loc4_,param2,param3);
      }
      
      public static function calculateCompletionTime(param1:Number) : String
      {
         var _loc3_:Date = new Date();
         var _loc2_:Number = _loc3_.getTime() + param1;
         var _loc4_:Date = new Date(_loc2_);
         return leftPadOrCrop(_loc4_.getHours(),2) + ":" + leftPadOrCrop(_loc4_.getMinutes(),2) + ":" + leftPadOrCrop(_loc4_.getSeconds(),2);
      }
      
      public static function calculateServerTime(param1:Number) : Date
      {
         var _loc2_:Date = new Date();
         var _loc3_:Number = _loc2_.getTime() + param1;
         return new Date(_loc3_);
      }
      
      public static function getServerTimeString(param1:Number) : String
      {
         return getFormattedTimeFromDate(calculateServerTime(param1));
      }
      
      public static function convertMillisecondToHour(param1:Number) : Number
      {
         return param1 / (1000 * 60 * 60);
      }
      
      public static function convertMillisecondToDay(param1:Number) : Number
      {
         return param1 / (1000 * 60 * 60 * 24);
      }
      
      public static function convertMillisecondToSecond(param1:Number) : Number
      {
         return param1 / 1000;
      }
      
      public static function leftPadOrCrop(param1:Number, param2:int, param3:String = "0") : String
      {
         var _loc6_:int = 0;
         var _loc4_:String = param1.toString();
         var _loc5_:int = param2 - _loc4_.length;
         if(_loc5_ > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = param3 + _loc4_;
               _loc6_++;
            }
         }
         else
         {
            _loc4_ = _loc4_.slice(_loc5_,_loc4_.length);
         }
         return _loc4_;
      }
      
      public static function leftPad(param1:Number, param2:int, param3:String = "0") : String
      {
         var _loc6_:int = 0;
         var _loc4_:String = param1.toString();
         var _loc5_:int = param2 - _loc4_.length;
         if(_loc5_ > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = param3 + _loc4_;
               _loc6_++;
            }
         }
         return _loc4_;
      }
      
      public static function getSecondsFromDuration(param1:String) : int
      {
         var _loc4_:Array = param1.split(":");
         var _loc5_:int = int(_loc4_[0]);
         var _loc2_:int = int(_loc4_[1]);
         var _loc3_:int = int(_loc4_[2]);
         return _loc5_ * 60 * 60 + _loc2_ * 60 + _loc3_;
      }
      
      public static function getTimezoneWithoutDST() : Number
      {
         var _loc1_:Date = new Date(2000,0,1);
         var _loc2_:Date = new Date(2000,6,1);
         return -Math.max(_loc1_.timezoneOffset,_loc2_.timezoneOffset) * 60 * 1000;
      }
      
      public static function set serverTimeZoneInMillis(param1:Number) : void
      {
         _serverTimeZoneInMillis = param1;
      }
      
      public static function dayDifference(param1:Number, param2:Number) : int
      {
         param1 -= param1 % (1000 * 60 * 60 * 24);
         param2 -= param2 % (1000 * 60 * 60 * 24);
         return DateTimeUtil.convertMillisecondToDay(param1 - param2);
      }
   }
}

