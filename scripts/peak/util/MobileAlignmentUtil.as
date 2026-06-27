package peak.util
{
   import starling.display.DisplayObject;
   
   public class MobileAlignmentUtil
   {
      
      private static const X_MARGIN:Number = 5;
      
      private static const Y_MARGIN:Number = 5;
      
      private static const DEFAULT_HEIGHT:Number = 30;
      
      private static const DEFAULT_WIDTH:Number = 80;
      
      public function MobileAlignmentUtil()
      {
         super();
      }
      
      public static function alignAboveOf(param1:DisplayObject, param2:DisplayObject, param3:Number = 5) : void
      {
         param1.x = param2.x;
         param1.y = param2.y - param1.height - param3 >> 0;
      }
      
      public static function alignAboveWithXMarginOf(param1:DisplayObject, param2:DisplayObject, param3:Number = 5, param4:Number = 5) : void
      {
         param1.x = param2.x + param3;
         param1.y = param2.y - param1.height - param4 >> 0;
      }
      
      public static function alignBelowOf(param1:DisplayObject, param2:DisplayObject, param3:Number = 5) : void
      {
         param1.x = param2.x;
         param1.y = param2.y + param2.height + param3 >> 0;
      }
      
      public static function alignHeightSpecifiedBelowOf(param1:DisplayObject, param2:DisplayObject, param3:Number = 5, param4:Number = 30) : void
      {
         param1.x = param2.x;
         param1.y = param2.y + param4 + param3 >> 0;
      }
      
      public static function alignRightOf(param1:DisplayObject, param2:DisplayObject, param3:Number = 5) : void
      {
         param1.x = param2.x + param2.width + param3 >> 0;
         param1.y = param2.y;
      }
      
      public static function alignLeftOf(param1:DisplayObject, param2:DisplayObject, param3:Number = 5) : void
      {
         param1.x = param2.x - param1.width - param3 >> 0;
         param1.y = param2.y;
      }
      
      public static function alignLowerAndRightCornerOf(param1:DisplayObject, param2:DisplayObject) : void
      {
         param1.x = param2.x + param2.width - param1.width >> 0;
         param1.y = param2.y + param2.height - param1.height >> 0;
      }
      
      public static function alignRightOfObjectAndAlignCenter(param1:DisplayObject, param2:DisplayObject, param3:Number = 5, param4:Number = 80) : void
      {
         param1.x = param2.x + param2.width + param3 + (param4 - param1.width) / 2 >> 0;
         param1.y = param2.y;
      }
      
      public static function alignWidthSpecifiedRightOf(param1:DisplayObject, param2:DisplayObject, param3:Number = 5, param4:Number = 80) : void
      {
         param1.x = param2.x + param4 + param3 >> 0;
         param1.y = param2.y;
      }
      
      public static function alignAccordingToPositionOf(param1:DisplayObject, param2:DisplayObject, param3:Number = 5, param4:Number = 5) : void
      {
         param1.x = param2.x + param3;
         param1.y = param2.y + param4;
      }
      
      public static function alignRightWithYMarginOf(param1:DisplayObject, param2:DisplayObject, param3:Number, param4:Number = 5) : void
      {
         param1.x = param2.x + param2.width + param4 >> 0;
         param1.y = param2.y + param3;
      }
      
      public static function alignBelowWithXMarginOf(param1:DisplayObject, param2:DisplayObject, param3:Number, param4:Number = 5) : void
      {
         param1.x = param2.x + param3;
         param1.y = param2.y + param2.height + param4 >> 0;
      }
      
      public static function alignMiddleOf(param1:DisplayObject, param2:DisplayObject) : void
      {
         alignMiddleYAxisOf(param1,param2);
         alignMiddleXAxisOf(param1,param2);
      }
      
      public static function alignMiddleYAxisOf(param1:DisplayObject, param2:DisplayObject) : void
      {
         param1.y = param2.y + (param2.height - param1.height >> 1);
      }
      
      public static function alignMiddleXAxisOf(param1:DisplayObject, param2:DisplayObject) : void
      {
         param1.x = param2.x + (param2.width - param1.width >> 1);
      }
      
      public static function alignHeightAccordingToPositionOf(param1:DisplayObject, param2:DisplayObject, param3:Number = 5) : void
      {
         param1.y = param2.y + param3;
      }
      
      public static function alignWidthAccordingToPositionOf(param1:DisplayObject, param2:DisplayObject, param3:Number = 5) : void
      {
         param1.x = param2.x + param3;
      }
      
      public static function alignMiddleYAxisAndWidthAccordingToPositionOf(param1:DisplayObject, param2:DisplayObject, param3:Number = 5) : void
      {
         alignMiddleYAxisOf(param1,param2);
         alignWidthAccordingToPositionOf(param1,param2,param3);
      }
      
      public static function alignMiddleXAxisAndHeightAccordingToPositionOf(param1:DisplayObject, param2:DisplayObject, param3:Number = 5) : void
      {
         alignMiddleXAxisOf(param1,param2);
         alignHeightAccordingToPositionOf(param1,param2,param3);
      }
   }
}

