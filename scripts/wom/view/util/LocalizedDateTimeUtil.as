package wom.view.util
{
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   
   public class LocalizedDateTimeUtil
   {
      
      public function LocalizedDateTimeUtil()
      {
         super();
      }
      
      public static function getUserFriendlyTime(param1:Number, param2:String = " ") : String
      {
         var _loc7_:String = "ui.common.daysuffix";
         var _loc6_:String = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         var _loc8_:String = "ui.common.hoursuffix";
         var _loc3_:String = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         var _loc9_:String = "ui.common.minutesuffix";
         var _loc4_:String = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         var _loc10_:String = "ui.common.secondsuffix";
         var _loc5_:String = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         return DateTimeUtil.getUserFriendlyTime(param1,param2,_loc6_,_loc3_,_loc4_,_loc5_);
      }
      
      public static function getUserFriendlyTimeWithoutSeconds(param1:Number, param2:String = " ") : String
      {
         var _loc6_:String = "ui.common.daysuffix";
         var _loc5_:String = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         var _loc7_:String = "ui.common.hoursuffix";
         var _loc3_:String = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         var _loc8_:String = "ui.common.minutesuffix";
         var _loc4_:String = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         return DateTimeUtil.getUserFriendlyTimeWithoutSeconds(param1,param2,_loc5_,_loc3_,_loc4_);
      }
      
      public static function getUserFriendlyTimeFromSeconds(param1:Number, param2:String = " ") : String
      {
         var _loc7_:String = "ui.common.daysuffix";
         var _loc6_:String = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         var _loc8_:String = "ui.common.hoursuffix";
         var _loc3_:String = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         var _loc9_:String = "ui.common.minutesuffix";
         var _loc4_:String = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         var _loc10_:String = "ui.common.secondsuffix";
         var _loc5_:String = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         return DateTimeUtil.getUserFriendlyTimeFromSeconds(param1,param2,_loc6_,_loc3_,_loc4_,_loc5_);
      }
   }
}

