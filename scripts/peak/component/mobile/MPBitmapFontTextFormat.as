package peak.component.mobile
{
   import feathers.text.BitmapFontTextFormat;
   
   public class MPBitmapFontTextFormat extends BitmapFontTextFormat
   {
      
      public var lineSpacing:int;
      
      public function MPBitmapFontTextFormat(param1:Object, param2:Number = NaN, param3:uint = 16777215, param4:String = "left", param5:int = 0)
      {
         super(param1,param2,param3,param4);
         this.lineSpacing = param5;
      }
   }
}

