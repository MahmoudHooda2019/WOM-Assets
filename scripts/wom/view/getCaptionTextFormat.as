package wom.view
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   import wom.view.component.MobileWomTextFormats;
   
   public function getCaptionTextFormat(param1:Number, param2:String = "left", param3:uint = 16777215, param4:uint = 8) : MPBitmapFontTextFormat
   {
      return MobileWomTextFormats.getTextFormat("B",param1,param2,param3,param4);
   }
}

