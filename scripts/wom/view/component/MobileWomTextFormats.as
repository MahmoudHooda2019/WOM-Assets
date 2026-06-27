package wom.view.component
{
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPBitmapFontTextFormat;
   
   public class MobileWomTextFormats
   {
      
      public static const FONT_NAME:String = "BL";
      
      public static const FONT_SIZE:Number = 40;
      
      public static const FONT_COLOR:int = 0;
      
      public static const DISABLED_TEXT_COLOR:int = 8947848;
      
      public static const COLOR_DARK_RED:int = 12210471;
      
      public static const COLOR_BRIGHT_RED:int = 16737894;
      
      public static const COLOR_GREEN:int = 2849024;
      
      public static const COLOR_LIGHT_GREEN:int = 6919761;
      
      public static const COLOR_ORANGE:int = 15682332;
      
      public static const COLOR_WHITE:int = 16777215;
      
      public static const COLOR_RED:int = 15016227;
      
      public static const COLOR_LIGHT_YELLOW:int = 15923090;
      
      public static const COLOR_YELLOW:int = 14657070;
      
      public static const COLOR_LIGHT_GREY:int = 12040119;
      
      public static const COLOR_GREY:int = 8882055;
      
      public static const CAPTION_FONT_NAME:String = "B";
      
      public static const CAPTION_FONT_SIZE:Number = 40;
      
      public static const CAPTION_FONT_COLOR:int = 16777215;
      
      public static const COLOR_MOBILE_CHAT_MESSAGE:uint = 16777215;
      
      public static const COLOR_MOBILE_CHAT_NAME:uint = 16777215;
      
      public static const SIZE_14:int = 15;
      
      public static const SIZE_16:int = 17;
      
      public static const SIZE_17:int = 18;
      
      public static const SIZE_18:int = 19;
      
      public static const SIZE_19:int = 20;
      
      public static const SIZE_20:int = 21;
      
      public static const SIZE_22:int = 23;
      
      public static const SIZE_24:int = 25;
      
      public static const SIZE_26:int = 27;
      
      public static const SIZE_27:int = 28;
      
      public static const SIZE_29:int = 30;
      
      public static const SIZE_32:int = 33;
      
      public static const SIZE_36:int = 38;
      
      public static const SIZE_40:int = 42;
      
      public static const SIZE_44:int = 46;
      
      public static const SIZE_48:int = 50;
      
      public static const SIZE_60:int = 62;
      
      private static var textFormatCache:Dictionary;
      
      public static const WOM_58:TextFormat = new TextFormat("BlambotFXProLightBB",29,0);
      
      public function MobileWomTextFormats()
      {
         super();
      }
      
      public static function init() : void
      {
         textFormatCache = new Dictionary();
      }
      
      public static function getTextFormat(param1:String, param2:Number, param3:String, param4:uint, param5:uint = 0) : MPBitmapFontTextFormat
      {
         var _loc6_:String = param1 + param2 + param4 + param3 + param5;
         if(_loc6_ in textFormatCache)
         {
            return textFormatCache[_loc6_];
         }
         textFormatCache[_loc6_] = new MPBitmapFontTextFormat(param1,param2,param4,param3,param5);
         return textFormatCache[_loc6_];
      }
   }
}

